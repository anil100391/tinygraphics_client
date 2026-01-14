cmake_minimum_required(VERSION 3.26)
project(PBR LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# For intellisense
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if (NOT EXISTS "${PROJECT_SOURCE_DIR}/deps/install/lib/cmake")
  message(STATUS "Dependencies missing; running scripts/SetupDeps.cmake to fetch/build them")
  include("${PROJECT_SOURCE_DIR}/scripts/SetupDeps.cmake")

  if (NOT EXISTS "${PROJECT_SOURCE_DIR}/deps/install/lib/cmake")
    message(FATAL_ERROR "Dependencies setup failed. Run \"cmake -P scripts/SetupDeps.cmake\" manually to see errors and retry.")
  endif()
endif()

list(APPEND CMAKE_PREFIX_PATH
     "${PROJECT_SOURCE_DIR}/deps/src/tinygraphics/deps/install/lib/cmake/glew"
     "${PROJECT_SOURCE_DIR}/deps/src/tinygraphics/deps/install/lib/cmake/glfw3"
     "${PROJECT_SOURCE_DIR}/deps/src/tinygraphics/deps/install/lib/cmake/glm"
     "${PROJECT_SOURCE_DIR}/deps/install/lib/cmake/tinygraphics")

find_package(OpenGL REQUIRED)
find_package(glm CONFIG REQUIRED)
find_package(glew CONFIG REQUIRED)
find_package(glfw3 CONFIG REQUIRED)
find_package(tinygraphics CONFIG REQUIRED)

# imgui
include_directories("${PROJECT_SOURCE_DIR}/vendor/imgui")

file(GLOB imgui_src 
     "${CMAKE_SOURCE_DIR}/vendor/imgui/*.cpp"
     "${CMAKE_SOURCE_DIR}/vendor/imgui/backends/imgui_impl_glfw.cpp"
     "${CMAKE_SOURCE_DIR}/vendor/imgui/backends/imgui_impl_opengl3.cpp")

file(GLOB core_src "${CMAKE_SOURCE_DIR}/*.cpp")

add_executable(PBR ${core_src} ${imgui_src})

target_include_directories(PBR PRIVATE "${CMAKE_SOURCE_DIR}")
target_link_libraries(PBR PRIVATE tinygraphics::tinygraphics)

target_compile_definitions(PBR PRIVATE NOMINMAX _USE_MATH_DEFINES)
