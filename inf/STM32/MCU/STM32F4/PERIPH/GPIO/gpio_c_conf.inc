@.CHARSET CP1251
@.desc type=module
@ +------------------------------------------------------------------+
@ |                 Ќастройка порта ввода вывода GPIO C              |
@ +------------------------------------------------------------------+
@ | ƒл€ использовани€ вставить в исполн€емую секцию:                 |
@ |     .include "им€ файла модул€"                                  |
@ |                                                                  |
@ | ѕри работе модул€ измен€ютс€ значени€ регистров:                 |
@ |    R0, R1, R2, R3, R4, R5, R6                                    |
@ | ≈сли в измен€емых регистрах важные значение - сохраните   их  на |
@ | стеке до директивы .include и восстановите значени€ после        |
@ |                                                                  |
@ | ћодуль не включает GPIO порт в подсистеме RCC, сделайте  это при |
@ | помощи соответсвующего модул€ RCC или иным образом               |
@ +------------------------------------------------------------------+
@.enddesc

.include "/src/inc/gpio.inc"

@ настраиваемый порт
.equ     gpio_port      , GPIOC  @ им€ порта дл€ конфигурировани€

@ настройки пинов порта
.EQU     pin0_MODER     , GPIO_MODER_INPUT
.EQU     pin0_AFR       , GPIO_AFR_0_SYS
.EQU     pin0_OTYPER    , GPIO_OTYPER_PP
.EQU     pin0_OSPEEDR   , GPIO_OSPEEDR_LOW_SPEED
.EQU     pin0_PUPDR     , GPIO_PUPDR_NPU_NPD

.EQU     pin1_MODER     , GPIO_MODER_INPUT
.EQU     pin1_AFR       , GPIO_AFR_0_SYS
.EQU     pin1_OTYPER    , GPIO_OTYPER_PP
.EQU     pin1_OSPEEDR   , GPIO_OSPEEDR_LOW_SPEED
.EQU     pin1_PUPDR     , GPIO_PUPDR_NPU_NPD

.EQU     pin2_MODER     , GPIO_MODER_INPUT
.EQU     pin2_AFR       , GPIO_AFR_0_SYS
.EQU     pin2_OTYPER    , GPIO_OTYPER_PP
.EQU     pin2_OSPEEDR   , GPIO_OSPEEDR_LOW_SPEED
.EQU     pin2_PUPDR     , GPIO_PUPDR_NPU_NPD

.EQU     pin3_MODER     , GPIO_MODER_ALT_MODE
.EQU     pin3_AFR       , GPIO_AFR_0_SYS
.EQU     pin3_OTYPER    , GPIO_OTYPER_PP
.EQU     pin3_OSPEEDR   , GPIO_OSPEEDR_LOW_SPEED
.EQU     pin3_PUPDR     , GPIO_PUPDR_NPU_NPD

.EQU     pin4_MODER     , GPIO_MODER_ALT_MODE
.EQU     pin4_AFR       , GPIO_AFR_0_SYS
.EQU     pin4_OTYPER    , GPIO_OTYPER_PP
.EQU     pin4_OSPEEDR   , GPIO_OSPEEDR_LOW_SPEED
.EQU     pin4_PUPDR     , GPIO_PUPDR_NPU_NPD

.EQU     pin5_MODER     , GPIO_MODER_INPUT
.EQU     pin5_AFR       , GPIO_AFR_0_SYS
.EQU     pin5_OTYPER    , GPIO_OTYPER_PP
.EQU     pin5_OSPEEDR   , GPIO_OSPEEDR_LOW_SPEED
.EQU     pin5_PUPDR     , GPIO_PUPDR_NPU_NPD

.EQU     pin6_MODER     , GPIO_MODER_INPUT
.EQU     pin6_AFR       , GPIO_AFR_0_SYS
.EQU     pin6_OTYPER    , GPIO_OTYPER_PP
.EQU     pin6_OSPEEDR   , GPIO_OSPEEDR_LOW_SPEED
.EQU     pin6_PUPDR     , GPIO_PUPDR_NPU_NPD

.EQU     pin7_MODER     , GPIO_MODER_INPUT
.EQU     pin7_AFR       , GPIO_AFR_0_SYS
.EQU     pin7_OTYPER    , GPIO_OTYPER_PP
.EQU     pin7_OSPEEDR   , GPIO_OSPEEDR_LOW_SPEED
.EQU     pin7_PUPDR     , GPIO_PUPDR_NPU_NPD

.EQU     pin8_MODER     , GPIO_MODER_INPUT
.EQU     pin8_AFR       , GPIO_AFR_0_SYS
.EQU     pin8_OTYPER    , GPIO_OTYPER_PP
.EQU     pin8_OSPEEDR   , GPIO_OSPEEDR_LOW_SPEED
.EQU     pin8_PUPDR     , GPIO_PUPDR_NPU_NPD

