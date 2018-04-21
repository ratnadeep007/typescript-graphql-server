if [ $# -eq 0 ]; then
    echo "No arguments passed"
fi

if [ $1 = "run" ]; then
    yarn dev
fi

if [ $1 = "build" ]; then
    docker build -t ratnaeep007/ts-graphql-server .
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