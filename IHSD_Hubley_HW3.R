

library(tidyverse)
library(tidyverse)
library(haven)
library(formatR)
library(Hmisc)
#install.packages("survey") 
library(survey)
#install.packages("srvyr")
#library(srvyr)
#install.packages("weights")
library(weights)

View(Zambia_HH_2023 )
names(Zambia_HH_2023)
names(Zambia_HH_2023)[names(Zambia_HH_2023) == "HV022"] <- "Sample_stratum_number"
names(Zambia_HH_2023)[names(Zambia_HH_2023) == "HV023"] <- "Sample_domain"
names(Zambia_HH_2023)[names(Zambia_HH_2023) == "HV002"] <- "Household_number"
names(Zambia_HH_2023)[names(Zambia_HH_2023) == "HV005"] <- "Sample_weight"
names(Zambia_HH_2023)[names(Zambia_HH_2023) == "HV009"] <- "Number_HH_members"
names(Zambia_HH_2023)[names(Zambia_HH_2023) == "HV014"] <- "Number_children_5_under"
names(Zambia_HH_2023)[names(Zambia_HH_2023) == "HV021"] <- "Primary_sampling_unit"
names(Zambia_HH_2023)

describe(Zambia_HH_2023)


length(unique(Zambia_HH_2023$Primary_sampling_unit)) 
length(unique(Zambia_HH_2023$Sample_domain))
length(unique(Zambia_HH_2023$Household_number)) 

range=as.data.frame(table(Zambia_HH_2023$Primary_sampling_unit))

diff(range.default(range))

min(range$Freq)
max(range$Freq)

length(unique(Zambia_HH_2023$Sample_domain)) 

length(unique(Zambia_HH_2023$Sample_stratum_number)) 

Zambia_HH_2023$porw = Zambia_HH_2023$Sample_weight/1000000

res_ITN <- table(Zambia_HH_2023$HH_residence, Zambia_HH_2023$HH_has_ITN)
prop.table(HH_has_ITN,1)
View (res_ITN)

Urban.ITN <- subset(Zambia_HH_2023, subset=(HH_residence=="Urban"))#creates subset featuring only HHs in urban areas
attach(Urban.ITN)# makes objects in data frames (urban subset) accessible without actually typing the name of the data frame

Rural.ITN <- subset(Zambia_HH_2023, subset=(HH_residence=="Rural")) #creates subset featuring only HHs in rural areas
attach(Rural.ITN)# make objects in data frames accessible (rural subset) without actually typing the name of the data frame

#Now we want to calculate the proportion (and standard error) of HHs in urban areas that have electricity:

mean.urban <- mean(Urban.ITN$HH_has_ITN)# Calculates the proportion of people living in urban areas with electricity
mean.urban #prints results
se.urban <-sqrt(var(Urban.ITN$HH_has_ITN,na.rm=TRUE)/length(na.omit(Urban.ITN$HH_has_ITN)))#calculates standard error
se.urban# prints results

#And in rural areas
mean.rural <- mean(Rural.ITN$HH_has_ITN)# Calculates the proportion of people living in urban areas with electricity
mean.rural #prints results
se.rural <-sqrt(var(Rural.ITN$HH_has_ITN,na.rm=TRUE)/length(na.omit(Rural.ITN$HH_has_ITN)))#calculates standard error
se.rural# prints results

edu_ITN <- table(Zambia_HH_2023$HH_head_education,Zambia_HH_2023$HH_has_ITN) 
prop.table(edu_ITN,1)
edu_ITN

mean((Zambia_HH_2023$HH_head_education=="No education"))

Noedu.ITN <- subset(Zambia_HH_2023, subset=(HH_head_education=="No education"))
attach(Noedu.ITN)
Primary.ITN <- subset(Zambia_HH_2023, subset=(HH_head_education=="Primary"))
attach(Primary.ITN)
Secondary.ITN <- subset(Zambia_HH_2023, subset=(HH_head_education=="Secondary"))
attach(Secondary.ITN)
Higher.ITN <- subset(Zambia_HH_2023, subset=(HH_head_education=="Higher than"))
attach(Higher.ITN)

