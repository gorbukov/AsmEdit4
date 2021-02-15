@.CHARSET  CP1251

.INCLUDE  "/src/inc/gpio.inc"

@ GNU AS
.SYNTAX unified
.CPU    cortex-m4
.THUMB
.FPU    fpv4-sp-d16

.SECTION .asmcode
@.DESC     name=GPIO_SET_CONFIG type=proc
@ ****************************************************************************
@ *       —охранение конфигурации GPIO из регистров микроконтроллера в       *
@ * регистры настройки GPIO. ¬ходные значени€ регистров не измен€ютс€        *
@ ****************************************************************************
@.ENDDESC

.GLOBAL GPIO_SET_CONFIG
GPIO_SET_CONFIG:
                         STR         R1, [ R0, GPIO_MODER ]
                         STR         R2, [ R0, GPIO_OTYPER ]
                         STR         R3, [ R0, GPIO_OSPEEDR ]
                         STR         R4, [ R0, GPIO_PUPDR ]
                         STR         R5, [ R0, GPIO_AFRL ]
                         STR         R6, [ R0, GPIO_AFRH ]
                         BX          LR
