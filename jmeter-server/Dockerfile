#Tomando como base la imagen de Ubuntu 16.04
FROM ubuntu:16.04

#Parametros de la compilacion
ARG version=4.0

#Instalando dependencias y creando usuario
RUN apt-get -y update \
    && apt-get install -y --no-install-recommends openjdk-8-jre-headless \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m -s /bin/bash tsoft

#Definiendo variable de entorno
ENV HOME /home/tsoft/

#Definiendo espacio de trabajo
WORKDIR $HOME

#Agregando archivo de Jmeter
ADD http://ftp.ps.pl/pub/apache/jmeter/binaries/apache-jmeter-$version.tgz .

#Asignando permisos
RUN chmod 755 apache-jmeter-$version.tgz \
    && chown tsoft:tsoft apache-jmeter-$version.tgz

#Cambiando a usuario tsoft
USER tsoft

#Preparando entorno de Jmeter
RUN tar -xvzf apache-jmeter-$version.tgz \
    && rm -f apache-jmeter-$version.tgz \
    && mkdir -p apache-jmeter-$version/tests/data \
    && chmod +x apache-jmeter-$version/bin/jmeter-server

#Definiendo espacio de trabajo
WORKDIR $HOME/apache-jmeter-$version

#Agregando certificado SSL
ADD ../documents/rmi_keystore.jks ./bin/.

#Cambiando a usuario root
USER root

#Definiendo permisos
RUN chown tsoft:tsoft ./bin/rmi_keystore.jks

#Cambiando a usuario tsoft
USER tsoft

#Definiendo espacio de trabajo
WORKDIR $HOME/apache-jmeter-$version/bin

#Exponiendo puerto
EXPOSE 1099

#Ejecutando jmeter server
#CMD ./jmeter-server -D server_port=1099 -D server.rmi.ssl.keystore.password=changeit -D server.rmi.ssl.keystore.alias=rmi
CMD ./jmeter-server -D server_port=1099
