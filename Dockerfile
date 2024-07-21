# Use an official Python runtime as the base image
#FROM mcr.microsoft.com/azure-functions/python:3.10
FROM python:3.10

# Set the working directory inside the container
WORKDIR /home/site/wwwroot

# Copy the project files into the container
COPY . .

# Install required Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Install Node.js and npm using apk (for Alpine)
#RUN apk add nodejs npm

# Install Node.js and npm using apt-get (for Ubuntu)
RUN apt-get update && apt-get install -y nodejs npm

# Install the Azure Functions Core Tools
RUN npm install -g azure-functions-core-tools@4 --unsafe-perm true

# Set the environment variables for your MySQL connection
#ENV MYSQL_USER=<your_mysql_user>
#ENV MYSQL_PASSWORD=<your_mysql_password>
#ENV MYSQL_HOST=<your_mysql_host>
#ENV MYSQL_PORT=<your_mysql_port>
#ENV MYSQL_DATABASE=<your_mysql_database>

# Set the Azure Functions runtime
ENV FUNCTIONS_WORKER_RUNTIME=python

# Expose the port for the Azure Functions host
EXPOSE 7071

# Initialize the Azure Functions project
RUN func init --worker-runtime python

# Define the command to run when the container starts
CMD ["func", "start"]

