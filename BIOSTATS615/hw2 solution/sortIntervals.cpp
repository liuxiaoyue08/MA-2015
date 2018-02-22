//sortIntervals.cpp

#include<vector>
#include<algorithm>
#include<iostream>
#include<climits>

using namespace std;

void mergeSort(vector<int>& lower, vector<int>& upper, int p, int r, vector<int>& order);
void merge(vector<int>& lower, vector<int>& upper,int p, int q, int r, vector<int>& order);
void printArray(vector<int>& A);
void printIntervals(vector<int>& lower, vector<int>& upper);

int main(){
  vector<int> lower;
  vector<int> upper;
  vector<int> order;
  int tok;
  bool readTok = true;
  int i = 1;
  while(readTok){
    readTok = (cin>>tok);
    if(readTok){
       lower.push_back(tok);
       order.push_back(i++);
    }
    readTok = (cin>>tok);
    if(readTok) 
       upper.push_back(tok); 
  }
  if(lower.size()==upper.size()){ 
    mergeSort(lower,upper,0,(int)(lower.size()-1),order);
    printIntervals(lower,upper);
  }
  printArray(order); 
  return 0;
}

void mergeSort(vector<int>& lower, vector<int>& upper, int p, int r, vector<int>& order){
   if(p < r){
      int q = (p+r)/2;
      mergeSort(lower,upper,p,q,order);
      mergeSort(lower,upper,q+1,r,order);
      merge(lower,upper,p,q,r,order);
   }
}

void merge(vector<int>& lower, vector<int>& upper,int p, int q, int r, vector<int>& order){
  vector<int> lowerL,lowerR,upperL,upperR,orderL,orderR;
  for(int i=p;i<=q; i++){
     lowerL.push_back(lower[i]);
     upperL.push_back(upper[i]);
     orderL.push_back(order[i]);
  } 
  for(int i=q+1; i<=r; i++){
     lowerR.push_back(lower[i]);
     upperR.push_back(upper[i]);
     orderR.push_back(order[i]);
  }
  
  lowerR.push_back(INT_MAX);
  lowerL.push_back(INT_MAX);
  upperR.push_back(INT_MAX);
  upperL.push_back(INT_MAX);
  
  for(int k=p, i=0,j=0; k<=r; k++){
     if(lowerL[i]<lowerR[j]){
       lower[k] = lowerL[i];
       upper[k] = upperL[i];
       order[k] = orderL[i];
       ++i;
     }
     else if((lowerL[i]==lowerR[j])&& (upperL[i]<=upperR[j])){
       lower[k] = lowerL[i];
       upper[k] = upperL[i];
       order[k] = orderL[i];
       ++i;       
     }
     else{
       lower[k] = lowerR[j];
       upper[k] = upperR[j];
       order[k] = orderR[j];
       ++j;
     }
  }
}

void printArray(vector<int>& A){
   for(int i=0;i<(int)A.size();i++){
       cout << A.at(i) << ' ';
   }
   cout << endl;
}

void printIntervals(vector<int>&lower, vector<int>& upper){
   for(int i=0; i<(int)lower.size(); i++){
       cout << lower.at(i) << ' ' << upper.at(i) << ' ';
   }
   cout << endl;
}

