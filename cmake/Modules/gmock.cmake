set(GTEST_DIR "$ENV{GTEST_ROOT}/googletest")
set(GMOCK_DIR "$ENV{GTEST_ROOT}/googlemock")

add_definitions(-DGTEST_USE_OWN_TR1_TUPLE=1)
add_subdirectory(${GMOCK_DIR} ${CMAKE_BINARY_DIR}/gmock)
set_property(TARGET gtest APPEND_STRING PROPERTY COMPILE_FLAGS " -w")

include_directories(
    SYSTEM
    ${GTEST_DIR}/include
    ${GMOCK_DIR}/include)

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
