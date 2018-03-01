#Base de Jmater Tsoft
FROM tsoft/jmeter-base

#Metadatos
LABEL jmeter_role="master" master_env="TEST_NAME, REMOTE_SLAVE_IP, LOCAL_IP"

#Puertos
EXPOSE 60000

#Directorios
VOLUME ${JMETER_HOME}/bin/workspace/tests
VOLUME ${JMETER_HOME}/bin/workspace/results

#Jmeter Master
ENTRYPOINT ./jmeter -n \
    -t ./workspace/tests/${TEST_NAME}.jmx \
    -l ./workspace/results/$(date +%Y%m%d%H%M%S)-${TEST_NAME}.csv \
    -j ./workspace/results/$(date +%Y%m%d%H%M%S)-${TEST_NAME}.log \
    -R ${REMOTE_SLAVE_IP} \
    -D java.rmi.server.hostname=${LOCAL_IP} \
    -D client.rmi.localport=60000
