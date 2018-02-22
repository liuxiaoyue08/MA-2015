//minSubSum.cpp
#include <iostream>
#include <cstdlib>
#include <vector>
#include <algorithm>

using namespace std;
int main(int argc, char** argv) {
        vector<int> n;
        int tok;
        while (cin >> tok) {
                n.push_back(tok);
        }
        int sum = 0;
        int max_sum = 0;
        int min_subsum = 0;
        for (int i = 0; i < (int)n.size(); i++) {
                sum += n[i];
                if (sum > max_sum) max_sum = sum;
                if (sum - max_sum < min_subsum) min_subsum = sum - max_sum;
        }
        cout.clear(); 
        cout << min_subsum << endl;
        return 0;
}

