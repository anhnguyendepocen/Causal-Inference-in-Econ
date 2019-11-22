* Nov 22, 2019 2SLS and GMM
* Name: Jikhan Jeong
* Ref: https://www.soderbom.net/metrix2.htm (code and leture note source)
* Ref: http://www3.grips.ac.jp/~yamanota/yamanoCourses.htm (data source)
* Data: CARD.dta | Wooldridge probm 5.4-6.1

* 1. down load user written package: iverg2_____________________________________

ssc install ivreg2
ssc install ranktest

* 2. summary statistics_________________________________________________________

* lwage is a dependent var
* educ is a endo var, because it may corrleated with unobserved error (=ability)
* nearc2 is a IV

tabstat lwage educ nearc2 , s(mean N min max p50)

* 3. OLS________________________________________________________________________

* $ educ |   coef .0520942   sd .0028697 
reg lwage educ 

* 4. 1st Stage and IV reg_______________________________________________________

* (1st result) 1stage regression : IV must be significant endo var ~ IV + other Xs
* (2st result) IV reg results 

ivreg2 lwage ( educ = nearc2 ), first

*  (1stage) nearc2 |   .2552584   .0981804     2.60   p-value 0.009 1st, Y= educ (=endo var)
*  (IV)       educ |   .3432739   .1274114     2.69   p-value 0.007
*  (OLS)      educ$coef |.0520942  << (IV) educ$coeff |.3432739  
*  (OLS)      educ$sd   |.0028697  << (IV) educ$coeff |.1274114  


tabstat lwage educ, s(mean) by(nearc2)

* IV coef with wald estimator : when # of IV = # endo var = 1 and dummy
* [E(y|IV=1)-E(y|IV=0)] / [E(x|IV=1)-E(x|IV=0)] = 6.310825 -  6.223202)/( 13.40618- 13.15092)  = 0.34326960745 = (IV) educ$coeff |.3432739 

* 5. 2SLS with robust endogeneous |educ |   .1033048   *.0126463     8.17   0.000 


* without robust option 2 IVs
* endogeneity test of endogenous regressors: Under H0 the specified endogenousregressors can actually be treated as exogenous
* Endogeneity test of endogenous regressors:  Chi-sq(1) P-val =    0.0864 : okay, this part is different than the lecture note, in the lecture note reject
ivreg2 lwage (educ=nearc2 nearc4) exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 south66

* without robust option 4 IVs
* Endogeneity test of endogenous regressors:  Chi-sq(1) P-val =    0.0266
ivreg2 lwage (educ=nearc2 nearc4 motheduc fatheduc ) exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 south66,endog(educ)

* with roubst option 4 IVs        | educ |  .1033048   *.0131855 (bigger than unrobust)     7.83   0.000

ivreg2 lwage (educ=nearc2 nearc4 motheduc fatheduc ) exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 south66, robust endog(educ)

* 6. GMM 2SLSgmm2s                |educ |   *.1019251 (smaller than 2SLS robust)   .0131539 (smaller than 2SLS robust)     7.75   0.000   

ivreg2 lwage (educ=nearc2 nearc4 motheduc fatheduc ) exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 south66, gmm2s robust endog(educ)