View(Noedu_ITN)

mean.none <- mean(Noedu.ITN$HH_has_ITN) #No education
mean.none
se.none <-sqrt(var(Noedu.ITN$HH_has_ITN,na.rm=TRUE)/length(na.omit(Noedu.ITN$HH_has_ITN)))
se.none
mean.primary<- mean(Primary.ITN$HH_has_ITN)#Primary
mean.primary
se.primary <-sqrt(var(Primary.ITN$HH_has_ITN,na.rm=TRUE)/length(na.omit(Primary.ITN$HH_has_ITN)))
se.primary
mean.secondary<- mean(Secondary.ITN$HH_has_ITN)#Secondary
mean.secondary
se.secondary <-sqrt(var(Secondary.ITN$HH_has_ITN,na.rm=TRUE)/length(na.omit(Secondary.ITN$HH_has_ITN)))
se.secondary
mean.higher <- mean(Higher.ITN$HH_has_ITN)#Higher than
mean.higher
se.higher <-sqrt(var(Higher.ITN$HH_has_ITN,na.rm=TRUE)/length(na.omit(Higher.ITN$HH_has_ITN)))
se.higher

lowestSES.ITN <- subset(Zambia_HH_2023, subset=(HH_wealth_index=="Lowest"))
attach(lowestSES.ITN)
lowSES.ITN <- subset(Zambia_HH_2023, subset=(HH_wealth_index=="Fourth"))
attach(lowSES.ITN)
middleSES.ITN <- subset(Zambia_HH_2023, subset=(HH_wealth_index=="Middle"))
attach(middleSES.ITN)
richSES.ITN <- subset(Zambia_HH_2023, subset=(HH_wealth_index=="Second"))
attach(richSES.ITN)
richestSES.ITN <- subset(Zambia_HH_2023, subset=(HH_wealth_index=="Highes"))
attach(richestSES.ITN)

mean.lowest <- mean(lowestSES.ITN$HH_has_ITN) #No education
mean.lowest
se.lowest <-sqrt(var(lowestSES.ITN$HH_has_ITN,na.rm=TRUE)/length(na.omit(lowestSES.ITN$HH_has_ITN)))
se.lowest
mean.low<- mean(lowSES.ITN$HH_has_ITN)#Primary
mean.low
se.low <-sqrt(var(lowSES.ITN$HH_has_ITN,na.rm=TRUE)/length(na.omit(lowSES.ITN$HH_has_ITN)))
se.low
mean.middle<- mean(middleSES.ITN$HH_has_ITN)#Secondary
mean.middle
se.middle <-sqrt(var(middleSES.ITN$HH_has_ITN,na.rm=TRUE)/length(na.omit(middleSES.ITN$HH_has_ITN)))
se.middle
mean.rich <- mean(richSES.ITN$HH_has_ITN)#Higher than
mean.rich
se.rich <-sqrt(var(richSES.ITN$HH_has_ITN,na.rm=TRUE)/length(na.omit(richSES.ITN$HH_has_ITN)))
se.rich
mean.richest <- mean(richestSES.ITN$HH_has_ITN)#Higher than
mean.richest
se.richest <-sqrt(var(richestSES.ITN$HH_has_ITN,na.rm=TRUE)/length(na.omit(richestSES.ITN$HH_has_ITN)))
se.richest

ITN_urban_m <- weighted.mean(Urban.ITN$HH_has_ITN, Urban.ITN$porw, na.rm=TRUE)
ITN_urban_m
ITN_rural_m <- weighted.mean(Rural.ITN$HH_has_ITN, Rural.ITN$porw, na.rm=TRUE)
ITN_rural_m

dim(Urban.ITN)
dim(Rural.ITN)


DHSs_SRS_wtd<-svydesign(ids= ~1, weights=~porw, data=Zambia_HH_2023, nest=TRUE)

ITN.Res.SRS <- svyby(~HH_has_ITN, ~HH_residence, DHSs_SRS_wtd, svymean, na.rm=TRUE) #Residence
ITN.Res.SRS


