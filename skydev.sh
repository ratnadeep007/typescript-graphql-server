if [ $# -eq 0 ]; then
    echo "No arguments passed"
fi

if [ $1 = "run" ]; then
    if [ $2 -eq 0 ]; then
        echo "Which one to run"
        echo "dev - to test locally"
        echo "deploy - to commit, push, build and run docker image"
    fi
    if [ $2 = "dev" ]; then
        yarn dev
    fi
    if [ $2 = "deploy" ]; then
        if [ $3 -eq 0 ]; then
            echo "Enter commit message"
            echo "Format skydev run deploy <message>"
        fi
        echo "Commiting and pushing"
        git add . && git commit -m "${3}"
        git push origin master
        echo "Building docker image"
        docker build -t ratnadeep007/ts-graphql-server .
        echo "Running docker image at port 4000"
        docker run -p 4000:4000 --name="test-gql" -d ratnadeep007/ts-graphql-server
        echo "Logs:"
        docker container logs test-gql
    fi 
fi

if [ $1 = "build" ]; then
    docker build -t ratnadeep007/ts-graphql-server .
fi

if [ $1 = "deploy" ]; then
    docker run -p 4000:4000 --name="test-gql" -d ratnadeep007/ts-graphql-server
fi

if [ $1 = "git" ]; then
    if [ $2 = "commit" ]; then
        git add . && git commit -m "${3}"
    fi
    if [ $2 = "push" ]; then
        git push origin master
    fi
fi

if [ $1 = "stop" ]; then
    docker container stop test-gql
fi

if [ $1 = "clean" ]; then
    if [ $2 = "all" ]; then
        echo "This will remove all images and cotainers related to this project"
        docker container stop test-gql
        docker container rm test-gql
        docker image rm ratnadeep007/ts-graphql-server
    fi

    if [ $2 = "image" ]; then
        echo "To remove image all containers related to image must be stoped and removed"
        docker image rm ratnadeep007/ts-graphql-server:latest
    fi

    if [ $2 = "container" ]; then
        echo "It will stop project container and remove it"
        docker container stop test-gql
        docker container rm test-gql
    fi
fi

