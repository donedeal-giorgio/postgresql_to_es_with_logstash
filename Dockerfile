FROM docker.elastic.co/logstash/logstash:6.4.0

USER root

WORKDIR /usr/src/app

COPY . .

CMD ["/usr/share/logstash/bin/logstash", "-f", "/usr/src/app/src/sync-es.conf"]
