#A multi-step Dockerfile
#note that as "builder" is the name of this stage or phase
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#note each From step is the terminator of the successor step or block
FROM nginx
#the --from=stage tell that we want to do something with output of that specified stage
COPY --from=builder /app/build /usr/share/nginx/html 
