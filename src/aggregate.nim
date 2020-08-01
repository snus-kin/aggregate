## Core API

import json
import db_sqlite
import jester

let db = open("posts.db", "", "", "")

routes:
  get "/posts/list.json":
    let posts = db.getAllRows(sql"SELECT * FROM posts")
    var jsonPosts: seq[JsonNode]
    for post in posts:
      var jsonPost = %* {
        "id": post[0],
        "name": post[1],
        "description": post[2]
      }
      echo pretty jsonPost
      jsonPosts.add jsonPost
    let jsonBody = %* jsonPosts
    
    resp jsonBody

db.close()