DHS_Clstr_wtd<-svydesign(ids= ~Primary_sampling_unit, weights=~porw, data=Zambia_HH_2023, nest=TRUE)

ITN.Res.Clstr <- svyby(~HH_has_ITN, ~HH_residence, DHS_Clstr_wtd, svymean, na.rm=TRUE) #Residence
ITN.Res.Clstr

#Has electricity by education level

ITN.Edu.Clstr<- svyby(~HH_has_ITN, ~HH_head_education, DHS_Clstr_wtd, svymean, na.rm=TRUE)
ITN.Edu.Clstr

ITN.SES.SRS<- svyby(~HH_has_ITN, ~HH_wealth_index, DHSs_SRS_wtd, svymean, na.rm=TRUE)
ITN.SES.SRS

ITN.SES.Clstr<- svyby(~HH_has_ITN, ~HH_wealth_index, DHS_Clstr_wtd, svymean, na.rm=TRUE)
ITN.SES.Clstr

DHS_Clstr_strat <-svydesign(ids= ~Primary_sampling_unit, strata= ~Sample_stratum_number, weights=~porw,data=Zambia_HH_2023, nest=TRUE)

ITN.Res.Strat <- svyby(~HH_has_ITN, ~HH_residence, DHS_Clstr_strat, svymean, na.rm=TRUE) #Residence
ITN.Res.Strat

ITN.SES.Strat <- svyby(~HH_has_ITN, ~HH_head_education, DHS_Clstr_strat, svymean, na.rm=TRUE) 
ITN.SES.Strat

ITN.edu.Strat <- svyby(~HH_has_ITN, ~HH_head_education, DHS_Clstr_strat, svymean, na.rm=TRUE) 
ITN.edu.Strat

zambia_child<-read.csv(file ="/Users/ClaireHubley/Documents/IHSDrstudio/IHSD_7440_HH_Sampling/2007_Zambia_Child_2023.csv")
View(zambia_child)


names(zambia_child)
names(zambia_child)[names(zambia_child) == "V022"] <- "Sample_stratum_number"
names(zambia_child)[names(zambia_child) == "V023"] <- "Sample_domain"
names(zambia_child)[names(zambia_child) == "V002"] <- "Household_number"
names(zambia_child)[names(zambia_child) == "V005"] <- "Sample_weight"
names(zambia_child)[names(zambia_child) == "V021"] <- "Primary_sampling_unit"
names(zambia_child)

library(Hmisc)

length(unique(zambia_child$Primary_sampling_unit)) 
describe(zambia_child)

zambia_child$porw = zambia_child$Sample_weight/1000000

res.ch_ITN <- table(zambia_child$HH_residence, zambia_child$Slept_ITN)
prop.table(res.ch_ITN,1)
View (res.ch_ITN)

Urban.chITN <- subset(zambia_child, subset=(HH_residence=="Urban"))#creates subset featuring only HHs in urban areas
attach(Urban.ITN)# makes objects in data frames (urban subset) accessible without actually typing the name of the data frame

Rural.chITN <- subset(zambia_child, subset=(HH_residence=="Rural")) #creates subset featuring only HHs in rural areas
attach(Rural.chITN)

mean.churban <- mean(Urban.chITN$Slept_ITN)# Calculates the proportion of people living in urban areas with electricity
mean.churban #prints results
se.churban <-sqrt(var(Urban.chITN$Slept_ITN,na.rm=TRUE)/length(na.omit(Urban.chITN$Slept_ITN)))#calculates standard error
se.churban# prints results

#And in rural areas
mean.chrural <- mean(Rural.chITN$Slept_ITN)# Calculates the proportion of people living in urban areas with electricity
mean.chrural #prints results
se.chrural <-sqrt(var(Rural.chITN$Slept_ITN,na.rm=TRUE)/length(na.omit(Rural.chITN$Slept_ITN)))#calculates standard error
se.chrural

zero.chITN <- subset(zambia_child, subset=(Child_age==0))#creates subset featuring only HHs in urban areas
attach(zero.chITN)# makes objects in data frames (urban subset) accessible without actually typing the name of the data frame

