library(Rgadget)
library(tidyverse)
library(grid)
library(gridExtra)

rm(list=ls())

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

source("../../utils/ggdata_coverage.R")
source("../../utils/add_captionModel.R")
source("../../utils/ggplot_AgeLenDistributionStock.R")


fit <- gadget.fit(main="WGTS/main.final", wgts="WGTS",
                  f.age.range=data.frame(stock=c("cap"),
                                         age.min=c(1),
                                         age.max=c(5)),
                  recruitment_step_age=data.frame(stock=c("cap"),
                                                  age=c(0),
                                                  step=c(5)))

# -------------
## ## Eventually change the likelihood weight for the survey indicex x100 and refit the model
## lkh <- read.gadget.file("./", file_name="WGTS/likelihood.final", file_type="likelihood")
## i <- which(sapply(lkh,function(x){x$name}) == "siQ1.had")
## lkh[[i]]$weight <- lkh[[i]]$weight * 100
## i <- which(sapply(lkh,function(x){x$name}) == "siQ3.had")
## lkh[[i]]$weight <- lkh[[i]]$weight * 100
## attributes(lkh)$file_name <- "likelihood.final1"
## lkh %>%
##     write.gadget.file(".")

## main <- read.gadget.file("./", file_name="main", file_type="main")
## main[[6]]$likelihoodfiles <- "likelihood.final1"
## attributes(main)$file_name <- "main2"
## main %>%
##     write.gadget.file(".")

## callGadget(l=1, i='params.in', p='params.final2', main='main2', opt='optinfofile')
## params <- read.gadget.parameters('params.final2')
## params$optimise <- 0
## write.gadget.parameters(params,file='params.final20')

## tmp <- gadget.iterative(rew.sI=TRUE,
##                         grouping=list(
##                           sind=c('siQ1.had','siQ3.had')),
##                         params.file='params.final20',
##                         optinfofile='optinfofile',
##                         main = "main2",
##                         wgts='WGTS2')

## fit <- gadget.fit(main="WGTS2/main.final", wgts="WGTS2",
##                   f.age.range=data.frame(stock=c("had"),
##                                          age.min=c(6),
##                                          age.max=c(15)),
##                   recruitment_step_age=data.frame(stock=c("had"),
##                                                   age=c(0),
##                                                   step=c(5)))

# --------

## load("WGTS2/WGTS.Rdata")
## fit <- out

# ------------------------------------------
# standard plots
dirFigs <- "out"
if(sum(match(list.files(),dirFigs), na.rm=T)==1){
  print(paste("folder",dirFigs,"exists"))
} else {system(paste("mkdir",dirFigs))}

figName <- "sidat_dir.ps"
plot(fit, data = "sidat", type = "direct") +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

figName <- "sidat_xy.ps"
## cairo_ps(paste(dirFigs,, sep="/"))
plot(fit, data = "sidat", type = "x-y") +
  scale_y_continuous(trans='log10') +
  scale_x_continuous(trans='log10') +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

figName <- "summary.ps"
## cairo_ps(paste(dirFigs,, sep="/"))
plot(fit, data='summary') +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

figName <- "summary_wgt.ps"
## cairo_ps(paste(dirFigs,"summary_wgt.ps", sep="/"))
plot(fit, data='summary',type = 'weighted') +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

figName <- "summary_pie.ps"
## cairo_ps(paste(dirFigs,"summary_pie.ps", sep="/"))
plot(fit, data='summary',type='pie') +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

figName <- "catch.ps"
## cairo_ps(paste(dirFigs,"catch.ps", sep="/"))
plot(fit, data="res.by.year", type="catch") + facet_wrap(~stock) +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

figName <- "F.ps"
## cairo_ps(paste(dirFigs,"F.ps", sep="/"))
plot(fit, data="res.by.year", type="F") + facet_wrap(~stock) + ylim(0,NA) +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

figName <- "total.ps"
## cairo_ps(paste(dirFigs,"total.ps", sep="/"))
plot(fit, data="res.by.year", type="total") + facet_wrap(~stock) + ylim(0,NA) +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

figName <- "rec.ps"
## cairo_ps(paste(dirFigs,"rec.ps", sep="/"))
plot(fit, data="res.by.year", type="rec") + facet_wrap(~stock) + ylim(0,NA) +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")


