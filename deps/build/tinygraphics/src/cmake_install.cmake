# Install script for directory: C:/dev/PBR/deps/src/tinygraphics/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/dev/PBR/scripts/../deps/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/dev/PBR/deps/build/tinygraphics/src/tinygraphics.lib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/tinygraphics" TYPE FILE FILES
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/app.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/camera.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/cubemap.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/framebuffer.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/indexbuffer.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/light.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/renderer.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/shader.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/stb_image.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/texture.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/vertexarray.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/vertexbuffer.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/vertexbufferlayout.h"
    )
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/tinygraphics/events" TYPE FILE FILES
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/events/event.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/events/keyevent.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/events/mouseevent.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/events/windowevent.h"
    )
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/tinygraphics/utils" TYPE FILE FILES
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/utils/bbox.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/utils/mesh.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/utils/meshbufferobjects.h"
    "C:/dev/PBR/deps/src/tinygraphics/include/tinygraphics/utils/meshgl.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/tinygraphics/tinygraphicsTargets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/tinygraphics/tinygraphicsTargets.cmake"
         "C:/dev/PBR/deps/build/tinygraphics/src/CMakeFiles/Export/2bc64533ec194f73009ebda4721f0808/tinygraphicsTargets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/tinygraphics/tinygraphicsTargets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/tinygraphics/tinygraphicsTargets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/tinygraphics" TYPE FILE FILES "C:/dev/PBR/deps/build/tinygraphics/src/CMakeFiles/Export/2bc64533ec194f73009ebda4721f0808/tinygraphicsTargets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/tinygraphics" TYPE FILE FILES "C:/dev/PBR/deps/build/tinygraphics/src/CMakeFiles/Export/2bc64533ec194f73009ebda4721f0808/tinygraphicsTargets-release.cmake")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/tinygraphics" TYPE FILE FILES "C:/dev/PBR/deps/src/tinygraphics/src/tinygraphicsConfig.cmake")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "C:/dev/PBR/deps/build/tinygraphics/src/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
