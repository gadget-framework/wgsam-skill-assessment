; Likelihood file - created in Rgadget
; WGTS/likelihood.ldist.had.com - 2023-09-26
[component]
name		alk.had.surQ1
weight		0.128518185323223
type		catchdistribution
datafile		Data/catchdistribution.alk.had.surQ1.sumofsquares
function		sumofsquares
aggregationlevel		0
overconsumption		0
epsilon		10
areaaggfile		Aggfiles/catchdistribution.alk.had.surQ1.area.agg
ageaggfile		Aggfiles/catchdistribution.alk.had.surQ1.age.agg
lenaggfile		Aggfiles/catchdistribution.alk.had.surQ1.len.agg
fleetnames		survQ1had
stocknames		had
;
[component]
name		alk.had.surQ3
weight		0.116292592161879
type		catchdistribution
datafile		Data/catchdistribution.alk.had.surQ3.sumofsquares
function		sumofsquares
aggregationlevel		0
overconsumption		0
epsilon		10
areaaggfile		Aggfiles/catchdistribution.alk.had.surQ3.area.agg
ageaggfile		Aggfiles/catchdistribution.alk.had.surQ3.age.agg
lenaggfile		Aggfiles/catchdistribution.alk.had.surQ3.len.agg
fleetnames		survQ3had
stocknames		had
;
[component]
name		ldist.had.com
weight		193.498452012384
type		catchdistribution
datafile		Data/catchdistribution.ldist.had.com.sumofsquares
function		sumofsquares
aggregationlevel		0
overconsumption		0
epsilon		10
areaaggfile		Aggfiles/catchdistribution.ldist.had.com.area.agg
ageaggfile		Aggfiles/catchdistribution.ldist.had.com.age.agg
lenaggfile		Aggfiles/catchdistribution.ldist.had.com.len.agg
fleetnames		comhad
stocknames		had
;
[component]
name		ldist.had.surQ1
weight		0.0554016620498615
type		catchdistribution
datafile		Data/catchdistribution.ldist.had.surQ1.sumofsquares
function		sumofsquares
aggregationlevel		0
overconsumption		0
epsilon		10
areaaggfile		Aggfiles/catchdistribution.ldist.had.surQ1.area.agg
ageaggfile		Aggfiles/catchdistribution.ldist.had.surQ1.age.agg
lenaggfile		Aggfiles/catchdistribution.ldist.had.surQ1.len.agg
fleetnames		survQ1had
stocknames		had
;
[component]
name		ldist.had.surQ3
weight		0.0512820512820513
type		catchdistribution
datafile		Data/catchdistribution.ldist.had.surQ3.sumofsquares
function		sumofsquares
aggregationlevel		0
overconsumption		0
epsilon		10
areaaggfile		Aggfiles/catchdistribution.ldist.had.surQ3.area.agg
ageaggfile		Aggfiles/catchdistribution.ldist.had.surQ3.age.agg
lenaggfile		Aggfiles/catchdistribution.ldist.had.surQ3.len.agg
fleetnames		survQ3had
stocknames		had
;
[component]
name		siQ1.had
weight		0.0278940027894003
type		surveyindices
datafile		Data/surveyindices.siQ1.had.lengths
sitype		lengths
biomass		1
areaaggfile		Aggfiles/surveyindices.siQ1.had.area.agg
lenaggfile		Aggfiles/surveyindices.siQ1.had.len.agg
stocknames		had
fittype		loglinearfit
;
[component]
name		siQ3.had
weight		0.0282406099971759
type		surveyindices
datafile		Data/surveyindices.siQ3.had.lengths
sitype		lengths
biomass		1
areaaggfile		Aggfiles/surveyindices.siQ3.had.area.agg
lenaggfile		Aggfiles/surveyindices.siQ3.had.len.agg
stocknames		had
fittype		loglinearfit
;
[component]
name		understocking
weight		10
type		understocking
;
[component]
name		bounds
weight		10
type		penalty
datafile		Data/bounds.penaltyfile
;
