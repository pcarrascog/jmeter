#Base de Ubuntu
FROM ubuntu:16.04

#Parametros de Compilacion
ARG version=4.0

#Dependencias y Usuario
RUN apt-get -y update \
    && apt-get install -y --no-install-recommends openjdk-8-jre-headless \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m -s /bin/bash tsoft

#Variable de Entorno
ENV HOME /home/tsoft

#Directorio de Trabajo
WORKDIR ${HOME}

#Jmeter
ADD https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${version}.tgz .

#Permisos y Espacio de Trabajo
RUN tar -zxvf apache-jmeter-${version}.tgz \
    && mv apache-jmeter-${version} apache-jmeter \
    && mkdir -p apache-jmeter/bin/workspace/tests \
    && mkdir -p apache-jmeter/bin/workspace/results \    
    && mkdir -p apache-jmeter/bin/workspace/certificate \    
    && chown -R tsoft:tsoft apache-jmeter/

#Directorios
VOLUME ${HOME}/apache-jmeter/bin/workspace/tests
VOLUME ${HOME}/apache-jmeter/bin/workspace/results
VOLUME ${HOME}/apache-jmeter/bin/workspace/certificate

#Usuario
USER tsoft

#Direcotio de Trabajo
WORKDIR ${HOME}/apache-jmeter/bin

#Metadatos
LABEL jmeter_version=${version} jmeter_rol="jmeter-master" cmd_vars="test_name, ip_server"

#Jmeter Master
CMD ./jmeter -n \
    -t ./workspace/tests/${test_name}.jmx \
    -l ./workspace/results/$(date +%Y%m%d%H%M%S)-${test_name}.csv \
    -j ./workspace/results/$(date +%Y%m%d%H%M%S)-${test_name}.log \
    -R ${ip_server} \
    -D server.rmi.ssl.keystore.file=./workspace/certificate/rmi_keystore.jks \
    -D server.rmi.ssl.keystore.password=changeit \
    -D server.rmi.ssl.keystore.alias=rmi