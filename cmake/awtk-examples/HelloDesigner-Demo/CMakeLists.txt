#设置demo目录
set(DEMOPATH ${TK_EXAMPLE_DIR}/HelloDesigner-Demo)
# 输出目录
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${DEMOPATH}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${DEMOPATH}/bin)

set(PRJ HelloDesigner-Demo)
set(SRC ${DEMOPATH}/src)
file(GLOB SOURCE_FILES  ${SRC}/*.c)

add_executable(${PRJ} ${SOURCE_FILES})
set_target_properties(${PRJ} PROPERTIES FOLDER "examples")
set_target_properties(${PRJ} PROPERTIES  LINK_FLAGS ${OS_SUBSYSTEM_WINDOWS})

# 设置窗口大小
target_compile_definitions(${PRJ} PRIVATE -DLCD_WIDTH=800 -DLCD_HEIGHT=480)

# 引用目录
target_include_directories(${PRJ} PRIVATE ${CPPPATH})

# 引用库
target_link_libraries(${PRJ} PRIVATE awtk)
