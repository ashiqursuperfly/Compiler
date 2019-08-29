int main(){

  int a[20];
  int i,val;


  for(i = 0;i < 15 ;i++){
    a[i] = i+1;
  }

  for(i = 0;i < 15 ;i++){
    val = a[i];
    println(val);
  }

	return 0;
}

// int main(){
// 	int a[8],c,i,j;
// 	a[0] = 1;
// 	a[1] = 5;
// 	i = a[0]+a[1];
// 	j = 2*3+(5%3 < 4 && 8) || 2 ;
//   a[1] = j;
//   return 0;
// }
