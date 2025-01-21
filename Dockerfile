# Use the Rocker base image with R
FROM rocker/r-ver:4.3.1

# Install plumber
RUN R -e "install.packages('plumber')"

# Copy your R script into the Docker image
COPY api.R /api.R

# Set the command to run the Plumber API
CMD ["R", "-e", "pr <- plumber::plumb('/api.R'); pr$run(host = '0.0.0.0', port = 8000)"]
