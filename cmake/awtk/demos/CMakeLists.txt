# 输出目录
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${TK_BIN_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${TK_BIN_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${TK_LIB_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${TK_LIB_DIR})

function(PRJ_CONFIG PRJ)
    #链接属性
    set_target_properties(${PRJ} PROPERTIES LINK_FLAGS ${OS_LINKFLAGS} LINK_FLAGS ${OS_SUBSYSTEM_WINDOWS})
    # 引用目录
    target_include_directories(${PRJ} PRIVATE ${CPPPATH})
    #库目录
    target_link_directories(${PRJ} PRIVATE ${TK_LIB_DIR})
    # 引用库
    target_link_libraries(${PRJ} PRIVATE assets awtk)

    add_definitions(${OS_FLAGS} ${COMMON_CCFLAGS})
    
endfunction()

set(DEMOPATH ${TK_ROOT}/demos)

#assets
add_library(assets STATIC ${DEMOPATH}/assets.c)
set_target_properties(assets PROPERTIES FOLDER "lib")
target_include_directories(assets PRIVATE ${CPPPATH})

#DemoUI
set(PRJ DemoUI)
add_executable(${PRJ} "")
target_sources(${PRJ} PRIVATE ${DEMOPATH}/demo_main.c ${DEMOPATH}/demo_ui_app.c)
set_target_properties(${PRJ} PROPERTIES FOLDER "demos")
PRJ_CONFIG(${PRJ})

#Demo1
set(PRJ Demo1)
add_executable(${PRJ} "")
target_sources(${PRJ} PRIVATE ${DEMOPATH}/demo_main.c ${DEMOPATH}/demo1_app.c)
set_target_properties(${PRJ} PROPERTIES FOLDER "demos")
PRJ_CONFIG(${PRJ})

#DemoVg
set(PRJ DemoVG)
add_executable(${PRJ} "")
target_sources(${PRJ} PRIVATE ${DEMOPATH}/demo_main.c ${DEMOPATH}/demo_vg_app.c)
set_target_properties(${PRJ} PROPERTIES FOLDER "demos")
PRJ_CONFIG(${PRJ})

#DemoTR
set(PRJ DemoTR)
add_executable(${PRJ} "")
target_sources(${PRJ} PRIVATE ${DEMOPATH}/demo_main.c ${DEMOPATH}/demo_tr_app.c)
set_target_properties(${PRJ} PROPERTIES FOLDER "demos")
PRJ_CONFIG(${PRJ})

#DemoAnimator
set(PRJ DemoAnimator)
add_executable(${PRJ} "")
target_sources(${PRJ} PRIVATE ${DEMOPATH}/demo_main.c ${DEMOPATH}/demo_animator_app.c)
set_target_properties(${PRJ} PROPERTIES FOLDER "demos")
PRJ_CONFIG(${PRJ})

#DemoThread
set(PRJ DemoThread)
add_executable(${PRJ} "")
target_sources(${PRJ} PRIVATE ${DEMOPATH}/demo_main.c ${DEMOPATH}/demo_thread_app.c)
set_target_properties(${PRJ} PROPERTIES FOLDER "demos")
PRJ_CONFIG(${PRJ})

#DemoBasic
set(PRJ DemoBasic)
add_executable(${PRJ} "")
target_sources(${PRJ} PRIVATE ${DEMOPATH}/demo_main.c ${DEMOPATH}/demo_basic.c)
set_target_properties(${PRJ} PROPERTIES FOLDER "demos")
PRJ_CONFIG(${PRJ})

#PreviewUI
set(PRJ PreviewUI)
add_executable(${PRJ} "")
target_sources(${PRJ} PRIVATE ${DEMOPATH}/preview_ui.c)
set_target_properties(${PRJ} PROPERTIES FOLDER "demos")
PRJ_CONFIG(${PRJ})


#DemoDesktop
set(PRJ DemoDesktop)
add_executable(${PRJ} "")
target_sources(${PRJ} PRIVATE ${DEMOPATH}/demo_desktop.c)
set_target_properties(${PRJ} PROPERTIES FOLDER "demos")
PRJ_CONFIG(${PRJ})


#DemoFile
set(PRJ DemoFileBrowser)
add_executable(${PRJ} "")
target_sources(${PRJ} PRIVATE ${DEMOPATH}/demo_main.c ${DEMOPATH}/demo_file_browser.c)
set_target_properties(${PRJ} PROPERTIES FOLDER "demos")
PRJ_CONFIG(${PRJ})







