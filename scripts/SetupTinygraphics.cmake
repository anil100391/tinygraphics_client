include("${CMAKE_CURRENT_LIST_DIR}/CloneGitRepo.cmake")

# --------------------------------------------------
# TINYGRAPHICS (compiled)
# --------------------------------------------------
clone_if_missing(
  tinygraphics
  https://github.com/anil100391/tinygraphics.git
  main
)

set(TINYGRAPHICS_BUILD_DIR "${BLD_DIR}/tinygraphics")

execute_process(
  COMMAND ${CMAKE_COMMAND}
    -P ${SRC_DIR}/tinygraphics/scripts/SetupDeps.cmake)

execute_process(
  COMMAND ${CMAKE_COMMAND}
    -S ${SRC_DIR}/tinygraphics
    -B ${TINYGRAPHICS_BUILD_DIR}
    -G Ninja
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    -DCMAKE_BUILD_TYPE=${DEPS_BUILD_TYPE}
    -DCMAKE_INSTALL_PREFIX:PATH=${INSTALL_DIR}
)

execute_process(
  COMMAND ${CMAKE_COMMAND}
    --build "${TINYGRAPHICS_BUILD_DIR}"
    --config ${DEPS_BUILD_TYPE}
    --target install
)
