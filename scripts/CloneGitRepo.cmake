function(clone_if_missing name repo tag)
  set(dst "${SRC_DIR}/${name}")

  if (EXISTS "${dst}/.git")
    message(STATUS "${name} already cloned")
    return()
  endif()

  message(STATUS "Cloning ${name}")
  execute_process(
    COMMAND git clone --depth 1 --branch ${tag} ${repo} ${dst}
    RESULT_VARIABLE res
  )

  if (NOT res EQUAL 0)
    message(FATAL_ERROR "Failed to clone ${name}")
  endif()
endfunction()
