library(plumber)
pr <- plumber::plumb("api.R")
pr$run(host = "0.0.0.0", port = as.numeric(Sys.getenv("PORT")))


# Define a function to process the survey data
#* @post /process_survey
#* @param req The incoming request
#* @serializer unboxedJSON
function(req) {
  # Parse the JSON input
  input_data <- jsonlite::fromJSON(req$postBody)

  # Ensure the input contains the required 'score' field
  if (!"score" %in% names(input_data)) {
    return(list(error = "Input JSON must include a 'score' field with an array of numbers."))
  }

  # Perform processing (example: calculate mean)
  scores <- input_data$score
  if (!is.numeric(scores)) {
    return(list(error = "The 'score' field must contain numeric values."))
  }

  # Calculate summary statistics
  result <- list(
    mean_score = mean(scores),
    min_score = min(scores),
    max_score = max(scores),
    count = length(scores)
  )

  return(result)
}
