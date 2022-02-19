
cmake_minimum_required (VERSION 3.0.0)
set(ProjectName "MathClient")
project (${ProjectName})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++14")

# Output dir:
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)


# Libs
add_library (MathLibrary STATIC "${CMAKE_CURRENT_LIST_DIR}/src/StaticMath/MathLibrary/MathLibrary.cpp" )
add_library (Printings STATIC "${CMAKE_CURRENT_LIST_DIR}/src/StaticMath/Printings/Printings.cpp" )


include_directories ("${CMAKE_CURRENT_LIST_DIR}/src/StaticMath/MathLibrary" )
include_directories ("${CMAKE_CURRENT_LIST_DIR}/src/StaticMath/Printings" )


# First define the executable:
add_executable (${ProjectName} "${CMAKE_CURRENT_LIST_DIR}/src/StaticMath/MathClient/MathClient.cpp")


target_link_libraries(${ProjectName} MathLibrary)
target_link_libraries(${ProjectName} Printings)


