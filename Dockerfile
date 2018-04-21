FROM node:carbon

RUN apt-get update

RUN apt-get install git -y

RUN git clone https://github.com/ratnadeep007/typescript-graphql-server.git usr/src/app

WORKDIR /usr/src/app

RUN npm install

EXPOSE 4000

CMD ["npm", "prod"]
