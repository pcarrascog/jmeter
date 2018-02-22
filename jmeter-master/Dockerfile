#Tomando como base la imagen de Ubuntu
FROM ubuntu:16.04

#Parametros de la compilacion
ARG version=4.0

#Instalando dependencias y creando usuario
RUN apt-get -y update \
    && apt-get install -y --no-install-recommends openjdk-8-jre-headless vim \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m -s /bin/bash automator

#Definiendo variable de entorno
ENV HOME /home/automator/

#Definiendo espacio de trabajo
WORKDIR $HOME

#Agregando archivo
ADD http://ftp.ps.pl/pub/apache/jmeter/binaries/apache-jmeter-$version.tgz .

#Asignando permisos
RUN chmod 755 apache-jmeter-$version.tgz \
    && chown automator:automator apache-jmeter-$version.tgz

#Cambiando usuario
USER automator

#Descomprimiendo Jmeter
RUN tar -xvzf apache-jmeter-$version.tgz \
    && rm -f apache-jmeter-$version.tgz \
    && mkdir -p apache-jmeter-$version/tests/data \
    && chmod +x apache-jmeter-$version/bin/jmeter-server

#Exponiendo puerto
EXPOSE 1099 5000 6000

#Definiendo espacio de trabajo
WORKDIR $HOME/apache-jmeter-$version

RUN mkdir /home/automator/apache-jmeter-4.0/results

ADD ./Documents/rmi_keystore.jks ./bin/.
ADD ./Documents/Example.jmx ./bin/Example.jmx

USER root
RUN chown automator:automator ./bin/rmi_keystore.jks
RUN chown automator:automator ./bin/Example.jmx
RUN chown -R automator:automator ./results
USER automator
WORKDIR $HOME/apache-jmeter-$version/bin

#Exponiendo directorio de jmeter
VOLUME $HOME/apache-jmeter-$version/tests \
	&& $HOME/apache-jmeter-$version/tests/data \
	&& /home/automator/apache-jmeter-4.0/results

CMD ./jmeter -D server.rmi.ssl.keystore.password=changeit -D server.rmi.ssl.keystore.alias=rmi -n -t Example.jmx -l /home/automator/apache-jmeter-4.0/results/$(date +%Y%m%d%H%M%S)_ExampleResult.csv -j /home/automator/apache-jmeter-4.0/results/$(date +%Y%m%d%H%M%S)_ExampleLog.log -R -R 173.1.0.222:1099
