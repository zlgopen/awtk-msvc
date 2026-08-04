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

@rem 设置双向排版实现：Unicode bidi implementation: sheenbidi (default) or fribidi
@REM @set BIDI_TYPE=sheenbidi
set BIDI_TYPE=fribidi

@rem 应用工程配置
@set PRJ_ENABLE=OFF
@set PRJ_NAME=Application
@set PRJ_LCDW=800
@set PRJ_LCDH=480
@set PRJ_TYPE=2
@set PRJ_PATH="C:\Users\UserName\Documents\AWStudioSolutions\AwtkApplication0"

@rem 控件工程配置
@set WIDGET_ENABLE=OFF
@set WIDGET_NAME=Widget
@set WIDGET_PRJ_PATH="C:\Users\UserName\Documents\AWStudioSolutions\AwtkCustomWidget0"

@rem 设置VS生成器
@set VS_GENERATOR="Visual Studio 14 Win64"

cmake -DPRJ_ENABLE=%PRJ_ENABLE% -DPRJ_NAME=%PRJ_NAME% -DPRJ_LCDW=%PRJ_LCDW% -DPRJ_LCDH=%PRJ_LCDH% -DPRJ_TYPE=%PRJ_TYPE% -DPRJ_PATH=%PRJ_PATH% -DWIDGET_ENABLE=%WIDGET_ENABLE% -DWIDGET_NAME=%WIDGET_NAME% -DWIDGET_PRJ_PATH=%WIDGET_PRJ_PATH% -DNANOVG_BACKEND=%NANOVG_TYPE% -DGPINYIN_ENABLE=%PINYIN_ENABLE% -DDISABLE_WARNING=%DISABLE_WARNING% -DBIDI_BACKEND=%BIDI_TYPE% -G %VS_GENERATOR% ../cmake
pause