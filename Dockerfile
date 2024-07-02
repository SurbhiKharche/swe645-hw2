# Use an official Ubuntu image as a base
FROM --platform=linux/amd64 ubuntu:latest

# Update the package list 
RUN apt-get update 

#Install Nginx
Run apt-get install -y nginx

RUN rm /var/www/html/index.nginx-debian.html

# Copy index.html file to the Nginx html directory
COPY kubernetes/src/index.html /var/www/html/

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]

