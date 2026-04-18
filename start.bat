@echo off
chcp 65001 >nul
title DoBao-TTS
echo.
echo ==========================================
echo    DoBao-TTS
echo ==========================================
echo.
echo Starting server...
echo.
echo Press Ctrl+C to stop
echo.

cd /d "%~dp0"

rem 设置环境变量，让程序使用打包的 FFmpeg
set FFMPEG_PATH=%~dp0runtime\ffmpeg.exe
set PATH=%~dp0runtime;%PATH%

runtime\node.exe app\src\server.js

if errorlevel 1 (
  echo.
  echo Failed to start server
  echo Press any key to exit...
  pause >nul
  exit /b 1
)