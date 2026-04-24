cmake_minimum_required(VERSION 3.20)

project(MyQtProject VERSION 1.0 LANGUAGES CXX)

# C++20
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Qt Auto features
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

# Find Qt
find_package(Qt6 REQUIRED COMPONENTS Widgets)

# =========================================================
# Output directory setup (Debug / Release separation)
# =========================================================

# Base output folder
set(OUTPUT_BASE_DIR ${CMAKE_BINARY_DIR}/bin)

# Detect generator type
if(CMAKE_CONFIGURATION_TYPES)
    # Multi-config (Visual Studio, Xcode)

    foreach(CONFIG ${CMAKE_CONFIGURATION_TYPES})
        string(TOUPPER ${CONFIG} CONFIG_UPPER)

        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CONFIG_UPPER} ${OUTPUT_BASE_DIR}/${CONFIG})
        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CONFIG_UPPER} ${OUTPUT_BASE_DIR}/${CONFIG})
        set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${CONFIG_UPPER} ${OUTPUT_BASE_DIR}/${CONFIG})
    endforeach()

else()
    # Single-config (Ninja, Makefiles)

    if(NOT CMAKE_BUILD_TYPE)
        set(CMAKE_BUILD_TYPE Debug CACHE STRING "" FORCE)
    endif()

    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_BASE_DIR}/${CMAKE_BUILD_TYPE})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${OUTPUT_BASE_DIR}/${CMAKE_BUILD_TYPE})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${OUTPUT_BASE_DIR}/${CMAKE_BUILD_TYPE})

endif()


if(WIN32)
    add_custom_command(TARGET MyQtProject POST_BUILD
        COMMAND ${Qt6_DIR}/../../../bin/windeployqt.exe
                $<TARGET_FILE:MyQtProject>
    )
endif()

# =========================================================
# Subdirectories
# =========================================================

add_subdirectory(Data-Layer)
add_subdirectory(GUI-Layer)
add_subdirectory(Main)