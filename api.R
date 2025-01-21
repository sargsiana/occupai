# Load plumber library
library(plumber)

#* @post /greet
#* @param req The incoming request
#* @serializer unboxedJSON
function(req) {
  # Parse the JSON input
  input_data <- jsonlite::fromJSON(req$postBody)
  
  # Check for the 'name' field
  if (!"name" %in% names(input_data)) {
    return(list(error = "Input JSON must include a 'name' field."))
  }
  
  # Create a response
  name <- input_data$name
  response <- list(message = paste("Hello,", name, "! Welcome to the API."))
  
  return(response)
}
