int x,y,z; float a;

void foo();

int var(int a, int b){
	return a+b;
}

int fib(int n) 
{ 
  int a, b, c, i;
  a=0;
  b=1; 
  if( n == 0) 
    return a; 
  for (i = 2; i <= n; i++) 
  { 
     c = a + b; 
     a = b; 
     b = c; 
  } 
  return b; 
} 

int main(){
	

	int x;
	x++;
	int a[2],c,i,j ; float d;
	a[0]=1;
	a[1]=5;
	i= a[0]+a[1];
	j= 2*3+(5%3 < 4 && 8) || 2 ;
	d=var(1,2*3)+3.5*2;
	return 0;
}