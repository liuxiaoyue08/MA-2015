//Homework 1.1 compute stadard deviation 
#include <iostream>
#include <cstdlib>
#include <iomanip>
#include <cmath>

using namespace std;

int main(int argc, char** argv) {
	double xbar = 0.0, x = 0.0, S2 = 0.0;
        x = atof(argv[1]);
        xbar = x;
        for (int i = 2; i < argc; i++){
            x = atof(argv[i]);
            S2 = S2 + (i-1)*1.0/(i*1.0)*(x-xbar)*(x-xbar);
            xbar = xbar + (x-xbar)/(1.0*i); 
        }
        S2 = S2/(1.0*(argc-2));
        cout << setprecision(8) << sqrt(S2) << endl;  
	return 0;

}

