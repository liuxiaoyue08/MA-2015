#include<iostream>
#include<cstdlib>
#include<vector>
//#include<Windows.h>
using namespace std;


//void quickSortLb(vector<int>& A,vector<int>& B,vector<int>& ID,int p,int r)
//{
//	if ( p < r ) 
//	{ // immediately terminate if subarray size is 1
//		int piv = A[r]; // take a pivot value
//		int i = p-1; // p- i -1 is the # elements < piv among A[ p.. j ]
//		int tmp1;
//		int tmp2;
//		int idtmp;
//		for( int j=p; j < r; ++j) 
//		{
//			if ( A[j] < piv ) 
//			{ // if smaller value is found , increase q (=i+1)
//				++i;
//				tmp1 = A[i]; A[i] = A[j]; A[j] = tmp1; // swap A[ i] and A[ j ]
//				tmp2 = B[i]; B[i] = B[j]; B[j] = tmp2;
//				idtmp= ID[i];ID[i]=ID[j]; ID[j]= idtmp;
//			}
//		}
//		A[r] = A[i+1]; A[i+1] = piv; // swap A[ i+1] and A[ r]
//		quickSortLb(A,B,ID, p, i);
//		quickSortLb(A,B,ID, i+2, r);
//	}
//}

void quickSortLb(vector<int>& A, vector<int>& B, vector<int>& ID)
{
	int vsize = ID.size();
	int tmp1;
	int tmp2;
	int idtmp;
	for (int i = 0;i < vsize-1;i++)
		if (A[i]>A[i + 1])
		{
			tmp1 = A[i]; A[i] = A[i+1]; A[i+1] = tmp1; // swap A[ i] and A[ j ]
			tmp2 = B[i]; B[i] = B[i+1]; B[i+1] = tmp2;
			idtmp= ID[i];ID[i]=ID[i+1]; ID[i+1]= idtmp;
		}
}

void quickSortUb(vector<int>& A, vector<int>& B, vector<int>& ID)
{
	int vsize = ID.size();
	int tmp1;
	int tmp2;
	int idtmp;
	for (int i = 0;i < vsize - 1;i++)
		if (A[i]==A[i+1]
		{
		if (B[i]>B[i + 1])
		{
			tmp1 = A[i]; A[i] = A[i + 1]; A[i + 1] = tmp1; // swap A[ i] and A[ j ]
			tmp2 = B[i]; B[i] = B[i + 1]; B[i + 1] = tmp2;
			idtmp = ID[i];ID[i] = ID[i + 1]; ID[i + 1] = idtmp;
		}
		}
}
//void quickSortUb(vector<int>& A,vector<int>& B,vector<int>& ID,int p,int r)
//{
//	if ( p < r ) 
//	{ // immediately terminate if subarray size is 1
//		int piv = B[r]; // take a pivot value
//		int i = p-1; // p- i -1 is the # elements < piv among B[ p.. j ]
//		int tmp1;
//		int tmp2;
//		int idtmp;
//		for( int j=p; j < r; ++j) 
//		{
//			if ( B[j] < piv ) 
//			{ // if smaller value is found , increase q (=i+1)
//				++i;
//				tmp1 = A[i]; A[i] = A[j]; A[j] = tmp1; // swap B[ i] and B[ j ]
//				tmp2 = B[i]; B[i] = B[j]; B[j] = tmp2;
//				idtmp= ID[i];ID[i]=ID[j]; ID[j]= idtmp;
//			}
//		}
//		B[r] = B[i+1]; B[i+1] = piv; // swap B[ i+1] and B[ r]
//		quickSortLb(A,B,ID, p, i);
//		quickSortLb(A,B,ID, i+2, r);
//	}
//}
/*void printArray( vector<double>& A) 
{ // call - by- reference
	for( int i=0; i < ( int ) A.size(); ++i) 
	{
		cout << " " << A[i];
	}
	cout << endl;
}*/


int main( int argc, char** argv) 
{
	vector< int > v;
	vector< int > id;
	vector< int > lb;
	vector< int > ub;
	int tok;
	while ( cin >> tok ) 
	{ 
		v.push_back(tok); 
	}
	/*for (int i = 0; i < 10;i++)
	{
		v.push_back(i);
	}*/
	/*v.push_back(0);
	v.push_back(3);
	v.push_back(7);
	v.push_back(9);
	v.push_back(6);
	v.push_back(9);
	v.push_back(6);
	v.push_back(8);
	v.push_back(8);
	v.push_back(9);*/
	for(int j=0;j<v.size();j++)
	{
		if(j%2==0)
		{
			lb.push_back(v[j]);
			int idnum=j/2+1;
			id.push_back(idnum);
		}
		else
		{
			ub.push_back(v[j]);
		}
	}
	//quickSortLb(lb,ub,id, 0, lb.size()-1); 
	//quickSortUb(lb,ub,id, 0, ub.size()-1); 
	quickSortLb(lb,ub,id); 
	quickSortUb(lb,ub,id); 

	for(int order=0;order<lb.size();order++)
	{
		if(order==lb.size()-1)
		{
			cout<<lb[order]<<" "<<ub[order]<<endl;
		}
		else
		{
			cout<<lb[order]<<" "<<ub[order]<<" ";
		}
		
	}
	for(int id2=0;id2<id.size();id2++)
	{
		if(id2==id.size()-1)
		{
			cout<<id[id2]<<endl;
		}
		else
		{
			cout<<id[id2]<<" ";
		}
	}
	//system("pause");
	return 0;
	
}
