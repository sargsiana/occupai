# Use the Rocker R image with Plumber pre-installed
FROM rocker/plumber

# Copy the R script into the Docker image
COPY api.R /api.R

# Run the Plumber API when the container starts
CMD ["R", "-e", "pr <- plumber::plumb('/api.R'); pr$run(host = '0.0.0.0', port = 8000)"]
