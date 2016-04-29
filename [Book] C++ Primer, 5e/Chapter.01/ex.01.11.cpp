#include <iostream>
int main(int argc, const char *argv[])
{
  std::cout << "Enter two numbers:" << std::endl;
  int v1, v2, val;
  std::cin >> v1 >> v2;
  while(v1 <= v2){
    std::cout << "The Loop is at : " << v1 << std::endl;
    v1++;
  }
  return 0;
}
