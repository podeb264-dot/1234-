@echo off
setlocal EnableExtensions
chcp 1251 >nul
title Лабораторная работа №1 — Меню (без переходов)

rem состояние
set "WORK_DIR="
set "WORK_FILE="

:MENU
cls
echo ================== М Е Н Ю ==================
echo Рабочий каталог: %WORK_DIR%
echo Рабочий файл:    %WORK_FILE%
echo ------------------------------------------------
echo 1) Создать каталог
echo 2) Создать текстовый файл
echo 3) Сделать файл скрытым
echo 4) Показать содержимое каталога
echo 5) Удалить каталог
echo 0) Выход
echo =================================================
choice /C 012345 /N /M "Выберите [0-5]: "
rem CHOICE: 1=0, 2=1, 3=2, 4=3, 5=4, 6=5

if %errorlevel%==1 goto END

rem === 1) Создать каталог ===
if %errorlevel%==2 (
  cls
  echo === Создание каталога ===
  set "WORK_DIR="
  set /p WORK_DIR=Введите имя каталога: 
  if "%WORK_DIR%"=="" (echo Имя пустое.& pause & goto MENU)
  if exist "%WORK_DIR%" (echo Такой каталог уже есть.& set "WORK_DIR=" & pause & goto MENU)
  md "%WORK_DIR%" && echo Создан: "%WORK_DIR%". || echo Ошибка создания.
  set "WORK_FILE="
  pause
  goto MENU
)

rem === 2) Создать текстовый файл (отдельная страница) ===
if %errorlevel%==3 (
  cls
  echo ==========================================
  echo        СОЗДАНИЕ ТЕКСТОВОГО ФАЙЛА
  echo ==========================================
  if "%WORK_DIR%"=="" (echo Сначала создайте каталог (п.1).& echo.& pause & goto MENU)
  if not exist "%WORK_DIR%" (echo Каталог "%WORK_DIR%" не найден.& set "WORK_DIR=" & echo.& pause & goto MENU)

  set "WORK_FILE="
  echo Текущий каталог: "%WORK_DIR%"
  echo.
  set /p WORK_FILE=Введите имя файла (без .txt): 
  if "%WORK_FILE%"=="" (echo.& echo Имя файла не может быть пустым.& pause & goto MENU)

  set "FULL_PATH=%WORK_DIR%\%WORK_FILE%.txt"
  if exist "%FULL_PATH%" (echo.& echo Такой файл уже существует: "%FULL_PATH%"& pause & goto MENU)

  cls
  echo ==========================================
  echo        СОЗДАНИЕ ТЕКСТОВОГО ФАЙЛА
  echo ==========================================
  echo Будет создан файл:
  echo    "%FULL_PATH%"
  echo.
  echo Нажмите любую клавишу, чтобы СОЗДАТЬ файл...
  pause >nul

  > "%FULL_PATH%" echo Лабораторная работа №1
  if exist "%FULL_PATH%" (echo.& echo [OK] Файл создан: "%FULL_PATH%") else (echo.& echo [ОШИБКА] Не удалось создать файл.)
  echo.
  pause
  goto MENU
)

rem === 3) Сделать файл скрытым ===
if %errorlevel%==4 (
  cls
  echo === Скрытие файла ===
  if "%WORK_DIR%"=="" (echo Сначала п.1.& pause & goto MENU)
  if "%WORK_FILE%"=="" (echo Сначала п.2.& pause & goto MENU)
  set "FULL_PATH=%WORK_DIR%\%WORK_FILE%.txt"
  if not exist "%FULL_PATH%" (echo Файл не найден.& pause & goto MENU)
  attrib +h "%FULL_PATH%" && echo Файл скрыт. || echo Не удалось изменить атрибут.
  pause
  goto MENU
)

rem === 4) Показать содержимое каталога ===
if %errorlevel%==5 (
  cls
  echo === Содержимое каталога ===
  if "%WORK_DIR%"=="" (echo Сначала п.1.& pause & goto MENU)
  if not exist "%WORK_DIR%" (echo Каталог не найден.& set "WORK_DIR=" & set "WORK_FILE=" & pause & goto MENU)
  dir /a "%WORK_DIR%"
  pause
  goto MENU
)

rem === 5) Удалить каталог ===
if %errorlevel%==6 (
  cls
  echo === Удаление каталога ===
  if "%WORK_DIR%"=="" (echo Каталог не задан.& pause & goto MENU)
  if not exist "%WORK_DIR%" (echo Каталог уже удалён.& set "WORK_DIR=" & set "WORK_FILE=" & pause & goto MENU)
  set /p CONF=Удалить "%WORK_DIR%" со всем содержимым? (y/N): 
  if /i not "%CONF%"=="y" (echo Отменено.& pause & goto MENU)
  attrib -h "%WORK_DIR%\%WORK_FILE%.txt" >nul 2>&1
  rd /s /q "%WORK_DIR%" && echo Удалено. || echo Не удалось удалить.
  set "WORK_DIR="
  set "WORK_FILE="
  pause
  goto MENU
)

goto MENU

:END
endlocal
exit /b 0