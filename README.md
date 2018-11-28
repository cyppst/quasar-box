# quasar-box

docker build -t quasar-box .
docker run -it -v $PWD:/src quasar-box

quasar-box () {
        set -x 2>&1 >/dev/null
        args="$@" 2>&1 >/dev/null
        docker start [CONTAINER_ID] 2>&1 >/dev/null
        docker exec -it [CONTAINER_ID] $args
        docker stop [CONTAINER_ID] 2>&1 >/dev/null
}


alias quasar-box=quasar-box

