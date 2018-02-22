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
ENV HOME /home/tsoft/

#Definiendo espacio de trabajo
WORKDIR ${HOME}

#Agregando archivo de Jmeter
ADD $path .

#Asignando permisos
RUN chown -R tsoft:tsoft $HOME/apache-jmeter-${version}/

#Exponiendo puerto
EXPOSE 1099

#Cambiando a usuario tsoft
USER tsoft

#Definiendo espacio de trabajo
WORKDIR $HOME/apache-jmeter-${version}/bin

#Ejecutando jmeter server
#CMD ./jmeter-server -D server_port=1099 -D server.rmi.ssl.keystore.password=changeit -D server.rmi.ssl.keystore.alias=rmi
CMD ./jmeter-server -D server_port=1099
