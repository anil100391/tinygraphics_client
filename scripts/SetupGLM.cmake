include("${CMAKE_CURRENT_LIST_DIR}/CloneGitRepo.cmake")

# --------------------------------------------------
# GLM (header-only)
# --------------------------------------------------
clone_if_missing(
  glm
  https://github.com/g-truc/glm.git
  0.9.9.8
)

file(COPY
  "${SRC_DIR}/glm/glm"
  DESTINATION "${INSTALL_DIR}/include"
)

file(COPY
  "${SRC_DIR}/glm/cmake"
  DESTINATION "${INSTALL_DIR}/lib"
)
