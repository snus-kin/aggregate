import json
import mersenne
import db_sqlite
import std/sha1
import jester

proc makeToken*(pass: string): array[2, string] =
  ## generate a unique salt each time, hopefully good enough
  var r = newMersenneTwister(uint32.high)
  let salt = $r.getNum
  result = [$ secureHash(salt & pass), salt]

proc recreateToken*(pass: string, salt: string): string =
  result = $ secureHash(salt & pass)

proc createUsersRouter*(db: DbConn) =
  router users:
    get "/users/validate.json":
      ## put a username & pass in and get the token back
      try:
        let user: string = request.params["username"]
        let pass: string = request.params["password"]
        
        let expected = db.getRow(sql"SELECT token, salt FROM users WHERE username = ?", user)
        let generated = recreateToken(pass, expected[1])

        if generated == expected[0]:
          let jsonBody = %* {"token": generated}
          resp jsonBody

        resp Http403
      except KeyError:
        resp Http400

    post "/users/create.json":
      try:
        let payload = parseJson(request.body)
        let token = makeToken(payload["password"].getStr)

        db.exec(sql"""INSERT INTO users (username, token, salt) VALUES (?, ?, ?)""", 
                      payload["username"].getStr, token[0], token[1])

        let jsonBody = %* {"token": token[0]}
        resp jsonBody
      except JsonParsingError, KeyError:
        resp Http400

    delete "/users/delete.json":
      resp "Not implemented"
