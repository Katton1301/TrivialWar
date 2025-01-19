if (NOT ENGINE_TARGET_NAME)
    message(FATAL_ERROR "ENGINE_TARGET_NAME not defined")
endif()

function(create_target_pt LIST_DIR)
    set(CMAKE_INSTALL_LIBDIR "lib" )
    set(CMAKE_INSTALL_BINDIR "${CMAKE_SOURCE_DIR}/_binaries" )
    set(CMAKE_SHARED_LIBRARY_PREFIX "")

    set(PRESENTATION_TOOL_TARGET_NAME "${PROJECT_NAME}.PresentationTool")

    message(STATUS "${PROJECT_NAME}.PT: CMAKE_CURRENT_LIST_DIR: ${LIST_DIR}")

    file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/presentation_tool/qml
         DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

    include_directories( ${LIST_DIR}/src)

    set(sources "")
    file(
            GLOB_RECURSE

            sources

            "${LIST_DIR}/*.h"
            "${LIST_DIR}/*.hpp"
            "${LIST_DIR}/*.cpp"
            "${LIST_DIR}/*.qml"
    )

    message(STATUS "[presentation_tool] target name: ${PRESENTATION_TOOL_TARGET_NAME}")

    find_package(Qt5Widgets REQUIRED)
    find_package(Qt5Core REQUIRED)
    find_package(Qt5Quick REQUIRED)

    set(CMAKE_AUTOMOC ON)
    set(CMAKE_AUTOUIC ON)
    set(CMAKE_AUTORCC ON)

    if(WIN32)
        add_link_options(-Wl,-subsystem=windows)
    endif()

    add_executable( ${PRESENTATION_TOOL_TARGET_NAME} ${sources} )

    set(pt_libraries "${ENGINE_TARGET_NAME}")
    message(STATUS "[presentation_tool] project dependencies: ${pt_libraries}")

    target_link_libraries(${PRESENTATION_TOOL_TARGET_NAME} ${static_libraries})
    target_link_libraries(${PRESENTATION_TOOL_TARGET_NAME} ${dynamic_libraries})
    target_link_libraries(${PRESENTATION_TOOL_TARGET_NAME} ${pt_libraries})
    target_link_libraries(${PRESENTATION_TOOL_TARGET_NAME} Qt5::Widgets)
    target_link_libraries(${PRESENTATION_TOOL_TARGET_NAME} Qt5::Core)
    target_link_libraries(${PRESENTATION_TOOL_TARGET_NAME} Qt5::Quick)

    set_target_properties(${PRESENTATION_TOOL_TARGET_NAME} PROPERTIES DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX})
    install( TARGETS ${PRESENTATION_TOOL_TARGET_NAME} DESTINATION "${CMAKE_INSTALL_BINDIR}/presentation_tool" )

endfunction()
