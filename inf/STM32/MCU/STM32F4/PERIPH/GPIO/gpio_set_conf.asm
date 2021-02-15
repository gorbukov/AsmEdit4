@.CHARSET CP1251

.include  "/src/inc/gpio.inc"

@ GNU AS
.syntax unified
.cpu cortex-m4
.thumb
.fpu fpv4-sp-d16

.section .asmcode
@.desc name=GPIO_SET_CONFIG type=proc
@ ****************************************************************************
@ *       —охранение конфигурации GPIO из регистров микроконтроллера в       *
@ * регистры настройки GPIO. ¬ходные значени€ регистров не измен€ютс€        *
@ ****************************************************************************
@.enddesc

.global GPIO_SET_CONFIG
GPIO_SET_CONFIG:
        STR     R1, [R0, GPIO_MODER]
        STR     R2, [R0, GPIO_OTYPER]
        STR     R3, [R0, GPIO_OSPEEDR]
        STR     R4, [R0, GPIO_PUPDR]
        STR     R5, [R0, GPIO_AFRL]
        STR     R6, [R0, GPIO_AFRH]
        BX      LR
