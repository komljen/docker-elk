FROM ubuntu:latest

RUN \
  apt-get update && \
  apt-get -y install \
          cron curl && \
  rm -rf /var/lib/apt/lists/*

ADD crontab crontab
ADD retention.sh retention.sh

RUN \
  crontab crontab && \
  chmod +x retention.sh && \
  touch /var/log/cron.log

CMD env | grep -v no_proxy > /cronenv && cron && tail -f /var/log/cron.log