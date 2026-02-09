@echo off
REM GPT-SoVITS Windows 11 快速启动脚本
REM 此脚本自动激活虚拟环境并启动WebUI

color 0A
cls

echo.
echo ============================================================
echo.
echo         GPT-SoVITS Windows 11 部署包
echo.
echo ============================================================
echo.

REM 检查虚拟环境是否存在
if not exist ".venv" (
    echo ❌ 错误: 虚拟环境不存在
    echo.
    echo 请先运行以下命令创建虚拟环境:
    echo   uv venv --python 3.11
    echo.
    pause
    exit /b 1
)

REM 激活虚拟环境
call .venv\Scripts\activate.bat

if errorlevel 1 (
    echo ❌ 虚拟环境激活失败
    pause
    exit /b 1
)

echo ✅ 虚拟环境已激活
echo.
echo 正在启动Web UI...
echo.
echo 访问地址: http://localhost:7860
echo.
echo 按 Ctrl+C 停止服务器
echo.
echo ============================================================
echo.

REM 启动WebUI
python webui.py

if errorlevel 1 (
    echo.
    echo ❌ WebUI 启动失败
    echo.
    echo 如有问题，请查看错误信息或参考 DEPLOYMENT_REPORT.md
    echo.
    pause
)

pause
