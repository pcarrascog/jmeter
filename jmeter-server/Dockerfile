#Tomando como base la imagen de Ubuntu 16.04
FROM ubuntu:16.04

#Parametros de la compilacion
ARG version=4.0
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
    && mkdir -p apache-jmeter/bin/tsoft/tests/data \
    && mkdir -p apache-jmeter/bin/tsoft/certificate \    
    && chown -R tsoft:tsoft apache-jmeter/

#Exponiendo puerto
EXPOSE 1099

#Exponiendo directorios
VOLUME ${HOME}/apache-jmeter/bin/tsoft/tests/data
VOLUME ${HOME}/apache-jmeter/bin/tsoft/certificate

#Cambiando a usuario tsoft
USER tsoft

#Definiendo espacio de trabajo
WORKDIR ${HOME}/apache-jmeter/bin

#Agregando metadatos
LABEL owner="tsoft" jmeter_version=${version} jmeter_rol="jmeter-server" exposed_port="1099" 

#Ejecutando jmeter server
CMD ./jmeter-server -D server.rmi.ssl.keystore.file=./tsoft/certificate/rmi_keystore.jks -D server_port=1099