# name of the stock for the next plots
sps <- unique(fit$sidat$stocknames)

figName <- "adist.ps"
## plot(fit, data='stock.std')# + facet_wrap(~stock) +
## ggRunName() + ggRunNameSize(6) +
## ggsave(paste(dirFigs,figName, sep="/"), device="ps")
ggAgeDistStk2(fit, stkName=sps, ageVec=1:12, plusGroup=12) +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

figName <- "suitability.ps"
##   plot(fit, data='suitability') +
##   labs(subtitle=figName) +
##   ggRunName() + ggRunNameSize(6) +
##   ggsave(paste(dirFigs,figName, sep="/"), device="ps")
ggplot(fit$suitability %>% filter(stock %in% sps & year == 80 &
                                    step %in% ifelse(substring(fleet,1,6)=="survQ1",1,3))) +
  geom_line(aes(length,suit,col=fleet)) +
  ## xlim(8,15) +
  facet_wrap(stock~., scales="free_x") +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

tmp <- plot(fit,data = 'catchdist.fleets')
names(tmp) <- c("alk.surQ1", "ldist.com", "ldist.surQ1", "ldist.surQ3") # here the stock name is removed to make the code general and applicable to all stocks

figName <- paste0("ldist_", sps, "_com.ps")
tmp$ldist.com +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

figName <- paste0("ldist_", sps, "_survQ1.ps")
tmp$ldist.surQ1 +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

figName <- paste0("ldist_", sps, "_survQ3.ps")
tmp$ldist.surQ3 +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

figName <- paste0("alk_", sps, "_survQ1.ps")
tmp$alk.surQ1 +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

## figName <- "alk_had_survQ3.ps"
##   tmp$alk.had.surQ3 +
##   labs(subtitle=figName) +
##   ggRunName() + ggRunNameSize(6)
## ggsave(paste(dirFigs,figName, sep="/"), device="ps")

## figName <- "adist_had_com.ps"
##   tmp$adist.had.com +
##   labs(subtitle=figName) +
##   ggRunName() + ggRunNameSize(6)
## ggsave(paste(dirFigs,figName, sep="/"), device="ps")

## figName <- "adist_had_survQ1.ps"
##   tmp$adist.had.surQ1 +
##   labs(subtitle=figName) +
##   ggRunName() + ggRunNameSize(6)
## ggsave(paste(dirFigs,figName, sep="/"), device="ps")

## figName <- "adist_had_survQ3.ps"
##   tmp$adist.had.surQ3 +
##   labs(subtitle=figName) +
##   ggRunName() + ggRunNameSize(6)
## ggsave(paste(dirFigs,figName, sep="/"), device="ps")


bubbles <- plot(fit,data = 'catchdist.fleets',type='bubble')
names(bubbles)

figName <- paste0("bubble_", sps, "_ldist.ps")
bubbles$ldist +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

figName <- paste0("bubble_", sps, "_aldist.ps")
bubbles$aldist +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

grplot <- plot(fit, data='catchdist.fleets', type='growth')
names(grplot) <- "alk.surQ1" # here the stock name is removed to make the code general and applicable to all stocks

figName <- paste0("growth_", sps, "_survQ1.ps")
grplot$alk.surQ1 +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")

## figName <- "growth_had_survQ3.ps"
##   grplot$alk.had.surQ3 +
##   labs(subtitle=figName) +
##   ggRunName() + ggRunNameSize(6)
## ggsave(paste(dirFigs,figName, sep="/"), device="ps")

## tmp <- plot(fit,data = 'stockdist')
##   names(tmp)

## figName <- "mat_com.ps"
##     tmp$mat.ven.com + xlim(9,18) +
##   ggRunName() + ggRunNameSize(6) +
## ggsave(paste(dirFigs,figName, sep="/"), device="ps")

figName <- "data_coverage.ps"
ggDataCoverage(fit) +
  labs(subtitle=figName) +
  ggRunName() + ggRunNameSize(6)
ggsave(paste(dirFigs,figName, sep="/"), device="ps")


