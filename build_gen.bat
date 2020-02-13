
@rem 设置渲染模式
@set NANOVG_TYPE=GLES2
@rem set NANOVG_TYPE=GLES3
@rem set NANOVG_TYPE=AGGE
@rem set NANOVG_TYPE=AGG

@rem 设置启用谷歌拼音
@set PINYIN_ENABLE=ON

@rem 设置VS生成器
@set VS_GENERATOR="Visual Studio 14 Win64"

@if exist build ( rmdir /q /s build )
@mkdir build
cmake -DNANOVG_BACKEND=%NANOVG_TYPE% -DGPINYIN_ENABLE=%PINYIN_ENABLE% -G %VS_GENERATOR% -S cmake -B build
