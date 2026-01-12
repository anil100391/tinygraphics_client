#include("${CMAKE_CURRENT_LIST_DIR}/CloneGitRepo.cmake") # still useful for helpers if you have them

# --------------------------------------------------
# GLEW (compiled, from GitHub releases)
# --------------------------------------------------
set(GLEW_VERSION 2.2.0)
set(GLEW_NAME "glew-${GLEW_VERSION}")
set(GLEW_ARCHIVE "${GLEW_NAME}.tgz")
set(GLEW_URL "https://github.com/nigels-com/glew/releases/download/glew-${GLEW_VERSION}/${GLEW_ARCHIVE}")

set(GLEW_SRC_DIR "${SRC_DIR}/${GLEW_NAME}")
set(GLEW_BUILD_DIR "${BLD_DIR}/glew")

# --------------------------------------------------
# Download + extract if missing
# --------------------------------------------------
if (NOT EXISTS "${GLEW_SRC_DIR}")
  message(STATUS "Downloading GLEW ${GLEW_VERSION} from GitHub releases")

  file(DOWNLOAD
    "${GLEW_URL}"
    "${SRC_DIR}/${GLEW_ARCHIVE}"
    SHOW_PROGRESS
    STATUS download_status
  )

  list(GET download_status 0 download_result)
  if (NOT download_result EQUAL 0)
    message(FATAL_ERROR "Failed to download GLEW archive")
  endif()

  execute_process(
    COMMAND ${CMAKE_COMMAND} -E tar xzf "${SRC_DIR}/${GLEW_ARCHIVE}"
    WORKING_DIRECTORY "${SRC_DIR}"
  )
endif()

# --------------------------------------------------
# Configure
# --------------------------------------------------
execute_process(
  COMMAND ${CMAKE_COMMAND}
    -S "${GLEW_SRC_DIR}/build/cmake"
    -B "${GLEW_BUILD_DIR}"
    -G Ninja
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX:PATH=${INSTALL_DIR}
    -DBUILD_SHARED_LIBS=OFF
    -DBUILD_STATIC_LIBS=ON
    -DBUILD_UTILS=OFF
    -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded
)

# --------------------------------------------------
# Build + install
# --------------------------------------------------
execute_process(
  COMMAND ${CMAKE_COMMAND}
    --build "${GLEW_BUILD_DIR}"
    --config Release
    --target install
)
