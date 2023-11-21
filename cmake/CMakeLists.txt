# cmake最低版本
cmake_minimum_required(VERSION 3.7)

# 启用IDE目录功能
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# 设置目录
set(TK_LIB_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../awtk/lib)
set(TK_BIN_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../awtk/bin)
set(TK_EXAMPLE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../awtk-demo-hello-designer)

# 输出目录
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${TK_LIB_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${TK_LIB_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${TK_BIN_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${TK_BIN_DIR})

# 项目名
project(awtk-msvc)
set(PROJ awtk)

# 设置awtk路径
set(TK_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/../../awtk)

if (CMAKE_CL_64)
    set(TARGET_ARCH x64)
else()
    set(TARGET_ARCH x86)
endif()

# 禁用部分警告
set(DISABLE_WARNING OFF CACHE BOOL "")
if (DISABLE_WARNING)
    set(DISABLE_WARNING_FLAGS "/wd4018 /wd4244 /wd4267")
endif(DISABLE_WARNING)

# 设置是否启用谷歌拼音
set(GPINYIN_ENABLE ON CACHE BOOL "")
if (GPINYIN_ENABLE)
    set(INPUT_ENGINE "pinyin")
else()
    set(INPUT_ENGINE "null")
endif(GPINYIN_ENABLE)

# 设置显示驱动
set(NATIVE_WINDOW "sdl")
set(VGCANVAS "NANOVG")
set(NANOVG_BACKEND "AGGE" CACHE STRING "")
set_property(CACHE NANOVG_BACKEND PROPERTY STRINGS "AGGE" "GLES2")

if (NANOVG_BACKEND STREQUAL "AGGE")
    set(LCD "SDL_FB")
    set(FRAME_BUFFER_FORMAT "bgr565")
    # set(FRAME_BUFFER_FORMAT "bgra8888")
else()
    set(LCD "SDL_GPU")
endif()
# set(LCD "SDL_FB_MONO")


### 构建编译参数

set(COMMON_CCFLAGS " -DTK_ROOT=\\\"${TK_ROOT}\\\" ")
#set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITHOUT_WINDOW_ANIMATOR_CACHE=1 ")
#set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DENABLE_PERFORMANCE_PROFILE=1 ")
#set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DNATIVE_WINDOW_BORDERLESS=1 ")
#set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DNATIVE_WINDOW_NOT_RESIZABLE=1 ")
#set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DENABLE_MEM_LEAK_CHECK=1 ")

set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_MBEDTLS=1 ")
set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DENABLE_CURSOR=1 ")
set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_TEXT_BIDI=1 ")
#set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DLOAD_ASSET_WITH_MMAP=1 ")
set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_DATA_READER_WRITER=1 ")
set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_EVENT_RECORDER_PLAYER=1 ")
set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_ASSET_LOADER -DWITH_FS_RES -DWITH_ASSET_LOADER_ZIP ")
set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DSTBTT_STATIC -DSTB_IMAGE_STATIC -DWITH_STB_IMAGE ")
set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_VGCANVAS -DWITH_UNICODE_BREAK -DWITH_DESKTOP_STYLE ")
set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_SDL -DHAS_STDIO -DHAVE_STDIO_H -DHAS_GET_TIME_US64 ")
set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DHAS_STD_MALLOC -DTK_MAX_MEM_BLOCK_NR=3 ")

if (INPUT_ENGINE STREQUAL "pinyin")
    set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_IME_PINYIN ")
else()
    set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_IME_NULL ")
endif()

if (LCD STREQUAL "SDL_GPU")
    set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_NANOVG_GPU -DWITH_VGCANVAS_LCD ")
    set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_STB_FONT ")
elseif (LCD STREQUAL "SDL_FB_MONO")
    set(NANOVG_BACKEND "AGGE")
    set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_LCD_MONO -DWITH_NANOVG_SOFT ")
    set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_STB_FONT ")
else()
    set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_STB_FONT ")
    set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_BITMAP_BGRA -DWITH_NANOVG_SOFT ")
    if (FRAME_BUFFER_FORMAT STREQUAL "bgra8888")
        set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_FB_BGRA8888=1 ")
    else()
        set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_FB_BGR565=1 ")
    endif()
endif()

if (NANOVG_BACKEND STREQUAL "AGGE")
    set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_NANOVG_AGGE ")
else()
    set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DWITH_NANOVG_GLES2 -DWITH_NANOVG_GL ")
endif()

if (CMAKE_SYSTEM_NAME MATCHES "Windows")
    set(OS_LIBS "gdi32" "user32" "winmm.lib" "imm32.lib" "version.lib" "shell32.lib" "ole32.lib" "Oleaut32.lib" "Advapi32.lib" "DelayImp.lib" "psapi.lib")
    set(OS_FLAGS " -DWIN32 -D_WIN32 -DWINDOWS /EHsc -D_CONSOLE /FS /Z7 ")
    set(OS_FLAGS "${OS_FLAGS} ${DISABLE_WARNING_FLAGS}")
    if (TARGET_ARCH STREQUAL "x86")
        set(OS_SUBSYSTEM_CONSOLE "/SUBSYSTEM:CONSOLE,5.01 ")
        set(OS_SUBSYSTEM_WINDOWS "/SUBSYSTEM:WINDOWS,5.01 ")
        set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -D_WIN32 ")
    else()
        set(OS_FLAGS " ${OS_FLAGS} -DWITH_64BIT_CPU ")
        set(OS_SUBSYSTEM_CONSOLE "/SUBSYSTEM:CONSOLE ")
        set(OS_SUBSYSTEM_WINDOWS "/SUBSYSTEM:WINDOWS ")
        set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -D_WIN64 ")
    endif()
    set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DHAVE_LIBC ")

    set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -DSDL_REAL_API -DSDL_HAPTIC_DISABLED -DSDL_SENSOR_DISABLED -DSDL_JOYSTICK_DISABLED ")
    set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -D__STDC_LIMIT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_CONSTANT_MACROS -D_HAS_EXCEPTIONS=0 -D_HAS_ITERATOR_DEBUGGING=0 -D_ITERATOR_DEBUG_LEVEL=0 -D_SCL_SECURE=0")
    set(COMMON_CCFLAGS " ${COMMON_CCFLAGS} -D_SECURE_SCL=0 -D_SCL_SECURE_NO_WARNINGS -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE -D_CRT_SECURE_NO_DEPRECATE ")
endif()


### 所有源文件

set(SOURCE_FILES "") 

# 添加nanovg源文件
set(NANOVG ${TK_ROOT}/3rd/nanovg)
aux_source_directory(${NANOVG}/base SRC)
set(SOURCE_FILES ${SOURCE_FILES} ${SRC})
if (NANOVG_BACKEND STREQUAL "AGGE")
    aux_source_directory(${NANOVG}/agge SRC)
    set(SOURCE_FILES ${SOURCE_FILES} ${SRC})
endif()

# 添加agge源文件
if (NANOVG_BACKEND STREQUAL "AGGE")
    set(AGGE_ROOT ${TK_ROOT}/3rd/agge)
    aux_source_directory(${AGGE_ROOT}/agge SRC)
    set(SOURCE_FILES ${SOURCE_FILES} ${SRC})
endif()

if (NANOVG_BACKEND STREQUAL AGGE)
    set(SOURCE_FILES ${SOURCE_FILES} ${TK_ROOT}/src/vgcanvas/vgcanvas_nanovg_soft.c)
else()
    set(SOURCE_FILES ${SOURCE_FILES} ${TK_ROOT}/src/vgcanvas/vgcanvas_nanovg_gl.c)
endif()

# 添加glad源文件
set(GLAD ${TK_ROOT}/3rd/glad)
aux_source_directory(${GLAD} SRC)
set(SOURCE_FILES ${SOURCE_FILES} ${SRC})

if (NATIVE_WINDOW STREQUAL "sdl")
    set(SOURCE_FILES ${SOURCE_FILES} ${TK_ROOT}/src/native_window/native_window_sdl.c)
elseif (NATIVE_WINDOW STREQUAL "fb_gl")
    set(SOURCE_FILES ${SOURCE_FILES} ${TK_ROOT}/src/native_window/native_window_fb_gl.c)
else()
    set(SOURCE_FILES ${SOURCE_FILES} ${TK_ROOT}/src/native_window/native_window_raw.c)
endif()

file(GLOB LCD_MEM_SRC ${TK_ROOT}/src/lcd/lcd_mem_*.c)
set(SOURCE_FILES ${SOURCE_FILES} ${LCD_MEM_SRC})

if (LCD STREQUAL "SDL_GPU")
    set(SOURCE_FILES ${SOURCE_FILES}        
        ${TK_ROOT}/src/lcd/lcd_nanovg.c
        ${TK_ROOT}/src/main_loop/main_loop_sdl.c
    )
elseif (LCD STREQUAL "SDL_FB")
    set(SOURCE_FILES ${SOURCE_FILES}        
        ${TK_ROOT}/src/lcd/lcd_sdl2.c
        ${TK_ROOT}/src/main_loop/main_loop_sdl.c
    )
elseif (LCD STREQUAL "SDL_FB_MONO")
    set(SOURCE_FILES ${SOURCE_FILES}        
        ${TK_ROOT}/src/lcd/lcd_sdl2_mono.c
        ${TK_ROOT}/src/main_loop/main_loop_sdl.c
    )
elseif (LCD STREQUAL "FB_GL")
    set(SOURCE_FILES ${SOURCE_FILES} ${TK_ROOT}/src/lcd/lcd_nanovg.c)
endif()

# 添加SDL代码
set(SDL ${TK_ROOT}/3rd/SDL)
file(GLOB SDL_SRC
    ${SDL}/src/atomic/*.c
    ${SDL}/src/audio/directsound/*.c
    ${SDL}/src/audio/disk/*.c
    ${SDL}/src/audio/dummy/*.c
    ${SDL}/src/audio/*.c
    ${SDL}/src/audio/winmm/*.c
    ${SDL}/src/audio/wasapi/*.c
    ${SDL}/src/core/windows/*.c
    ${SDL}/src/cpuinfo/*.c
    ${SDL}/src/events/*.c
    ${SDL}/src/file/*.c
    ${SDL}/src/filesystem/windows/*.c
    ${SDL}/src/libm/*.c
    ${SDL}/src/loadso/windows/*.c
    ${SDL}/src/power/*.c
    ${SDL}/src/power/windows/*.c
    ${SDL}/src/render/direct3d/*.c
    ${SDL}/src/render/direct3d11/*.c
    ${SDL}/src/render/opengl/*.c
    ${SDL}/src/render/opengles2/*.c
    ${SDL}/src/render/software/*.c
    ${SDL}/src/render/*.c
    ${SDL}/src/stdlib/*.c
    ${SDL}/src/thread/generic/SDL_syscond.c
    ${SDL}/src/thread/SDL_thread.c
    ${SDL}/src/thread/windows/*.c
    ${SDL}/src/timer/SDL_timer.c
    ${SDL}/src/timer/windows/*.c
    ${SDL}/src/video/dummy/*.c
    ${SDL}/src/video/windows/*.c
    ${SDL}/src/video/*.c
    ${SDL}/src/video/yuv2rgb/*.c
    ${SDL}/src/*.c
)
set(SOURCE_FILES ${SOURCE_FILES} ${SDL_SRC})

# 添加gpinyin源文件
set(GPINYIN ${TK_ROOT}/3rd/gpinyin)
aux_source_directory(${GPINYIN}/src SRC)
set(SOURCE_FILES ${SOURCE_FILES} ${SRC})
set(SOURCE_FILES ${SOURCE_FILES} ${TK_ROOT}/src/input_methods/input_method_creator.c)

if (INPUT_ENGINE STREQUAL "pinyin")
    set(SOURCE_FILES ${SOURCE_FILES} ${TK_ROOT}/src/input_engines/input_engine_pinyin.cpp)
else()
    set(SOURCE_FILES ${SOURCE_FILES} ${TK_ROOT}/src/input_engines/input_engine_null.c)
endif()

# 添加linebreak源文件
set(LIBUNIBREAK ${TK_ROOT}/3rd/libunibreak)
set(SOURCE_FILES ${SOURCE_FILES}        
    ${LIBUNIBREAK}/graphemebreak.c
    ${LIBUNIBREAK}/linebreak.c
    ${LIBUNIBREAK}/linebreakdef.c
    ${LIBUNIBREAK}/unibreakbase.c
    ${LIBUNIBREAK}/unibreakdef.c
    ${LIBUNIBREAK}/wordbreak.c
    ${LIBUNIBREAK}/emojidef.c
    ${LIBUNIBREAK}/linebreakdata.c
)

# 添加fribidi代码
set(FRIBIDI ${TK_ROOT}/3rd/fribidi)
file(GLOB FRIBIDI_SRC ${FRIBIDI}/*.c)
set(SOURCE_FILES ${SOURCE_FILES} ${FRIBIDI_SRC})

# 添加nativefiledialog源文件
set(NATIVEFILEDIALOG ${TK_ROOT}/3rd/nativefiledialog)
file(GLOB NATIVEFILEDIALOG_SRC
    ${NATIVEFILEDIALOG}/src/nfd_common.c
    ${NATIVEFILEDIALOG}/src/nfd_win.cpp
)
set(SOURCE_FILES ${SOURCE_FILES} ${NATIVEFILEDIALOG_SRC})

# 添加lz4源文件
set(LZ4 ${TK_ROOT}/3rd/lz4)
set(SOURCE_FILES ${SOURCE_FILES}        
    ${LZ4}/lz4.c
    ${LZ4}/lz4frame.c
    ${LZ4}/lz4hc.c
    ${LZ4}/xxhash.c
)

# 添加miniz源文件
set(MINIZ ${TK_ROOT}/3rd/miniz)
set(MINIZ_SRC       
    ${MINIZ}/miniz.c
    ${MINIZ}/miniz_tdef.c
    ${MINIZ}/miniz_tinfl.c
    ${MINIZ}/miniz_zip.c
)
set(SOURCE_FILES ${SOURCE_FILES} ${MINIZ_SRC})

# 添加compressors代码
set(COMPRESSORS ${TK_ROOT}/src/compressors)
file(GLOB COMPRESSORS_SRC ${COMPRESSORS}/*.c)
set(SOURCE_FILES ${SOURCE_FILES} ${COMPRESSORS_SRC})

# 添加csv代码
set(CSV ${TK_ROOT}/src/csv)
file(GLOB CSV_SRC ${CSV}/*.c)
set(SOURCE_FILES ${SOURCE_FILES} ${CSV_SRC})

# 添加ubjson代码
set(UBJSON ${TK_ROOT}/src/ubjson)
file(GLOB UBJSON_SRC ${UBJSON}/*.c)
set(SOURCE_FILES ${SOURCE_FILES} ${UBJSON_SRC})

# 添加cjson代码
set(CJSON ${TK_ROOT}/3rd/cjson)
file(GLOB CJSON_SRC ${CJSON}/*.c)
set(SOURCE_FILES ${SOURCE_FILES} ${CJSON_SRC})

# 添加conf_io代码
set(CONF_IO ${TK_ROOT}/src/conf_io)
file(GLOB CONF_IO_SRC ${CONF_IO}/*.c)
set(SOURCE_FILES ${SOURCE_FILES} ${CONF_IO_SRC})

# 添加hal代码
set(HAL ${TK_ROOT}/src/hal)
file(GLOB HAL_SRC 
    ${HAL}/*.c
    ${HAL}/windows/*.c
)
set(SOURCE_FILES ${SOURCE_FILES} ${HAL_SRC})

# 添加mbedtls代码
set(MBEDTLS ${TK_ROOT}/3rd/mbedtls)
file(GLOB MBEDTLS_SRC 
    ${MBEDTLS}/library/*.c
    ${MBEDTLS}/3rdparty/everest/library/everest.c
    ${MBEDTLS}/3rdparty/everest/library/x25519.c
    ${MBEDTLS}3rdparty/everest/library/Hacl_Curve25519_joined.c
)
set(SOURCE_FILES ${SOURCE_FILES} ${MBEDTLS_SRC})

# 添加streams代码
set(STREAMS ${TK_ROOT}/src/streams)
file(GLOB STREAMS_SRC 
    ${STREAMS}/buffered/*.c
    ${STREAMS}/file/*.c
    ${STREAMS}/inet/*.c
    ${STREAMS}/mem/*.c
    ${STREAMS}/serial/*.c
    ${STREAMS}/shdlc/*.c
    ${STREAMS}/noisy/*.c
    ${STREAMS}/misc/*.c
    ${STREAMS}/statistics/*.c
    ${STREAMS}/*.c
)
set(SOURCE_FILES ${SOURCE_FILES} ${STREAMS_SRC})

# 添加service代码
set(SERVICE ${TK_ROOT}/src/service)
file(GLOB SERVICE_SRC 
    ${SERVICE}/*.c
)
set(SOURCE_FILES ${SOURCE_FILES} ${SERVICE_SRC})

# 添加remote_ui代码
set(REMOTE_UI ${TK_ROOT}/src/remote_ui)
file(GLOB REMOTE_UI_SRC 
    ${REMOTE_UI}/client/*.c
    ${REMOTE_UI}/service/*.c
)
set(SOURCE_FILES ${SOURCE_FILES} ${REMOTE_UI_SRC})

# 添加debugger代码
set(DEBUGGER ${TK_ROOT}/src/debugger)
file(GLOB DEBUGGER_SRC ${DEBUGGER}/*.c)
set(SOURCE_FILES ${SOURCE_FILES} ${DEBUGGER_SRC})

# 添加charset代码
set(CHARSET ${TK_ROOT}/src/charset)
file(GLOB CHARSET_SRC ${CHARSET}/*.c)
set(SOURCE_FILES ${SOURCE_FILES} ${CHARSET_SRC})

# 添加awtk内核代码
file(GLOB AWTK_SRC 
    ${TK_ROOT}/src/layouters/*.c
    ${TK_ROOT}/src/base/*.c
    ${TK_ROOT}/src/ui_loader/*.c
    ${TK_ROOT}/src/xml/*.c
    ${TK_ROOT}/src/svg/*.c
    ${TK_ROOT}/src/clip_board/*.c
    ${TK_ROOT}/src/font_loader/*.c
    ${TK_ROOT}/src/blend/*.c
    ${TK_ROOT}/src/image_loader/*.c
    ${TK_ROOT}/src/designer_support/*.c
    ${TK_ROOT}/src/widget_animators/*.c
    ${TK_ROOT}/src/misc/*.c
    ${TK_ROOT}/src/window_animators/*.c
    ${TK_ROOT}/src/dialog_highlighters/*.c
    ${TK_ROOT}/src/window_manager/window_manager_default.c
    ${TK_ROOT}/src/graphic_buffer/graphic_buffer_default.c
)
set(SOURCE_FILES ${SOURCE_FILES} ${AWTK_SRC})

file(GLOB SRC_SRC 
    ${TK_ROOT}/src/awtk_global.c
    ${TK_ROOT}/src/widgets/*.c
    ${TK_ROOT}/src/tkc/*.c
    ${TK_ROOT}/src/fscript_ext/*.c
    ${TK_ROOT}/src/platforms/pc/*.c
    ${TK_ROOT}/src/ext_widgets/*.c
    ${TK_ROOT}/src/ext_widgets/*/*.c
)
set(SOURCE_FILES ${SOURCE_FILES} ${SRC_SRC})

set(SOURCE_FILES ${SOURCE_FILES}        
    ${TK_ROOT}/src/lcd/lcd_mono.c
    ${TK_ROOT}/src/main_loop/main_loop_simple.c
)

add_library(${PROJ} STATIC ${SOURCE_FILES})
set_target_properties(${PROJ} PROPERTIES FOLDER "lib")
target_link_libraries(${PROJ} ${OS_LIBS})
set_target_properties(${PROJ} PROPERTIES STATIC_LABRARY_FLAGS  ${OS_SUBSYSTEM_CONSOLE})
add_definitions(${OS_FLAGS} ${COMMON_CCFLAGS})

# 添加包含路径
set(CPPPATH 
    ${TK_ROOT}/src
    ${TK_ROOT}/3rd 
    ${TK_ROOT}/src/ext_widgets 
    ${TK_ROOT}/3rd/pixman 
    ${TK_ROOT}/3rd/agge 
    ${TK_ROOT}/3rd/cjson
    ${TK_ROOT}/3rd/fribidi
    ${TK_ROOT}/3rd/mbedtls/include
    ${TK_ROOT}/3rd/mbedtls/3rdparty/everest/include
    ${TK_ROOT}/3rd/nanovg 
    ${TK_ROOT}/3rd/nanovg/gl 
    ${TK_ROOT}/3rd/nanovg/base 
    ${TK_ROOT}/3rd/nanovg/agge 
    ${TK_ROOT}/3rd/SDL/src 
    ${TK_ROOT}/3rd/SDL/include
    ${TK_ROOT}/3rd/SDL/src/video/khronos
    ${TK_ROOT}/3rd/agge/src 
    ${TK_ROOT}/3rd/agge/include 
    ${TK_ROOT}/3rd/gpinyin/include 
    ${TK_ROOT}/3rd/libunibreak 
    ${TK_ROOT}/3rd/nativefiledialog/src
    ${TK_ROOT}/3rd/nativefiledialog/src/include
    ${TK_ROOT}/3rd/gtest/googletest 
    ${TK_ROOT}/3rd/gtest/googletest/include 
    ${TK_ROOT}/tools
)
target_include_directories(${PROJ} PRIVATE ${CPPPATH})

# 编译demo
add_subdirectory(awtk/demos)
# 编译tools
add_subdirectory(awtk/tools)
# 编译tests
# add_subdirectory(awtk/tests)

# 编译awtk-demo-hello-designer
if (EXISTS ${TK_EXAMPLE_DIR})
add_subdirectory(awtk-demo-hello-designer)
else()
message("!! Missing project dir: ${TK_EXAMPLE_DIR}")
endif()
