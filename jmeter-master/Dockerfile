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
ADD $path .

#Asignando permisos
RUN chown -R tsoft:tsoft $HOME/apache-jmeter-${version}/

#Exponiendo directorios
VOLUME $HOME/apache-jmeter-${version}/bin/tsoft/tests
VOLUME $HOME/apache-jmeter-${version}/bin/tsoft/tests/data
VOLUME $HOME/apache-jmeter-${version}/bin/tsoft/results
VOLUME $HOME/apache-jmeter-${version}/bin/tsoft/certificate

#Cambiando a usuario tsoft
USER tsoft

#Definiendo espacio de trabajo
WORKDIR $HOME/apache-jmeter-${version}/bin

#Agregando metadatos
LABEL owner="tsoft" jmeter_version=${version} rol="jmeter-master" enviroment_vars="test_name, ip_server"

#Ejecutando jmeter server
CMD ./jmeter -D server.rmi.ssl.keystore.password=changeit -D server.rmi.ssl.keystore.alias=rmi -n -t ./tsoft/tests/${test_name}.jmx -l ./tsoft/results/$(date +%Y%m%d%H%M%S)-${test_name}.csv -j ./tsoft/results/$(date +%Y%m%d%H%M%S)-${test_name}.log -R ${ip_server}
