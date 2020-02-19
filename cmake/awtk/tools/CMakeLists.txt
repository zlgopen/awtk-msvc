#编译awtk工具
#common库
add_library(common ${TK_ROOT}/tools/common/utils.c)
set_target_properties(common PROPERTIES FOLDER "lib")
target_include_directories(common PRIVATE ${CPPPATH})

#指定包含目录、配置选项、链接库等
function(tools_prop_config libname binname)
    set_target_properties(${libname} PROPERTIES FOLDER "lib")
    target_include_directories(${libname} PRIVATE ${CPPPATH})
    set_target_properties(${binname} PROPERTIES FOLDER "tools")
    target_link_libraries(
        ${binname} PRIVATE
        ${libname}
        common
        awtk
    )
    target_include_directories(${binname} PRIVATE ${CPPPATH})
    set_target_properties(${binname} PROPERTIES
        LINK_FLAGS ${OS_LINKFLAGS} 
        LINK_FLAGS ${OS_SUBSYSTEM_CONSOLE}
    ) 
endfunction(tools_prop_config)

#theme_gen
add_library(theme_gen
    ${TK_ROOT}/tools/theme_gen/theme_gen.cc
    ${TK_ROOT}/tools/theme_gen/xml_theme_gen.cc
)
add_executable(themegen ${TK_ROOT}/tools/theme_gen/main.cc)
tools_prop_config(theme_gen themegen)

#font_gen
add_library(font_gen ${TK_ROOT}/tools/font_gen/font_gen.c)
add_executable(fontgen ${TK_ROOT}/tools/font_gen/main.c)
add_executable(genascii ${TK_ROOT}/tools/font_gen/gen_ascii.c)
tools_prop_config(font_gen fontgen)
tools_prop_config(font_gen genascii)

#image_gen
add_library(image_gen ${TK_ROOT}/tools/image_gen/image_gen.c)
add_executable(imagegen ${TK_ROOT}/tools/image_gen/main.c)
tools_prop_config(image_gen imagegen)

#str_gen
add_library(str_gen
    ${TK_ROOT}/tools/str_gen/xml_str_gen.cc
    ${TK_ROOT}/tools/str_gen/str_gen.cc
 )
add_executable(strgen ${TK_ROOT}/tools/str_gen/main.cc)
tools_prop_config(str_gen strgen)

#image_resize
add_executable(image_resize ${TK_ROOT}/tools/image_resize/resize.c)
add_executable(image_info ${TK_ROOT}/tools/image_resize/info.c)
add_executable(image_to_rgb565 ${TK_ROOT}/tools/image_resize/to_rgb565.c)

set(bin_list image_resize image_info image_to_rgb565)
foreach(bin ${bin_list})
    if(CMAKE_SYSTEM_NAME MATCHES "Darwin")
        target_link_libraries(${bin} PRIVATE m)
    elseif(CMAKE_SYSTEM_NAME MATCHES "Linux")
        target_link_libraries(${bin} PRIVATE m)
    endif()
    set_target_properties(${bin} PROPERTIES FOLDER "tools")
    target_include_directories(${bin} PRIVATE ${CPPPATH})
    set_target_properties(${bin} PROPERTIES
        LINK_FLAGS ${OS_LINKFLAGS} 
        LINK_FLAGS ${OS_SUBSYSTEM_CONSOLE}
    )    
endforeach(bin)

#res_gen
function(res_bin_gen_config binname)
    set_target_properties(${binname} PROPERTIES FOLDER "tools")
    target_include_directories(${binname} PRIVATE ${CPPPATH})
    target_link_libraries(${binname} PRIVATE awtk common)
    set_target_properties(${binname} PROPERTIES
        LINK_FLAGS ${OS_LINKFLAGS}
        LINK_FLAGS ${OS_SUBSYSTEM_CONSOLE}
    )     
endfunction(res_bin_gen_config)

add_executable(resgen ${TK_ROOT}/tools/res_gen/main.c)
res_bin_gen_config(resgen)

#qt_to_xml
add_executable(qt_to_xml ${TK_ROOT}/tools/ui_gen/qt_to_xml/qt_to_xml.cc)
res_bin_gen_config(qt_to_xml)

#xml_to_ui
add_executable(xml_to_ui ${TK_ROOT}/tools/ui_gen/xml_to_ui/xml_to_ui.c)
res_bin_gen_config(xml_to_ui)

#svg_gen
function(svg_gen_config binname)
    set_target_properties(${binname} PROPERTIES FOLDER "tools")
    target_include_directories(${binname} PRIVATE ${CPPPATH})
    target_link_libraries(${binname} PRIVATE awtk theme_gen common)
    set_target_properties(${binname} PROPERTIES
        LINK_FLAGS ${OS_LINKFLAGS} 
        LINK_FLAGS ${OS_SUBSYSTEM_CONSOLE}
    )  
endfunction(svg_gen_config)

add_executable(bsvggen ${TK_ROOT}/tools/svg_gen/bsvg_gen.cc)
add_executable(bsvgdump ${TK_ROOT}/tools/svg_gen/bsvg_dump.cc)
svg_gen_config(bsvggen)
svg_gen_config(bsvgdump)