#include <iostream>
int main(int argc, const char *argv[])
{
  std::cout << "Enter two numbers:" << std::endl;
  int v1, v2, val;
  int a, b;
  std::cin >> v1 >> v2;
  if(v1 <= v2){
    a = v1;
    b = v2;
  }else{
    a = v2;
    b = v1;
  }
  int sum = 0;
  while(a <= b){
    sum += a;
    a++;
  }
  std::cout << "The Sum is " << sum << std::endl;
  return 0;
}
