@.CHARSET CP1251
@GNU AS
@.DESC     type=module
@ ***************************************************************************
@ *                  МОДУЛЬ УПРАВЛЕНИЯ LCD НА ST7735                        *
@ ***************************************************************************
@ * Процедуры:                                                              *
@ *     LCD_INIT:     Инициализация SPI, LCD (инициализации GPIO нет !)     *
@ *     LCD_FILLREC   Заполнение области цветом                             *
@ *     LCD_CHAR:     Вывод символа                                         *
@ *                                                                         *
@ *  ПРИМЕЧАНИЕ !                                                           *
@ *  - допустимые координаты: 0<X<159, 0<Y<127                              *
@ *  - вывод символов LCD_CHAR с точностью до пискела                       *
@ *  - в знакогенераторе нет прописных (маленьких) букв                     *
@ *                                                                         *
@ ***************************************************************************
@.ENDDESC

.SYNTAX unified                     @ синтаксис исходного кода
.THUMB                              @ тип используемых инструкций Thumb
.CPU    cortex-m4                   @ процессор
.FPU    fpv4-sp-d16                 @ сопроцессор

.INCLUDE  "/src/inc/rcc.inc"
.INCLUDE  "/src/inc/gpio.inc"
.INCLUDE  "/src/inc/spi.inc"

@ подключение дисплея

.EQU  pCS                           , 11
.EQU  pCS_GPIO_BASE                 , GPIOB_BASE

.EQU  pDC                           , 12
.EQU  pDC_GPIO_BASE                 , GPIOB_BASE

.EQU  pRST                          , 14
.EQU  pRst_GPIO_BASE                , GPIOB_BASE

@ аппаратный SPI (смотрите файл настройки GPIO для выбранного SPI)
.EQU  LCD_SPI                       , SPI2_BASE

.SECTION .asmcode
@.DESC     name=LCD_INIT type=proc
@ +--------------------------------------------------------------------+
@ |               Процедура инициализации дисплея ST7735               |
@ +--------------------------------------------------------------------+
@ | Процедура проводит инициализацию: SPI, и самого дисплея            |
@ | Инициализацию GPIO нужно выполнить до вызова этой процедуры        |
@ +--------------------------------------------------------------------+
@.ENDDESC
.GLOBAL LCD_INIT
LCD_INIT:                LKU:
                         PUSH        { R0, R1, LR }
                    @ включим SPI 2
                         MOV         R0, 1
                         LDR         R1, = ( PERIPH_BB_BASE + ( RCC_BASE + RCC_APB1ENR ) * 32 + RCC_APB1ENR_SPI2EN_N * 4 )
                         STR         R0, [ R1 ]

          @ настройка и включение интерфейса SPI
.EQU  spi_dir            , SPI_CR1_BIDIOE | SPI_CR1_BIDIMODE    @ SPI_Direction_1Line_Tx
.EQU  spi_mode_master    , SPI_CR1_MSTR | SPI_CR1_SPE        @ SPI_Mode_Master & SPI_Enable
.EQU  spi_nss            , SPI_CR1_SSM | SPI_CR1_SSI         @ SPI_NSS_Soft
.EQU  spi_brpresc        , SPI_CR1_BR_DIV_2                  @ делитель частоты для SPI

                    @ включаем SPI2 с выбранными выше настройками
                         LDR         R1, = ( PERIPH_BASE + LCD_SPI )
                         LDR         R0, = ( spi_dir | spi_mode_master | spi_nss | spi_brpresc )
                         STR         R0, [ R1, SPI_CR1 ]

          @ начало работы с дисплеем

                    @ укажем дисплею что работаем с ним
                         BL          LCD_CS0

                    @ аппаратный сброс LCD
                         @ установим линию RST=0
                         MOV         R0, 0
                         LDR         R1, = ( PERIPH_BB_BASE + ( pRst_GPIO_BASE + GPIO_ODR ) * 32 + pRST * 4 )
                         STR         R0, [ R1 ]
                     @ пауза для фиксации сигнала сброса устройством
                         MOV         R0, 10
                         BL          SYSTICK_DELAY
                         @ установим линию RST=1
                         MOV         R0, 1
                         STR         R0, [ R1 ]
                     @ пауза после сброса
                         MOV         R0, 10
                         BL          SYSTICK_DELAY

          @ отправка команд инициализации LCD
                         MOV         R0, 0x11               @ разбудим дисплей после сброса
                         BL          LCD_SENDCOM

                         MOV         R0, 10                 @ подождем пока проснется
                         BL          SYSTICK_DELAY

                         MOV         R0, 0x3A               @ режим цвета
                         BL          LCD_SENDCOM
                         MOV         R0, 0x05               @ 16ти битный цвет
                         BL          LCD_SENDDATA

                         MOV         R0, 0x36               @ направление вывода изображения и формат rgb
                         BL          LCD_SENDCOM
                         MOV         R0, 0X1C
                         BL          LCD_SENDDATA

                         MOV         R0, 0x29               @ включить отображение
                         BL          LCD_SENDCOM

                         BL          LCD_CS1

          @ отключимся от дисплея, он уже проинициализирован
                         POP         { R0, R1, PC }



