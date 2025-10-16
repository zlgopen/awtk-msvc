# 最新动态

2025/10/16
  * 加入编译widget dll工程的支持
  * 按AWStudio-2.x的build文件组织结构生成app和widget的编译产物

2025/10/11
  * 修改脚本支持生成"MinGW Makefiles"工程，可以通过mingw32-make执行构建
  * 修改脚本让awtk工程生成dll动态库，删除原来的静态库方式
  * 生成工程前自动执行node命令生成awtk的idl和awtk.def文件
  * 生成应用工程后，自动把依赖的awtk.dll拷贝的应用exe所在目录

2025/9/27
  * 修改脚本支持生成AWStudio-2.x创建的应用工程，可以配置PRJ_XXX宏修改工程路径和属性
