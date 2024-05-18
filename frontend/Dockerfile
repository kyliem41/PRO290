FROM cirrusci/flutter:stable

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages
RUN flutter pub get

# Build the Flutter application
RUN flutter build web

# Expose the port that the application will run on
EXPOSE 8080

# Run the Flutter application
CMD ["flutter", "run", "-d", "web-server", "--web-hostname", "0.0.0.0", "--web-port", "8088"]