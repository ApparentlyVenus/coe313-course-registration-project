#!/bin/sh

DB_USERNAME=$(cat /run/secrets/db_username)
DB_PASSWORD=$(cat /run/secrets/db_password)
JWT_SECRET=$(cat /run/secrets/jwt_secret)

export DB_USERNAME
export DB_PASSWORD
export JWT_SECRET

exec java -jar app.jar