#Tomando como base la imagen de Ubuntu 16.04
FROM ubuntu:16.04

#Parametros de la compilacion
ARG version=3.3
ARG path=./files/apache-jmeter-${version}.tgz

#Instalando dependencias y creando usuario
RUN apt-get -y update \
    && apt-get install -y --no-install-recommends openjdk-8-jre-headless \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m -s /bin/bash tsoft

#Definiendo variable de entorno
ENV HOME /home/tsoft

#Definiendo espacio de trabajo
WORKDIR ${HOME}

#Agregando archivo de Jmeter
ADD ${path} .

#Asignando permisos y crando espacio de trabajo
RUN mv apache-jmeter-${version} apache-jmeter \
    && mkdir -p apache-jmeter/bin/tsoft/tests \
    && mkdir -p apache-jmeter/bin/tsoft/results \    
    #&& mkdir -p apache-jmeter/bin/tsoft/certificate \    
    && chown -R tsoft:tsoft apache-jmeter/

#Exponiendo directorios
VOLUME ${HOME}/apache-jmeter/bin/tsoft/tests
VOLUME ${HOME}/apache-jmeter/bin/tsoft/results
#VOLUME ${HOME}/apache-jmeter/bin/tsoft/certificate

#Cambiando a usuario tsoft
USER tsoft

#Definiendo espacio de trabajo
WORKDIR ${HOME}/apache-jmeter/bin

#Agregando metadatos
LABEL owner="tsoft" jmeter_version=${version} jmeter_rol="jmeter-master" cmd_vars="test_name, ip_server"

#Ejecutando jmeter server
#CMD ./jmeter -D server.rmi.ssl.keystore.file=./tsoft/certificate/rmi_keystore.jks -D server.rmi.ssl.keystore.password=changeit -D server.rmi.ssl.keystore.alias=rmi -n -t ./tsoft/tests/${test_name}.jmx -l ./tsoft/results/$(date +%Y%m%d%H%M%S)-${test_name}.csv -j ./tsoft/results/$(date +%Y%m%d%H%M%S)-${test_name}.log -R ${ip_server}
CMD ./jmeter -n -t ./tsoft/tests/${test_name}.jmx -l ./tsoft/results/$(date +%Y%m%d%H%M%S)-${test_name}.csv -j ./tsoft/results/$(date +%Y%m%d%H%M%S)-${test_name}.log -R ${ip_server}

