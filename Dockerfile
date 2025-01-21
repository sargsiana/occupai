# Use a base image with R and Plumber
FROM rocker/r-ver:4.3.1

# Install Plumber
RUN R -e "install.packages('plumber')"

# Copy your R script into the container
COPY api.R /api.R

# Expose the port (for Railway compatibility)
EXPOSE 8000

# Set the command to run your Plumber API
CMD ["R", "-e", "pr <- plumber::plumb('/api.R'); pr$run(host = '0.0.0.0', port = as.numeric(Sys.getenv('PORT')) )"]
