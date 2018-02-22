//detectSquare

#include<iostream>
#include<vector>
#include<algorithm>
#include<map>
#include<set>

using namespace std;

bool detectSquare(const vector<int> & dat){
    map<int, set<int> > points;
    for(int i=0; i<dat.size()/2;i++){
        points[dat[2*i]].insert(dat[2*i+1]);
    }
    //print out unique points
    map<int, set<int> >::iterator pt;
    map<int, set<int> >::iterator pt1;
    for(pt = points.begin(); pt != points.end(); pt++){
       int x = pt->first;
       for(pt1 = pt; pt1!=points.end(); pt1++){
          if(pt1!=pt){
              set<int> intersect;

              int x1=pt1->first;
              set_intersection(points[x].begin(),points[x].end(),
                           points[x1].begin(),points[x1].end(),
                           inserter(intersect,intersect.begin()));
              //for(set<int>::iterator s=intersect.begin(); s!=intersect.end();s++){
              //   cout << "(" << x << "," << *s << ")" << endl;
              //   cout << "(" << x1 << "," << *s << ")" << endl;
              // }
              if (intersect.size()>=2){
                 
                 for(set<int>::iterator s=intersect.begin();s!=intersect.end();s++){
                    for(set<int>::iterator s1=s; s1!=intersect.end();s1++){
                        if(x1 - x == *s1 - *s){
                           return true;
                        }
                    }
                 }
              }

          }
       }       
    }    

    /*set<int>::iterator ypt;
    for(pt = points.begin(); pt != points.end(); pt++){
       int x = pt->first;
       for(ypt = pt->second.begin(); ypt != pt->second.end(); ypt++){
           cout << "(" << x << "," << *ypt << ")" << endl;
       }
    }*/ 
    //detect Squares;
    
    return false;
}

int main(){
  vector<int> dat;
  int tok;
  while (cin >> tok){
     dat.push_back(tok);
  }
  if(dat.size()%2!=0){ 
      cout << "You need to input even number of integters!" << endl;
  }
  else{
      if(detectSquare(dat)) cout << "Yes" << endl; else cout << "No" << endl;
  }
  return 0;
}
