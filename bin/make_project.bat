:: Файл компиляции и сборки проектов GNU AS
echo off
cls

:: Удалим файлы прежних попыток сборки проекта ------------------------------
del /Q compile\*.* 
del /Q compile\temp\*.* 

:: Назначаем переменные каталог запуска -------------------------------------
set pth=%~dp0
set path=%~dp0bin\
echo Текущий путь запуска: %path%
echo.

echo Компиляция файлов:
:: обходим все каталоги проекта и компилируем asm файлы в .o ----------------
Setlocal EnableDelayedExpansion
for /r /d %%i in (*) do (
   cd %%i
   for %%b in (*.asm) do (
      set a=%%~fb
      set o=%%~db%%~pb%%~nb.o
      set l=compile/temp/%%~nb.lst
      echo !a!
      cd !pth!
%path%arm-none-eabi-as.exe -o !o! -I %%~db%%~pb !a!
%path%arm-none-eabi-objdump.exe -j .vectors -j .text -j .asmcode -j .bss -j .rodata -d -t -w !o! > !l!
      cd %%i
   )
)

:: обходим все каталоги проекта и строим список .o файлов -------------------
cd %pth%
set ofiles=
Setlocal EnableDelayedExpansion
for /r /d %%i in (*) do (
   cd %%i
   for %%b in (*.o) do set ofiles=!ofiles! %%~fb
   )
)
::echo.

::echo Компоновка файлов: 
::echo %ofiles%
::echo.
:: компонуем полученные .o файлы в прошивку ---------------------------------
cd !pth!
%path%arm-none-eabi-ld.exe -T src\link.ld -o compile\sys.elf %ofiles%

:: Если при компиляции были ошибки и выходного файла нет - выходим !
set ou=compile\sys.elf
IF NOT exist %ou% (
   echo Ошибка при компиляции !
   PAUSE
   goto exit
)

:: из .elf файла делаем файлы прошивок .bin и .hex --------------------------
cd %pth%
%path%arm-none-eabi-objcopy.exe -O binary compile\sys.elf compile\output.bin
%path%arm-none-eabi-objcopy.exe -O ihex   compile\sys.elf compile\output.hex
:: Адреса меток и значения переменных, вывод в файл
%path%arm-none-eabi-nm.exe -A -p compile\sys.elf > compile\labels.lst
%path%arm-none-eabi-objdump.exe -D compile\sys.elf > compile\start.dasm
%path%arm-none-eabi-objdump.exe -S compile\sys.elf > compile\source.dasm
echo.
echo Файлы прошивки находятся в папке \compile\

:exit
:: удаляем .o файлы чтобы не мешались----------------------------------------
cd %pth%
Setlocal EnableDelayedExpansion
for /r /d %%i in (*) do (
   cd %%i
   for %%b in (*.o) do (del /Q %%~fb)
)
