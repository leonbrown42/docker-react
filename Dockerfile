# to build: docker build .
# to run: docker run -p 8080:80 [imageID]
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#next phase is signified by the FROM
FROM nginx
# expose port 80 for elastic beanstalk specifically, otherwise "EXPOSE" does nothing.
EXPOSE 80
#copy from builder's app/build folder to nginx's html folder
COPY --from=builder /app/build /usr/share/nginx/html
# it auto starts