one.chITN <- subset(zambia_child, subset=(Child_age==1)) #creates subset featuring only HHs in rural areas
attach(one.chITN)

two.chITN <- subset(zambia_child, subset=(Child_age==2)) #creates subset featuring only HHs in rural areas
attach(two.chITN)

three.chITN <- subset(zambia_child, subset=(Child_age==3)) #creates subset featuring only HHs in rural areas
attach(three.chITN)

four.chITN <- subset(zambia_child, subset=(Child_age==4)) #creates subset featuring only HHs in rural areas
attach(four.chITN)

mean.ch.zero <- mean(zero.chITN$Slept_ITN)# Calculates the proportion of people living in urban areas with electricity
mean.ch.zero #prints results
se.ch.zero <-sqrt(var(zero.chITN$Slept_ITN,na.rm=TRUE)/length(na.omit(zero.chITN$Slept_ITN)))#calculates standard error
se.ch.zero# prints results

mean.ch.one <- mean(one.chITN$Slept_ITN)# Calculates the proportion of people living in urban areas with electricity
mean.ch.one #prints results
se.ch.one <-sqrt(var(one.chITN$Slept_ITN,na.rm=TRUE)/length(na.omit(one.chITN$Slept_ITN)))#calculates standard error
se.ch.one # prints results

mean.ch.two <- mean(two.chITN$Slept_ITN)# Calculates the proportion of people living in urban areas with electricity
mean.ch.two #prints results
se.ch.two <-sqrt(var(two.chITN$Slept_ITN,na.rm=TRUE)/length(na.omit(two.chITN$Slept_ITN)))#calculates standard error
se.ch.two # prints results

mean.ch.three <- mean(three.chITN$Slept_ITN)# Calculates the proportion of people living in urban areas with electricity
mean.ch.three #prints results
se.ch.three <-sqrt(var(three.chITN$Slept_ITN,na.rm=TRUE)/length(na.omit(three.chITN$Slept_ITN)))#calculates standard error
se.ch.three # prints results

mean.ch.four <- mean(four.chITN$Slept_ITN)# Calculates the proportion of people living in urban areas with electricity
mean.ch.four #prints results
se.ch.four <-sqrt(var(four.chITN$Slept_ITN,na.rm=TRUE)/length(na.omit(four.chITN$Slept_ITN)))#calculates standard error
se.ch.four # prints results

poorest.chITN <- subset(zambia_child, subset=(HH_wealth_index=="Lowest")) #creates subset featuring only HHs in rural areas
attach(poorest.chITN)

poor.chITN <- subset(zambia_child, subset=(HH_wealth_index=="Fourth")) #creates subset featuring only HHs in rural areas
attach(poor.chITN)

middle.chITN <- subset(zambia_child, subset=(HH_wealth_index=="Middle")) #creates subset featuring only HHs in rural areas
attach(middle.chITN)

rich.chITN <- subset(zambia_child, subset=(HH_wealth_index=="Second")) #creates subset featuring only HHs in rural areas
attach(rich.chITN)

richest.chITN <- subset(zambia_child, subset=(HH_wealth_index=="Highes")) #creates subset featuring only HHs in rural areas
attach(richest.chITN)

mean.ch.lowest <- mean(poorest.chITN$Slept_ITN)# Calculates the proportion of people living in urban areas with electricity
mean.ch.lowest #prints results
se.ch.lowest <-sqrt(var(poorest.chITN$Slept_ITN,na.rm=TRUE)/length(na.omit(poorest.chITN$Slept_ITN)))#calculates standard error
se.ch.lowest # prints results

mean.ch.low <- mean(poor.chITN$Slept_ITN)# Calculates the proportion of people living in urban areas with electricity
mean.ch.low #prints results
se.ch.low <-sqrt(var(poor.chITN$Slept_ITN,na.rm=TRUE)/length(na.omit(poor.chITN$Slept_ITN)))#calculates standard error
se.ch.low # prints results

