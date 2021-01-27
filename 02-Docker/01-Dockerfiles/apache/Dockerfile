# Base Image Def. 
FROM ubuntu:16.04

# Update the apt repo.
RUN apt-get update

# Install apache packages 
RUN apt-get install -y apache2 

# Copy the Custom Web Page
COPY index.html  /var/www/html/

# Exposed 
EXPOSE 80
EXPOSE 3306

# Start the apache service
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

