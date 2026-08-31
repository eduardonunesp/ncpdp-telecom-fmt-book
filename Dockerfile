FROM node:22-alpine AS builder
WORKDIR /build
COPY package.json ./
RUN npm install
COPY docs/ docs/
RUN npx honkit build docs

FROM alpine:3
RUN apk add --no-cache nginx
COPY --from=builder /build/docs/_book /usr/share/nginx/html
COPY nginx.conf /etc/nginx/http.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]