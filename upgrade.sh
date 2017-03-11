#!/bin/bash

if [[ -z "$API_NAME" ]]; then
  API_NAME="localhost";
fi

if [[ -z "$API_PORT" ]]; then
  API_PORT="8000";
fi

if [[ -z "$API_PROTOCOL" ]]; then
  API_PROTOCOL="http";
fi

docker pull lxndryng/taiga-back
docker pull lxndryng/taiga-front
docker stop taiga-back taiga-front
docker rm taiga-back taiga-front
docker run -d --name taiga-back  -p 127.0.0.1:8000:8000 -e API_NAME=$API_NAME  -v /data/taiga-media:/usr/src/app/taiga-back/media --link postgres:postgres lxndryng/taiga-back
docker run -d --name taiga-front -p 127.0.0.1:8080:80 -e API_NAME=$API_NAME -e API_PORT=$API_PORT -e API_PROTOCOL=$API_PROTOCOL --link taiga-back:taiga-back --volumes-from taiga-back lxndryng/taiga-front
docker run -it --rm -e API_NAME=$API_NAME --link postgres:postgres lxndryng/taiga-back /bin/bash -c "cd /usr/src/app/taiga-back; python manage.py migrate --noinput; python manage.py compilemessages; python manage.py collectstatic --noinput"

