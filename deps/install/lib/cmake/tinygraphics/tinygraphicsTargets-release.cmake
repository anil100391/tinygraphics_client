#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "tinygraphics::tinygraphics" for configuration "Release"
set_property(TARGET tinygraphics::tinygraphics APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(tinygraphics::tinygraphics PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/tinygraphics.lib"
  )

list(APPEND _cmake_import_check_targets tinygraphics::tinygraphics )
list(APPEND _cmake_import_check_files_for_tinygraphics::tinygraphics "${_IMPORT_PREFIX}/lib/tinygraphics.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
