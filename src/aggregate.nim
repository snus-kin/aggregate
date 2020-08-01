## Core API

import json
import db_sqlite
import jester

import posts, users

let db = open("posts.db", "", "", "")

settings:
  port = Port(5000)

createPostsRouter(db)
createUsersRouter(db)

routes:
  extend posts, ""
  extend users, ""

db.close()
