@.CHARSET CP1251
@ GNU AS

@.desc type=module
@ +------------------------------------------------------------------+
@ |      SET - Настройка тактирования GPIO периферии RCC_AHB1ENR     |
@ +------------------------------------------------------------------+
@ | Модуль настройки тактирования подключенных к AHB1ENR GPIO A-I    |
@ |                                                                  |
@ | Внимание!                                                        |
@ | Происходит полная перезапись регистра RCC_AHB1ENR !              |
@ |                                                                  |
@ | Для использования вставить в исполняемую секцию:                 |
@ |     .include "имя файла модуля"                                  |
@ |                                                                  |
@ | При работе модуля изменяются значения регистров:                 |
@ |    R0, R1                                                        |
@ | Если в изменяемых регистрах важные значение - сохраните   их  на |
@ | стеке до директивы .include и восстановите значения после        |
@ |                                                                  |
@ +------------------------------------------------------------------+
@.enddesc

.equ  GPIOA_EN        , DISABLE  *  RCC_AHB1ENR_GPIOAEN  @ Тактирование GPIO_A
.equ  GPIOB_EN        , ENABLE  *  RCC_AHB1ENR_GPIOBEN  @ Тактирование GPIO_B
.equ  GPIOC_EN        , DISABLE  *  RCC_AHB1ENR_GPIOCEN  @ Тактирование GPIO_C
.equ  GPIOD_EN        , DISABLE  *  RCC_AHB1ENR_GPIODEN  @ Тактирование GPIO_D
.equ  GPIOE_EN        , DISABLE  *  RCC_AHB1ENR_GPIOEEN  @ Тактирование GPIO_E
.equ  GPIOF_EN        , DISABLE  *  RCC_AHB1ENR_GPIOFEN  @ Тактирование GPIO_F
.equ  GPIOG_EN        , DISABLE  *  RCC_AHB1ENR_GPIOGEN  @ Тактирование GPIO_G
.equ  GPIOH_EN        , DISABLE  *  RCC_AHB1ENR_GPIOHEN  @ Тактирование GPIO_H
.equ  GPIOI_EN        , DISABLE  *  RCC_AHB1ENR_GPIOIEN  @ Тактирование GPIO_I

@ --------------------------  дальше настроек нет ----------------------
@.item SWITCH
.equ  ENABLE          , 1 @ включить
.equ  DISABLE         , 0 @ выключить
@.end

@.config GPIOA_EN=SWITCH GPIOB_EN=SWITCH GPIOC_EN=SWITCH GPIOD_EN=SWITCH GPIOE_EN=SWITCH GPIOF_EN=SWITCH GPIOG_EN=SWITCH GPIOH_EN=SWITCH GPIOI_EN=SWITCH
.include         "/src/inc/rcc.inc"

.equ  ahb1enr_v2    , GPIOA_EN+GPIOB_EN+GPIOC_EN+GPIOD_EN+GPIOE_EN+GPIOF_EN+GPIOG_EN+GPIOH_EN+GPIOI_EN

                LDR     R0, =PERIPH_BASE +  RCC_BASE + RCC_AHB1ENR
                LDR     R1, [R0]
                BFC     R1, 0, 9
                ADD     R1, ahb1enr_v2
                STR     R1, [R0]


