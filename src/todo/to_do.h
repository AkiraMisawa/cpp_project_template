#pragma once
#include <string>
#include <vector>

namespace todo {
class ToDo {
 public:
  ToDo();

  ~ToDo();

  std::size_t size() const;

  void add_task(const std::string& task);

  std::string get_task(const std::size_t index) const;

 private:
  std::vector<std::string> _tasks;
};
}  // namespace todo
