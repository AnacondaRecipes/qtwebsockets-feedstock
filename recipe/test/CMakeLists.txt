cmake_minimum_required (VERSION 3.0)

set (CMAKE_BUILD_TYPE "Release" CACHE STRING "build type")

project (qtwebsockets-test CXX)

find_package (Qt6 CONFIG REQUIRED COMPONENTS WebSockets)

add_executable (test_qtwebsockets test_qtwebsockets.cpp)
target_link_libraries (test_qtwebsockets Qt6::WebSockets)

enable_testing ()
add_test (NAME test_qtwebsockets COMMAND test_qtwebsockets)
