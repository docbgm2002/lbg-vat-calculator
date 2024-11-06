FROM node:19-alpine as build
### This does the heavy lifting
WORKDIR /app

COPY package.json .
#Install all dependencies
RUN npm install
# copies everything from the base folder. NOTE This comes after the RUN npm install command
COPY . . 

RUN npm run build

### This is what we will deploy
FROM nginx:1.23-alpine

COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
