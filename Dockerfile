# Use the official MySQL image as the base image
FROM mysql:8.0.34-debian

RUN mkdir /app

WORKDIR /app

# Set environment variables for MySQL (replace with your desired values)
ENV MYSQL_ROOT_PASSWORD=raji123*
ENV MYSQL_DATABASE=devops
ENV MYSQL_USER=raji
ENV MYSQL_PASSWORD=raji123*

# Copy your custom database initialization script into the container

# Expose the MySQL port
EXPOSE 3306

# Start MySQL when the container runs
CMD ["mysqld"]
