# ---------------------------------------------------
# Import mskeyrun data into mfdb
# ---------------------------------------------------
library(tidyverse)
library(mfdb)
library(mskeyrun)
library(ggplot2)

rm(list=ls())

# Connect to the database
## mfdb("Barents", db_params=list(dbname="noba"), destroy_schema = TRUE)
mdb <- mfdb('Barents', db_params=list(dbname="noba"))

# 11 spp list with extra biological data
sppLookup <- data.frame(nobaSpp = c("BWH","CAP","GRH","HAD","LRD","MAC","NCO","PCO","RED","SAI","SSH"),
                        mfdbSpp = c("WHB","CAP","GLH","HAD","PLA","MAC","COD","POC","RED","SAI","HER"),
                        ageGrpSize = c(1,1,2,2,2,2,2,2,4,2,2))
sppList <- left_join(simBiolPar, sppLookup %>% rename(Code=nobaSpp))
    
# name simulation
simName <- unique(simCatchIndex$ModSim)

# Area (ie no info available)
mfdb_import_area(mdb, data.frame(
    id = 1,
    name = "noba_area",
    size = 100))

# Set-up sampling types
mfdb_import_sampling_type(mdb, data.frame(
    name = c("RES", "LND"),
    description = c("Research", "Landings"),
    stringsAsFactors = FALSE))

# Add to the mfdb taxonomy
mfdb_import_cs_taxonomy(mdb, "index_type", # BTS survey indices by species
                        expand_grid(v1=c("BTS_spring","BTS_fall","BTS_spring_cv","BTS_fall_cv"), v2=sppList$mfdbSpp) %>%
                        mutate(name=paste(v1,v2,sep="_")) %>%
                        select(name))

# ---------------------------------------------------
# IMPORT CATCHES
# ---------------------------------------------------
tmp <- simCatchIndex %>%
    ## filter(variable=="catch")
    mutate(units=NULL) %>%
    left_join(sppList) %>%
    spread(variable,value)
tmp <- expand.grid(year=sort(unique(tmp$year)),
                    step=1:4) %>%
    full_join(tmp) %>%
    mutate(catch = catch/4) %>% # split the catches equally among quarters
    mutate(month = step*3-1) %>% # assign month as mid-quarter
    mutate(area = "noba_area")

mfdb_import_survey(mdb,
    data_source = paste0('catches_',simName),
    data.frame(
        year = tmp$year,
        month = tmp$month,
        areacell = tmp$area,
        species = tmp$mfdbSpp,
        sampling_type = 'LND',
        weight = tmp$catch,
        weight_var = tmp$cv,
        count = 1,
        stringsAsFactors = TRUE))

## aggdata <- mfdb_sample_totalweight(mdb, c('species','data_source'), list(
##     timestep        = mfdb_timestep_yearly,
##     year            = 1:99,
##     species         = mfdb_unaggregated(), 
##     sampling_type   = 'LND',
##     data_source     = paste0('catches_',simName)))[[1]]
## aggdata[1:4,]
## ggplot(aggdata) + geom_line(aes(year,total_weight)) + facet_wrap(~species, scale="free_y")

# ---------------------------------------------------
# IMPORT CATCH LENGTH DISTRIBUTIONS
# ---------------------------------------------------
tmp <- simFisheryLencomp %>%
    mutate(units=NULL) %>%
    left_join(sppList) %>%
    mutate(month = 6) %>% # assign month as approx mid-year
    mutate(area = "noba_area")

mfdb_import_survey(mdb,
    data_source = paste0('ldist_catch_',simName),
    data.frame(
        year = tmp$year,
        month = tmp$month,
        areacell = tmp$area,
        species = tmp$mfdbSpp,
        sampling_type = 'LND',
        length = tmp$lenbin,
        count = tmp$value,
        stringsAsFactors = TRUE))

# ---------------------------------------------------
# IMPORT CATCH AGE DISTRIBUTIONS
# ---------------------------------------------------
tmp <- simFisheryAgecomp %>%
    mutate(units=NULL) %>%
    left_join(sppList) %>%
    mutate(month = 6) %>% # assign month as approx mid-year
    mutate(area = "noba_area")

mfdb_import_survey(mdb,
    data_source = paste0('adist_catch_',simName),
    data.frame(
        year = tmp$year,
        month = tmp$month,
        areacell = tmp$area,
        species = tmp$mfdbSpp,
        sampling_type = 'LND',
        age = tmp$age,
        count = tmp$value,
        stringsAsFactors = TRUE))

