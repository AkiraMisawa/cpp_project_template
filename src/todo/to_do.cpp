#include "to_do.h"

namespace todo {
ToDo::ToDo() {}

ToDo::~ToDo() {}

std::size_t ToDo::size() const { return _tasks.size(); }

void ToDo::add_task(const std::string& task) { _tasks.push_back(task); }

std::string ToDo::get_task(const std::size_t index) const {
  if (index < _tasks.size()) {
    return _tasks[index];
  } else {
    return "";
  }
}
}  // namespace todo
