@.CHARSET CP1251
@GNU AS
@.desc type=module
@ ***************************************************************************
@ *               МОДУЛЬ ДОПОЛНИТЕЛЬНЫХ ФУНКЦИЙ МОДУЛЯ LCD                  *
@ ***************************************************************************
@ * Процедуры:                                            *
@ *     LCD_PUTSTR:   Вывод строки по координатам:                          *
@ *                   R0:Y, R1:X, R2:COLOR R4:ADR_TEXT                      *
@ *                   Текст должен заканчиваться нулевым символом           *
@ *                   Управляющий код: 0x01, .short Y, .short X, .word col  *
@ *                                                                         *
@ *     LCD_PUTHEX:   Вывод шестнадцатеричного числа:                       *
@ *                   R0:Y, R1:X, R2:COLOR R4:HEXVal, R5:DigitCol           *
@ *                                                                         *
@ *     LCD_PUTDEC:   Вывод десятичного числа:                        *
@ *                   R0:Y, R1:X, R2:COLOR R4:DECVal, R5:DigitCol           *
@ *                                                                         *
@ *     LCD_LINE:     Вывод линии:                                          *
@ *                   R0:Y1, R1:X1, R2:COLOR R3:Y2, R4:X2                   *
@ *                                                                         *
@ *     LCD_RECT:     Вывод прямоугольника:                                 *
@ *                   R0:Y1, R1:X1, R2:COLOR R3:Y2, R4:X2                   *
@ *                                                                         *
@ *  ПРИМЕЧАНИЕ !                                                           *
@ *  - Все процедуры не портят регистры!                                    *
@ *                                                                         *
@ *  - допустимые координаты и шаг печати native процедурами определяются   *
@ *    в файле lcd_param.inc который должен лежать рядом с файлом модуля    *
@ *                                                                         *
@ *  - Драйвер дисплея должен содержать функции определенные как .global:   *
@ *    LCD_CHAR: (R0:Y, R1:X, R2:Color, R3:Char) - native вывод символа     *
@ *    LCD_PIXEL: (R0:Y, R1:X, R2:Color)         - native вывод пиксела     *
@ *                                                                         *
@ ***************************************************************************
@.enddesc

.syntax unified         @ синтаксис исходного кода
.thumb                  @ тип используемых инструкций Thumb
.cpu    cortex-m4       @ процессор
.fpu    fpv4-sp-d16     @ сопроцессор

.section .asmcode

.include "src/devices/pcd8544/lcd_param.inc"     @ параметры дисплея

@.desc name=LCD_PUTSTR type=proc
@ ***************************************************************************
@ *                       ПЕЧАТЬ СТРОКИ ПО КООРДИНАТАМ                      *
@ ***************************************************************************
@ * R0:Y, R1:X, R2:COLOR R4:ADR_TEXT                                        *
@ ***************************************************************************
@ * Текст в себе может содержать string с 0x00 в конце и указание атрибутов *
@ * вывода после команды 0x01:                                              *
@ *   (.short) 0xYYYY      координата Y                                     *
@ *   (.short) 0xXXXX      координата X                                     *
@ *   (.word)  0xXXXXXXXX  цвет текста                                      *
@ ***************************************************************************
@.enddesc

.global LCD_PUTSTR
LCD_PUTSTR:
                    PUSH      { R0, R1, R2, R3, R4, LR }
LCD_PUTSTR_loop:
                    LDRB      R3, [ R4 ], 1     @  загружаем байт для печати

                    CMP       R3, 0          @ символ конца строки
                    BEQ       LCD_PUTSTR_exit

                    CMP       R3, 1          @ загрузка координат и режима печати
                    BNE       LCD_PUTSTR_char
                    ITTT      EQ
                    LDRHEQ    R0, [ R4 ], 2     @ Y
                    LDRHEQ    R1, [ R4 ], 2     @ X
                    LDREQ     R2, [ R4 ], 4     @ COLOR

                    BL        LCD_PUTSTR_loop
LCD_PUTSTR_char:
                    BL        LCD_CHAR

                    ADD       R1, R1, LCD_PARAM_char_stepx
                    CMP       R1 , LCD_PARAM_size_px
                    BMI       LCD_PUTSTR_loop
                    MOV       R1, 0
                    ADD       R0, R0, LCD_PARAM_char_stepy
                    CMP       R0, LCD_PARAM_size_py
                    BMI       LCD_PUTSTR_loop
