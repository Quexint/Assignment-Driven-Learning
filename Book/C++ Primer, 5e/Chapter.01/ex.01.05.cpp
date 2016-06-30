#include <iostream>
int main(int argc, const char *argv[])
{
  std::cout << "Enter two numbers:" ;
  std::cout << std::endl;
  int v1, v2;
  std::cin >> v1 >> v2;
  std::cout << "The product fo ";
  std::cout << v1;
  std::cout << " and ";
  std::cout << v2;
  std::cout << " is ";
  std::cout << v1 * v2;
  std::cout << std::endl;
  return 0;
}
