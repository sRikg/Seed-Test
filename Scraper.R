library(rvest)

temp <- as.character(
          html_nodes(read_html("http://trak.in/india-startup-funding-investment-2015/"), 
          xpath = "//body//div//div//main//div//div//div//div//article//div//h3"))
temp <- as.character(temp)

URLs <- sapply(1:31, function(i) unlist(strsplit(temp[i], split=" "))[grep(unlist(strsplit(temp[i], split=" ")), pattern = "href")])
URLs <- sapply(1:31, function(i) unlist(strsplit(URLs[i], split = "http://"))[2])
URLs <- sapply(1:31, function(i) substr(URLs[i], 1, nchar(URLs[i])-2))

hh <- list()
dt <- list()

for(i in 1:length(URLs)) {hh[[i]] <- read_html(paste0("http://", URLs[i]))
print(i)}

dt <- as.data.frame(matrix(ncol = 10, NA))

temp <- as.character(
          html_nodes(
            hh[[1]], 
            xpath = "//body//div//div//main//div//div//div//div//article//div//table//tbody"
                    )
                    )

temp <- unlist(strsplit(temp, split = "</tr>"))

dt <- as.data.frame(
        lapply(
          2:length(temp), 
          function(i) unlist(strsplit(
                          unlist(strsplit(
                              unlist(strsplit(
                                      temp[i], 
                                      split = "\n")),
                                     split = ">")), 
                              split = "<"))[
                              c(5, 9, 14, 17, 25, 29, 33, 37, 43, 51)]
              ), 
         nrow = (length(temp)-1) ,
         ncol = 10
                    )