LCD_PUTSTR_exit:
                    POP       { R0, R1, R2, R3, R4, PC }

@.desc name=LCD_PUTHEX type=proc
@ ***************************************************************************
@ *                       ПЕЧАТЬ ШЕСТНАДЦАТИРИЧНОГО ЧИСЛА                   *
@ ***************************************************************************
@ * R0:Y, R1:X, R2:COLOR R4:HEXVal, R5:DigitCol                             *
@ ***************************************************************************
@.enddesc

.global LCD_PUTHEX
LCD_PUTHEX:
                    PUSH      { R0, R1, R2, R3, R4, R5, R6, R7, LR }
                    ADD       R5, R5, 1
                    MOV       R7, 8
LCD_PUTHEX_loop:
                    MOV       R3, R4              @ берем исходное число
                    AND       R3, R3, 0xF0000000  @ оставляем старшие 4 бита

                    LSL       R4, R4, 4     @ исходное число на 4 бита влево
                    LSR       R3, R3, 28     @ старшие 4 бита в начало слова

                    CMP       R3, 10          @ преобразовываем число в символ
                    ITE       MI
                    ADDMI     R3, R3, 48                   @ для 0..9 прибавим 48 (код "0")
                    ADDPL     R3, R3, 55   @ для А..F прибавим 55 (код "A"-10)

                    MOV       R6, 0                 @ шаг X
                    CMP       R7, R5                @ если номер позиции меньше заданной
                    ITT       MI                    @ то
                    ADDMI     R6, R6, LCD_PARAM_char_stepx  @ -увеличим позицию X на stepx после печати
                    BLMI      LCD_CHAR                   @ -печатаем число

                    ADD       R1, R1, R6     @ Х=Х+stepx (или X=X+0 если печати не было)

                    SUBS      R7, R7, 1     @ уменьшаем номер позиции
                    BNE       LCD_PUTHEX_loop @ если не ноль, то циклимся

                    POP       { R0, R1, R2, R3, R4, R5, R6, R7, PC }

@.desc name=LCD_LINE type=proc
@ ***************************************************************************
@ *                                ВЫВОД ЛИНИИ                              *
@ ***************************************************************************
@ * R0:Y1, R1:X1, R2:COLOR R3:Y2, R4:X2                                     *
@ ***************************************************************************
@.enddesc

.global LCD_LINE
LCD_LINE:
                    PUSH      { R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, LR }

          @ расчет параметра dx и s1
                    MOV       R5, 0
                    MOV       R7, 0
                    CMP       R1, R4
                    BEQ       LCD_LINE_dx_s1
                    ITTEE     MI
                    SUBMI     R5, R4, R1
                    MOVMI     R7, 1
                    SUBPL     R5, R1, R4
                    MOVPL     R7, -1
                @ R5 = dx ( |X2-X1| )
LCD_LINE_dx_s1:
                @ расчет параметра dy и s2
                    MOV       R6, 0
                    MOV       R8, 0
                    CMP       R0, R3
                    BEQ       LCD_LINE_dy_s2
                    ITTEE     MI
                    SUBMI     R6, R3, R0
                    MOVMI     R8, 1
                    SUBPL     R6, R0, R3
                    MOVPL     R8, -1
                @ R6 = dy ( |Y2-Y1| )
LCD_LINE_dy_s2:
                @ обмен значений dx и dy в зависимости от углового коэффициента наклона отрезка
                    MOV       R4, 0
                    CMP       R6, R5
                    ITTTT     PL
                    MOVPL     R9, R5
                    MOVPL     R5, R6
                    MOVPL     R6, R9
                    MOVPL     R4, 1

                    MOV       R3, R6, LSL 1   @ e=2*dy
                    SUB       R3, R3, R5      @ e=2*dy-dx

                    MOV       R9, R5          @ переменная цикла
LCD_LINE_LOOP:  @  цикл рисования линии

                    BL        LCD_PIXEL      @ R1-x, R0-y, R2-color

LCD_LINE_WHILE:
                    ORRS      R3, R3, R3
                    BMI       LCD_LINE_WHILE_END

                    CMP       R4, 1
                    ITE       EQ
                    ADDEQ     R1, R1, R7
                    ADDNE     R0, R0, R8

                    SUB       R3, R3, R5, lsl 1
                    B         LCD_LINE_WHILE

