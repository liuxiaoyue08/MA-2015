#include <iostream>
#include <cstdlib>
#include <vector>
#include <algorithm>

using namespace std;


long exponentiation1(long a, long b, long c) {
	a = a % c;
	long result = 1;
	while(b>0) {
		if (b%2) result = (result * a) % c;
		b /= 2;
		a = (a * a) % c;
	}
	return result;
}

int main(int argc, char** argv) {
	vector<long> numbers;
	int tok;
	while (cin >> tok) {
		numbers.push_back(tok);	
	}
	int a = numbers[0];
        long c = 10;
        for(int i = 1; i<(int)numbers.size();i++){
           c *= 10;
        }
	for (int i = 1; i < (int)numbers.size(); i++) {
		a = exponentiation1(a, numbers[i], c);
	}
	cout << a << endl;
	return 0;
}

