import db_sqlite
proc makeTables*(db: DbConn): void =
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
