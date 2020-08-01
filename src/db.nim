## DB SETUP SCRIPT
## temp dev env
import db_sqlite
let db = open("posts.db", "", "", "")

# db.exec(sql"""DROP TABLE IF EXISTS posts""")
# db.exec(sql"""DROP TABLE IF EXISTS users""")
db.exec(sql"""CREATE TABLE IF NOT EXISTS posts (
                 id   INTEGER PRIMARY KEY AUTOINCREMENT,
                 name VARCHAR(50) NOT NULL,
                 description VARCHAR(120) NOT NULL,
                 time DATETIME DEFAULT CURRENT_TIMESTAMP
              )""")

db.exec(sql"""CREATE TABLE IF NOT EXISTS users (
                 token VARCHAR(64) NOT NULL UNIQUE,
                 username VARCHAR(50) NOT NULL UNIQUE
              )""")


# db.exec(sql"INSERT INTO posts (name, description) VALUES ('test', 'testdesc')")
# db.exec(sql"INSERT INTO posts (name, description) VALUES ('test2', 'testdesc2')")
# 
# db.exec(sql"INSERT INTO users VALUES ('blah', 'testUSER1')")
# db.exec(sql"INSERT INTO users VALUES ('blah1', 'testUSER2')")

db.close()
