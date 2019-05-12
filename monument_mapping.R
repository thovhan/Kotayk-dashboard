mapping <- read.csv('object_code_mapping.csv', sep = ',', header = FALSE,
        fileEncoding = "UTF-16")

mapping$V2 = sub("^\\s+", "", as.character(mapping$V2))

colnames(mapping) <- c("Name", "Code")