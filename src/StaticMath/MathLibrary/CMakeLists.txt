
cmake_policy(SET CMP0057 NEW) # Must be set to NEW if want to use: 'IN_LIST' operator. Else use 2 lines: 1. list(FIND CONAN_LIBS "MathL111ibrary" _index)  2. if (${_index} GREATER -1)
cmake_policy(SET CMP0054 NEW) # Must be set to NEW if want to avoid only interpreting if() arguments as variables or keywords when unquoted  <-- needed for IN_LIST operator

set(CurrentProjectName "MathLibrary")
project (${CurrentProjectName})
set(LIBRARIES_NAMES_TO_LINK_WITH "")
include_directories (${CMAKE_CURRENT_LIST_DIR})

# Vars:
#   CMAKE_BINARY_DIR - the top level dir of CMakeLists.txt

# Conan - Load only if found 'conanbuildinfo.cmake' file
set(CONAN_CMAKE_INCLUDE_FILE_PATH ${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
MESSAGE("Checking if exist: ${CONAN_CMAKE_INCLUDE_FILE_PATH}")
if ((EXISTS "${CONAN_CMAKE_INCLUDE_FILE_PATH}") AND (NOT IS_DIRECTORY "${CONAN_CMAKE_INCLUDE_FILE_PATH}"))
	MESSAGE("Loading ${CONAN_CMAKE_INCLUDE_FILE_PATH}")
	include(${CONAN_CMAKE_INCLUDE_FILE_PATH})
	conan_basic_setup(NO_OUTPUT_DIRS)
endif()


MESSAGE("")
MESSAGE("${CurrentProjectName} - Conan vars:")
MESSAGE(STATUS "CONAN_LIBS=${CONAN_LIBS}")
MESSAGE(STATUS "CONAN_INCLUDE_DIRS=${CONAN_INCLUDE_DIRS}")
MESSAGE(STATUS "CONAN_LIBS_DIRS=${CONAN_LIB_DIRS}")
MESSAGE("")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++14")

# Output dir:
MESSAGE("Outputting to: ${CMAKE_BINARY_DIR}/build_out")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build_out/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build_out/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build_out/bin)


if (NOT ("${CurrentProjectName}" IN_LIST CONAN_LIBS))
	MESSAGE("Adding target library '${CurrentProjectName}' on: ${CMAKE_CURRENT_LIST_DIR}/${CurrentProjectName}.cpp")
	add_library (${CurrentProjectName} STATIC "${CMAKE_CURRENT_LIST_DIR}/${CurrentProjectName}.cpp" )
	list(APPEND LIBRARIES_NAMES_TO_LINK_WITH "${CurrentProjectName}")
endif()



