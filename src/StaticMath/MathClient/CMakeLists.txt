
cmake_policy(SET CMP0057 NEW) # Must be set to NEW if want to use: 'IN_LIST' operator. Else use 2 lines: 1. list(FIND CONAN_LIBS "MathL111ibrary" _index)  2. if (${_index} GREATER -1)
cmake_policy(SET CMP0054 NEW) # Must be set to NEW if want to avoid only interpreting if() arguments as variables or keywords when unquoted  <-- needed for IN_LIST operator

set(CurrentProjectName "MathClient")
project (${CurrentProjectName})
set(LIBRARIES_NAMES_TO_LINK_WITH "")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++14")
include(CheckIncludeFileCXX)
include(CheckIncludeFile)

# Output dir:
MESSAGE("Outputting to: ${CMAKE_BINARY_DIR}/build_out")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build_out/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build_out/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build_out/bin)


# Conan - Load only if found 'conanbuildinfo.cmake' file
set(CONAN_CMAKE_INCLUDE_FILE_PATH ${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
MESSAGE("Checking if exist: ${CONAN_CMAKE_INCLUDE_FILE_PATH}")
if ((EXISTS "${CONAN_CMAKE_INCLUDE_FILE_PATH}") AND (NOT IS_DIRECTORY "${CONAN_CMAKE_INCLUDE_FILE_PATH}"))
	MESSAGE("Loading ${CONAN_CMAKE_INCLUDE_FILE_PATH}")
	include(${CONAN_CMAKE_INCLUDE_FILE_PATH})
	conan_basic_setup(NO_OUTPUT_DIRS)
endif()


MESSAGE("")
MESSAGE("Conan vars:")
MESSAGE(STATUS "CONAN_LIBS='${CONAN_LIBS}'")
MESSAGE(STATUS "CONAN_INCLUDE_DIRS='${CONAN_INCLUDE_DIRS}'")
MESSAGE(STATUS "CONAN_LIBS_DIRS='${CONAN_LIB_DIRS}'")
MESSAGE("")




# Link with conan libs if they exist:
if (DEFINED CONAN_LIBS)
	MESSAGE("Appending CONAN_LIBS=${CONAN_LIBS}  to link libraries list: ${LIBRARIES_NAMES_TO_LINK_WITH}")
	set(LIBRARIES_NAMES_TO_LINK_WITH "${LIBRARIES_NAMES_TO_LINK_WITH} ${CONAN_LIBS}")  # Append conan libs incase they exist
	MESSAGE("LIBRARIES_NAMES_TO_LINK_WITH=${LIBRARIES_NAMES_TO_LINK_WITH}")
endif()


# Add conan dirs if exist:
if ((DEFINED CONAN_INCLUDE_DIRS) AND (NOT (CONAN_INCLUDE_DIRS STREQUAL "")))
	MESSAGE("Including dirs: CONAN_INCLUDE_DIRS=${CONAN_INCLUDE_DIRS}")
	include_directories ("${CONAN_INCLUDE_DIRS}")
endif()
if ((DEFINED CONAN_LIBS_DIRS) AND (NOT (CONAN_LIBS_DIRS STREQUAL "")))
	MESSAGE("Including dirs: CONAN_LIBS_DIRS=${CONAN_LIBS_DIRS}")
	include_directories ("${CONAN_LIBS_DIRS}")
endif()


# Include dirs - only when required to
set(CMAKE_CHECK_HEADER_FILE_NAME "MathLibrary.h")
MESSAGE(STATUS "Checking if ${CMAKE_CHECK_HEADER_FILE_NAME} exists and includable")
unset(FOUND_INCLUDE_HEADER_FILE_PATH)
find_path(FOUND_INCLUDE_HEADER_FILE_PATH "${CMAKE_CHECK_HEADER_FILE_NAME}" PATHS ${CONAN_INCLUDE_DIRS} NO_DEFAULT_PATHS)
if (NOT (DEFINED FOUND_INCLUDE_HEADER_FILE_PATH) OR (NOT FOUND_INCLUDE_HEADER_FILE_PATH))
	MESSAGE("Including '${CMAKE_CHECK_HEADER_FILE_NAME}' source dir: ${CMAKE_CURRENT_LIST_DIR}/../MathLibrary")
	include_directories ("${CMAKE_CURRENT_LIST_DIR}/../MathLibrary" )
endif()

set(CMAKE_CHECK_HEADER_FILE_NAME "Printings.h")
MESSAGE(STATUS "Checking if ${CMAKE_CHECK_HEADER_FILE_NAME} exists and includable")
unset(FOUND_INCLUDE_HEADER_FILE_PATH)
find_path(FOUND_INCLUDE_HEADER_FILE_PATH "${CMAKE_CHECK_HEADER_FILE_NAME}" PATHS ${CONAN_INCLUDE_DIRS} NO_DEFAULT_PATHS)
if (NOT (DEFINED FOUND_INCLUDE_HEADER_FILE_PATH) OR (NOT FOUND_INCLUDE_HEADER_FILE_PATH))
	MESSAGE("Including '${CMAKE_CHECK_HEADER_FILE_NAME}' source dir: ${CMAKE_CURRENT_LIST_DIR}/../Printings")
	include_directories ("${CMAKE_CURRENT_LIST_DIR}/../Printings" )
endif()



# Libs - target only when required to
MESSAGE("Trimming var: LIBRARIES_NAMES_TO_LINK_WITH='${LIBRARIES_NAMES_TO_LINK_WITH}'")
string(STRIP "${LIBRARIES_NAMES_TO_LINK_WITH}" LIBRARIES_NAMES_TO_LINK_WITH)
MESSAGE("Trimmed: LIBRARIES_NAMES_TO_LINK_WITH='${LIBRARIES_NAMES_TO_LINK_WITH}'")
if (NOT ("MathLibrary" IN_LIST LIBRARIES_NAMES_TO_LINK_WITH))
	MESSAGE("Adding target library 'MathLibrary' on: ${CMAKE_CURRENT_LIST_DIR}/../MathLibrary/MathLibrary.cpp")
	add_library (MathLibrary STATIC "${CMAKE_CURRENT_LIST_DIR}/../MathLibrary/MathLibrary.cpp" )
	list(APPEND LIBRARIES_NAMES_TO_LINK_WITH "MathLibrary")
endif()

if (NOT ("Printings" IN_LIST LIBRARIES_NAMES_TO_LINK_WITH))
	MESSAGE("Adding target library 'Printings' on: ${CMAKE_CURRENT_LIST_DIR}/../Printings/Printings.cpp")
	add_library (Printings STATIC "${CMAKE_CURRENT_LIST_DIR}/../Printings/Printings.cpp" )
	list(APPEND LIBRARIES_NAMES_TO_LINK_WITH "Printings")
endif()




# First define the executable:
add_executable (${CurrentProjectName} "${CMAKE_CURRENT_LIST_DIR}/MathClient.cpp")


MESSAGE("Linking to libs: '${LIBRARIES_NAMES_TO_LINK_WITH}'")
target_link_libraries(${CurrentProjectName} ${LIBRARIES_NAMES_TO_LINK_WITH})


