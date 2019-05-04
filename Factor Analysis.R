## LIBRARIES

library(psych)
library(GPArotation)


## READ IN DATA

url_jury <- read.csv("https://www.richardtwatson.com/data/jury.csv") %>%
  clean_names() %>%
  remove_empty()


## CREATING FACTORS
jury_factor <- url_jury
jury_factor <- jury_factor[complete.cases(url_jury),]
describe(jury_factor)

bartlett.test(jury_factor)

KMO(jury_factor)

jury_factor <- jury_factor %>%
  select(- crime,
         - gender_subject,
         -sentence,
         - serious,
         -gender_defendent,
         -phys_attr_manip,
         -phys_attr
  )

  results <- tibble(factors = integer())
start <- 3
end <- 7
jury_cor <- cor(jury_factor)
for(i in start:end) {
  fit <- fa(r = jury_cor,
            nfactors = i,
            rotate = "oblimin",
            fm = "minres")
  results[i-start + 1,1] <- i # recording fit measures
  results[i-start + 1,2] <- fit$rms # the sum of quared off diagonal residuals divided by dO
  results[i-start + 1,3] <- fit$crms # rmse adjusted for DoF
  results[i-start + 1,4] <- fit$fit # How well the factor model reproduce the correlation ma
  results[i-start + 1,5] <- fit$objective
}


colnames(results) <- c('factors', 'rms', 'crms', 'fit', 'objective')

ggplot(results) +
  geom_line(mapping = aes(factors, y = objective, color = 'fit$objective')) +
  geom_line(mapping = aes(x = factors, y = crms, color = 'fit$crms')) +
  geom_line(mapping = aes(x = factors, y = fit, color = 'fit')) +
  scale_color_hue() +
  labs(color = 'Measures') +
  xlab('Measure') +
  ylab('Factors')

fit <- fa(r = jury_cor, nfactors = 4, rotate = "oblimin", fm = "minres")
print(fit$loadings, cutoff = 0.5)

  fa.diagram(fit)
