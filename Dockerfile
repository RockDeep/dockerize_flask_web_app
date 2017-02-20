FROM ubuntu:14.04

# Update OS
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade

# Install Python
RUN apt-get install -y python-dev python-pip

# Add requirements.txt
# Create app directory
ADD . /webapp

# Install wsgi Python web server
RUN pip install uwsgi
# Install app requirements
# Full path to requirements
RUN pip install -r /webapp/requirements.txt

# Set the default directory for our environment
ENV HOME /webapp
WORKDIR /webapp

# Expose port 8000 for uwsgi
EXPOSE 8000

ENTRYPOINT ["uwsgi", "--http", "0.0.0.0:8000", "--module", "app:app", "--processes", "1", "--threads", "8"]