#/bin/bash
while getopts r:v:p:t:s: option; do
    case "${option}" in
        r) ROL=${OPTARG};;
        v) VOLUME=${OPTARG};;
        p) PORT=${OPTARG};;
        t) TEST=${OPTARG};;
        s) SERVER=${OPTARG};;
    esac
done
if [ ${ROL} = "server" ]; then
    docker run -d -i -t \
    -v ${VOLUME}/tests/data:/home/tsoft/apache-jmeter-4.0/bin/tsoft/tests/data \
    -v ${VOLUME}/certificate:/home/tsoft/apache-jmeter-4.0/bin/tsoft/certificate \
    -p ${PORT}:1099 \
    --name jmeter-server \
    --rm \
    tsoft/jmeter-server:4.0
elif [ ${ROL} = "master" ]; then
    docker run -i -t \
    -v ${VOLUME}/tests:/home/tsoft/apache-jmeter-4.0/bin/tsoft/tests \
    -v ${VOLUME}/results:/home/tsoft/apache-jmeter-4.0/bin/tsoft/results \
    -v ${VOLUME}/certificate:/home/tsoft/apache-jmeter-4.0/bin/tsoft/certificate \
    -e test_name=${TEST} \
    -e ip_server=${SERVER} \
    --name jmeter-master \
    --rm \
    tsoft/jmeter-master:4.0
fi