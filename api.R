library(plumber)
library(plumber)
pr <- plumber::plumb("api.R")
pr$run(host = "0.0.0.0", port = as.numeric(Sys.getenv("PORT")))

#* @post /greet
#* @param req The incoming request
#* @serializer unboxedJSON
function(req) {
  input_data <- jsonlite::fromJSON(req$postBody)
  
  # Validate input
  if (!"name" %in% names(input_data)) {
    return(list(error = "Input JSON must include a 'name' field."))
  }
  
  name <- input_data$name
  response <- list(message = paste("Hello,", name, "! Welcome to Railway!"))
  
  return(response)
}
