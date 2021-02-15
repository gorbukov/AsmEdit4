@GNU AS
@.CHARSET CP1251

@.desc type=module
@ +------------------------------------------------------------------+
@ |                      Модуль таймера SysTick                      |
@ +------------------------------------------------------------------+
@ | Для использования необходимо инициализировать модуль вызовом:    |
@ |     BL   SYSTICK_START                                           |
@ |                                                                  |
@ | В дальнейшем при необходимости осуществления задержки:           |
@ |    MOV R0, <время задержки в милисекундах>                       |
@ |    BL  SYSTICK_DELAY                                             |
@ +------------------------------------------------------------------+
@.enddesc

.syntax unified      @ синтаксис исходного кода
.thumb               @ тип используемых инструкций Thumb
.cpu cortex-m4       @ процессор
.fpu fpv4-sp-d16     @ сопроцессор

@ определение констант
.equ SCB_BASE           ,0xE000ED00   @ System control block (SCB)
.equ SHPR3              ,0x20         @ System handler priority registers (SHPRx)
.equ SYSTICK_BASE       ,0xE000E010   @ System timer
.equ STK_CTRL           ,0x00         @ Регистр статуса и управления
.equ STK_LOAD           ,0x00000004   @ Значение для перезагрузки счетчика
.equ STK_VAL            ,0x00000008   @ Текущее значение счетчика
.equ STK_CTRL_CLKSOURSE ,0x00000004   @ (RW) источник тактирования: 0: AHB/8; 1: AHB
.equ STK_CTRL_TICKINT   ,0x00000002   @ (RW) при установке генерирует прерывание при переходе через 0
.equ STK_CTRL_ENABLE    ,0x00000001   @ (RW) включает счетчик.


.section .bss
@ Переменная в ОЗУ
SYSTICK_COUNTER:
          .word     0             @ Значение необходимой задержки

.section .asmcode
@.desc name=IRQ_SysTick type=proc
@ ****************************************************************************
@ *             Обработчик прерывания системного таймера SysTick             *
@ ****************************************************************************
@ Прерывание уменьшает значение счетчика SYSTICK_COUNTER на "1" (в случае если
@ значение счетчика больше "0"
@.enddesc

.global IRQ_SysTick

IRQ_SysTick:
          PUSH     { R0 , R1 , LR }
          LDR      R1 , =SYSTICK_COUNTER
          LDR     R0 , [R1 , 0]
          ORRS     R0 , R0 , 0       @ Проверка R0 на 0
          ITT     NE                           @ Если R0<>0 уменьшаем его на 1
          SUBNE     R0 , R0 , 1
          STRNE     R0 , [R1 , 0]
          POP     { R0 , R1 , PC }

@.desc name=SYSTICK_START type=proc
@ ****************************************************************************
@ *                 Инициализация системного таймера SysTick                 *
@ ****************************************************************************
@ Для частоты AHB=168 Мгц
@ Частота счета 1000 Гц
@
@.enddesc

@ Включение SysTick
.global SYSTICK_START

SYSTICK_START:
          PUSH     { R0 , R1 , LR }
          LDR     R0 , =SYSTICK_BASE

     @ установка значения пересчета для получения частоты 1000 гц
          LDR     R1 , =168000 - 1
          STR     R1 , [ R0 , STK_LOAD]

     @ источник частоты AHB (168 мгц) + прерывания + включаем SYSTICK
          LDR     R1 , =(STK_CTRL_CLKSOURSE +  STK_CTRL_TICKINT + STK_CTRL_ENABLE)
          STR     R1 , [ R0 , STK_CTRL]

     @ установка приоритета прерываний от SysTick
          LDR     R0 , =SCB_BASE
          LDR     R1 , [ R0, SHPR3]
          ORR     R1 , R1 , 0x0F << 12
          STR     R1 , [ R0 , SHPR3]

         POP     { R0 , R1 , PC }

@.desc name=SYSTICK_DELAY type=proc
@ ****************************************************************************
@ *             Задержка средствами системного таймера SysTick               *
@ ****************************************************************************
@ Входной параметр: R0 - задержка в милисекундах
@ Выходной параметр: R0 = 0
@ Изменение других регистров: нет
@
@.enddesc

.global SYSTICK_DELAY

SYSTICK_DELAY:
          PUSH      {R1, R2, LR}

          LDR     R2, =SYSTICK_BASE   @ сбросим текущий счетчик
          STR     R0, [R2, STK_VAL]

          LDR      R1, =SYSTICK_COUNTER   @ адрес счетчика
          STR     R0, [R1 , 0]           @ сохраним начальное значение
DELAY_LOOP:
          LDR     R0, [R1 , 0]     @ ждем обнуления счетчика
          ORRS     R0, R0 , 0
          BNE     DELAY_LOOP
          POP      { R1 , R2, PC }
