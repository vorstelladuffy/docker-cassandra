#!/bin/bash

docker run \
  -i --rm \
  --env CLASSPATH="/reporter-config-base-3.0.3.jar:/reporter-config3-3.0.3.jar:/" \
  --env JVM_EXTRA_OPTS="-Dcassandra.metricsReporterConfigFile=metrics.yaml" \
  duffy/cassandra:2.1.8 | tee cassandra.out
