cmake_minimum_required(VERSION 3.21)
set(PROJECT_NAME "TrivialWar")
project(${PROJECT_NAME} VERSION 0.1.0)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_DEBUG_POSTFIX .debug)

set(ENGINE_TARGET_NAME "${PROJECT_NAME}.Engine")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++20")

function(create_target_engine LIST_DIR)
    set(CMAKE_AUTOMOC OFF)
    set(CMAKE_AUTOUIC OFF)
    set(CMAKE_AUTORCC OFF)
    set(CMAKE_AUTOUIC_SEARCH_PATHS "")
    set(sources "")
    file(
        GLOB_RECURSE
        sources
        "${LIST_DIR}/*.h"
        "${LIST_DIR}/*.hpp"
        "${LIST_DIR}/*.cpp"
    )
    include_directories(${LIST_DIR}/src)
    add_library(
        ${ENGINE_TARGET_NAME}
        STATIC ${sources}
    )
    target_link_libraries(${ENGINE_TARGET_NAME} ${static_libraries})
    set_target_properties(${ENGINE_TARGET_NAME} PROPERTIES LINKER_LANGUAGE CXX)
    #target_include_directories(${ENGINE_TARGET_NAME} PRIVATE "${CMAKE_CURRENT_BINARY_DIR}")
    #install(TARGETS ${ENGINE_TARGET_NAME} DESTINATION ${CMAKE_INSTALL_LIBDIR})
endfunction()

set(static_libraries "")
message(STATUS "static_libraries: ${static_libraries}")
add_compile_options(-Wall -Wextra -Wreturn-type -Wunused -Wno-terminate)

include(presentation_tool/template_pt.cmake)

create_target_engine(${CMAKE_CURRENT_LIST_DIR}/engine)
create_target_pt(${CMAKE_CURRENT_LIST_DIR}/presentation_tool)
