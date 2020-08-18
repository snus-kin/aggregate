## Example CLI client in nim for aggregate

import json, httpclient, algorithm, times, os, htmlparser, xmltree
import cligen

const token = getEnv("AGGREGATE_TOKEN")

# read servers file
var 
  servers: seq[string]
  s: File
  line: string

if s.open("servers"):
  while s.readLine(line):
    servers.add line
s.close

proc list() =
  ## provide a list of aggregate servers and order posts by timestamp
  let client = newHttpClient()
  var posts: seq[JsonNode]
  for server in servers:
    let resp = parseJson(client.getContent(server & "/posts/list.json"))
    for post in resp["posts"].getElems:
      posts.add post 
  
  var sortedPosts = posts.sorted(proc(a, b: JsonNode): int = cmp(parse(a["time"].getStr, "YYYY-MM-dd HH:mm:ss"), parse(b["time"].getStr, "YYYY-MM-dd HH:mm:ss")))
  for post in sortedPosts:
    echo post
  client.close()

proc latest() =
  let client = newHttpClient()
  var posts: seq[JsonNode]
  for server in servers:
    let resp = parseJson(client.getContent(server & "/posts/latest.json"))
    posts.add resp
  var sortedPosts = posts.sorted(proc(a, b: JsonNode): int = cmp(parse(a["time"].getStr, "YYYY-MM-dd HH:mm:ss"), parse(b["time"].getStr, "YYYY-MM-dd HH:mm:ss")))
  sortedPosts.reverse()
  echo sortedPosts[0]
  client.close()

proc makePost(server, title, link: string, description: string = "") =
  let client = newHttpClient()
  client.headers = newHttpHeaders({"Authorization": token})
  let jsonBody = %* {"title": title, "link": link, "description": description}
  let resp = client.post(server & "/posts/create.json", body= $jsonBody)
  echo resp.status
  client.close()

proc autoPost(link: string, server: string) = 
  let client = newHttpClient()
  client.headers = newHttpHeaders({"Authorization": token})
  let toPost = client.getContent(link)
  let targetHtml = parseHtml(toPost)
  let title = targetHtml.findAll("title")[0].innerText

  let jsonBody = %* {"title": title, "link": link}
  let resp = client.post(server & "/posts/create.json", body= $jsonBody)
  echo resp.status

  client.close()

when isMainModule:
  dispatchMulti([list], [latest], [makePost], [autopost])
