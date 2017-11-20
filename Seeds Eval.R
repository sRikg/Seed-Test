names <- c("Company.Name, Company.Industry, Company.Sector, Fund.USD, Stake_percent, Fund.INR, Fund.Round, Company.Stage, Fund.Investors, Investors.Type, Investment.Date, Oct17.Exit.Status, Company.Website, Company.City, Company.Region, Company.Advisors, Investors.Advisors, Deal.Misc_Info, Deal.Link, Deal.Post_Money.Valuation.INR_Cr, Company.Revenue.Equity_Value.Market_Cap, Company.Revenue.Equity_Value.EBITDA, Company.Revenue.Equity_Value.PAT, Company.Price_to_Book, Company.Valuation, Company.Revenue.INR_Cr, Company.EBITDA.INR_Cr, Company.PAT.INR_Cr, Company.Book_Value.Share, Company.Price.Share, Company.Link.Financials")

names(data) <- unlist(strsplit(names, split = ", "))

data$Deal.Misc_Info <- as.character(data$Deal.Misc_Info)
data$Deal.Link <- as.character(data$Deal.Link)
data$Company.Website <- as.character(data$Company.Website)
data$Company.Valuation <- as.character(data$Company.Valuation)
data$Company.City <- as.character(data$Company.City)
data$Company.Region <- as.character(data$Company.Region)
data$Company.Advisors <- as.character(data$Company.Advisors)
data$Investors.Advisors <- as.character(data$Investors.Advisors)
data$Company.Name <- as.character(data$Company.Name)
data$Company.Industry <- as.character(data$Company.Industry)
data$Company.Sector <- as.character(data$Company.Sector)
data$Fund.Investors <- as.character(data$Fund.Investors)
data$Investors.Type <- as.character(data$Investors.Type)

data$Investment.Date <- as.character(data$Investment.Date)
data$Investment.Date <-  as.Date(paste0("01-", data$Investment.Date), format = "%d-%b-%y")

remove <- rownames(data[!is.na(data$Fund.INR),c(4,6)][which(data[!is.na(data$Fund.INR),c(4)]/data[!is.na(data$Fund.INR),c(6)] > 0.24),])
data1 <- data[-as.integer(remove),]
rm(remove)

data2 <- data1[!is.na(data1$Fund.INR) & !is.na(data1$Stake_percent),c(1,4:6)]

data2$value.USD <- data2[,2]*100/(data2[,3])
data2$value.INR <- data2[,4]*1000/(data2[,3])

data3 <- data2[!data2[,1] %in% names(table(data2[,1])[table(data2[,1])>1]),]

data4 <- data3[!data3$Company.Name %in% names(table(data1[data1$Company.Name %in% data3$Company.Name,1])[table(data1[data1$Company.Name %in% data3$Company.Name,1])

data1$Valuation_Calc_USDM[data1$Company.Name %in% data4$Company.Name] <- data4$value.USD
data1$Valuation_Calc_INRCr[data1$Company.Name %in% data4$Company.Name] <- data4$value.INR

