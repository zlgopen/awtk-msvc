@if exist build ( rmdir /q /s build )
@mkdir build
@cd build

@rem 设置渲染模式
@set NANOVG_TYPE=AGGE
@rem set NANOVG_TYPE=GLES2

@rem 设置启用谷歌拼音
@set PINYIN_ENABLE=ON

@rem 禁用部分警告
@set DISABLE_WARNING=ON

@rem 设置VS生成器
@set VS_GENERATOR="Visual Studio 14 Win64"

cmake -DNANOVG_BACKEND=%NANOVG_TYPE% -DGPINYIN_ENABLE=%PINYIN_ENABLE% -DDISABLE_WARNING=%DISABLE_WARNING% -G %VS_GENERATOR% ../cmake
pause