#include <iostream>
#include "todo/to_do.h"

int main(int, char**) {
  std::cout << "Hello world!!" << std::endl;
  todo::ToDo list;
  list.add_task("feed neko");
  list.add_task("feed inu");
  list.add_task("sleep with inu and neko");

  std::cout << "size = " << list.size() << std::endl;
  std::cout << "task0 = " << list.get_task(0) << std::endl;
  std::cout << "task1 = " << list.get_task(1) << std::endl;
  std::cout << "task2 = " << list.get_task(2) << std::endl;

  return 0;
}