# ---------------------------------------------------
# IMPORT CATCH WGT@AGE
# ---------------------------------------------------
tmp <- simFisheryWtatAge %>%
    mutate(units=NULL) %>%
    left_join(sppList) %>%
    mutate(month = 6) %>% # assign month as approx mid-year
    mutate(area = "noba_area")

mfdb_import_survey(mdb,
    data_source = paste0('wgtAge_catch_',simName),
    data.frame(
        year = tmp$year,
        month = tmp$month,
        areacell = tmp$area,
        species = tmp$mfdbSpp,
        sampling_type = 'LND',
        age = tmp$age,
        weight = tmp$value/1000, # convert g2kg
        stringsAsFactors = TRUE))

# ---------------------------------------------------
# IMPORT SURVEY INDICES
# ---------------------------------------------------
si <- simSurveyIndex %>%
    mutate(units=NULL) %>%
    left_join(sppList) %>%
    spread(variable,value) %>%
    mutate(month = ifelse(survey=="BTS_fall_allbox_effic1",10,
                   ifelse(survey=="BTS_spring_allbox_effic1",4,NA))) %>%
    mutate(area = "noba_area")

for(i in si %>% filter(survey=="BTS_spring_allbox_effic1") %>% .$mfdbSpp %>% unique()){
    tmp <- si %>% filter(mfdbSpp==i) %>% filter(survey=="BTS_spring_allbox_effic1")
    mfdb_import_survey_index(mdb, data_source=paste0('BTS_spring_',simName,"_",i),
                             data.frame(index_type=paste0('BTS_spring_',i),
                                        year=tmp$year,
                                        month=tmp$month,
                                        areacell=tmp$area,
                                        value=tmp$biomass))
}

for(i in si %>% filter(survey=="BTS_fall_allbox_effic1") %>% .$mfdbSpp %>% unique()){
    tmp <- si %>% filter(mfdbSpp==i) %>% filter(survey=="BTS_fall_allbox_effic1")
    mfdb_import_survey_index(mdb, data_source=paste0('BTS_fall_',simName,"_",i),
                             data.frame(index_type=paste0('BTS_fall_',i),
                                        year=tmp$year,
                                        month=tmp$month,
                                        areacell=tmp$area,
                                        value=tmp$biomass))
}

## df <- NULL
## for(i in 1:nrow(sppList)){
##     tmp <- mfdb_survey_index_mean(mdb, c('data_source'),
##                                   list(
##                                       timestep      = mfdb_timestep_quarterly,
##                                       year          = 1:99,
##                                       species= mfdb_unaggregated(),
##                                       index_type    = paste0('BTS_spring_',sppList$mfdbSpp[i]),
##                                       data_source   = paste0('BTS_spring_',simName,"_",sppList$mfdbSpp[i])))[[1]] %>%
##         mutate(species = sppList$mfdbSpp[i])
##     df <- rbind(df,tmp)
##     rm(tmp)
## }
## ggplot(df) + geom_line(aes(year,mean)) + facet_wrap(~species, scale="free_y")

tmp <- si %>% filter(survey=="BTS_spring_allbox_effic1")
mfdb_import_survey(mdb, data_source=paste0('index_BTS_spring_',simName),
                   data.frame(year=tmp$year,
                              month=tmp$month,
                              areacell=tmp$area,
                              species=tmp$mfdbSpp,
                              sampling_type = 'RES',
                              weight_total=tmp$biomass,
                              weight_var=tmp$cv,
                              ## count=tmp$biomass,
                              stringsAsFactors = TRUE))

tmp <- si %>% filter(survey=="BTS_fall_allbox_effic1")
mfdb_import_survey(mdb, data_source=paste0('index_BTS_fall_',simName),
                   data.frame(year=tmp$year,
                              month=tmp$month,
                              areacell=tmp$area,
                              species=tmp$mfdbSpp,
                              sampling_type = 'RES',
                              weight_total=tmp$biomass,
                              weight_var=tmp$cv,
                              ## count=tmp$biomass,
                              stringsAsFactors = TRUE))


# ---------------------------------------------------
# IMPORT SURVEY LENGTH DISTRIBUTIONS
# ---------------------------------------------------
tmp <- simSurveyLencomp %>%
    mutate(units=NULL) %>%
    left_join(sppList) %>%
    mutate(month = ifelse(survey=="BTS_fall_allbox_effic1",10,
                   ifelse(survey=="BTS_spring_allbox_effic1",4,NA))) %>%
    mutate(area = "noba_area")

mfdb_import_survey(mdb,
    data_source = paste0('ldist_survey_',simName),
    data.frame(
        year = tmp$year,
        month = tmp$month,
        areacell = tmp$area,
        species = tmp$mfdbSpp,
        sampling_type = 'RES',
        length = tmp$lenbin,
        count = tmp$value,
        stringsAsFactors = TRUE))