# merge into a PDF
system(paste("psmerge $(ls ",dirFigs,"/*.ps) > ",dirFigs,"/figs_all.ps ; ps2pdf ",dirFigs,"/figs_all.ps ",dirFigs,"/figs_all.pdf ; rm ",dirFigs,"/figs_all.ps",sep=""))
## system(paste("convert -density 120x120 -quality 100 $(ls ",dirFigs,"/*.ps) ",dirFigs,"/figs_all.pdf",sep=""))


# -------------------------------------------
# Comparison among runs (see for more plots in vendace/compare_runs.R

## load("../../03.haddock/had05/WGTS2/WGTS.Rdata")
load("../had01_1cm/WGTS2/WGTS.Rdata")
fit1 <- out
load("../had01_2cm/WGTS2/WGTS.Rdata")
fit2 <- out
load("../had01_3cm/WGTS2/WGTS.Rdata")
fit3 <- out

fitL <- bind.gadget.fit("fit1"=fit1, "fit2"=fit2, "fit3"=fit3)

# SSB
tmp <- fitL$res.by.year %>% filter(stock=="had") ## %>%
## filter(model %in% c("Singlesp","Multispp"))
tsb <- ggplot(tmp, aes(year,total.biomass,col=model)) + geom_line() + geom_point() +
  ylim(0,max(tmp$total.biomass)) + ylab("SSB")
# Rec
tmp <- fitL$res.by.year %>% filter(stock=="had") ## %>%
## filter(model %in% c("Singlesp","Multispp"))
rec <- ggplot(tmp, aes(year,recruitment,col=model)) + geom_line() + geom_point() +
  ylim(0,max(tmp$recruitment)) + ylab("Number immature")
# F
tmp <- fitL$res.by.year %>% filter(stock=="had") ## %>%
## filter(model %in% c("Singlesp","Multispp"))
fbar <- ggplot(tmp, aes(year,F,col=model)) + geom_line() + geom_point() +
  ylim(0,max(tmp$F)) + ylab("Fishing mortality")

figName <- "standard_plot_comp_runs.ps"
postscript(paste(dirFigs,figName, sep="/"))
grid.arrange(tsb, rec, fbar)
dev.off()

# compare survey indices
ggplot(fitL$sidat) +
  geom_point(aes(year, observed), fill=1) +
  geom_line(aes(year, predicted, col=model)) +
  facet_wrap(~name, scale="free") +
  theme_bw()

ggplot(fitL$sidat) +
  geom_point(aes(observed, predicted, col=model)) +
  ## coord_trans(x="log10", y="log10") +
  scale_x_continuous(trans='log10') +
  scale_y_continuous(trans='log10') +
  facet_wrap(~name, scale="free") +
  theme_bw()

source("~/../valerio/Share/Gadget/Rscripts/ggplot_AgeLenDistribution.R")
ggLenDist(Gfit=fitL, compName="ldist.had.com", yrs=50:60)
ggLenDist(Gfit=fitL, compName="ldist.had.surQ1", yrs=50:60)
ggLenDist(Gfit=fitL, compName="ldist.had.surQ3", yrs=50:60)
ggAgeDist(Gfit=fitL, compName="adist.had.com", yrs=50:60)
ggAgeDist(Gfit=fitL, compName="adist.had.surQ1", yrs=50:60)
ggAgeDist(Gfit=fitL, compName="adist.had.surQ3", yrs=50:60)

# selection pattern
tmp <- fitL$suitability %>% filter(stock %in% c("had") & year == 80 &
                                     step %in% ifelse(substring(fleet,1,6)=="survQ1",1,3))
ggplot(tmp) + geom_line(aes(length,suit,group=model,col=model)) + facet_wrap(~fleet, scale="free_x")

# compare LH scores
lh <- fitL$likelihoodsummary %>%
  group_by(model,component) %>%
  summarise(likelihood_value=sum(likelihood_value))
ggplot(lh, aes(component, likelihood_value)) +
  geom_bar(aes(fill=model),position="dodge",stat='identity') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

# compare parameters values
ggplot(fitL$params %>% filter(value<100),
       aes(switch, value)) +
  geom_bar(aes(fill=model),position="dodge",stat='identity') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

# compare the sse of selected components (only if the same datasets are used)
tmp <- fitL$resTable %>%
  filter(.id=="final")
ggplot(tmp, aes(model, understocking)) +
  geom_bar(stat="identity")
ggplot(tmp, aes(model, ldist.had.com)) +
  geom_bar(stat="identity")
