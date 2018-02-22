//simpleQuantiles.cpp

#include<vector>
#include<iostream>
#include<algorithm>

using namespace std;

int main(int argc, char** argv){
   vector<double> u;
   for(int i=1; i<argc; i++){
      u.push_back(atof(argv[i]));
   }
   vector<double> x;
   double tok;
   while(cin >> tok){
      x.push_back(tok);
   }
   sort(x.begin(),x.end());
   int n = (int)x.size();
   int m = 0;
   for(int i=0; i<(int)u.size();i++){
      m = (int)(n*u[i]);
      if((m>0) && (m==n*u[i]))
        cout << x[m-1] << ' ';
      else
        cout << x[m] << ' ';
   }
   cout << endl;

   return 0;
}
