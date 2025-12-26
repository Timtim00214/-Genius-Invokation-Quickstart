@echo off
:: 防止乱码
chcp 65001 >nul

echo [Info] 开始同步任务...

:: 1. 添加所有文件
git add .

:: 2. 输入备注信息 (你的核心需求)
set "msg="
set /p msg="请输入提交备注 (直接回车默认 update): "
if "%msg%"=="" set "msg=update"

:: 3. 提交
git commit -m "%msg%"

:: 4. 推送到 GitHub (origin)
echo.
echo [1/2] 正在推送到 GitHub...
git push origin main

:: 5. 推送到 Gitee (gitee)
echo.
echo [2/2] 正在推送到 Gitee...
git push gitee main

echo.
echo [Success] 全部完成。
pause