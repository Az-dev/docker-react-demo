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
#to tell a service like elasticbeans on aws to do the port mapping to the aws instance on port 80 in this case
#Hint: as i got on our local machine this doesnot have effect
EXPOSE 80
#the --from=stage tell that we want to do something with output of that specified stage
COPY --from=builder /app/build /usr/share/nginx/html 
