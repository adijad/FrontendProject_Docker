# Configuration for BUILD phase
# Use an existing docker image as a base
FROM node:16-alpine as builder
WORKDIR '/app'

# Download and install a dependency
COPY ./package.json ./
RUN npm install
COPY ./ ./
# RUN mkdir node_modules/.cache && chmod -R 777 node_modules/.cache

# Tell the image what to do when it starts
# CMD [ "npm", "run", "start" ]
RUN npm run build


# Configuration for RUN phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html


