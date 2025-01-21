library(jsonlite)

data <- read.csv("input.csv")

data[sapply(data, is.numeric)] <- data[sapply(data, is.numeric)] + 1

i <- 0
summe <- 0
for (val in data) {
    if (i != 0){
        summe = summe + as.integer(val)
    }
    i = i+1
  
}

png('filename.png')
plot(summe)

result <- data.frame(summe = summe)
exportJSON <- toJSON(result)
write(exportJSON, "output.json")

while (!is.null(dev.list()))  dev.off()
