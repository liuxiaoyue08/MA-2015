#include <iostream>
#include <cstdlib>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

map<pair<int, int>, int> solutions;
map<pair<int, int>, vector< map<int, int > > > trace_combinations;

int changeMoney(int N, vector<int> n, vector< map<int,int> >& combinations) {
	int k = (int)n.size();
	if (k == 0) {
		if (N == 0) {
                     map<int, int> combination;
                     combination[N] = 1;
                     combinations.push_back(combination);
                     return 1;
                 }
		 else return 0;
	}

	if (solutions.count(pair<int, int>(k, N)) > 0) {
           combinations.insert(combinations.end(),trace_combinations[pair<int, int>(k, N)].begin(),trace_combinations[pair<int, int>(k, N)].end()); 
           return solutions[pair<int, int>(k, N)];
	}
	int result = 0;
	if (k == 1) {
		if (N % n[0] == 0){ 
                    map<int, int> combination;
                     combination[n[0]] = N/n[0];
                     combinations.push_back(combination);
                    result = 1;
                }				
		else result = 0;
	} else {
		for (int i = 0; i <= N/n[0]; i++) {
			vector<int> n1 = n;
                        vector< map<int,int> > subcomb;
			n1.erase(n1.begin());
                        int temp = changeMoney(N - i * n[0],n1,subcomb);
                        if(temp > 0){
                           for(int j=0; j < subcomb.size(); j++){
                              subcomb[j][n[0]] += i;
                           }
                           combinations.insert(combinations.end(),subcomb.begin(),subcomb.end());
                           
			   result += temp;
                        }
		}
	}
	solutions[pair<int, int>(k, N)] = result;
        trace_combinations[pair<int, int>(k, N)] = combinations;
	return result;
}

int main(int argc, char** argv) {
	int N = atoi(argv[1]);
	vector<int> n;
        vector<map<int, int> > combinations;
	for (int i = 2; i < argc; i++) n.push_back(atoi(argv[i]));
	sort(n.begin(), n.end(), std::greater<int>());
	int counts = changeMoney(N, n, combinations);
        cout << counts << endl;
        for(int i=0; i<counts; i++){
           for(int j=n.size()-1; j>=0; j--){
               for(int l=0; l<combinations[i][n[j]]; l++)
                   cout<< n[j] << " ";
           }
           cout << endl;
        }
	return 0;
}

