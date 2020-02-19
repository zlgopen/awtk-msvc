
set(GTEST_ROOT ${TK_ROOT}/3rd/gtest/googletest)
set(TESTS_DIR ${TK_ROOT}/tests)
file(GLOB SRC
    ${GTEST_ROOT}/src/gtest-all.cc
    ${TESTS_DIR}/*.cc
    ${TESTS_DIR}/*.c
)
set(INCLUDE_PATH 
    ${TK_ROOT}
    ${GTEST_ROOT}
    ${TK_ROOT}/src
    ${TK_ROOT}/3rd/SDL/src
    ${TK_ROOT}/3rd/SDL/include
    ${TK_ROOT}/src/ext_widgets
    ${TK_ROOT}/3rd/libunibreak
    ${GTEST_ROOT}/src
    ${GTEST_ROOT}/include
    ${GTEST_ROOT}/make
)

add_executable(runTest ${SRC})
add_executable(mem_test ${TESTS_DIR}/mem_test.cpp)
add_executable(recycle_test ${TESTS_DIR}/recycle_test.cpp)


set(BINS runTest mem_test recycle_test)

foreach(bin ${BINS})
    set_target_properties(${bin} PROPERTIES FOLDER "tests")
    #链接属性
    set_target_properties(${bin} PROPERTIES LINK_FLAGS ${OS_LINKFLAGS} LINK_FLAGS ${OS_SUBSYSTEM_CONSOLE})
    #引用目录
    target_include_directories(${bin} PRIVATE ${INCLUDE_PATH})
    #链接库
    target_link_libraries(${bin} PRIVATE assets image_gen theme_gen font_gen str_gen common awtk)
endforeach()
