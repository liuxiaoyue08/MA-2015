//Example 3.2 float point representation
#include<iostream>
#include<cmath>
#include<iomanip>
#include<cstdlib>

using namespace std;

void printBinaryInt(int val){
  for(int i = 7; i>=0; i--){
     if(val & (1 << i)){
        cout << "1";
     }
     else{
        cout << "0";
     }
  }
}


int main(int argc, char* argv[]){
   //get the number and save as a double variable
   double x = atof(argv[1]);
   //find the sign
   int sign = 1;
   if(x<0){
      cout << "1";
      sign = -1;
   }
   else{
      cout << "0";
   }
   //find the exponent
   
   int exponent = 0;
   if(sign*x != 0){
      exponent = (int)floor(log(sign*x)/log(2.0))+127;
   }
   double exponent_val = pow(2.0,exponent-127);
   printBinaryInt(exponent);
   //find the significand
   double y = sign*x/exponent_val-1.0;
   int bit = 0;
   double significand_val = 0.0;
   for(int i=0; i<23;i++){
      y = 2*y;
      if(y<1.0-pow(2.0,-23+i)){
         bit = 0;
      }
      else{
         bit = 1;
         significand_val += pow(2.0,-(i+1.0));
      }
      y = y - bit;
      cout << bit; 
   }
   cout << endl;
   cout << setprecision(30) << sign*(1.0+significand_val)*exponent_val <<endl; 
   return 0;
}
