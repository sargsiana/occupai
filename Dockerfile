# Example Dockerfile
FROM r-base:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev

# Install plumber
RUN R -e "install.packages('plumber')"

# Copy your app files
COPY . /app
WORKDIR /app

# Expose the port for Plumber API
EXPOSE 8000

# Run the Plumber API
CMD ["R", "-e", "pr <- plumber::plumb('api.R'); pr$run(host='0.0.0.0', port=8000)"]