LCD_SENDCOM:  @ отправка команды с предварительным  ожиданием BSY
                         PUSH        { R1, R2, R3, LR }

                    @ ожидание ухода предыдущих данных или команды
                         BL          SPI_WAIT_TXE
                         BL          SPI_WAIT_BSY            @ ожидание окончания прошлой отправки

                    @ переходим в режим команд  DC=0
                         MOV         R2, 0
                         LDR         R3, = ( PERIPH_BB_BASE + ( pDC_GPIO_BASE + GPIO_ODR ) * 32 + pDC * 4 )
                         STR         R2, [ R3 ]

                         STR         R0, [ R1, SPI_DR ]     @ отправка команды
                    @ ожидание ухода команды
                         BL          SPI_WAIT_TXE           @ ждем когда данные уйдут на передачу
                         BL          SPI_WAIT_BSY           @ ждем физического окончания передачи

                    @ переходим в режим данных DC=1
                         MOV         R2, 1
                         STR         R2, [ R3 ]

                         POP         { R1, R2, R3, PC }


LCD_SENDDATA:            @ отправка данных с предварительным ожиданием TXE
                         PUSH        { R1, R2, LR }
                         BL          SPI_WAIT_TXE           @ проверим что прошлый байт ушел на отправку
                         STR         R0, [ R1, SPI_DR ]
                         POP         { R1, R2, PC }


SPI_WAIT_BSY:            @ ожидание конца физической передачи
                         LDR         R2, [ R1, SPI_SR ]
                         TST         R2, SPI_SR_BSY
                         BNE         SPI_WAIT_BSY
                         BX          LR

SPI_WAIT_TXE:            @ ожидание записи данных из spi_dr в shift
                         LDR         R1, = ( PERIPH_BASE + LCD_SPI )
spi_TXE_wait:
                         LDR         R2, [ R1, SPI_SR ]
                         TST         R2, SPI_SR_TXE
                         BEQ         spi_TXE_wait

                         BX          LR

     @ управление линией CS - - - - - - - - - - - - - - - - - - - - - - -
LCD_CS0:
                         PUSH        { R0, R1 }
                         MOV         R0, 0
                         LDR         R1, = ( PERIPH_BB_BASE + ( pCS_GPIO_BASE + GPIO_ODR ) * 32 + pCS * 4 )
                         STR         R0, [ R1 ]
                         POP         { R0, R1 }
                         BX          LR

LCD_CS1:
                         MOV         R0, 1
                         LDR         R1, = ( PERIPH_BB_BASE + ( pCS_GPIO_BASE + GPIO_ODR ) * 32 + pCS * 4 )
                         STR         R0, [ R1 ]
                         BX          LR


@.DESC     name=LCD_AT type=proc
@ ***************************************************************************
@ *                  Задание прямоугольной области экрана                   *
@ ***************************************************************************
@ | Задание области экрана для операций                                     |
@ | Параметры:                                                              |
@ |  R2 - координаты X: 31:16 - SX, 15:0 - EX                               |
@ |  R3 - координаты Y: 31:16 - SY, 15:0 - EY                               |
@ +-------------------------------------------------------------------------+
@.ENDDESC
LCD_AT:                  @ определение прямоугольной области экрана
                         PUSH        { R0, LR }

                         MOV         R0, 0x2A               @ задать координаты StartX, EndX
                         BL          LCD_SENDCOM            @ отправка команды

                         UBFX        R0, R2, 24, 8          @ отправка StartX
                         BL          LCD_SENDDATA
                         UBFX        R0, R2, 16, 8          @ отправка StartX
                         BL          LCD_SENDDATA

                         UBFX        R0, R2, 8, 8           @ отправка EndX
                         BL          LCD_SENDDATA
                         UBFX        R0, R2, 0, 8           @ отправка EndX
                         BL          LCD_SENDDATA

                         MOV         R0, 0x2B               @ задать координаты StartY, EndY
                         BL          LCD_SENDCOM            @ отправка команды

                         UBFX        R0, R3, 24, 8          @ отправка StartY
                         BL          LCD_SENDDATA
                         UBFX        R0, R3, 16, 8          @ отправка StartY
                         BL          LCD_SENDDATA

                         UBFX        R0, R3, 8, 8           @ отправка EndY
                         BL          LCD_SENDDATA
                         UBFX        R0, R3, 0, 8           @ отправка EndY
                         BL          LCD_SENDDATA

                         MOV         R0, 0x2C               @ команда заполнения области
                         BL          LCD_SENDCOM

                         POP         { R0, PC }

