#设置demo目录
set(DEMOPATH ${TK_EXAMPLE_DIR}/Chart-Demo)
# 输出目录
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${DEMOPATH}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${DEMOPATH}/bin)

set(PRJ Chart-Demo)
set(SRC ${DEMOPATH}/src)
file(GLOB SOURCE_FILES 
    ${SRC}/*.c
    ${SRC}/base/*.c
    ${SRC}/custom_widgets/*.c
    ${SRC}/custom_widgets/*/*.c
)

add_executable(${PRJ} ${SOURCE_FILES})
set_target_properties(${PRJ} PROPERTIES FOLDER "examples")
set_target_properties(${PRJ} PROPERTIES  LINK_FLAGS ${OS_SUBSYSTEM_WINDOWS})

# 引用目录
target_include_directories(${PRJ} PRIVATE ${CPPPATH})

# 引用库
target_link_libraries(${PRJ} PRIVATE awtk)
