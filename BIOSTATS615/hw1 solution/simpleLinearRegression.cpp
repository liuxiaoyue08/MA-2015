//Homework 1.2 simple linear regression
#include<cstdlib>
#include<iomanip>
#include<iostream>
using namespace std;

int main(int argc, char* argv[]){
   double x=0.0, y = 0.0, xy = 0.0, xx = 0.0, xbar = 0.0, ybar=0.0;
   x = 1.0;
   xbar = x;
   y = atof(argv[1]);
   ybar = y;
   for(int i=2; i<argc; i++){
      y = atof(argv[i]);
      x = i;
      xy = xy + (i-1)*(x-xbar)*(y-ybar)/i;
      xx = xx + (i-1)*(x-xbar)*(x-xbar)/i;
      ybar = ybar + (y-ybar)/i;
      xbar = xbar + (x-xbar)/i;
   }
   double beta_1 = (xy/(argc-1))/(xx/(argc-1));
   double beta_0 = ybar-beta_1*xbar;
   cout << setprecision(8) << beta_0 << " " << beta_1 << endl;
   return 0;
}
