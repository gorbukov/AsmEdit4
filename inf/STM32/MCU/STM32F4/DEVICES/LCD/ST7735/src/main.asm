@.CHARSET  CP1251
@GNU AS

.SYNTAX unified                     @ синтаксис исходного кода
.THUMB                              @ тип используемых инструкций Thumb
.CPU    cortex-m4                   @ процессор
.FPU    fpv4-sp-d16                 @ сопроцессор

.SECTION .asmcode

@ основная программа
.GLOBAL    Start
Start:
                         BL          SYSCLK168_START         @ настройка  тактирования
                         BL          SYSTICK_START           @ запуск SysTick

.INCLUDE  "/src/periph/rcc/rcc_ahb1enr_gpio_set.inc"         @ тактирование gpio
.INCLUDE  "/src/periph/gpio/gpio_b_conf.inc"                 @ конфигурация gpio b

                         BL          LCD_INIT                @ инициализация дисплея

                         MOV         R8, 0
LOOP:
                         MOV         R1, 0XF800
                         @ Зададим прямоугольную область заполнения
                         LDR         R2, = ( 0 << 16 ) | ( 127 << 0 )    @ Y
                         LDR         R3, = ( 0 << 16 ) | ( 159 << 0 )    @ X
                         BL          LCD_FILLRECT

                         MOV         R1, 'S'                @ символ для вывода
                         MOV         R2, 64                 @ координата Y
                         MOV         R3, R8                 @ координата X
                         LDR         R4, = 0xffff0000       @ цвета
                         bl          LCD_CHAR
                         MOV         R1, 'T'                @ символ для вывода
                         ADD         R3, 7                  @ координата X
                         bl          LCD_CHAR
                         MOV         R1, '7'                @ символ для вывода
                         ADD         R3, 7                  @ координата X
                         bl          LCD_CHAR
                         MOV         R1, '7'                @ символ для вывода
                         ADD         R3, 7                  @ координата X
                         bl          LCD_CHAR
                         MOV         R1, '3'                @ символ для вывода
                         ADD         R3, 7                  @ координата X
                         bl          LCD_CHAR
                         MOV         R1, '5'                @ символ для вывода
                         ADD         R3, 7                  @ координата X
                         bl          LCD_CHAR

                         ADD         R8, R8, 1
                         AND         R8, 0x7f

                         MOV         R0, 255
                         BL          SYSTICK_DELAY

                         B           LOOP


