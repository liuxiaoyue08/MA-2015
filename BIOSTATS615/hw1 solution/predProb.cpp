//homework 1.3 compute predictive probabilties
#include<cstdlib>
#include<iostream>
#include<iomanip>
#include<cmath>

using namespace std;

int main(int argc, char* argv[]){
  double logProb[5];
  for(int k=0; k<5; k++)
     logProb[k] = pow(2.0,-(k+1));
  for(int j=1; j<argc;j++){
     for(int k = 0; k<5; k++){
        logProb[k] += pow(2.0,abs(k+1-j))*atof(argv[j]); 
     } 
  }
  double maxLogProb = logProb[0];
  for(int k=1;k<5; k++){
     if(maxLogProb<logProb[k])
        maxLogProb = logProb[k];
  }
  
  for(int k=0;k<5;k++){
     logProb[k] = exp(logProb[k]-maxLogProb);
  }
  
  maxLogProb = 0.0;
  for(int k=0;k<5;k++){
     maxLogProb += logProb[k]; 
  }

  for(int k=0;k<5;k++){
     logProb[k] /= maxLogProb;
     cout << setprecision(8) << logProb[k] << endl; 
  }
  

  return 0;
}
