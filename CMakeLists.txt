cmake_minimum_required(VERSION 3.21)
project(test VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_BUILD_RPATH_USE_ORIGIN 1)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR})
add_compile_options(-fdiagnostics-color=always)

file(GLOB SRC src/*.cc)

add_executable(test ${SRC})
target_compile_options(test PRIVATE
        -Wall -Wextra -Wundef -Werror=return-type
        -Wno-unused-function -Wno-unused-parameter -Wno-unused-variable
        -Wno-empty-body -Wno-nonnull -fdiagnostics-color=always
        -Xclang -fprebuilt-module-path=${PROJECT_SOURCE_DIR}/out)

if (CMAKE_BUILD_TYPE STREQUAL "Release")
    target_compile_options(test PRIVATE -O3 -DNDEBUG)
else ()
    target_compile_options(test PRIVATE -O0 -ggdb)
endif ()

target_link_libraries(test PRIVATE fmt)
