
cmake_minimum_required (VERSION 3.0.0)
cmake_policy(SET CMP0057 NEW) # Must be set to NEW if want to use: 'IN_LIST' operator. Else use 2 lines: 1. list(FIND CONAN_LIBS "MathL111ibrary" _index)  2. if (${_index} GREATER -1)
cmake_policy(SET CMP0054 NEW) # Must be set to NEW if want to avoid only interpreting if() arguments as variables or keywords when unquoted  <-- needed for IN_LIST operator
set(ProjectName "MathClient")
project (${ProjectName})
set(LIBRARIES_NAMES_TO_LINK_WITH "")


# Vars:
#   CMAKE_BINARY_DIR - the top level dir of CMakeLists.txt

# Conan - Load only if found 'conanbuildinfo.cmake' file
set(CONAN_CMAKE_INCLUDE_FILE_PATH ${CMAKE_BINARY_DIR}/../conanbuildinfo.cmake)
MESSAGE("Checking if exist: ${CONAN_CMAKE_INCLUDE_FILE_PATH}")
if ((EXISTS "${CONAN_CMAKE_INCLUDE_FILE_PATH}") AND (NOT IS_DIRECTORY "${CONAN_CMAKE_INCLUDE_FILE_PATH}"))
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



# MESSAGE("==========================================================================================")
# MESSAGE(STATUS "Running multiple tests")
# MESSAGE("CONAN_LIBS=\"${CONAN_LIBS}\"")
# MESSAGE("")

# MESSAGE("Checking: \"MathLibrary\" IN_LIST CONAN_LIBS")

# if ("MathLibrary" IN_LIST CONAN_LIBS)
	# MESSAGE("True")
# else()
	# MESSAGE("False")
# endif()


# MESSAGE("Checking: if (MathLibrary IN_LIST CONAN_LIBS)")
# if (MathLibrary IN_LIST CONAN_LIBS)
	# MESSAGE("True")
# else()
	# MESSAGE("False")
# endif()



# MESSAGE("Running loop: foreach(LibName ${CONAN_LIBS})")
# foreach (Line ${CONAN_LIBS})
	# MESSAGE("Line='${Line}'")
# endforeach()



# MESSAGE("")
# MESSAGE("Done")
# MESSAGE("==========================================================================================")


set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++14")

# Output dir:
MESSAGE("Outputting to: ${CMAKE_BINARY_DIR}/build_out")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build_out/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build_out/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build_out/bin)



# Check if already provided by the conan:
# MESSAGE("Searching for libraries..")
# find_library (
	# MathLibrary 
	# MathLibrary
	# PATHS ${CMAKE_BINARY_DIR}/build_out/lib/Debug
	# REQUIRED
# )
# find_library (
	# Printings 
	# Printings
	# PATHS ${CMAKE_BINARY_DIR}/build_out/lib/Debug
	# REQUIRED
# )
# MESSAGE(STATUS "${MathLibrary}")
# MESSAGE(STATUS "${Printings}")
# if (NOT MathLibrary)
	# MESSAGE("Adding target library 'MathLibrary' on: ${CMAKE_CURRENT_LIST_DIR}/src/StaticMath/MathLibrary/MathLibrary.cpp")
	# add_library (MathLibrary STATIC "${CMAKE_CURRENT_LIST_DIR}/src/StaticMath/MathLibrary/MathLibrary.cpp" )
# endif()

# if (NOT Printings)
	# MESSAGE("Adding target library 'Printings' on: ${CMAKE_CURRENT_LIST_DIR}/src/StaticMath/Printings/Printings.cpp")
	# add_library (Printings STATIC "${CMAKE_CURRENT_LIST_DIR}/src/StaticMath/Printings/Printings.cpp" )
# endif()



# Libs
if (NOT ("MathLibrary" IN_LIST CONAN_LIBS))
	MESSAGE("Adding target library 'MathLibrary' on: ${CMAKE_CURRENT_LIST_DIR}/src/StaticMath/MathLibrary/MathLibrary.cpp")
	add_library (MathLibrary STATIC "${CMAKE_CURRENT_LIST_DIR}/src/StaticMath/MathLibrary/MathLibrary.cpp" )
	list(APPEND LIBRARIES_NAMES_TO_LINK_WITH "MathLibrary")
endif()

if (NOT ("Printings" IN_LIST CONAN_LIBS))
	MESSAGE("Adding target library 'Printings' on: ${CMAKE_CURRENT_LIST_DIR}/src/StaticMath/Printings/Printings.cpp")
	add_library (Printings STATIC "${CMAKE_CURRENT_LIST_DIR}/src/StaticMath/Printings/Printings.cpp" )
	list(APPEND LIBRARIES_NAMES_TO_LINK_WITH "Printings")
endif()


include_directories ("${CMAKE_CURRENT_LIST_DIR}/src/StaticMath/MathLibrary" )
include_directories ("${CMAKE_CURRENT_LIST_DIR}/src/StaticMath/Printings" )
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


# First define the executable:
add_executable (${ProjectName} "${CMAKE_CURRENT_LIST_DIR}/src/StaticMath/MathClient/MathClient.cpp")


MESSAGE("Linking to libs: ${LIBRARIES_NAMES_TO_LINK_WITH} ${CONAN_LIBS}")
target_link_libraries(${ProjectName} ${LIBRARIES_NAMES_TO_LINK_WITH} ${CONAN_LIBS})


