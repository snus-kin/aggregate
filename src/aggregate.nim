## Core API
import json
import db_sqlite
import jester

import config, database
import api/[posts, users]

const dbPath {.strdefine.} = "./posts.db"
const cfgFile {.strdefine.} = "./aggregate.conf"
let cfg = getConfig(cfgFile)

let db = open(dbPath, "", "", "")
makeTables(db)

settings:
  bindAddr = cfg.host
  port = Port(cfg.port)

createPostsRouter(db)
createUsersRouter(db)

routes:
  extend posts, ""
  extend users, ""

db.close()
