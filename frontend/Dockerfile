# FROM cirrusci/flutter:stable
FROM debian:stable-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip libglu1-mesa

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set Flutter to a specific version
RUN /usr/local/flutter/bin/flutter channel stable
RUN /usr/local/flutter/bin/flutter upgrade

# Set environment variables
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Verify Flutter and Dart SDK versions
RUN flutter --version
RUN dart --version

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages
RUN flutter pub get

# Build the Flutter application
RUN flutter build web

# Expose the port that the application will run on
EXPOSE 8088

# Run the Flutter application
CMD ["flutter", "run", "-d", "web-server", "--web-hostname", "0.0.0.0", "--web-port", "8088"]