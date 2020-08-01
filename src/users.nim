import json
import mersenne
import db_sqlite
import std/sha1
import jester

proc makeToken*(pass: string): string =
  ## generate a unique salt each time, hopefully good enough
  var r = newMersenneTwister(uint32.high)
  result = $ secureHash($ r.getNum & pass)

proc createUsersRouter*(db: DbConn) =
  router users:
    get "/users/validate.json":
      ## put a pass in and get the token back
      resp "Not implemented"

    post "/users/create.json":
      try:
        let payload = parseJson(request.body)
        echo pretty payload
        let token = makeToken($payload["password"])

        db.exec(sql"""INSERT INTO users (username, token) VALUES (?, ?)""", 
                      payload["username"], token)

        let jsonBody = %* {"token": token}
        resp jsonBody
      except JsonParsingError, KeyError:
        resp Http400

    delete "/users/delete.json":
      resp "Not implemented"
