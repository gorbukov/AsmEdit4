@.CHARSET CP866
@GNU AS
@.desc type=module
@ ***************************************************************************
@ *                  МОДУЛЬ УПРАВЛЕНИЯ LCD НА PCD8544                       *
@ ***************************************************************************
@ * Процедуры:                                                              *
@ *     LCD_INIT:     Инициализация SPI, LCD (инициализации GPIO нет !)     *
@ *     LCD_REFRESH:  Вывод содержимого буфера на LCD                       *
@ *     LCD_CLEAR:    Очистка буфера                                        *
@ *     LCD_PIXEL:    Вывод пиксела (R0:Y, R1:X, R2:[1/0])                  *
@ *     LCD_CHAR:     Вывод символа (R0:Y, R1:X, R2:[1/0], R3:char)         *
@ *                                                                         *
@ *  ПРИМЕЧАНИЕ !                                                           *
@ *  - Все процедуры не портят регистры!                                    *
@ *  - допустимые координаты: 0<X<84, 0<Y<48                                *
@ *  - вывод символов LCD_CHAR с точностью до пискела                       *
@ *  - в знакогенераторе нет прописных (маленьких) букв                     *
@ *                                                                         *
@ ***************************************************************************
@.enddesc

.syntax unified     @ синтаксис исходного кода
.thumb              @ тип используемых инструкций Thumb
.cpu cortex-m4      @ процессор
.fpu fpv4-sp-d16    @ сопроцессор

.include             "/src/inc/rcc.inc"
.include             "/src/inc/gpio.inc"
.include             "/src/inc/spi.inc"

@ подключение дисплея

.equ pCS            , 11
.equ pCS_GPIO_BASE  , GPIOB_BASE

.equ pDC            , 12
.equ pDC_GPIO_BASE  , GPIOB_BASE

.equ pRST           , 14
.equ pRst_GPIO_BASE , GPIOB_BASE

@ аппаратный SPI
.equ LCD_SPI        , SPI2_BASE


.section .asmcode
@.desc name=LCD_INIT type=proc
@ +--------------------------------------------------------------------+
@ |               Процедура инициализации дисплея PCD8544              |
@ +--------------------------------------------------------------------+
@ | Процедура проводит инициализацию: SPI, и самого дисплея            |
@ | Инициализацию GPIO нужно выполнить до вызова этой процедуры        |
@ +--------------------------------------------------------------------+
@.enddesc
.global LCD_INIT
LCD_INIT:
                    PUSH     { R0, R1, R2, R3, R4, R5, LR }

                    MOV     R0, 0
                    MOV     R1, 1

          @ включим SPI 2
                    LDR     R2, =(PERIPH_BB_BASE+(RCC_BASE+RCC_APB1ENR)*32+RCC_APB1ENR_SPI2EN_N*4)
                    STR     R1, [ R2 ]

     @ настройка и включение интерфейса SPI
.equ spi_dir        , SPI_CR1_BIDIOE | SPI_CR1_BIDIMODE    @ SPI_Direction_1Line_Tx
.equ spi_mode_master, SPI_CR1_MSTR   | SPI_CR1_SSI         @ SPI_Mode_Master
.equ spi_nss        , SPI_CR1_SSM    | SPI_CR1_SPE         @ SPI_NSS_Soft & SPI_Enable
.equ spi_brpresc    , SPI_CR1_BR_DIV_4                     @ делитель частоты для SPI

          @ включаем SPI2 с нужной конфигурацией
                    LDR       R2, =( PERIPH_BASE + LCD_SPI )
                    LDR       R3, =( spi_dir | spi_mode_master | spi_nss | spi_brpresc )
                    LDR       R4, [ R2, SPI_CR1 ]
                    ORR       R3, R3, R4
                    STR       R3, [ R2, SPI_CR1 ]

          @ работа с дисплеем
          @ аппаратный сброс LCD
                    BL        LCD_CS0
                    BL        LCD_DC0

                    BL        LCD_RST0

                    MOV       R0, 1
                    BL        SYSTICK_DELAY

                    BL        LCD_RST1

