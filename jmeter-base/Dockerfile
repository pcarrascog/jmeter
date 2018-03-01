#Base de OpenJDK
FROM openjdk:8-jre-slim

#Parametros de Compilacion
ARG JMETER_VERSION=3.3

#Dependencias y Usuario
RUN apt-get -y update \
    && apt-get install -y --no-install-recommends telnet iputils-ping \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m -s /bin/bash tsoft

#Variable de Entorno
ENV HOME /home/tsoft

#Directorio de Trabajo
WORKDIR ${HOME}

#Jmeter
ADD https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz .

#Permisos y Espacio de Trabajo
RUN tar -zxvf apache-jmeter-${JMETER_VERSION}.tgz \
    && rm -f apache-jmeter-${JMETER_VERSION}.tgz \
    && mv apache-jmeter-${JMETER_VERSION} apache-jmeter \
    && mkdir -p apache-jmeter/bin/workspace/tests \
    && mkdir -p apache-jmeter/bin/workspace/data \
    && mkdir -p apache-jmeter/bin/workspace/results \
    && chown -R tsoft:tsoft apache-jmeter

#Variable de Entorno
ENV JMETER_HOME ${HOME}/apache-jmeter

#Usuario
USER tsoft

#Direcotio de Trabajo
WORKDIR ${JMETER_HOME}/bin

#Metadatos
LABEL jmeter_version=${JMETER_VERSION}