# ---------------------------------------------------
# IMPORT SURVEY AGE DISTRIBUTIONS
# ---------------------------------------------------
tmp <- simSurveyAgecomp %>%
    mutate(units=NULL) %>%
    left_join(sppList) %>%
    mutate(month = ifelse(survey=="BTS_fall_allbox_effic1",10,
                   ifelse(survey=="BTS_spring_allbox_effic1",4,NA))) %>%
    mutate(area = "noba_area")

mfdb_import_survey(mdb,
    data_source = paste0('adist_survey_',simName),
    data.frame(
        year = tmp$year,
        month = tmp$month,
        areacell = tmp$area,
        species = tmp$mfdbSpp,
        sampling_type = 'RES',
        age = tmp$age,
        count = tmp$value,
        stringsAsFactors = TRUE))

# ---------------------------------------------------
# IMPORT SURVEY ALK
# ---------------------------------------------------
tmp <- simSurveyAgeLencomp %>%
    mutate(units=NULL) %>%
    left_join(sppList) %>%
    mutate(age = ifelse(ageGrpSize == 2, agecl*2-1, # assign the first age in the age class
                 ifelse(ageGrpSize == 4, agecl*4-1, agecl))) %>%                        
    mutate(month = ifelse(survey=="BTS_fall_allbox_effic1",10,
                   ifelse(survey=="BTS_spring_allbox_effic1",4,NA))) %>%
    mutate(area = "noba_area")
   
mfdb_import_survey(mdb,
    data_source = paste0('aldist_survey_',simName),
    data.frame(
        year = tmp$year,
        month = tmp$month,
        areacell = tmp$area,
        species = tmp$mfdbSpp,
        sampling_type = 'RES',
        length = tmp$lenbin,
        age = tmp$age,
        count = tmp$value,
        stringsAsFactors = TRUE))

# ---------------------------------------------------
# IMPORT SURVEY WGT@AGE
# ---------------------------------------------------
tmp <- simSurveyWtatAge %>%
    mutate(units=NULL) %>%
    left_join(sppList) %>%
    mutate(month = ifelse(survey=="BTS_fall_allbox_effic1",10,
                   ifelse(survey=="BTS_spring_allbox_effic1",4,NA))) %>%
    mutate(area = "noba_area")

mfdb_import_survey(mdb,
    data_source = paste0('wgtAge_survey_',simName),
    data.frame(
        year = tmp$year,
        month = tmp$month,
        areacell = tmp$area,
        species = tmp$mfdbSpp,
        sampling_type = 'RES',
        age = tmp$age,
        weight = tmp$value/1000, # convert g2kg
        stringsAsFactors = TRUE))

# ---------------------------------------------------
# IMPORT DIET DATA
# ---------------------------------------------------
tmp <- simSurveyDietcomp %>%
    mutate(units=NULL) %>%
    left_join(sppList) %>%
    mutate(age = ifelse(ageGrpSize == 2, agecl*2-1, # assign the first age in the age class
                 ifelse(ageGrpSize == 4, agecl*4-1, agecl))) %>%                        
    mutate(month = ifelse(survey=="BTS_fall_allbox_effic1",10,
                   ifelse(survey=="BTS_spring_allbox_effic1",4,NA))) %>%
    mutate(predID = paste(mfdbSpp,year,month,age,sep="_")) %>%
    mutate(area = "noba_area")

tmp <- sppList %>%
    select(Name,mfdbSpp) %>%
    rename(prey=Name, mfdbPrey=mfdbSpp) %>%
    right_join(tmp) %>%
    mutate(mfdbPrey = ifelse(is.na(mfdbPrey), "OTH", mfdbPrey)) %>%
    group_by(ModSim,year,month,area,survey,predID,mfdbSpp,agecl,age,mfdbPrey) %>%
    summarise(value=sum(value))

## ggplot(tmp %>% filter(month==10 & year %in% c(60,80,100))) + geom_bar(aes(agecl,value,fill=mfdbPrey), stat="identity") + facet_grid(mfdbSpp~year)
## ggplot(tmp %>% filter(mfdbSpp=="RED" & year %in% c(60,80,100))) + geom_bar(aes(agecl,value,fill=mfdbPrey), stat="identity") + facet_grid(month~year)
## p1 <- ggplot(tmp %>% filter(mfdbSpp=="COD" & year %in% c(60,80,100))) + geom_bar(aes(agecl,value,fill=mfdbPrey), stat="identity") + facet_grid(month~year)
## ggsave("cod_diet_NOBA_sacc_38.png", p1, device="png", width=12)

