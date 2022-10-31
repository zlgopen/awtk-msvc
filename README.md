# AWTK-MSVC

## 1 下载并安装 CMake 

### 1.1 下载 CMake

前往 [CMake 官网](https://cmake.org/download/) 下载最新版安装包。

### 1.2 安装 CMake

1. 双击运行安装包，一路点击 【next】；
2. 到如下图步骤时，选中【add CMake to the system PATH for all users】和【Create CMake Desktop Icon】；

![AddPath](./docs/images/AddPath.png)

3. 再一路点击【next】，并最后点击【install】，安装成功后，点击【Finish】。

## 2 环境配置

### 2.1 下载 awtk

直接使用 [AWStudio](https://awtk.zlg.cn/) 安装目录下的 `AWTK/SDK/awtk`，或则从 GitHub 仓库克隆 awtk，命令如下：

```bash
git clone https://github.com/zlgopen/awtk.git
```

### 2.2 下载 awtk-demo-hello-designer

在 [AWStudio](https://awtk.zlg.cn/) 中下载示例程序 HelloDesigner-Demo，或者前往 JihuLab 仓库下载 [awtk-demo-hello-designer](https://jihulab.com/awtk/awtk-demo-hello-designer)。

### 2.3 下载 awtk-msvc

从 GitHub 仓库克隆 awtk-msvc，命令如下

```bash
git clone https://github.com/zlgopen/awtk-msvc.git
```

**​确保 awtk-msvc 与 awtk 及 awtk-demo-hello-designer 在同一文件夹下。**

## 3 生成VS工程

### 3.1 修改 build_gen.bat 文件

#### 3.1.1 设置渲染模式

可根据需要自行修改：

```bat
@rem 设置渲染模式
@set NANOVG_TYPE=AGGE
@rem set NANOVG_TYPE=GLES2
```

> “rem”为批处理的注释符号，如需修改渲染模式，删去对应语句的“rem“即可。

#### 3.1.2 设置启用谷歌拼音

该项通常无需修改，默认即可：

```bat
@rem 设置启用谷歌拼音
@set PINYIN_ENABLE=ON
```

#### 3.1.3 禁用部分警告

```bat
@rem 禁用部分警告
@set DISABLE_WARNING=ON
```

工程默认禁用 C4244、C4267 及 C4018 警告，用户可自行开启警告。

#### 3.1.4 设置VS平台

可根据用户安装的VS版本（vs2015或以上），自行修改VS平台：

```bat
@rem 设置VS生成器
@set VS_GENERATOR="Visual Studio 14 Win64"
```

参数中的"Win64"表示生成 64 位工程，如需生成 32 位工程，修改参数为"Visual Studio 14"即可。

VS_PLATFORM 参数取值可参考下图：

![generator](./docs/images/generator.png)

> 在终端上运行 `cmake --help`，可得到上图输出结果。

### 3.2 执行 build_gen.bat 文件

双击 build_gen.bat 文件，将生成VS工程到build文件夹下。

## 4 打开VS工程

打开 build 文件夹，双击 awtk-msvc.sln 文件即可打开 VS 工程。

## 5 编译并运行VS工程中的项目

打开 VS 工程后，在"解决方案资源管理器"中右键点击"解决方案awtk-msvc"，选择右键菜单中的【生成解决方案】，可以编译 VS 工程中的项目，编译顺序如下：

1. 编译生成 awtk 的库文件、工具以及内置的示例程序，分别放在 awtk 的 lib、tools 以及 bin 目录中。
2. 编译生成 awtk-demo-hello-designer 项目的可执行文件，放在 awtk-demo-hello-designer 的 bin 目录中。

### 5.1 运行 awtk 的内置例程 demoui

双击运行 awtk/bin/demoui.exe。

### 5.2 运行 awtk-demo-hello-designer

在运行 awtk-demo-hello-designer 前，需要先打包项目资源，可以在 AWTK Designer 中打开该项目打包资源，也可以通过 scripts/update_res.py 脚本打包资源，步骤如下：

1. 下载并安装 [Python](https://python.org/downloads/)。
2. 在 awtk-demo-hello-designer 目录下打开终端，执行以下命令，打包资源：

```bash
python scripts/update_res.py all
```

打包好项目资源后，双击运行 awtk-demo-hello-designer/bin/demo.exe。
