#include<stdio.h>
const int N=100005;
int read()
{
    int x;
    scanf("%d",&x);
    return x;
}
int main() 
{
    int n,m,k=0,p[N];
    int vis[N];
	n=read();
    m=read();
    int i=1;
    while(i<=n) 
    {
        vis[i]=0;
        i=i+1;
    }
    i=2;
    while(i<N)
	{
		if(!vis[i]) 
        {
            k=k+1; 
            p[k]=i;
        }
        int j=1;
        while(j<=k&&i*p[j]<N)
		{
			vis[i*p[j]]=1;
			if(i%p[j]==0)
                break;
            j=j+1;
		}
        i=i+1;
	}
	while(m)
	{
		int x=read();
		printf("%d\n",p[x]);
        m=m-1;
	}
}