.EQU     pin9_MODER     , GPIO_MODER_INPUT
.EQU     pin9_AFR       , GPIO_AFR_0_SYS
.EQU     pin9_OTYPER    , GPIO_OTYPER_PP
.EQU     pin9_OSPEEDR   , GPIO_OSPEEDR_LOW_SPEED
.EQU     pin9_PUPDR     , GPIO_PUPDR_NPU_NPD

.EQU     pin10_MODER    , GPIO_MODER_INPUT
.EQU     pin10_AFR      , GPIO_AFR_0_SYS
.EQU     pin10_OTYPER   , GPIO_OTYPER_PP
.EQU     pin10_OSPEEDR  , GPIO_OSPEEDR_LOW_SPEED
.EQU     pin10_PUPDR    , GPIO_PUPDR_NPU_NPD

.EQU     pin11_MODER    , GPIO_MODER_INPUT
.EQU     pin11_AFR      , GPIO_AFR_0_SYS
.EQU     pin11_OTYPER   , GPIO_OTYPER_PP
.EQU     pin11_OSPEEDR  , GPIO_OSPEEDR_LOW_SPEED
.EQU     pin11_PUPDR    , GPIO_PUPDR_NPU_NPD

.EQU     pin12_MODER    , GPIO_MODER_INPUT
.EQU     pin12_AFR      , GPIO_AFR_0_SYS
.EQU     pin12_OTYPER   , GPIO_OTYPER_PP
.EQU     pin12_OSPEEDR  , GPIO_OSPEEDR_LOW_SPEED
.EQU     pin12_PUPDR    , GPIO_PUPDR_NPU_NPD

.EQU     pin13_MODER    , GPIO_MODER_INPUT
.EQU     pin13_AFR      , GPIO_AFR_0_SYS
.EQU     pin13_OTYPER   , GPIO_OTYPER_PP
.EQU     pin13_OSPEEDR  , GPIO_OSPEEDR_LOW_SPEED
.EQU     pin13_PUPDR    , GPIO_PUPDR_NPU_NPD

.EQU     pin14_MODER    , GPIO_MODER_INPUT
.EQU     pin14_AFR      , GPIO_AFR_0_SYS
.EQU     pin14_OTYPER   , GPIO_OTYPER_PP
.EQU     pin14_OSPEEDR  , GPIO_OSPEEDR_LOW_SPEED
.EQU     pin14_PUPDR    , GPIO_PUPDR_NPU_NPD

.EQU     pin15_MODER    , GPIO_MODER_INPUT
.EQU     pin15_AFR      , GPIO_AFR_0_SYS
.EQU     pin15_OTYPER   , GPIO_OTYPER_PP
.EQU     pin15_OSPEEDR  , GPIO_OSPEEDR_LOW_SPEED
.EQU     pin15_PUPDR    , GPIO_PUPDR_NPU_NPD