@          MOV     R0, 2           @ некоторые дисплеи после сброса тоже
@          BL     SYSTICK_DELAY   @ требуют задержку, но не pcd8544

          @ отправка команд настройки LCD
                    MOV       R5, 0x21
                    BL        LCD_SENDDATA

                    MOV       R5, 0xC1
                    BL        LCD_SENDDATA

                    MOV       R5, 0x06
                    BL        LCD_SENDDATA

                    MOV       R5, 0x13
                    BL        LCD_SENDDATA

                    MOV       R5, 0x20
                    BL        LCD_SENDDATA

                    MOV       R5, 0x0C
                    BL        LCD_SENDDATA

                    BL        SPI_WAIT_BSY     @ ожидание конца посылки настройки

                    BL        LCD_CS1

                    POP       {R0, R1, R2, R3, R4,  R5, PC}


     @ отправка байта по spi с ожиданием флага TXE - - - - - - - - - - - -
LCD_SENDDATA:
                    LDR       R2, =(PERIPH_BASE + LCD_SPI)
spi2_txe_wait:
                    LDR       R3, [R2, SPI_SR]
                    TST       R3, SPI_SR_TXE
                    BEQ       spi2_txe_wait
                    STR       R5, [R2, SPI_DR]
                    BX        LR

     @ ожидание конца передачи - - - - - - - - - - - - - - - - - - - - - -
SPI_WAIT_BSY:
                    LDR       R2, =(PERIPH_BASE + LCD_SPI)
spi_bsy_wait:
                    LDR       R3, [R2, SPI_SR]
                    TST       R3, SPI_SR_BSY
                    BNE       spi_bsy_wait
                    BX        LR

     @ управление линией CS - - - - - - - - - - - - - - - - - - - - - - -
LCD_CS0:
                    LDR       R2, =(PERIPH_BB_BASE + (pCS_GPIO_BASE + GPIO_ODR)*32 + pCS*4)
                    STR       R0, [R2]
                    BX        LR

LCD_CS1:
                    LDR       R2, =(PERIPH_BB_BASE + (pCS_GPIO_BASE + GPIO_ODR)*32 + pCS*4)
                    STR       R1, [R2]
                    BX        LR

     @ управление линией DC - - - - - - - - - - - - - - - - - - - - - - - -
LCD_DC0:
                    LDR       R2, =(PERIPH_BB_BASE + (pDC_GPIO_BASE + GPIO_ODR)*32 + pDC*4)
                    STR       R0, [R2]
                    BX        LR

LCD_DC1:
                    LDR       R2, =(PERIPH_BB_BASE + (pDC_GPIO_BASE + GPIO_ODR)*32 + pDC*4)
                    STR       R1, [R2]
                    BX        LR

     @ управление линией RST - - - - - - - - - - - - - - - - - - - - - - -
LCD_RST0:
                    LDR       R2, =(PERIPH_BB_BASE + (pRst_GPIO_BASE + GPIO_ODR)*32 + pRST*4)
                    STR       R0, [R2]
                    BX        LR

LCD_RST1:
                    LDR       R2, =(PERIPH_BB_BASE + (pRst_GPIO_BASE + GPIO_ODR)*32 + pRST*4)
                    STR       R1, [R2]
                    BX        LR


@.desc name=LCD_CLEAR type=proc
@ ***************************************************************************
@ *                             ОЧИСТКА БУФЕРА                              *
@ ***************************************************************************
@ Процедура очищает буфер экрана в ОЗУ, никаких данных ни дисплей не отправ-
@ ляет (для этого используйте LCD_Refresh)
@ входные параметры: нет
@ выходные параметры: нет
@ изменяемые регистры по выходу: нет
@
@.enddesc
.section .bss
.align(4)
LCD_BUFF:
                    .space    84*6, 0                  @ буфер дисплея в SRAM

.section .asmcode

.global LCD_CLEAR