@.DESC     name=LCD_FILLRECT type=proc
@ ***************************************************************************
@ *                  Заливка прямоугольной области экрана                   *
@ ***************************************************************************
@ | Очистка области экрана и заливка цветом                                 |
@ | Параметры:                                                              |
@ |  R1 - цвет заливки                                                      |
@ |  R2 - координаты Y: 31:16 - START_Y, 15:0 - END_Y                       |
@ |  R3 - координаты X: 31:16 - START_X, 15:0 - END_X                       |
@ +-------------------------------------------------------------------------+
@.ENDDESC
.GLOBAL LCD_FILLRECT
LCD_FILLRECT:
                         PUSH        { R0, R4, R5, R6, LR }

                         BL          LCD_CS0

                         BL          LCD_AT        @ установим рабочую область на весь экран

                         @ Расчитаем размер по Y
                         UBFX        R5, R2, 0, 16
                         UBFX        R6, R2, 16, 16
                         SUB         R5, R5, R6
                         @ Расчитаем размер по X
                         UBFX        R0, R3, 0, 16
                         UBFX        R6, R3, 16, 16
                         SUB         R6, R0, R6
                         ADD         R5, R5, 1
                         ADD         R6, R6, 1
                         MUL         R4, R5, R6    @ Общее количество точек заполнения

LCD_CLEAR_loop:
                         UBFX        R0, R1, 8, 8
                         BL          LCD_SENDDATA
                         UBFX        R0, R1, 0, 8
                         BL          LCD_SENDDATA

                         SUBS        R4, R4, 1
                         BNE         LCD_CLEAR_loop

                         BL          SPI_WAIT_TXE
                         BL          SPI_WAIT_BSY

                         BL          LCD_CS1                 @ завершим сеанс работы с дисплеем

                         POP         { R0, R4, R5, R6, PC }

@.DESC     name=LCD_CHAR type=proc
@ ***************************************************************************
@ *                       Вывод символа по координатам                      *
@ ***************************************************************************
@ | Очистка области экрана и заливка цветом                                 |
@ | Параметры:                                                              |
@ |  R1 - код символа для вывода                                            |
@ |  R2 - Y                                                                 |
@ |  R3 - X                                                                 |
@ |  R4 - colors                                                            |
@ | R2, R3, R4 - сохраняют значения при выходе, R1 значение теряет          |
@ +-------------------------------------------------------------------------+
@.ENDDESC
.GLOBAL LCD_CHAR
LCD_CHAR:
                         PUSH        { R0, R2, R3, R4, R5, R6, R7, R8, LR }

                         BL          LCD_CS0                @ обращение к lcd

                     @ рассчитаем адрес символа
                         @ в зависимости от кода символа возьмем нужнуя часть знакогенератора
                         CMP         R1, 192
                         ITTEE       CC
                         LDRCC       R5, = LCD_LAT_CHARS
                         SUBCC       R1, R1, 32
                         LDRCS       R5, = LCD_RUS_CHARS
                         SUBCS       R1, R1, 192

                         MOV         R0, 6
                         MUL         R1, R1, R0
                         ADD         R5, R5, R1             @ в R5 адрес символа

                     @ Создадим область вывода
                         @ Упаковываем координату Y
                         MOV         R0, R2
                         PKHBT       R2, R2, R2, LSL 16
                         ADD         R2, R2, 7
                         @ Упаковываем координату X
                         MOV         R0, R3
                         PKHBT       R3, R3, R3, LSL 16
                         ADD         R3, R3, 5
                         BL          LCD_AT

                    @ R1 - байт символа
                    @ R2 - Y
                    @ R3 - X
                    @ R4 - color
                    @ R5 - адрес байта символа для вывода
                    @ R6 - счетчик строк символа для вывода
                    @ R7 - счетчик бит

                         MOV         R6, 6
LCD_line_loop:
                      @ передача одной строки символа
                         MOV         R7, 8

                         LDRB        R1, [ R5 ], 1

LCD_pix_loop:
                     @ выбираем цвет точки
                         TST         R1, 0x80
                         ITE         EQ
                         UBFXEQ      R8, R4, 0, 16
                         UBFXNE      R8, R4, 16, 16
                     @ передаем цвет
                         UBFX        R0, R8, 8, 8
                         BL          LCD_SENDDATA
                         UBFX        R0, R8, 0, 8
                         BL          LCD_SENDDATA
                     @ переходим к следующему биту
                         LSL         R1, R1, 1
                     @ цикл передачи бит (снизу вверх)
                         SUBS        R7, R7, 1
                         BNE         LCD_pix_loop
                     @ цикл передачи линий (слева на право)
                         SUBS        R6, R6, 1
                         BNE         LCD_line_loop

                         BL          SPI_WAIT_TXE
                         bl          SPI_WAIT_BSY

                         BL          LCD_CS1

                         POP         { R0, R2, R3, R4, R5, R6, R7, R8, PC }

.INCLUDE  "/src/devices/ST7735/font6x8.inc"                  @ шрифт для вывода



