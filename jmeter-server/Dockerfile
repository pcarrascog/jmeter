#Base de Ubuntu
FROM ubuntu:16.04

#Parametros de Compilacion
ARG version=4.0

#Dependencias y Usuario
RUN apt-get -y update \
    && apt-get install -y --no-install-recommends openjdk-8-jre-headless \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m -s /bin/bash tsoft

#Variables de Entorno
ENV HOME /home/tsoft

#Directorio de Trabajo
WORKDIR ${HOME}

#Jmeter
ADD https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${version}.tgz .

#Permisos y Espacio de Trabajo
RUN tar -zxvf apache-jmeter-${version}.tgz \
    && mv apache-jmeter-${version} apache-jmeter \
    && mkdir -p apache-jmeter/bin/workspace/data \
    && mkdir -p apache-jmeter/bin/workspace/certificate \    
    && chown -R tsoft:tsoft apache-jmeter/

#Puertos
EXPOSE 1099

#Directorios
VOLUME ${HOME}/apache-jmeter/bin/workspace/data
VOLUME ${HOME}/apache-jmeter/bin/workspace/certificate

#Usuario
USER tsoft

#Directorio de Trabajo
WORKDIR ${HOME}/apache-jmeter/bin

#Metadatos
LABEL owner="tsoft" jmeter_version=${version} jmeter_rol="jmeter-server" exposed_port="1099" 

#Jmeter Server
CMD ./jmeter-server -D server.rmi.ssl.keystore.file=./tsoft/certificate/rmi_keystore.jks -D server_port=1099