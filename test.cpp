#include<iostream>
// declaring the namespace
using namespace std;

int main()
{
	int i;
	cin>>i;	//taking i as input
	while(i!=42){	
	    cout<<i<<"\n";	//print i onto screen in a line and input it again
	    cin>>i;
	}
	return 0;
}
