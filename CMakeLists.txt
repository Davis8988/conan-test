
cmake_minimum_required (VERSION 3.0.0)
cmake_policy(SET CMP0057 NEW) # Must be set to NEW if want to use: 'IN_LIST' operator. Else use 2 lines: 1. list(FIND CONAN_LIBS "MathL111ibrary" _index)  2. if (${_index} GREATER -1)
cmake_policy(SET CMP0054 NEW) # Must be set to NEW if want to avoid only interpreting if() arguments as variables or keywords when unquoted  <-- needed for IN_LIST operator

set(CurrentProjectName "StaticMath")
project (${CurrentProjectName})
set(LIBRARIES_NAMES_TO_LINK_WITH "")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++14")
include(CheckIncludeFileCXX)

# Output dir:
MESSAGE("Outputting to: ${CMAKE_BINARY_DIR}/build_out")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build_out/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build_out/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build_out/bin)




# Vars:
#   CMAKE_BINARY_DIR - the top level dir of CMakeLists.txt

# Conan - Load only if found 'conanbuildinfo.cmake' file
MESSAGE("\$ENV{CONAN_CMAKE_INCLUDE_FILE_PATH}=$ENV{CONAN_CMAKE_INCLUDE_FILE_PATH}")
set(CONAN_CMAKE_INCLUDE_FILE_PATH "$ENV{CONAN_CMAKE_INCLUDE_FILE_PATH}")
MESSAGE("Checking if exist: '${CONAN_CMAKE_INCLUDE_FILE_PATH}'")
if ((DEFINED CONAN_CMAKE_INCLUDE_FILE_PATH) AND (EXISTS "${CONAN_CMAKE_INCLUDE_FILE_PATH}") AND (NOT IS_DIRECTORY "${CONAN_CMAKE_INCLUDE_FILE_PATH}"))
	MESSAGE("Loading ${CONAN_CMAKE_INCLUDE_FILE_PATH}")
	include(${CONAN_CMAKE_INCLUDE_FILE_PATH})
	conan_basic_setup(NO_OUTPUT_DIRS)
endif()


MESSAGE("")
MESSAGE("Conan vars:")
MESSAGE(STATUS "CONAN_LIBS=${CONAN_LIBS}")
MESSAGE(STATUS "CONAN_INCLUDE_DIRS=${CONAN_INCLUDE_DIRS}")
MESSAGE(STATUS "CONAN_LIBS_DIRS=${CONAN_LIB_DIRS}")
MESSAGE("")


# Link with conan libs if they exist:
if (DEFINED CONAN_LIBS)
	MESSAGE("Appending CONAN_LIBS=${CONAN_LIBS}  to link libraries list: ${LIBRARIES_NAMES_TO_LINK_WITH}")
	set(LIBRARIES_NAMES_TO_LINK_WITH "${LIBRARIES_NAMES_TO_LINK_WITH} ${CONAN_LIBS}")  # Append conan libs incase they exist
	MESSAGE("LIBRARIES_NAMES_TO_LINK_WITH=${LIBRARIES_NAMES_TO_LINK_WITH}")
endif()


# Add conan dirs if exist:
if ((DEFINED CONAN_INCLUDE_DIRS) AND (NOT (CONAN_INCLUDE_DIRS STREQUAL "")))
	include_directories ("${CONAN_INCLUDE_DIRS}")
endif()

if ((DEFINED CONAN_INCLUDE_DIRS) AND (NOT (CONAN_INCLUDE_DIRS STREQUAL "")))
	MESSAGE("Including dirs: CONAN_INCLUDE_DIRS=${CONAN_INCLUDE_DIRS}")
	include_directories ("${CONAN_INCLUDE_DIRS}")
endif()
if ((DEFINED CONAN_LIB_DIRS) AND (NOT (CONAN_LIB_DIRS STREQUAL "")))
	MESSAGE("Including dirs: CONAN_LIB_DIRS=${CONAN_LIB_DIRS}")
	include_directories ("${CONAN_LIB_DIRS}")
endif()


MESSAGE("Addin subdirectories: MathLibrary Printings MathClient")
add_subdirectory("src/StaticMath/MathLibrary")
add_subdirectory("src/StaticMath/Printings")
add_subdirectory("src/StaticMath/MathClient")
MESSAGE("")
MESSAGE("Done")
MESSAGE("")
MESSAGE("Finished build")
MESSAGE("")