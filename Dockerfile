# vim:set ft=dockerfile:
FROM cassandra:2.1.8

RUN apt-get update && apt-get -y --force-yes install --no-install-recommends sysstat curl
COPY files/cassandra.yaml /etc/cassandra
COPY files/prometheus.yaml /etc/cassandra
COPY files/jmx_prometheus_javaagent-0.2.0.jar /usr/share/cassandra/lib
COPY files/perf.sh /

CMD ["/perf.sh"]
