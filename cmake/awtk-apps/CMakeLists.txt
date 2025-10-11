function(PRJ_CONFIG PRJ LCDW LCDH TYPE BIN)
    target_compile_definitions(${PRJ} PRIVATE LCD_WIDTH=${LCDW} LCD_HEIGHT=${LCDH} APP_TYPE=${TYPE})
    # 链接属性
    set_target_properties(${PRJ} PROPERTIES LINK_FLAGS ${OS_SUBSYSTEM_WINDOWS})
    # 引用目录
    target_include_directories(${PRJ} PRIVATE ${CPPPATH})
    # 引用库
    target_link_libraries(${PRJ} PRIVATE awtk)
    # 自动拷贝依赖的dll
    add_custom_command(TARGET ${PRJ} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:awtk> ${BIN})
endfunction()


set(PRJ_NAME "Application" CACHE STRING "")
set(PRJ_LCDW 800 CACHE STRING "")
set(PRJ_LCDH 480 CACHE STRING "")
set(PRJ_TYPE 2 CACHE STRING "0-APP_MOBILE, 1-APP_SIMULATOR, 2-APP_DESKTOP")
set(PRJ_PATH "/path/to/app/project" CACHE STRING "")
set(APP_PATH ${PRJ_PATH}/Logic)
set(BIN_PATH ${PRJ_PATH}/build)


# 输出目录
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${BIN_PATH})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${BIN_PATH})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${TK_LIB_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${TK_LIB_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${BIN_PATH})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${TK_LIB_DIR})


add_executable(${PRJ_NAME} "")
file(GLOB_RECURSE SRC_FILES "${APP_PATH}/*.cpp" "${APP_PATH}/*.c")
target_sources(${PRJ_NAME} PRIVATE ${SRC_FILES})
set_target_properties(${PRJ_NAME} PROPERTIES FOLDER "apps")
PRJ_CONFIG(${PRJ_NAME} ${PRJ_LCDW} ${PRJ_LCDH} ${PRJ_TYPE} ${BIN_PATH})
