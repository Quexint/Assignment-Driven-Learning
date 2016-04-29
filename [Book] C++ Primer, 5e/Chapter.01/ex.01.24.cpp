#include <iostream>
#include "Sales_item.h"

int main()
{
  Sales_item sum, item;
  if(std::cin >> sum){
    int transactions = 1;
    while(std::cin >> item){
      if(item.isbn() == sum.isbn()){
        sum += item;
        transactions++;
      }else{
        std::cout << "Transactions: " << transactions << " ISBN: " <<  sum << std::endl;
        sum = item;
        transactions = 1;
      }
    }
    std::cout << "Transactions: " << transactions << " ISBN: " <<  sum << std::endl;
  }else{
    std::cerr << "No data" << std::endl;
    return -1;
  }
  return 0;
}
