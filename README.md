1.docker build -t quasar-box .
2.docker run -it -v $PWD:/src --name quasar-box quasar-box

q-box () {
        set -x 2>&1 >/dev/null
        args="$@" 2>&1 >/dev/null
        docker start quasar-box 2>&1 >/dev/null
        docker exec -it quasar-box $args
        docker stop quasar-box 2>&1 >/dev/null
}

alias qbox=q-box
