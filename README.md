# About
Example project to demonstrate use of tinygraphics slib

# Building

## Requirements

- CMake 3.26 or higher
- tinygraphics dependencies. See https://github.com/anil100391/tinygraphics

  ### Linux
- opengl libs and glfw dependencies for building glfw
  e.g. on Ubuntu:

  ```bash
  sudo apt-get install libgl-dev libgl1-mesa-dev libglu1-mesa-dev libwayland-dev libxkbcommon-dev xorg-dev
  ```
  if using provided presets for configuring using cmake install ninja-build
  ```bash
  sudo apt-get install ninja-build
  ```
  ### Windows
  Visual Studio

## Building

In bash (on linux) or developer powershell (on windows)
* clone the repo
  ```
  git clone https:://github.com/anil100391/tinygraphics_client.git
  cd tinygraphics_client
  ```

* configure debug or release build
  ```
  cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_POLICY_VERSION_MINIMUM="3.5" -B build -S . -G Ninja
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM="3.5" -B build -S . -G Ninja
  ```

* build
  ```
  cmake --build build
  ```
