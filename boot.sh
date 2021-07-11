#!/bin/sh
# this script is used to boot a Docker container
source venv/bin/activate
python3 run.py
'''
while true; do
    flask db upgrade
    if [[ "$?" == "0" ]]; then
        break
    fi
    echo Deploy command failed, retrying in 5 secs...
    exit 0
done
flask translate compile
exec gunicorn -b :5000 --access-logfile - --error-logfile - microblog:app
'''