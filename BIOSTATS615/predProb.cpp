#include<cstdlib>
#include<iostream>
#include<cmath>
#include<iomanip>
//#include<Windows.h>

using namespace std;

int main(int argc,char* argv[])
{
	if(argc<=2)
	{
		cout<<"Error: Not Enough Inputs"<<endl;
	}
	else
	{
		//int j=0;
		double b[6][100]={0.0};
		double pr[10]={0.0};
		double total=0.0;
		int k=0;
		for(k=1;k<=5;k++)
		{
			double sum=0.0;
			b[k][0]=pow(2,-k);
			for(int j=1;j<argc;j++)
			{
				int m=k-j;
				//cout<<"k-j="<<m<<endl;
				b[k][j]=pow(2,fabs(m));
				//cout<<"b"<<k<<j<<"="<<b[k][j]<<endl;
				sum=sum+b[k][j]*atof(argv[j]);
				//cout<<"sum="<<sum<<endl;
			}
			pr[k]=exp(b[k][0]+sum);
			//cout<<"pr"<<k<<"="<<pr[k]<<endl;
			total=total+pr[k];
			//cout<<"total="<<total<<endl;
			//cout<<pr[k]/total<<endl;
			//cout<<pr[1]<<" "<<pr[2]<<endl;
		}
		for(k=1;k<=5;k++)
		{
			cout<<setprecision(8)<<pr[k]/total<<endl;
		}
	}
	return 0;
	//getchar();
}





