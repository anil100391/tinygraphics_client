cmake_minimum_required(VERSION 3.28)
project(PBR LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# For intellisense
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Download tinygraphics release into vendor/
set(TINYGRAPHICS_VENDOR_DIR "${CMAKE_SOURCE_DIR}/vendor/tinygraphics")
set(TINYGRAPHICS_ARCHIVE "${CMAKE_SOURCE_DIR}/vendor/tinygraphics.zip")

if(NOT EXISTS "${TINYGRAPHICS_VENDOR_DIR}")
    message(STATUS "Downloading tinygraphics ${TINYGRAPHICS_VERSION}...")
    file(DOWNLOAD
        "https://github.com/anil100391/tinygraphics/releases/download/0.1/tinygraphics-0.1-win64_debug.zip"
        "${TINYGRAPHICS_ARCHIVE}"
        STATUS download_status
    )
    list(GET download_status 0 status_code)
    if(NOT status_code EQUAL 0)
        message(FATAL_ERROR "Failed to download tinygraphics: ${download_status}")
    endif()

    file(ARCHIVE_EXTRACT INPUT "${TINYGRAPHICS_ARCHIVE}" DESTINATION "${TINYGRAPHICS_VENDOR_DIR}")
    file(REMOVE "${TINYGRAPHICS_ARCHIVE}")
endif()

# Point find_package to the vendor directory
list(APPEND CMAKE_PREFIX_PATH "${TINYGRAPHICS_VENDOR_DIR}")

find_package(OpenGL REQUIRED)
find_package(tinygraphics CONFIG REQUIRED)

file(GLOB core_src "${CMAKE_SOURCE_DIR}/*.cpp")

add_executable(PBR ${core_src})

target_include_directories(PBR PRIVATE .)
target_link_libraries(PBR PRIVATE tinygraphics::tinygraphics)

target_compile_definitions(PBR PRIVATE NOMINMAX _USE_MATH_DEFINES)
