## DB SETUP SCRIPT
## temp dev env
import db_sqlite
let db = open("posts.db", "", "", "")

# db.exec(sql"""DROP TABLE IF EXISTS posts""")
db.exec(sql"""DROP TABLE IF EXISTS users""")
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


# db.exec(sql"INSERT INTO posts (username, title, link, description) VALUES ('testUSER1', 'test', 'https://snufk.in', 'testdesc')")
# db.exec(sql"INSERT INTO posts (username, title, link, description) VALUES ('testUSER2', 'test2', 'https://snufk.in/blog', 'testdesc2')")
# 
# db.exec(sql"INSERT INTO users VALUES ('blah', 'testUSER1')")
# db.exec(sql"INSERT INTO users VALUES ('blah1', 'testUSER2')")

db.close()
