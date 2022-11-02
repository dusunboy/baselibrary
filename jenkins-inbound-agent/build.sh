#!/bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

registry="docker.io"
repository="zhaojli/jenkins-inbound-agent"
tag="latest"

BUILD () {
for tag in ${tag};
do
    docker build --pull --no-cache -f ${dir}/Dockerfile -t ${registry}/${repository}:${tag} ${dir}
done
}

TEST () {
docker rm -f image-test
docker run --name image-test -tid ${registry}/${repository}:${tag} /bin/bash
docker exec -i image-test /bin/bash -c "jenkins-agent -version"
if [ $? -eq 0 ]; then
    echo "image run check success.";
else
    echo "image run check faild.";
    exit 1;
fi
docker rm -f image-test
}

PUSH () {
for tag in ${tag};
do
docker push ${registry}/${repository}:${tag}
done
}


HELP () {
cat << USAGE
usage:
    --build : Build images
    --push : Push images
    --test : Test images
USAGE
exit 0
}


case "${1}" in
--build)
        BUILD
        ;;
--push)
        PUSH
        ;;
--test)
        TEST
        ;;
*)
        HELP;
        ;;
esac

