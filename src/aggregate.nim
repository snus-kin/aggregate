## Core API

import json
import db_sqlite
import jester

let db = open("posts.db", "", "", "")

routes:
  get "/posts/list.json":
    ## GET a list of the posts, we should sort by timestamp
    # unauthed
    let posts = db.getAllRows(sql"SELECT * FROM posts ORDER BY time DESC")
    var jsonPosts: seq[JsonNode]
    for post in posts:
      var jsonPost = %* {
        "id": post[0],
        "name": post[1],
        "description": post[2],
        "time": post[3]
      }
      echo pretty jsonPost
      jsonPosts.add jsonPost
    
    let jsonBody = %* jsonPosts
    resp jsonBody

  get "/posts/latest.json":
    ## GET the latest post
    # unauthed
    let post = db.getRow(sql"SELECT * FROM posts ORDER BY time DESC")
    var jsonPost = %* {
      "id": post[0],
      "name": post[1],
      "description": post[2],
      "time": post[3]
    }

    resp jsonPost

  post "/posts/create.json":
    ## POST to create a new post
    ## Authorization header must be set
    ## example body:
    ## ```json
    ## {
    ##  "type": "link",
    ##  "title": "An Example Post",
    ##  "link": "https://link.com",
    ##  "description": "lorem ipsum"
    ## }```
    try: 
      let payload = parseJson(request.body)
      if request.headers.hasKey("Authorization"):
        let token = request.headers["Authorization"]
        let username = db.getValue(sql"SELECT username FROM users WHERE token == ?", token)
        if username == "":
          # No token with a username
          resp Http403

        echo pretty payload
        db.exec(sql""" INSERT INTO posts (name, description) VALUES (?, ?)""", payload["title"], payload["description"])
        # all is good
        resp Http200
      else:
        # must be authed
        resp Http400
    except JsonParsingError, KeyError:
      # if we can't parse it's a bad request
      resp Http400

db.close()
