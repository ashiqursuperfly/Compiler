int max(int a,int b)
{
	if(a<b)return b;
	else return a;
}

int main()
{
	int a,b,c,d,e,f,i;
	a = 3 + 2;
	println(a);
	b = 2 - 5*a + (7%3);
	println(b);
	//c = -b;
	c++;
	println(c);
	b--;
	println(b);
	
	if((b > a) || (c>b))
	{ 
		e = 1 + (2&&5);
		println(e);
	}
	f = 0;
	for(i=100;i>=1;i--)
	{
		f++;
	}
	println(f);
	
	f = 0;
	while(i>40)
	{
		f--;
		i--;
	}
	println(f);
	
	f = max(10,4);
	println(f);
}
