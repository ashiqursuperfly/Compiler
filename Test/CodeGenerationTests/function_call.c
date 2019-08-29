int fact(int n){
  int f,i;
  f = 1;
  for(i=n;i>0;i--){
    f = f * i;
  }
  return f;
}


int main(){

  int n,f;
  n = 6;
  f = fact(n);

  println(f);


	return 0;
}