LCD_CLEAR:
                    PUSH      { R0, R1, R2 }

                    MOV       R0, 0                  @ записываемое значение
                    MOV       R1, ( 84 * 6 ) / 4     @ количество слов для записи

                    LDR       R2, =LCD_BUFF            @ адрес буфера

LCD_CLEAR_loop: @ обнуляем буфер записью по 4 байта (так быстрее)
                    STR       R0, [R2], 4

                    SUBS      R1, R1, 1
                    BNE       LCD_CLEAR_loop

                    POP       { R0, R1, R2 }
                    BX        LR

@.desc name=LCD_REFRESH type=proc
@ **************************************************************************
@ *                 ОБНОВЛЕНИЕ ЭКРАНА СОДЕРЖИМЫМ БУФЕРА                    *
@ **************************************************************************
@.enddesc
.global LCD_REFRESH

LCD_REFRESH:
@ очистка экрана (отладка)
                    PUSH      { R0, R1, R2, R4, R5, R6, LR }
                    MOV       R0, 0
                    MOV       R1, 1

                    BL        LCD_CS0
                    BL        LCD_DC0

                    MOV       R5, 0x40
                    BL        LCD_SENDDATA

                    MOV       R5, 0x80
                    BL        LCD_SENDDATA

                    BL        SPI_WAIT_BSY

                    BL        LCD_DC1

                    MOV       R4, 84 * 6
                    LDR       R6, =LCD_BUFF

LCD_REFRESH_loop:
                    LDRB      R5, [R6], 1
                    BL        LCD_SENDDATA

                    SUBS      R4, R4, 1
                    BNE       LCD_REFRESH_loop

                    BL        SPI_WAIT_BSY

                    BL        LCD_CS1

                    POP       { R0, R1, R2, R4, R5, R6, PC }

@.desc name=LCD_PIXEL type=proc
@ ***************************************************************************
@ *                           ВЫВОД ПИКСЕЛА                                 *
@ ***************************************************************************
@ * R0 - Y                                                                  *
@ * R1 - X                                                                  *
@ * R2 - цвет (0: белый, 1: черный)                                         *
@ ***************************************************************************
@.enddesc

.global LCD_PIXEL
LCD_PIXEL:
                    PUSH      { R0, R1, R2, R3, R4, R5, LR }

                    CMP       R0, 48          @ проверим допустимость координат
                    BPL       LCD_PIXEL_exit
                    CMP       R1, 84
                    BPL       LCD_PIXEL_exit

                    @ вычисляем адрес пиксела
                    LSR       R3, R0, 3        @  y >> 3
                    MOV       R4, 84
                    MUL       R3, R3, R4       @ (y >> 3) * 84
                    ADD       R5, R3, R1       @ (y >> 3) * 84 + x
                    LDR       R4, =LCD_BUFF
                    ADD       R5, R5, R4      @ в R5 адрес бита
                    LDRB      R4, [ R5 ]         @ читаем байт бита

          @ вычисляем маску для наложения
                    MOV       R3, 1
                    AND       R0, R0, 0x07
                    LSL       R3, R3, R0

          @ в зависимости от цвета: стираем или накладываем маску
                    CMP       R2, 0x01     @ вывод/стирание ?
                    ITEE      EQ
                    ORREQ     R4, R4, R3      @ вывод маски
                    RSBNE     R3, R3, 0xFF    @ инверсия маски
                    ANDNE     R4, R4, R3      @ сброс по маске

                    STRB      R4, [ R5 ]     @ запись в буфер

LCD_PIXEL_exit:
                    POP       { R0, R1, R2, R3, R4, R5, PC }

@.desc name=LCD_CHAR type=proc
@ ***************************************************************************
@ *                           ВЫВОД СИМВОЛА                                 *
@ ***************************************************************************
@ * R0 - Y                                                                  *
@ * R1 - X                                                                  *
@ * R2 - цвет (0: инверсия, 1: черный)                                      *
@ * R3 - символ                                                             *
@ ***************************************************************************
@.enddesc

.include "/src/devices/pcd8544/font6x8.inc"  @ файл знакогенератора