LCD_LINE_WHILE_END:
                    CMP       R4, 1
                    ITE       EQ
                    ADDEQ     R0, R0, R8
                    ADDNE     R1, R1, R7

                    ADD       R3, R3, R6, lsl 1

                    SUBS      R9, R9, 1
                    BNE       LCD_LINE_LOOP

                    POP       { R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, PC }

@.desc name=LCD_RECT type=proc
@ ***************************************************************************
@ *                            ВЫВОД ПРЯМОУГОЛЬНИКА                         *
@ ***************************************************************************
@ * R0:Y1, R1:X1, R2:COLOR R3:Y2, R4:X2                                     *
@ ***************************************************************************
@.enddesc

.global LCD_RECT
LCD_RECT:
                    PUSH      { R0, R1, R3, R4, R5, LR }

          @ вывод горизонтальной верхней линии
                    MOV       R5, R3 @ сохраним Y2
                    MOV       R3, R0
                    BL        LCD_LINE

          @ вывод горизонтальной нижней линии
                    MOV       R3, R5 @ восстановим Y2
                    MOV       R5, R0 @ сохраним Y1
                    MOV       R0, R3
                    BL        LCD_LINE

          @ вывод вертикальной левой линии
                    MOV       R0, R5 @ восстановим Y1
                    MOV       R5, R4 @ сохраним Х2
                    MOV       R4, R1
                    BL        LCD_LINE

          @ вывод вертикальной правой линии
                    MOV       R4, R5 @ восстановим Х2
                    MOV       R1, R4
                    BL        LCD_LINE
                    POP       { R0, R1, R3, R4, R5, PC }

@.desc name=LCD_PUTDEC type=proc
@ ***************************************************************************
@ *                        ПЕЧАТЬ ДЕСЯТИЧНОГО ЧИСЛА                         *
@ ***************************************************************************
@ * R0:Y, R1:X, R2:COLOR R4:DECVal, R5:DigitCol                             *
@ ***************************************************************************
@.enddesc

.global LCD_PUTDEC
LCD_PUTDEC:
                    PUSH      { R0, R1, R2, R3, R4, R5, R6, R7, R8, LR }
                    MOV       R8, 0                   @ количество разрядов десятичного числа
LCD_DEC_loop:
                    MOV       R6, R4                  @ делимое

                    CMP       R6, 0
                    BEQ       LCD_DEC_null            @ если делимое =0 то деление закончено

                    LSR       R6, R6, 1          @ умножаем число на 0.8
                    ADD       R6, R6, R6, LSR 1       @
                    ADD       R6, R6, R6, LSR 4       @
                    ADD       R6, R6, R6, LSR 8       @
                    ADD       R6, R6, R6, LSR 16      @

                    LSR       R6, R6, 3               @ делим число на 8

                    MOV       R7, 10              @ проверяем результат
                    MUL       R3, R6, R7
                    SUB       R3, R4, R3
                    CMP       R3, 10                  @ коррекция результата
                    IT        PL
                    ADDPL     R6, R6, 1               @ R6 новое делимое

                    MUL       R3, R6, R7
                    SUB       R7, R4, R3              @ R7 остаток от деления
                    PUSH      { R7 }
                    ADD       R8, R8, 1             @ увеличием счетчик разрядом
                    MOV       R4, R6
                    B         LCD_DEC_loop

LCD_DEC_null:     @ печатаем лидирующие нули если нужно
                    CMP       R5, R8    @ R5:нужно число цифр, R8:получилось цифр
                    BEQ       LCD_DEC_prn
                    BMI       LCD_DEC_prn
                    MOV       R3, '0'
                    BL        LCD_CHAR
                    ADD       R1, R1, LCD_PARAM_char_stepx  @ X+stepx
                    SUB       R5, R5, 1
                    B         LCD_DEC_null

LCD_DEC_prn:    @ печатаем получившееся число
                    CMP       R8, 0
                    BEQ       LCD_DEC_exit
                    POP       { R3 }              @ читаем значение
                    ADD       R3, R3, '0'
                    BL        LCD_CHAR
                    ADD       R1, R1, LCD_PARAM_char_stepx  @ X+stepx
                    SUB       R8, R8, 1
                    B         LCD_DEC_prn
LCD_DEC_exit:
                    POP       { R0, R1, R2, R3, R4, R5, R6, R7, R8, PC }

