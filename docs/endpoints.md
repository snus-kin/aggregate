All endpoints return either `application/json` or no body. Examples use
'agg.ins' as the domain, this is not a real domain
# Posts
## GET `/posts/list.json`
## GET `/posts/latest.json`
## POST `/posts/create.json`
## DELETE `/posts/delete.json`

# Users
## GET `/users/validate.json`
Send a `username` and `password`, receive a token if the password matches.

If the password does not match, the response's status will be `403` if an
invalid request is made the status will be `400`

**Example:**
Request:
`GET http://agg.ins/users/validate.json?username=zzz&password=zzz`

Response:
```json
{
    "token": "05914DF29A2F94F0F43EA60BE694D36151534E37"
}
```

## POST `/users/create.json`
Create a new user sending a `username` and `password`, returns a
new token.

**Example:**
Request:
`POST http://agg.ins/users/create.json`

Request Body:
```json
{
    "username": "zzz",
    "password": "zzz"
}
```

Response:
```json
{
    "token": "05914DF29A2F94F0F43EA60BE694D36151534E37"
}
```

## PUT `/users/newToken.json`
Make a new token, invalidating the previous, send the `token`, and a
`new_password` and receive a token. The `new_password` does not
need to be different from the previous password. (Perhaps this is bad as
the mersenne twister sequence can be leaked)

**Example:**
Request:
`PUT http://agg.ins/users/newToken.json`

Request Headers:
`Authorization: 05914DF29A2F94F0F43EA60BE694D36151534E37` 

Request Body:
```json
{
    "new_password": "zzz"
}
```

Response:
```json
{
    "token": "05914DF29A2F94F0F43EA60BE694D36151534E37"
}
```

## DELETE `/users/delete.json`
