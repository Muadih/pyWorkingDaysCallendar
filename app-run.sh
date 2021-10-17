#!/bin/sh

APP_DB_PATH=${APP_DB_PATH:-../var/instance/flaskr.sqlite}

if [ ! -f ${APP_DB_PATH} ]; then
echo Creating database
flask init-db
fi

echo Running app $FLASK_APP
flask run --host=0.0.0.0
