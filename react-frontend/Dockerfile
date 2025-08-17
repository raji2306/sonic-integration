# -------------------------
# Stage 1: Build React app
# -------------------------
FROM node:18-alpine AS build

# Set working directory
WORKDIR /react-app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all project files
COPY . .

# Set the backend URL at build time via env variable
ARG REACT_APP_SPRING_BOOT_URL
ENV REACT_APP_SPRING_BOOT_URL=$REACT_APP_SPRING_BOOT_URL

# Build the React app
RUN npm run build

# -------------------------
# Stage 2: Serve with Nginx
# -------------------------
FROM nginx:alpine

# Copy the React build output to Nginx html folder
COPY --from=build /react-app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