@.config gpio_port=GPIO
@.config pin0_MODER=GPIO_MODER  pin0_AFR=GPIO_AFRL  pin0_OTYPER=GPIO_OTYPER  pin0_OSPEEDR=GPIO_OSPEEDR  pin0_PUPDR=GPIO_PUPDR
@.config pin1_MODER=GPIO_MODER  pin1_AFR=GPIO_AFRL  pin1_OTYPER=GPIO_OTYPER  pin1_OSPEEDR=GPIO_OSPEEDR  pin1_PUPDR=GPIO_PUPDR
@.config pin2_MODER=GPIO_MODER  pin2_AFR=GPIO_AFRL  pin2_OTYPER=GPIO_OTYPER  pin2_OSPEEDR=GPIO_OSPEEDR  pin2_PUPDR=GPIO_PUPDR
@.config pin3_MODER=GPIO_MODER  pin3_AFR=GPIO_AFRL  pin3_OTYPER=GPIO_OTYPER  pin3_OSPEEDR=GPIO_OSPEEDR  pin3_PUPDR=GPIO_PUPDR
@.config pin4_MODER=GPIO_MODER  pin4_AFR=GPIO_AFRL  pin4_OTYPER=GPIO_OTYPER  pin4_OSPEEDR=GPIO_OSPEEDR  pin4_PUPDR=GPIO_PUPDR
@.config pin5_MODER=GPIO_MODER  pin5_AFR=GPIO_AFRL  pin5_OTYPER=GPIO_OTYPER  pin5_OSPEEDR=GPIO_OSPEEDR  pin5_PUPDR=GPIO_PUPDR
@.config pin6_MODER=GPIO_MODER  pin6_AFR=GPIO_AFRL  pin6_OTYPER=GPIO_OTYPER  pin6_OSPEEDR=GPIO_OSPEEDR  pin6_PUPDR=GPIO_PUPDR
@.config pin7_MODER=GPIO_MODER  pin7_AFR=GPIO_AFRL  pin7_OTYPER=GPIO_OTYPER  pin7_OSPEEDR=GPIO_OSPEEDR  pin7_PUPDR=GPIO_PUPDR
@.config pin8_MODER=GPIO_MODER  pin8_AFR=GPIO_AFRH  pin8_OTYPER=GPIO_OTYPER  pin8_OSPEEDR=GPIO_OSPEEDR  pin8_PUPDR=GPIO_PUPDR
@.config pin9_MODER=GPIO_MODER  pin9_AFR=GPIO_AFRH  pin9_OTYPER=GPIO_OTYPER  pin9_OSPEEDR=GPIO_OSPEEDR  pin9_PUPDR=GPIO_PUPDR
@.config pin10_MODER=GPIO_MODER pin10_AFR=GPIO_AFRH pin10_OTYPER=GPIO_OTYPER pin10_OSPEEDR=GPIO_OSPEEDR pin10_PUPDR=GPIO_PUPDR
@.config pin11_MODER=GPIO_MODER pin11_AFR=GPIO_AFRH pin11_OTYPER=GPIO_OTYPER pin11_OSPEEDR=GPIO_OSPEEDR pin11_PUPDR=GPIO_PUPDR
@.config pin12_MODER=GPIO_MODER pin12_AFR=GPIO_AFRH pin12_OTYPER=GPIO_OTYPER pin12_OSPEEDR=GPIO_OSPEEDR pin12_PUPDR=GPIO_PUPDR
@.config pin13_MODER=GPIO_MODER pin13_AFR=GPIO_AFRH pin13_OTYPER=GPIO_OTYPER pin13_OSPEEDR=GPIO_OSPEEDR pin13_PUPDR=GPIO_PUPDR
@.config pin14_MODER=GPIO_MODER pin14_AFR=GPIO_AFRH pin14_OTYPER=GPIO_OTYPER pin14_OSPEEDR=GPIO_OSPEEDR pin14_PUPDR=GPIO_PUPDR
@.config pin15_MODER=GPIO_MODER pin15_AFR=GPIO_AFRH pin15_OTYPER=GPIO_OTYPER pin15_OSPEEDR=GPIO_OSPEEDR pin15_PUPDR=GPIO_PUPDR

                LDR     R0, =gpio_port
                LDR     R1, =pin0_MODER + pin1_MODER<<2 + pin2_MODER<<4 + pin3_MODER<<6 + pin4_MODER<<8 + pin5_MODER<<10 + pin6_MODER<<12 + pin7_MODER<<14 + pin8_MODER<<16 + pin9_MODER<<18 + pin10_MODER<<20 + pin11_MODER<<22 + pin12_MODER<<24 + pin13_MODER<<26 + pin14_MODER<<28 + pin15_MODER<<30
                LDR     R2, =pin0_OTYPER + pin1_OTYPER<<1 + pin2_OTYPER<<2 + pin3_OTYPER<<3 + pin4_OTYPER<<4 + pin5_OTYPER<<5 + pin6_OTYPER<<6 + pin7_OTYPER<<7 + pin8_OTYPER<<8 + pin9_OTYPER<<9 + pin10_OTYPER<<10 + pin11_OTYPER<<11 + pin12_OTYPER<<12 + pin13_OTYPER<<13 + pin14_OTYPER<<14 + pin15_OTYPER<<15
                LDR     R3, =pin0_OSPEEDR + pin1_OSPEEDR<<2 + pin2_OSPEEDR<<4 + pin3_OSPEEDR<<6 + pin4_OSPEEDR<<8 + pin5_OSPEEDR<<10 + pin6_OSPEEDR<<12 + pin7_OSPEEDR<<14 + pin8_OSPEEDR<<16 + pin9_OSPEEDR<<18 + pin10_OSPEEDR<<20 + pin11_OSPEEDR<<22 + pin12_OSPEEDR<<24 + pin13_OSPEEDR<<26 + pin14_OSPEEDR<<28 + pin15_OSPEEDR<<30
                LDR     R4, =pin0_PUPDR + pin1_PUPDR<<2 + pin2_PUPDR<<4 + pin3_PUPDR<<6 + pin4_PUPDR<<8 + pin5_PUPDR<<10 + pin6_PUPDR<<12 + pin7_PUPDR<<14 + pin8_PUPDR<<16 + pin9_PUPDR<<18 + pin10_PUPDR<<20 + pin11_PUPDR<<22 + pin12_PUPDR<<24 + pin13_PUPDR<<26 + pin14_PUPDR<<28 + pin15_PUPDR<<30
                LDR     R5, =pin0_AFR + pin1_AFR<<4 + pin2_AFR<<8 + pin3_AFR<<12 + pin4_AFR<<16 + pin5_AFR<<20 + pin6_AFR<<24 + pin7_AFR<<28
                LDR     R6, =pin8_AFR + pin9_AFR<<4 + pin10_AFR<<8 + pin11_AFR<<12 + pin12_AFR<<16 + pin13_AFR<<20 + pin14_AFR<<24 + pin15_AFR<<28
                BL      GPIO_SET_CONFIG  @ установим конфигурацию

