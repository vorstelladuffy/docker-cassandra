# vim:set ft=dockerfile:
FROM cassandra:2.1

COPY files/metrics.yaml /
COPY files/metrics-kafka-0.0.1.jar /
RUN rm /usr/share/cassandra/lib/reporter-config*
COPY files/reporter-config-base-3.0.3.jar /
COPY files/reporter-config3-3.0.3.jar /

CMD ["cassandra", "-f"]
