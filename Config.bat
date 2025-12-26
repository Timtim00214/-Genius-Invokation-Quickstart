@echo off
chcp 65001 >nul
setlocal

echo "=========================================="
echo "[Info] 启动初始化 (Force Init)..."
echo "=========================================="

:: 1. 删除旧 .git
if exist .git (
    echo "[Step 1/5] 清理旧配置..."
    attrib -h .git
    rd /s /q .git
)

:: 2. 初始化
echo "[Step 2/5] 初始化仓库..."
git init
:: 解决换行符警告
git config core.autocrlf true
:: 锁定分支名
git branch -M main

:: 3. 关联远程 (确认地址无误)
echo "[Step 3/5] 关联远程..."
git remote add origin https://github.com/Timtim00214/-Genius-Invokation-Quickstart.git
git remote add gitee https://gitee.com/Tim7im/genius-invokation-quickstart.git

:: 4. 提交本地代码
echo "[Step 4/5] 封装本地代码..."
git add .
git commit -m "Force Init: Reset Project" >nul 2>&1

:: 5. 暴力推送
echo "[Step 5/5] 强制覆盖远程仓库 (All in)..."

echo "------------------------------------------"
echo "正在覆盖 GitHub..."
:: -f 表示强制，-u 表示记录默认分支
git push -u -f origin main

echo "------------------------------------------"
echo "正在覆盖 Gitee..."
git push -u -f gitee main

echo.
echo "=========================================="
echo "[Success] 暴力初始化完成！"
echo "现在的远程仓库已完全符合本地。"
echo "=========================================="
pause