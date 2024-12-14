FROM node:20-alpine as builder
# as sectionName -> makes this a multi-stage configuration 
WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .
RUN npm run build

# A new FROM automatically ends a stage and starts a new one
FROM nginx
#COPY Files from builder stage image
COPY --from=builder /app/build /usr/share/nginx/html