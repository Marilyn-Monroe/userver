cmake_minimum_required(VERSION 3.14)
project(userver-samples-mongo_service CXX)

if(NOT TARGET userver::mongo)
  find_package(userver COMPONENTS mongo REQUIRED)
  userver_setup_environment()
endif()

add_executable(${PROJECT_NAME} "mongo_service.cpp")
target_link_libraries(${PROJECT_NAME} userver::mongo)

userver_testsuite_add_simple()
