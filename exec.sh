#/bin/bash
while getopts r:v:t:s: option; do
    case "${option}" in
        r) ROL=${OPTARG};;
        v) VOLUME=${OPTARG};;
        t) TEST=${OPTARG};;
        s) SERVER=${OPTARG};;
    esac
done
if [ ${ROL} = "server" ]; then
    docker run -d -i -t \
    -v ${VOLUME}/tests/data:/home/tsoft/apache-jmeter/bin/workspace/data \
    -v ${VOLUME}/certificate:/home/tsoft/apache-jmeter/bin/workspace/certificate \
    -p 1099:1099 \
    --name jmeter-server --hostname jmeter-server --rm tsoft/jmeter-server
elif [ ${ROL} = "master" ]; then
    docker run -i -t \
    -v ${VOLUME}/tests:/home/tsoft/apache-jmeter/bin/workspace/tests \
    -v ${VOLUME}/results:/home/tsoft/apache-jmeter/bin/workspace/results \
    -v ${VOLUME}/certificate:/home/tsoft/apache-jmeter/bin/workspace/certificate \
    -e test_name=${TEST} -e ip_server=${SERVER} \
    --name jmeter-master --hostname jmeter-master --rm tsoft/jmeter-master
fi