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

#Cambiando a usuario tsoft
USER tsoft

#Definiendo espacio de trabajo
WORKDIR ${HOME}

#Agregando archivo de Jmeter
ADD $path .

#Definiendo espacio de trabajo
WORKDIR $HOME/apache-jmeter-${version}/bin

#Exponiendo puerto
EXPOSE 1099

#Ejecutando jmeter server
CMD ./jmeter -D server.rmi.ssl.keystore.password=changeit -D server.rmi.ssl.keystore.alias=rmi -n -t ./tsoft/${NAME}.jmx -l ./tsoft/results/$(date +%Y%m%d%H%M%S)-${NAME}.csv -j ./tsoft/results/$(date +%Y%m%d%H%M%S)-${NAME}.log -R ${IP}