tmpPred <- tmp %>%
    select(predID,ModSim,survey,year,month,area,mfdbSpp,age) %>%
    unique()

tmpPrey <- tmp

mfdb_import_species_taxonomy(mdb, data.frame(
    name = c("OTH"),
    description = c("Other"),
    stringsAsFactors = FALSE))

mfdb_import_stomach(mdb,
                    data_source = paste0('dietWprop_',simName),
                    predator_data = data.frame(
                        stomach_name = tmpPred$predID,
                        year = tmpPred$year,
                        month = tmpPred$month,
                        areacell = tmpPred$area,
                        species = tmpPred$mfdbSpp,
                        age = tmpPred$age,
                        stringsAsFactors = TRUE),
                    prey_data = data.frame(
                        stomach_name = tmpPrey$predID,
                        species = tmpPrey$mfdbPrey,
                        weight = tmpPrey$value,
                        ## length = 1, # only for convenience for the extraction
                        count = 1, # =1 correspond to aggregated data
                        stringsAsFactors = TRUE))

## df <- mfdb_stomach_preyweightratio(mdb,
##                        c("predator_species","age","prey_species"),
##                        list(year = 80,
##                             timestep = mfdb_timestep_quarterly,
##                             predator_species="COD",
##                             age = mfdb_group('age3'=3,'age4'=4,'age5'=5,'age6'=6,'age7'=7,'age8'=8),
##                             prey_length = mfdb_unaggregated(),
##                             prey_species = mfdb_unaggregated(),
##                             data_source=paste0('dietWprop_',simName)))[[1]]
## ggplot(df %>% mutate(age=as.numeric(substring(age,4,6)))) + geom_bar(aes(age,ratio,fill=prey_species), stat="identity") + facet_grid(~step)
## ggplot(tmpPrey %>% filter(year==80 & age %in% 3:8, mfdbSpp=="COD")) + geom_bar(aes(age,value,fill=mfdbPrey), stat="identity") + facet_grid(~month)

# ---------------------------------------------------
# IMPORT INITIAL POPULATION BY AGE
# ---------------------------------------------------
tmp <- simStartPars %>%
    mutate(units=NULL) %>%
    filter(variable == "Natage") %>%
    left_join(sppList) %>%
    rename(age = agecl) %>%
    mutate(year=40, month = 1) %>% # *** verify that initial year is 40
    mutate(area = "noba_area")
   
mfdb_import_survey(mdb,
    data_source = paste0('anumb_init_',simName),
    data.frame(
        year = tmp$year,
        month = tmp$month,
        areacell = tmp$area,
        species = tmp$mfdbSpp,
        sampling_type = 'RES',
        age = tmp$age,
        count = tmp$value,
        stringsAsFactors = TRUE))

# ---------------------------------------------------
# IMPORT INITIAL RECRUITMENT
# ---------------------------------------------------
tmp <- simStartPars %>%
    mutate(units=NULL) %>%
    filter(variable == "AvgRec") %>%
    left_join(sppList) %>%
    mutate(age = 0) %>% # recruitment assumed at age0 ***CHECK
    mutate(year=39, month = 1) %>% # *** verify that initial year for age0 is 39
    mutate(area = "noba_area")
   
mfdb_import_survey(mdb,
    data_source = paste0('logrec_init_',simName),
    data.frame(
        year = tmp$year,
        month = tmp$month,
        areacell = tmp$area,
        species = tmp$mfdbSpp,
        sampling_type = 'RES',
        age = tmp$age,
        count = tmp$value,
        stringsAsFactors = TRUE))

# ---------------------------------------------------
# IMPORT INITIAL POPULATION AGE-LENGTH
# ---------------------------------------------------
tmp <- simStartPars %>%
    mutate(units=NULL) %>%
    filter(variable == "Natlen") %>%
    left_join(sppList) %>%
    mutate(age = ifelse(ageGrpSize == 2, agecl*2-1, # assign the first age in the age class
                 ifelse(ageGrpSize == 4, agecl*4-1, agecl))) %>%
    mutate(year=40, month = 1) %>% # *** verify that initial year is 40
    mutate(area = "noba_area")
   
mfdb_import_survey(mdb,
    data_source = paste0('alnumb_init_',simName),
    data.frame(
        year = tmp$year,
        month = tmp$month,
        areacell = tmp$area,
        species = tmp$mfdbSpp,
        sampling_type = 'RES',
        length = tmp$lenbin,
        age = tmp$age,
        count = tmp$value,
        stringsAsFactors = TRUE))

# ---------------------------------------------------
mfdb_disconnect(mdb)
