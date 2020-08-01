import db_sqlite
import jester

proc createUsersRouter*(db: DbConn) =
  router users:
    get "/users/validate.json":
      resp "Not implemented"

    post "/users/create.json":
      resp "Not implemented"

    delete "/users/delete.json":
      resp "Not implemented"
