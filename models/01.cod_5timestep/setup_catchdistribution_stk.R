minage <- stk[[1]]$minage
maxage <- stk[[1]]$maxage
maxlength <- stk[[1]]$maxlength 
minlength <- stk[[1]]$minlength
dl <- stk[[1]]$dl

ll <- mfdb_interval("all",c(minlength,maxlength),
                    open_ended = c("upper","lower"))
## names(ll) <- "all"
names(ll) <- c("all","all")

aa <- mfdb_interval("all",c(minage,maxage), open_ended = c("upper","lower"))
## names(aa) <- "all"
names(aa) <- c("all","all")

# ---------------------------------------------------------------------
# Query commercial age distribution
adist.com <- mfdb_sample_count(mdb, c('age','length'), list(
    area            = defaults$area,
    timestep      = defaults$timestep,
    year          = defaults$year,
    sampling_type = 'LND',
    data_source   = paste0('adist_catch_',simName),
    species       = defaults$species,
    length        = ll,
    age           = defaults$age))[[1]]

## adist.com$area <- "area1"
## attributes(adist.com)$area <- "area1"
## names(attributes(adist.com)$area) <- "area1"
## attributes(adist.spr.com)$area$area1 <- "area1"

# replicate same adist for all quarters
# ***hack to avoid error in the likelihood which is aggregated over the year***
## adist.com <- bind_rows(adist.com %>% mutate(step='1'),
##                        adist.com,
##                        adist.com %>% mutate(step='3'),
##                        adist.com %>% mutate(step='4'))

## ggplot(filter(adist.com,year %in% 50:60)) +
##     geom_bar(aes(age,number), stat="identity") +
##     facet_grid(step~year)

# ---------------------------------------------------------------------
# Query survey age distribution
adist.survQ1 <- mfdb_sample_count(mdb, c('age','length'), list(
    area            = defaults$area,
    timestep      = mfdb_group('1'=1:3),
    ## timestep      = mfdb_timestep_quarterly,
    year          = defaults$year,
    sampling_type = 'RES',
    data_source   = paste0('adist_survey_',simName),
    species       = defaults$species,
    length        = ll,
    age           = defaults$age))[[1]]

adist.survQ3 <- mfdb_sample_count(mdb, c('age','length'), list(
    area            = defaults$area,
    timestep      = mfdb_group('3'=6:8),
    ## timestep      = mfdb_timestep_quarterly,
    year          = defaults$year,
    sampling_type = 'RES',
    data_source   = paste0('adist_survey_',simName),
    species       = defaults$species,
    length        = ll,
    age           = defaults$age))[[1]]

# ---------------------------------------------------------------------
# Query commercial length distribution
ldist.com <- mfdb_sample_count(mdb, c('age','length'), list(
    area          = defaults$area,
    timestep      = defaults$timestep,
    year          = defaults$year,
    sampling_type = 'LND',
    data_source   = paste0('ldist_catch_',simName),
    species       = defaults$species,
    ## length        = mfdb_interval("len", seq(70, 125, by = 1)),
    length        = defaults$length,
    age           = aa))[[1]]

# replicate same ldist for all quarters
# ***hack to avoid error in the likelihood which is aggregated over the year***
## ldist.com <- bind_rows(ldist.com %>% mutate(step='1'),
##                        ldist.com,
##                        ldist.com %>% mutate(step='3'),
##                        ldist.com %>% mutate(step='4'),
##                        ldist.com %>% mutate(step='5'))

## ggplot(ldist.com %>% filter(year %in% 50:60) %>%
##        mutate(length=as.numeric(substring(length,4,6)))) +
##     geom_bar(aes(length,number), stat="identity") +
##     facet_grid(step~year)

# ---------------------------------------------------------------------
# Query survey length distribution
ldist.survQ1 <- mfdb_sample_count(mdb, c('age','length'), list(
    area          = defaults$area,
    timestep      = mfdb_group('1'=1:3),
    ## timestep      = mfdb_timestep_quarterly,
    year          = defaults$year,
    sampling_type = 'RES',
    data_source   = paste0('ldist_survey_',simName),
    species       = defaults$species,
    length        = defaults$length,
    age           = aa))[[1]]

ldist.survQ3 <- mfdb_sample_count(mdb, c('age','length'), list(
    area          = defaults$area,
    timestep      = mfdb_group('3'=6:8),
    year          = defaults$year,
    sampling_type = 'RES',
    data_source   = paste0('ldist_survey_',simName),
    species       = defaults$species,
    length        = defaults$length,
    age           = aa))[[1]]

# ---------------------------------------------------------------------
# Query survey age-length distribution
aldist.survQ1 <- mfdb_sample_count(mdb, c('age','length'), list(
    area          = defaults$area,
    timestep      = mfdb_group('1'=1:3),
    ## timestep      = mfdb_timestep_quarterly,
    year          = defaults$year,
    sampling_type = 'RES',
    data_source   = paste0('aldist_survey_',simName),
    species       = defaults$species,
    length        = defaults$length,
    age           = ageClsM3))[[1]]
    ## age           = defaults$age))[[1]]

aldist.survQ3 <- mfdb_sample_count(mdb, c('age','length'), list(
    area          = defaults$area,
    timestep      = mfdb_group('3'=6:8),
    ## timestep      = mfdb_timestep_quarterly,
    year          = defaults$year,
    sampling_type = 'RES',
    data_source   = paste0('aldist_survey_',simName),
    species       = defaults$species,
    length        = defaults$length,
    age           = ageClsM8))[[1]]
    ## age           = defaults$age))[[1]]

## ggplot(aldist.survQ1 %>% filter(year %in% 50:60) %>%
##        mutate(age=as.numeric(substring(age,4,5)),
##               length=as.numeric(substring(length,4,6)))) +
##     geom_point(aes(age,length,size=number)) +
##     facet_wrap(~year)

