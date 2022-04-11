setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(readxl)

#league stats
leagueShooting <- read_excel(path = '2022-student-research-case-study-player-data.xlsx',
                             sheet = 'League Shooting', range = 'B12:AA5566', col_names = TRUE)
leaguePassing <- read_excel(path = '2022-student-research-case-study-player-data.xlsx',
                            sheet = 'League Passing', range = 'B12:AF5566', col_names = TRUE)
leagueDefense <- read_excel(path = '2022-student-research-case-study-player-data.xlsx',
                            sheet = 'League Defense', range = 'B12:AG5566', col_names = TRUE)
leagueGoalkeeping <- read_excel(path = '2022-student-research-case-study-player-data.xlsx',
                                sheet = 'League Goalkeeping', range = 'B12:AB425', col_names = TRUE)

#tournament stats
tournaShooting <- read_excel(path = '2022-student-research-case-study-player-data.xlsx',
                             sheet = 'Tournament Shooting', range = 'B12:Z2027', col_names = TRUE)
tournaPassing <- read_excel(path = '2022-student-research-case-study-player-data.xlsx',
                            sheet = 'Tournament Passing', range = 'B12:AE500', col_names = TRUE)
tournaDefense <- read_excel(path = '2022-student-research-case-study-player-data.xlsx',
                            sheet = 'Tournament Defense', range = 'B12:AF500', col_names = TRUE)
tournaGoalkeeping <- read_excel(path = '2022-student-research-case-study-player-data.xlsx',
                             sheet = 'Tournament Goalkeeping', range = 'B12:AA141', col_names = TRUE)

#tournament results
results_2020 <- read_excel(path = '2022-student-research-case-study-player-data.xlsx',
                           sheet = 'Tournament Results', range = 'B11:C27', col_names = TRUE)
results_2021 <- read_excel(path = '2022-student-research-case-study-player-data.xlsx',
                           sheet = 'Tournament Results', range = 'E11:F35', col_names = TRUE)

#salaries
salaries_2020 <- read_excel(path = '2022-student-research-case-study-player-data.xlsx',
                            sheet = '2020 Salaries', range = 'B12:G2744', col_names = TRUE)
salaries_2021 <- read_excel(path = '2022-student-research-case-study-player-data.xlsx',
                            sheet = '2021 Salaries', range = 'B12:G2834', col_names = TRUE)
names(salaries_2020)[1] <- 'Player'
names(salaries_2020)[6] <- 'Annualized Salary 2020'
names(salaries_2021)[1] <- 'Player'
names(salaries_2021)[6] <- 'Annualized Salary 2021'


library(dplyr)
library(CPP)
set.seed(1)

#league
#goalkeeping

#Excluding players who played less than 6 full games or less during the year
leagueGK_viable <- (leagueGoalkeeping %>% filter(`Playing Time Min` >= 6*90)
                             %>% filter(Age < 40))

#2020
#Excluding invalid data
leagueGK_2020 <- (leagueGK_viable %>% filter(Year == 2020)
                           %>% filter(`Performance CS%`>0))

#Taking relevant KPIs to run the CPP model on:
model1 <- CPP.Axes.Beta(cbind(leagueGK_2020[,c(15,20)],-leagueGK_2020[,12]), s = 4)

leagueGK_2020 <- leagueGK_2020 %>% mutate(ranks_2020 = rank(rowSums(model1$Axes[,c(2,4)]),ties.method = 'min'))


#2021
#Excluding invalid data
leagueGK_2021 <- (leagueGK_viable %>% filter(Year == 2021)
                           %>% filter(`Performance CS%`>0))

#Taking relevant KPIs to run the CPP model on:
model2 <- CPP.Axes.Beta(cbind(leagueGK_2021[,c(15,20)],-leagueGK_2021[,12]), s = 4)

leagueGK_2021 <- leagueGK_2021 %>% mutate(ranks_2021 = rank(rowSums(model2$Axes[,c(2,4)]),ties.method = 'min'))

#Final goalkeeper ranking:
leagueGK_ranks <- full_join(leagueGK_2020,leagueGK_2021, by = "Player")
leagueGK_ranks <- left_join(leagueGK_ranks,salaries_2020, by = 'Player')
leagueGK_ranks <- left_join(leagueGK_ranks,salaries_2021, by = 'Player')
leagueGK_ranks <- leagueGK_ranks[!duplicated(leagueGK_ranks$Player),]

################################################################################
#other positions

#renaming to avoid duplicate columns with different values - so we can merge
names(leagueDefense)[7] <- '90s_def'
names(leaguePassing)[7] <- '90s_pass'
names(leagueShooting)[7] <- '90s_shoot'

#merging...
leagueStats <- left_join(leagueDefense,leaguePassing)
leagueStats <- left_join(leagueStats,leagueShooting)

#error-checking
View(leagueStats[which.max(rowMeans(is.na(leagueStats))),])

#checking the 'Pos' categorisations
unique(leagueStats$Pos)

#FWs
leagueFW_viable <- (leagueStats %>% filter(`Pos` == 'FW'|`Pos` == 'MFFW'|`Pos` == 'FWMF'|`Pos` == 'FWDF')
                    %>% filter(`90s_shoot` >= 6)
                    %>% filter(Age < 40))

