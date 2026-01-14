cmake_minimum_required(VERSION 3.26)

set(ROOT_DIR "${CMAKE_CURRENT_LIST_DIR}/..")
set(DEPS_DIR "${ROOT_DIR}/deps")
set(SRC_DIR  "${DEPS_DIR}/src")
set(BLD_DIR  "${DEPS_DIR}/build")
set(INSTALL_DIR "${DEPS_DIR}/install")

# Determine dependency build type from CMAKE_BUILD_TYPE (default to Debug)
if (NOT DEFINED DEPS_BUILD_TYPE)
    if(DEFINED CMAKE_BUILD_TYPE AND NOT "${CMAKE_BUILD_TYPE}" STREQUAL "")
        set(DEPS_BUILD_TYPE "${CMAKE_BUILD_TYPE}")
    else()
        set(DEPS_BUILD_TYPE "Debug")
    endif()
endif()

file(MAKE_DIRECTORY "${SRC_DIR}" "${BLD_DIR}" "${INSTALL_DIR}")

include("${CMAKE_CURRENT_LIST_DIR}/SetupTinygraphics.cmake")

message(STATUS "All dependencies installed to ${INSTALL_DIR}")
