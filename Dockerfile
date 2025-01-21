# Use a base image with R
FROM rocker/r-ver:4.3.1

# Install Plumber and JSONlite
RUN R -e "install.packages(c('plumber', 'jsonlite'))"

# Copy the R script into the container
COPY api.R /api.R

# Expose the port (Railway uses dynamic ports)
EXPOSE 8000

# Start the Plumber API
CMD ["R", "-e", "pr <- plumber::plumb('/api.R'); pr$run(host = '0.0.0.0', port = as.numeric(Sys.getenv('PORT')) )"]