mean.ch.middle <- mean(middle.chITN$Slept_ITN)# Calculates the proportion of people living in urban areas with electricity
mean.ch.middle #prints results
se.ch.middle <-sqrt(var(middle.chITN$Slept_ITN,na.rm=TRUE)/length(na.omit(middle.chITN$Slept_ITN)))#calculates standard error
se.ch.middle # prints results

mean.ch.rich <- mean(rich.chITN$Slept_ITN)# Calculates the proportion of people living in urban areas with electricity
mean.ch.rich #prints results
se.ch.rich <-sqrt(var(rich.chITN$Slept_ITN,na.rm=TRUE)/length(na.omit(rich.chITN$Slept_ITN)))#calculates standard error
se.ch.rich # prints results

mean.ch.richest <- mean(richest.chITN$Slept_ITN)# Calculates the proportion of people living in urban areas with electricity
mean.ch.richest #prints results
se.ch.richest <-sqrt(var(richest.chITN$Slept_ITN,na.rm=TRUE)/length(na.omit(richest.chITN$Slept_ITN)))#calculates standard error
se.ch.richest # prints results

noedu.chITN <- subset(zambia_child, subset=(Mother_education=="No education")) #creates subset featuring only HHs in rural areas
attach(noedu.chITN)

predu.chITN <- subset(zambia_child, subset=(Mother_education=="Primary")) #creates subset featuring only HHs in rural areas
attach(predu.chITN)

seedu.chITN <- subset(zambia_child, subset=(Mother_education=="Secondary")) #creates subset featuring only HHs in rural areas
attach(seedu.chITN)

htedu.chITN <- subset(zambia_child, subset=(Mother_education=="Higher than")) #creates subset featuring only HHs in rural areas
attach(htedu.chITN)

mean.ch.noedu <- mean(noedu.chITN$Slept_ITN)# Calculates the proportion of people living in urban areas with electricity
mean.ch.noedu #prints results
se.ch.noedu <-sqrt(var(noedu.chITN$Slept_ITN,na.rm=TRUE)/length(na.omit(noedu.chITN$Slept_ITN)))#calculates standard error
se.ch.noedu # prints results

mean.ch.predu <- mean(predu.chITN$Slept_ITN)
mean.ch.predu 
se.ch.predu <-sqrt(var(predu.chITN$Slept_ITN,na.rm=TRUE)/length(na.omit(predu.chITN$Slept_ITN)))
se.ch.predu 

mean.ch.seedu <- mean(seedu.chITN$Slept_ITN)
mean.ch.seedu 
se.ch.seedu <-sqrt(var(seedu.chITN$Slept_ITN,na.rm=TRUE)/length(na.omit(seedu.chITN$Slept_ITN)))
se.ch.seedu 

ITN_urban_chm <- weighted.mean(Urban.chITN$Slept_ITN, Urban.chITN$porw, na.rm=TRUE)
ITN_urban_chm
ITN_rural_chm <- weighted.mean(Rural.chITN$Slept_ITN, Rural.chITN$porw, na.rm=TRUE)
ITN_rural_chm

DHSs_SRS_wtd<-svydesign(ids= ~1, weights=~porw, data=zambia_child, nest=TRUE)

ITN.chRes.SRS <- svyby(~Slept_ITN, ~HH_residence, DHSs_SRS_wtd, svymean, na.rm=TRUE) #Residence
ITN.chRes.SRS

DHS_chClstr_wtd<-svydesign(ids= ~Primary_sampling_unit, weights=~porw, data=zambia_child, nest=TRUE)

ITN.chRes.Clstr <- svyby(~Slept_ITN, ~HH_residence, DHS_chClstr_wtd, svymean, na.rm=TRUE) #Residence
ITN.chRes.Clstr

DHS_chClstr_strat <-svydesign(ids= ~Primary_sampling_unit, strata= ~Sample_stratum_number, weights=~porw,data=zambia_child, nest=TRUE)

ITN.chRes.Strat <- svyby(~Slept_ITN, ~HH_residence, DHS_chClstr_strat, svymean, na.rm=TRUE) #Residence
ITN.chRes.Strat