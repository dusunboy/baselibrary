#!/bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

registry="docker.io"
repository="zhaojli/aspnet"
tag="3.1 5.0 6.0"

BUILD () {
for tag in ${tag};
do
    docker build --pull --no-cache -f ${dir}/mainline/${tag}/Dockerfile -t ${registry}/${repository}:${tag} ${dir}
done
}

TEST () {
for tag in ${tag};
do
    docker rm -f image-test
    docker run --name image-test -tid ${registry}/${repository}:${tag}
    docker exec -i image-test /bin/bash -c "dotnet --info"
    if [ $? -eq 0 ]; then
        echo "image run check success.";
    else
        echo "image run check faild.";
        exit 1;
    fi
done
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

