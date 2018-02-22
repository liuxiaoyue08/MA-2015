#include <iostream>
#include <cmath>
#include <cstdlib>

double logHypergeometricProb(double* logFacs, int a, int b, int c, int d);
void initLogFacs(double* logFacs, int n);
int main(int argc, char** argv);

void initLogFacs(double* logFacs, int n) {
	logFacs[0] = 0;
	for(int i=1; i < n+1; ++i) {
		logFacs[i] = logFacs[i-1] + log((double)i); // only n times of log() calls
	}
}

double logHypergeometricProb(double* logFacs, int a, int b, int c, int d) {
	return logFacs[a+b] + logFacs[c+d] + logFacs[a+c] + logFacs[b+d]
	- logFacs[a] - logFacs[b] - logFacs[c] - logFacs[d] - logFacs[a+b+c+d];
}

int main(int argc, char** argv) {
	int a = atoi(argv[1]), b = atoi(argv[2]), c = atoi(argv[3]), d = atoi(argv[4]);
	int n = a + b + c + d;
	double* logFacs = new double[n+1]; // *** dynamically allocate memory logFacs[0..n] ***
	initLogFacs(logFacs, n); // *** initialize logFacs array ***
	double logpCutoff = logHypergeometricProb(logFacs,a,b,c,d); // *** logFacs added
	double pFraction = 0;
	for(int x=0; x < a; ++x) {
		if ( a+b-x >= 0 && a+c-x >= 0 && d-a+x >=0 ) {
			double l = logHypergeometricProb(logFacs,x,a+b-x,a+c-x,d-a+x);
			pFraction += exp(l - logpCutoff);
		}
	}
	double logpValue = logpCutoff + log(pFraction);
	double pValue = exp(logpValue);
	if (pValue < 0.05) std::cout << "significant" << std::endl;
	else std::cout << "not significant" << std::endl;
	delete [] logFacs;
	return 0;
}
