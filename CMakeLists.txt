cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# get rid of the warning you would have seen when using cygwin
set(CMAKE_LEGACY_CYGWIN_WIN32 0)

project(alpha)

# append user defined cmake module
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules)

enable_testing()
# include the gmock module we created, which enabels us to develop test driven.
include(gmock)

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" OR
    "${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    set(warnings "-Wall -Wextra -Werror")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    set(warnings "/W4 /WX /EHsc")
endif()

if (NOT CONFIGURED_ONCE)
    set(CMAKE_CXX_FLAGS "${warnings}"
        CACHE STRING "Flags used by the compiler during all build types." FORCE)
    set(CMAKE_CFLAGS "${warnings}"
        CACHE STRING "Flags used by the compiler during all build types." FORCE)
endif()

# include serach path is always set to be here
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)

# testing environment. you can create an executable here.
add_subdirectory(sandbox)
# source code directory
add_subdirectory(src)
# unit test directory. CTest is invoked automatically after building project.
add_subdirectory(test)


set(CONFIGURED_ONCE TRUE CACHE INTERNAL
    "A flag showing that CMake has configured at least once.")