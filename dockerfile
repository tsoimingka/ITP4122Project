FROM amazonlinux:latest

RUN yum update -y && \
yum install -y gcc && \
yum install -y python3 && \
yum install -y python3-devel && \
yum install -y mysql-devel

COPY requirements.txt requirements.txt
RUN python3 -m venv venv && \
venv/bin/pip3 install --upgrade pip && \
venv/bin/pip3 install -r requirements.txt && \
venv/bin/pip3 install mysqlclient && \
venv/bin/pip3 install gunicorn

COPY app app
COPY config.py run.py boot.sh ./
RUN chmod +x boot.sh

ENV FLASK_APP run.py

EXPOSE 8080
ENTRYPOINT ["./boot.sh"]