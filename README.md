# MWCD code

Computation of the minimum weighted covariance determinant (MWCD) estimator

The code in Matlab allows to compute the minimum weighted covariance determinant (MWCD) estimator proposed by Roelant (2009). This is a robust estimator of parameters of a multivariate dataset with a (possibly) high breakdown point. 

Feel free to use or modify the code.

## Requirements

You need the file fastlts.m to run the full code, which compares the MWCD with the 
minimum covariance determinant (MCD) estimator. 
Available at https://svn-mede.ewi.tudelft.nl/trac/MM-ICT/DTAX/browser/software/dd_tools/fastmcd.m

## Usage

 * mainMwcd.m
	Main file, which reads an external data file, runs the estimates for the classical 
estimates (i.e. maximum likelihood for Gaussian data), MCD and MWCD estimators,
and presents their results. It also presents the resulting MWCD estimator graphically.

 * mwcdCheck.m
         The function for computing the MWCD estimator for the given dataset.          

## Authors
 * Jan Tichavský, The Czech Academy of Sciences, Institute of Computer Science
 * Jan Kalina, The Czech Academy of Sciences, Institute of Computer Science

## Contact

Do not hesitate to contact us (tichavsk@seznam.cz) or write an Issue.

## How to cite

Please consider citing the following:

Tichavský J, Kalina J (2019). MWCD code. Available at https://github.com/Veragin/MWCDcode.

Roelant E, Van Aelst S, Willems G. (2009). The minimum weighted covariance determinant estimator. Metrika 70, 177-201.

Kalina J (2019) Common multivariate estimators of location and scatter capture the symmetry of the underlying distribution. Communications in Statistics Simulation and Computation. Online first.

## Acknowledgement

This work was supported by the Czech Science Foundation grant 19-05704S.