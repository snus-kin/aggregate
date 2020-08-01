## DB SETUP SCRIPT
import db_sqlite
let db = open("posts.db", "", "", "")

db.exec(sql"""DROP TABLE IF EXISTS posts""")
db.exec(sql"""CREATE TABLE posts (
                 id   INTEGER PRIMARY KEY,
                 name VARCHAR(50) NOT NULL,
                 description VARCHAR(120) NOT NULL
              )""")

db.exec(sql"INSERT INTO posts VALUES (1, 'test', 'testdesc')")
db.exec(sql"INSERT INTO posts VALUES (2, 'test2', 'testdesc2')")

db.close()
