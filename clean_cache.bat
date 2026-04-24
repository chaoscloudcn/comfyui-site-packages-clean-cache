@echo off
rem 切换编码格式，防止中文乱码
chcp 65001 >nul
setlocal

rem 获取当前路径并设置目标路径
set "BASE_DIR=%~dp0"
set "TARGET_DIR=%BASE_DIR%python\Lib\site-packages"

echo ====================================================
echo 正在准备清理: %TARGET_DIR%
echo ====================================================

if not exist "%TARGET_DIR%" (
    echo [错误] 找不到路径！请确认脚本放在 ComfyUI 根目录下。
    pause
    exit /b
)

echo 发现清理目标：pip 升级残留文件夹（如 ~~mpy, ~umpy, ~orch 等）
echo.
set /p confirm="确定要清理这些残留文件夹吗？(Y/N): "
if /i "%confirm%" neq "Y" exit /b

pushd "%TARGET_DIR%"

echo.
echo [1/2] 正在清理 pip 残留垃圾 (以 ~ 开头的文件夹)...
rem 遍历当前目录下所有以 ~ 开头的文件夹并删除
for /d %%i in (~*) do (
    echo 发现并删除垃圾文件夹: "%%i"
    rd /s /q "%%i"
)

echo.
echo [2/2] 正在清理 __pycache__ 缓存...
for /d /r %%i in (__pycache__) do (
    if exist "%%i" (
        rd /s /q "%%i"
    )
)

popd

echo.
echo ====================================================
echo 清理彻底完成！你的 site-packages 现在干净了。
echo ====================================================
pause