leagueFW_2020 <- (leagueFW_viable %>% filter(Year == 2020)
                  %>% filter(`Standard SoT%` > 0)
                  %>% filter(`Standard SoT/90` > 0)
                  %>% filter(`Standard G/SoT`> 0)
                  %>% filter(`Gls`> 0))

model3 <- CPP.Axes.Beta(cbind(leagueFW_2020[,c(60,62,64)],1+leagueFW_2020[,72]), s = 4)

leagueFW_2020 <- leagueFW_2020 %>% mutate(ranks_2020 = rank(rowSums(model3$Axes[,c(2,4)]),ties.method = 'min'))

leagueFW_2021 <- (leagueFW_viable %>% filter(Year == 2021)
                  %>% filter(`Standard SoT%` > 0)
                  %>% filter(`Standard SoT/90` > 0)
                  %>% filter(`Standard G/SoT`> 0)
                  %>% filter(`Gls`> 0))

model4 <- CPP.Axes.Beta(cbind(leagueFW_2021[,c(60,62,64)],1+leagueFW_2021[,72]), s = 4)

leagueFW_2021 <- leagueFW_2021 %>% mutate(ranks_2021 = rank(rowSums(model4$Axes[,c(2,4)]),ties.method = 'min'))

#Final FW ranking:
leagueFW_ranks <- full_join(leagueFW_2020,leagueFW_2021,by = 'Player')
leagueFW_ranks <- left_join(leagueFW_ranks,salaries_2020,by = 'Player')
leagueFW_ranks <- left_join(leagueFW_ranks,salaries_2021,by = 'Player')
leagueFW_ranks <- leagueFW_ranks[!duplicated(leagueFW_ranks$Player),]

#MF
leagueMF_viable <- (leagueStats %>% filter(`Pos` == 'MF'|`Pos` == 'MFDF'|`Pos` == 'MFFW'|`Pos` == 'FWMF'|`Pos` == 'DFMF')
                    %>% filter(`90s_shoot` >= 6)
                    %>% filter(Age < 40))

leagueMF_2020 <- (leagueMF_viable %>% filter(Year == 2020))
 
model5 <- CPP.Axes.Beta(as.matrix(leagueMF_2020[,c(8,41,44,47)]), s = 4)

leagueMF_2020 <- leagueMF_2020 %>% mutate(ranks_2020 = rank(rowSums(model5$Axes[,c(2,4)]),ties.method = 'min'))

leagueMF_2021 <- (leagueMF_viable %>% filter(Year == 2021))

model6 <- CPP.Axes.Beta(as.matrix(leagueMF_2021[,c(8,41,44,47)]), s = 4)

leagueMF_2021 <- leagueMF_2021 %>% mutate(ranks_2021 = rank(rowSums(model6$Axes[,c(2,4)]),ties.method = 'min'))

#Final MF ranking:
leagueMF_ranks <- full_join(leagueMF_2020,leagueMF_2021,by = 'Player')
leagueMF_ranks <- left_join(leagueMF_ranks,salaries_2020,by = 'Player')
leagueMF_ranks <- left_join(leagueMF_ranks,salaries_2021,by = 'Player')
leagueMF_ranks <- leagueMF_ranks[!duplicated(leagueMF_ranks$Player),]

#DF
leagueDF_viable <- (leagueStats %>% filter(`Pos` == 'DF'|`Pos` == 'MFDF'|`Pos` == 'DFFW'|`Pos` == 'DFMF'|`Pos` == 'FWDF')
                    %>% filter(`90s_shoot` >= 6)
                    %>% filter(Age < 40))

leagueDF_2020 <- (leagueDF_viable %>% filter(Year == 2020)
                  %>% filter(`Vs Dribbles Tkl%`>0)
                  %>% filter(`Blocks Sh` > 0))

model7 <- CPP.Axes.Beta(as.matrix(leagueDF_2020[,c(8,9,15,17,19,26,27)]), s = 4)

leagueDF_2020 <- leagueDF_2020 %>% mutate(ranks_2020 = rank(rowSums(model7$Axes[,c(2,4)]),ties.method = 'min'))

leagueDF_2021 <- (leagueDF_viable %>% filter(Year == 2021)
                  %>% filter(`Vs Dribbles Tkl%`>0)
                  %>% filter(`Blocks Sh` > 0))

model8 <- CPP.Axes.Beta(as.matrix(leagueDF_2021[,c(8,9,15,17,19,26,27)]), s = 4)

leagueDF_2021 <- leagueDF_2021 %>% mutate(ranks_2021 = rank(rowSums(model8$Axes[,c(2,4)]),ties.method = 'min'))

#Final MF ranking:
leagueDF_ranks <- full_join(leagueDF_2020,leagueDF_2021,by = 'Player')
leagueDF_ranks <- left_join(leagueDF_ranks,salaries_2020,by = 'Player')
leagueDF_ranks <- left_join(leagueDF_ranks,salaries_2021,by = 'Player')
leagueDF_ranks <- leagueDF_ranks[!duplicated(leagueDF_ranks$Player),]

#Results of interest
leagueGK_ranks[,c(1,28,55,60,65)]
leagueFW_ranks[,c(1,74,147,152,157)]
leagueMF_ranks[,c(1,74,147,152,157)]
leagueDF_ranks[,c(1,74,147,152,157)]

sessionInfo()







































