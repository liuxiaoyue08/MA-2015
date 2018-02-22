#include <iostream>
#include <vector>
using namespace std;
int main(){
    int z,k0,i0,j0,i,j,k,n,s0;
    vector<long int> x1;
    vector<long int> x2;
    cin>>k0;
    cin>>i0;
    cin>>j0;
    s0=10000;
    while(cin>>z) x1.push_back(z%s0);
    n=x1.size();
    vector<long int> x3(n,0);
    for(i=0;i<n;i++) (i0-1-i)>=0?x2.push_back(x1[i0-1-i]):x2.push_back(x1[i-i0+1]);
    for(k=0;k<k0-1;k++){
        for(i=0;i<n;i++){
            x3[i]=0;
            for(j=0;j<n;j++){
                (i-j)>=0?(x3[i]=(x3[i]+x2[j]*x1[i-j])%s0):(x3[i]=(x3[i]+x2[j]*x1[j-i])%s0);
            }
        }
        for(i=0;i<n;i++) x2[i]=x3[i];
    }
    cout<<x2[j0-1]<<endl;
}
