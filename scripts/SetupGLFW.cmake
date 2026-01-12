include("${CMAKE_CURRENT_LIST_DIR}/CloneGitRepo.cmake")

# --------------------------------------------------
# GLFW (compiled)
# --------------------------------------------------
clone_if_missing(
  glfw
  https://github.com/glfw/glfw.git
  3.4
)

set(GLFW_BUILD_DIR "${BLD_DIR}/glfw")

execute_process(
  COMMAND ${CMAKE_COMMAND}
    -S ${SRC_DIR}/glfw
    -B ${GLFW_BUILD_DIR}
    -G Ninja
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX:PATH=${INSTALL_DIR}
    -DGLFW_BUILD_DOCS=OFF
    -DGLFW_BUILD_TESTS=OFF
    -DGLFW_BUILD_EXAMPLES=OFF
    -DGLFW_INSTALL=ON
    -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded
)

execute_process(
  COMMAND ${CMAKE_COMMAND}
    --build "${GLFW_BUILD_DIR}"
    --config Release
    --target install
)
