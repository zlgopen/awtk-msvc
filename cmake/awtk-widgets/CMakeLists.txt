function(WIDGET_CONFIG WIDGET BIN)
    if (MINGW)
        set(DLL_LINKFLAGS "${BIN}/dll.def")
    else()
        set(DLL_LINKFLAGS "/DEF:${BIN}/dll.def")
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
set(BIN_PATH ${WIDGET_PRJ_PATH}/build)


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
WIDGET_CONFIG(${WIDGET_NAME} ${BIN_PATH})

execute_process(COMMAND node ${TK_ROOT}/tools/idl_gen/index.js ${BIN_PATH}/idl.json ${WIDGET_SRC_PATH} ${TK_ROOT}/tools/idl_gen/idl.json)
execute_process(COMMAND node ${TK_ROOT}/tools/dll_def_gen/index.js ${BIN_PATH}/idl.json ${BIN_PATH}/dll.def false)
