library(XML)
library(stringr)
library(foreign)



bcoin <- xmlToDataFrame("sitemap.xml")

print(bcoin)


# URL Length

bcoin$'URL_Length' <- nchar(bcoin$loc)

# @ symbol

bcoin$'having_At_Symbol' <- str_detect(bcoin$loc, "@")

# // after first //

split_df <- bcoin %>%
  select(loc) 
split1 <- as.data.frame(separate(split_df, loc, into = c(NA, 'domain'), sep = '//', remove = TRUE, extra = "merge"))
bcoin$'double_slash_redirecting' <- str_detect(split1$domain, "//")

# has -

bcoin$'Prefix_Suffix' <- str_detect(bcoin$loc, "-")

# https after http

bcoin$'Https_token' <- str_detect(split1$domain, "https")

# more than 1 . after www.

split2 <- as.data.frame(separate(split_df, loc, into = c(NA, 'domain'), sep = 'www.', remove = TRUE, extra = "merge"))
bcoin$'having_Sub_Domain' <- str_count(split2$domain, "\\.")

## RECODING

attach(bcoin)


bcoin$'URL_Length' <- case_when(
  URL_Length < 54 ~ -1,
  URL_Length >= 54 & URL_Length <= 75 ~ 0,
  URL_Length > 75 ~ 1
)

bcoin$'having_Sub_Domain' <- case_when(
  having_Sub_Domain == 1 ~ -1,
  having_Sub_Domain == 2 ~ 0,
  having_Sub_Domain >= 3 ~ 1
)

bcoin$'having_At_Symbol' <- case_when(
  having_At_Symbol == "FALSE" ~ -1,
  having_At_Symbol == "TRUE" ~ 1
)


bcoin$'double_slash_redirecting' <- case_when(
  double_slash_redirecting == "FALSE" ~ -1,
  double_slash_redirecting == "TRUE" ~ 1
)


bcoin$'Prefix_Suffix' <- case_when(
  Prefix_Suffix == "FALSE" ~ -1,
  Prefix_Suffix == "TRUE" ~ 1
)

bcoin$'Https_token' <- case_when(
  Https_token == "FALSE" ~ -1,
  Https_token == "TRUE" ~ 1
)

summary(bcoin)

## EXPORTING CSV'S OF TEST AND TRAIN

ML_Phish_data_all <- read.arff("Training Dataset.arff")

ML_Phish_data <- ML_Phish_data_all %>%
  select(URL_Length, HTTPS_token, Prefix_Suffix, double_slash_redirecting, having_At_Symbol)

summary(bcoin)


write.csv(bcoin, file = "Binance Test Dataset.csv")
write.csv(ML_Phish_data, file = "Binance Train Dataset.csv")


