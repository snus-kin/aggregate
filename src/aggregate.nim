## Core API

import json
import db_sqlite
import jester

import posts

let db = open("posts.db", "", "", "")

settings:
  port = Port(5000)

createPostsRouter(db)

routes:
  extend posts, ""

db.close()
