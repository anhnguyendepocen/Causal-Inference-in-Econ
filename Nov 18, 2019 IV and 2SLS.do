* Nov 18, 2019 IV and 2SLS
* Name : Jikhan Jeong
* Reference: http://www3.grips.ac.jp/~yamanota/yamanoCourses.htm
* Dataset used: CARD.dta


****************************************************************** 
* IV
****************************************************************** 

* Simple OLS: educ is endogeneous variable x = correlated with error

reg lwage educ


* x ~ z, z= nearc4 (IV) z is significant

reg educ nearc4 

* IV justidentification 

** standerror using iv is wrong
** but following ivreg fixed it in the results
** same coefficient with OLS but stand error is smaller .0028697 (OLS) >  .1036988 (IV)
** iverg is 2SLS and fixed its standard error

ivreg lwage(educ=nearc4)


****************************************************************** 
* 2SLS
****************************************************************** 

* OLS (educ = endo variable) : edu coefficient: .074009 edu sd:   .0035054    adR:  0.2891
reg lwage educ exper expersq black smsa south 

* 2 IVs :                     edu coefficient: .1608487 edu sd:   .0486291    adR:  0.1438
* Instrumented:  educ
* Instruments:   nearc2 nearc4

ivreg lwage (educ= nearc2 nearc4) exper expersq black smsa south

* 4 IVs:                      edu coefficient: .1000713 edu sd:   .01263      adR: 0.2507 ******** lowest sd. 
ivreg lwage (educ= nearc2 nearc4 fatheduc motheduc) exper expersq black smsa south

* 2 IVs:                      edu coefficient: .099931 edu sd:    .012756     adR: 0.2508
ivreg lwage (educ= fatheduc motheduc) exper expersq black smsa south





