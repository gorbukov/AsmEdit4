:: ���� �������樨 � ᡮન �஥�⮢ GNU AS
echo off
cls

:: ������ 䠩�� �०��� ����⮪ ᡮન �஥�� ------------------------------
del /Q compile\*.* 
del /Q compile\temp\*.* 

:: �����砥� ��६���� ��⠫�� ����᪠ -------------------------------------
set pth=%~dp0
set path=%~dp0bin\
echo ����騩 ���� ����᪠: %path%
echo.

echo ��������� 䠩���:
:: ��室�� �� ��⠫��� �஥�� � ��������㥬 asm 䠩�� � .o ----------------
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

:: ��室�� �� ��⠫��� �஥�� � ��ந� ᯨ᮪ .o 䠩��� -------------------
cd %pth%
set ofiles=
Setlocal EnableDelayedExpansion
for /r /d %%i in (*) do (
   cd %%i
   for %%b in (*.o) do set ofiles=!ofiles! %%~fb
   )
)
::echo.

::echo ���������� 䠩���: 
::echo %ofiles%
::echo.
:: ������㥬 ����祭�� .o 䠩�� � ��訢�� ---------------------------------
cd !pth!
%path%arm-none-eabi-ld.exe -T src\link.ld -o compile\sys.elf %ofiles%

:: �᫨ �� �������樨 �뫨 �訡�� � ��室���� 䠩�� ��� - ��室�� !
set ou=compile\sys.elf
IF NOT exist %ou% (
   echo �訡�� �� �������樨 !
   PAUSE
   goto exit
)

:: �� .elf 䠩�� ������ 䠩�� ��訢�� .bin � .hex --------------------------
cd %pth%
%path%arm-none-eabi-objcopy.exe -O binary compile\sys.elf compile\output.bin
%path%arm-none-eabi-objcopy.exe -O ihex   compile\sys.elf compile\output.hex
:: ���� ��⮪ � ���祭�� ��६�����, �뢮� � 䠩�
%path%arm-none-eabi-nm.exe -A -p compile\sys.elf > compile\labels.lst
%path%arm-none-eabi-objdump.exe -D compile\sys.elf > compile\start.dasm
%path%arm-none-eabi-objdump.exe -S compile\sys.elf > compile\source.dasm
echo.
echo ����� ��訢�� ��室���� � ����� \compile\

:exit
:: 㤠�塞 .o 䠩�� �⮡� �� ��蠫���----------------------------------------
cd %pth%
Setlocal EnableDelayedExpansion
for /r /d %%i in (*) do (
   cd %%i
   for %%b in (*.o) do (del /Q %%~fb)
)
