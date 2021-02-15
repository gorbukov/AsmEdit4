@.CharSet=CP1251
@GNU AS

.syntax unified     @ синтаксис исходного кода
.thumb              @ тип используемых инструкций Thumb
.cpu cortex-m4      @ процессор
.fpu fpv4-sp-d16    @ сопроцессор


.section .asmcode

@ основная программа
.global Start
Start:
                    BL        SYSCLK168_START     @ настройка  тактирования
                    BL        SYSTICK_START       @ запуск SysTick

.include            "/src/periph/rcc/rcc_ahb1enr_gpio_set.inc"  @ тактирование gpio
.include            "/src/periph/gpio/gpio_b_conf.inc"          @ конфигурация gpio b

                    BL        LCD_INIT        @ инициализация дисплея

                    BL        LCD_CLEAR

                    MOV       R0, 0           @ Y1
                    MOV       R1, 0           @ X1
                    MOV       R2, 1
                    MOV       R3, 47          @ Y2
                    MOV       R4, 83          @ X2
                    BL        LCD_RECT        @ рисуем прямоугольник

                    ADR       R4, ADR_TEXT1   @ выводим текст STM32 НА АССЕМБЛЕРЕ
                    BL        LCD_PUTSTR      @

                    BL        LCD_REFRESH

LOOP:               B         LOOP

ADR_TEXT1:
                    .byte     1             @ задать координаты
                    .short    18,      20   @ X, Y
                    .word     1             @ цвет
                    .ascii    "STM32F4"     @ текст

                    .byte     1
                    .short    28,      38
                    .word     1
                    .ascii    "НА"

                    .byte     1
                    .short    38,      8
                    .word     1
                    .ascii    "АССЕМБЛЕРЕ"
                    .byte     0             @ закончить вывод


