# Build stage
FROM node:18-alpine AS build
WORKDIR /app

# Accept build arg for backend URL
ARG REACT_APP_SPRING_BOOT_URL=""
ENV REACT_APP_SPRING_BOOT_URL=$REACT_APP_SPRING_BOOT_URL

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# Optional: copy custom nginx config if needed
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
