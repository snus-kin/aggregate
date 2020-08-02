## Core API

import json
import db_sqlite
import jester

import posts, users

let db = open("posts.db", "", "", "")

# make some tables
db.exec(sql"""CREATE TABLE IF NOT EXISTS posts (
                 id   INTEGER PRIMARY KEY AUTOINCREMENT,
                 username TEXT NOT NULL,
                 title TEXT NOT NULL,
                 link TEXT NOT NULL,
                 description TEXT,
                 time DATETIME DEFAULT CURRENT_TIMESTAMP
              )""")
db.exec(sql"""CREATE TABLE IF NOT EXISTS users (
                 token TEXT NOT NULL,
                 username TEXT NOT NULL UNIQUE,
                 salt TEXT NOT NULL
              )""")
# TODO debug
# db.exec(sql"INSERT INTO posts (username, title, link, description) VALUES ('testUSER1', 'test', 'https://snufk.in', 'testdesc')")
# db.exec(sql"INSERT INTO posts (username, title, link, description) VALUES ('testUSER2', 'test2', 'https://snufk.in/blog', 'testdesc2')")

settings:
  port = Port(5000)

createPostsRouter(db)
createUsersRouter(db)

routes:
  extend posts, ""
  extend users, ""

db.close()