.global LCD_CHAR
LCD_CHAR:
                    PUSH      { R0 - R12, LR }

                    CMP       R0, 48          @ проверим допустимость координат
                    BPL       LCD_CHAR_exit
                    CMP       R1, 84
                    BPL       LCD_CHAR_exit

                    CMP       R2, 0           @ если выводим символ в инверсии
                    BNE       LCD_CHAR_noleftline
                    PUSH      { R0, R1, R2 }
                    MOV       R4, 8           @ то рисуем слева от символа
                    SUB       R1, R1, 1       @ вертикальную линию
                    SUB       R0, R0, 1       @ чтобы символ не сливался
                    MOV       R2, 1           @ с фоном

LCD_CHAR_leftline:
                    BL        LCD_PIXEL
                    ADD       R0, R0, 1
                    SUBS      R4, R4, 1
                    BNE       LCD_CHAR_leftline
                    POP       { R0, R1, R2 }

LCD_CHAR_noleftline:
          @ пересчитаем код char для нашего знакогенератора
                    CMP       R3, 127
                    ITTEE     MI
                    ADRMI     R12, LCD_LAT_CHARS
                    SUBMI     R3, R3, 32
                    ADRPL     R12, LCD_RUS_CHARS
                    SUBPL     R3, R3, 192
          @ в R3:символ R12:адрес знакогенератора

                    AND       R4, R0, 0x07
                    MOV       R7, 7
                    SUB       R4, R7, R4      @ в R4 битовая позиция в байте

                    LSR       R5, R0, 3       @ в R5 байтовая позиция на экране

                    MOV       R6, 0           @ счетчик цикла

LCD_CHAR_loop:
                    MOV       R7, 6
                    MUL       R8, R3, R7     @ код символа * 6

                    ADD       R8, R8, R6     @ прибавили номер столбца символа
                    ADD       R8, R8, R12     @ прибавили адрес знакогенератора

                    LDRB      R8, [ R8 ]     @ столбец (байт символа)

                    CMP       R2, 0          @ в зависимости от цвета
                    BNE       LCD_CHAR_noinv
                    RSB       R8, R8, 0xFF    @ инвертируем байт символа
                    PUSH      { R0, R1, R2 }
                    SUB       R0, R0, 1       @ сверху вывод контрастной точки
                    MOV       R2, 1           @ чтобы символ не сливался с
                    BL        LCD_PIXEL       @ с фоном
                    POP       { R0, R1, R2 }

LCD_CHAR_noinv:
                    AND       R8, R8, 0x7F

                    LDR       R9, =LCD_BUFF
                    MOV       R7, 84
                    MUL       R7, R7, R5
                    ADD       R9, R9, R7
                    ADD       R9, R9, R1      @ адрес в буфере

                    RSB       R10, R4, 7      @ вывод верхней части символа
                    LSL       R11, R8, R10
                    LDR       R10, [ R9 ]
                    ORR       R11, R10, R11
                    STRB      R11, [ R9 ]

                    CMP       R4, 7                @ проверяем нужно ли выводить
                    BEQ       LCD_CHAR_loop_end  @ нижнюю часть символа

                    ADD       R5, R5, 1       @ если экранные строки кончились
                    CMP       R5, 6
                    BEQ       LCD_CHAR_loop_end  @ то пропускаем их вывод

                    LDR       R9, =LCD_BUFF
                    MOV       R7, 84
                    MUL       R7, R7, R5
                    ADD       R9, R9, R7
                    ADD       R9, R9, R1
                    SUB       R5, R5, 1

                    ADD       R10, R4, 1     @ вывод нижней части символа
                    LSR       R11, R8, R10
                    LDR       R10, [ R9 ]
                    ORR       R11, R10, R11
                    STRB      R11, [ R9 ]

LCD_CHAR_loop_end:
                    ADD       R1, R1, 1
                    CMP       R1, 84
                    BPL       LCD_CHAR_exit

                    ADD       R6, R6, 1
                    CMP       R6, 6
                    BNE       LCD_CHAR_loop

LCD_CHAR_exit:
                    POP       { R0 - R12, PC }

