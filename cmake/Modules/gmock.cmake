# These two directories depend on my local environment. You should change these ones for yourself.
set(GTEST_DIR "$ENV{GTEST_ROOT}/googletest")
set(GMOCK_DIR "$ENV{GTEST_ROOT}/googlemock")

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    # force this option to ON so that Google Test will use /MD instead of /MT
    # /MD is now the default for Visual Studio, so it should be our default, too
    option(
        gtest_force_shared_crt
        "Use shared (DLL) run-time lib even when Google Test is built as static lib."
        ON)
elseif(APPLE)
    # When you are using relatively newer Mac OS X which default to using a different standard library 
    # that fully supports C++11. GTest uses the tuple class from the draft TR1 standard and therefore 
    # looks for it in the std::tr1 namespace. The tr1 namespace is not present in the C++11 standard library 
    # that Apple uses so GTest cannot find it and won't compile. We fix this by telling GTest to use its own tuple implementation.
    add_definitions(-DGTEST_USE_OWN_TR1_TUPLE=1)
endif()

# Add the ${GMOCK_DIR} to the current project with binary directory ${CMAKE_BINARY_DIR}/gmock
# as its corresponding binary output directory.
add_subdirectory(${GMOCK_DIR} ${CMAKE_BINARY_DIR}/gmock)

# There are a variety of things that have properties in CMake, in this case we are interested in a target's properties. 
# Each target can have it's own compiler flags in addition the ones set in CMAKE_<LANG>_FLAGS. 
# Here we append " -w" to gtest's COMPILE_FLAGS. The flag "-w" disables all warnings for both GCC and Clang. 
# When compiling with MSVC the "-w" will be automatically converted to "/w" which has the same function.
# This is a capability that can easily be abused. In the case of Google Test we didn't write it and we know, 
# or at least assume, that it works fine. Because of that we don't care about any warnings we might find in Google Test's code.
# We need to be careful not to use this feature to allow ourselves to write poor code.
set_property(TARGET gtest APPEND_STRING PROPERTY COMPILE_FLAGS " -w")

# Specify that these two directories are system include directories. 
# This only has an affect on compilers that support the distinction. 
# This can change the order in which the compiler searches include directories 
# or the handling of warnings from headers found in these directories.
include_directories(
    SYSTEM
    ${GTEST_DIR}/include
    ${GMOCK_DIR}/include)

# Welcome to TDD!
#
# add_gtest_test(<target> <sources>...)
#
# Adds a googl test based test executable, <target>, built from <sources>
# and adds the test so that CTest will run it. Both the executable and
# the test will be named <target>.
#
function(add_gtest_test target)
    add_executable(${target} ${ARGN})
    target_link_libraries(${target} gmock_main)

    add_test(${target} ${target})

    add_custom_command(
        TARGET ${target}
        POST_BUILD
        COMMAND ${target}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Running ${target}" VERBATIM)
endfunction()
