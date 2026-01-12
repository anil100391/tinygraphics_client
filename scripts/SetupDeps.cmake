cmake_minimum_required(VERSION 3.26)

set(ROOT_DIR "${CMAKE_CURRENT_LIST_DIR}/..")
set(DEPS_DIR "${ROOT_DIR}/deps")
set(SRC_DIR  "${DEPS_DIR}/src")
set(BLD_DIR  "${DEPS_DIR}/build")
set(INSTALL_DIR "${DEPS_DIR}/install")

file(MAKE_DIRECTORY "${SRC_DIR}" "${BLD_DIR}" "${INSTALL_DIR}")

include("${CMAKE_CURRENT_LIST_DIR}/SetupTinygraphics.cmake")

message(STATUS "All dependencies installed to ${INSTALL_DIR}")
