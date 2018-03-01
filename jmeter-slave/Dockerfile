#Base de Jmater Tsoft
FROM tsoft/jmeter-base

#Metadatos
LABEL jmeter_role="slave" slave_env="LOCAL_IP"

#Puertos
EXPOSE 1099 50000

#Directorios
VOLUME ${JMETER_HOME}/bin/workspace/data

#Jmeter Slave
ENTRYPOINT jmeter-server \
    -Dserver.rmi.localport=50000 \
    -Dserver_port=1099 \
    -Djava.rmi.server.hostname=${LOCAL_IP}
