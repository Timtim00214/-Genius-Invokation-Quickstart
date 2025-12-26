@echo off

echo =============================================
echo  PostgreSQL Docker Container Manager
echo =============================================
echo.

:menu
cls
echo =============================================
echo  PostgreSQL Docker Container Manager
echo =============================================
echo.
echo [1] 启动容器
echo [2] 停止容器
echo [3] 查看状态
echo [4] 查看日志
echo [5] 进入 PostgreSQL 命令行
echo [6] 重启容器
echo [7] 备份数据库
echo [8] 退出
echo.
set /p choice="请选择操作 (1-8): "

if "%choice%"=="1" goto start
if "%choice%"=="2" goto stop
if "%choice%"=="3" goto status
if "%choice%"=="4" goto logs
if "%choice%"=="5" goto psql
if "%choice%"=="6" goto restart
if "%choice%"=="7" goto backup
if "%choice%"=="8" goto exit
goto menu

:start
echo 正在启动 PostgreSQL 容器...
docker start gcg-postgres
if errorlevel 1 (
    echo 启动失败！
) else (
    echo 启动成功！
)
timeout /t 2 /nobreak > nul
goto status

:stop
echo 正在停止 PostgreSQL 容器...
docker stop gcg-postgres
if errorlevel 1 (
    echo 停止失败！容器可能未运行。
) else (
    echo 停止成功！
)
timeout /t 1 /nobreak > nul
goto status

:status
echo.
echo 容器状态:
docker ps --filter "name=gcg-postgres"
echo.
echo 按任意键返回菜单...
pause >nul
goto menu

:logs
cls
echo 最近日志 (最后20行):
echo ====================================
docker logs --tail 20 gcg-postgres
echo ====================================
echo.
echo 按任意键返回菜单...
pause >nul
goto menu

:psql
echo 进入 PostgreSQL 命令行...
echo 提示：输入 \q 退出PSQL返回菜单
timeout /t 2 /nobreak > nul
docker exec -it gcg-postgres psql -U postgres
goto menu

:restart
echo 重启容器...
docker restart gcg-postgres
if errorlevel 1 (
    echo 重启失败！
) else (
    echo 重启成功！
)
timeout /t 2 /nobreak > nul
goto status

:backup
set backup_name=
set /p backup_name="输入备份文件名 (默认: backup_%date:/=-%): "
if "%backup_name%"=="" set backup_name=backup_%date:/=-%
echo 正在备份到 %backup_name%.sql...
docker exec gcg-postgres pg_dumpall -U postgres > "%backup_name%.sql"
if errorlevel 1 (
    echo 备份失败！
) else (
    echo 备份完成: %backup_name%.sql
    dir "%backup_name%.sql"
)
echo.
echo 按任意键返回菜单...
pause >nul
goto menu

:exit
echo 退出管理程序...
timeout /t 1 /nobreak > nul
exit