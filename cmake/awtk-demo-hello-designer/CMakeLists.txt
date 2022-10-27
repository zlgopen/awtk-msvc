#设置示例程序目录
set(DEMOPATH ${TK_EXAMPLE_DIR})

# 设置输出目录
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${DEMOPATH}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${DEMOPATH}/bin)

# 添加程序代码
set(PRJ awtk-demo-hello-designer)
set(SRC ${DEMOPATH}/src)
file(GLOB SOURCE_FILES 
    ${SRC}/*.c
    ${SRC}/common/*.c
    ${SRC}/pages/*.c
)

add_executable(${PRJ} ${SOURCE_FILES})
set_target_properties(${PRJ} PROPERTIES FOLDER "projects")
set_target_properties(${PRJ} PROPERTIES LINK_FLAGS ${OS_SUBSYSTEM_WINDOWS})

# 设置窗口大小
target_compile_definitions(${PRJ} PRIVATE -DLCD_WIDTH=800 -DLCD_HEIGHT=480)

# 设置语言环境
target_compile_definitions(${PRJ} PRIVATE -DAPP_DEFAULT_LANGUAGE="zh" -DAPP_DEFAULT_COUNTRY="CN")

# 引用目录
target_include_directories(${PRJ} PRIVATE ${CPPPATH})

# 引用库
target_link_libraries(${PRJ} PRIVATE awtk)
