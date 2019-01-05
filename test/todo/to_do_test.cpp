#include "todo/to_do.h"
#include <gmock/gmock.h>
#include <gtest/gtest.h>
#include <string>

namespace todo {
namespace test {
using ::testing::Eq;

class ToDoTest : public ::testing::Test {
 protected:
  ToDoTest() {}
  ~ToDoTest() {}

  virtual void SetUp() {}
  virtual void TearDown() {}
};

TEST_F(ToDoTest, ctor_creates_empty_list) {
  ToDo todo;
  EXPECT_THAT(todo.size(), Eq(std::size_t(0)));
}

TEST_F(ToDoTest, add_task_three_times_size_is_three) {
  ToDo todo;
  todo.add_task("feed inu");
  todo.add_task("feed neko");
  todo.add_task("sleep with inu and neko");
}

TEST_F(ToDoTest, get_task_with_one_task_returns_correct_string) {
  ToDo todo;
  todo.add_task("feed inu");
  ASSERT_THAT(todo.size(), Eq(std::size_t(1)));
  EXPECT_THAT(todo.get_task(0), Eq("feed inu"));
}

TEST_F(ToDoTest,
       get_task_with_three_tasks_returns_correct_string_for_each_index) {
  ToDo todo;
  todo.add_task("feed inu");
  todo.add_task("feed neko");
  todo.add_task("sleep with inu and neko");

  ASSERT_THAT(todo.size(), Eq(std::size_t(3)));
  EXPECT_THAT(todo.get_task(0), Eq("feed inu"));
  EXPECT_THAT(todo.get_task(1), Eq("feed neko"));
  EXPECT_THAT(todo.get_task(2), Eq("sleep with inu and neko"));
}

}  // namespace test
}  // namespace ToDoCore
