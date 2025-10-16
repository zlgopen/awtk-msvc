function(WIDGET_CONFIG WIDGET IDL)
    if (MINGW)
        set(DLL_LINKFLAGS "${IDL}/${WIDGET}.def")
    else()
        set(DLL_LINKFLAGS "/DEF:${IDL}/${WIDGET}.def")
    endif()
    # 链接属性
    target_link_options(${WIDGET} PRIVATE ${DLL_LINKFLAGS})
    set_target_properties(${WIDGET} PROPERTIES LINK_FLAGS ${OS_SUBSYSTEM_WINDOWS})
    # 引用目录
    target_include_directories(${WIDGET} PRIVATE ${CPPPATH})
    # 引用库
    target_link_libraries(${WIDGET} PRIVATE awtk)
endfunction()


set(WIDGET_NAME "Widget" CACHE STRING "")
set(WIDGET_PRJ_PATH "/path/to/app/project" CACHE STRING "")
set(WIDGET_SRC_PATH ${WIDGET_PRJ_PATH}/Logic/src)
set(BIN_PATH ${WIDGET_PRJ_PATH}/build/bin)
set(IDL_PATH ${WIDGET_PRJ_PATH}/build/idl_def)


# 输出目录
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${BIN_PATH})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${BIN_PATH})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${BIN_PATH})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${BIN_PATH})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${BIN_PATH})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${BIN_PATH})


add_library(${WIDGET_NAME} SHARED "")
file(GLOB_RECURSE SRC_FILES "${WIDGET_SRC_PATH}/*.cpp" "${WIDGET_SRC_PATH}/*.c")
target_sources(${WIDGET_NAME} PRIVATE ${SRC_FILES})
set_target_properties(${WIDGET_NAME} PROPERTIES FOLDER "widgets")
set_target_properties(${WIDGET_NAME} PROPERTIES PREFIX "")
WIDGET_CONFIG(${WIDGET_NAME} ${IDL_PATH})

execute_process(COMMAND node ${TK_ROOT}/tools/idl_gen/index.js ${IDL_PATH}/${WIDGET_NAME}.json ${WIDGET_SRC_PATH} ${TK_ROOT}/tools/idl_gen/idl.json)
execute_process(COMMAND node ${TK_ROOT}/tools/dll_def_gen/index.js ${IDL_PATH}/${WIDGET_NAME}.json ${IDL_PATH}/${WIDGET_NAME}.def false)
