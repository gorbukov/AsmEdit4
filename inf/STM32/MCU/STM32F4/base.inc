@GNU AS
@.CHARSET =CP1251 ( Cyrillic )
@.DESC     type=module
@ +------------------------------------------------------------------+
@ |                Базовые константы микроконтроллера                |
@ +------------------------------------------------------------------+
@.ENDDESC

@ базовые константы микроконтроллера

@.ITEM     STM32F4
.EQU  FLASH_BASE         , 0x08000000                        @ Адрес Flash
.EQU  CCMDATARAM         , 0
.EQU  SRAM_BASE          , 0x20000000                        @ Адрес SRAM
.EQU  PERIPH             , 0                                 @ Регистры настройки периферии микроконтроллера
.EQU  BKPSRAM            , 0
.EQU  FSMC_BASE          , 0xA0000000
.EQU  CORE               , 0                                 @ Регистры настройки устройств ядра микроконтроллера
@.END

@.ITEM     CCMDATARAM
.EQU  CCMDATARAM_BASE    , 0x10000000
.EQU  CCMDATARAM_BB_BASE , 0x12000000
@.END


@.ITEM     BKPSRAM
.EQU  BKPSRAM_BASE       , 0x40024000
.EQU  BKPSRAM_BB_BASE    , 0x42024000
@.END


@.ITEM     PERIPH
.EQU  PERIPH_BASE        , 0x40000000
.EQU  PERIPH_BB_BASE     , 0x42000000
.EQU  APB1PERIPH_BASE    , 0x00000000
.EQU  APB2PERIPH_BASE    , 0x00010000
.EQU  AHB1PERIPH_BASE    , 0x00020000
@.END


@.ITEM     CORE
.EQU  CORE_BASE          , 0xE0000000
.EQU  SYSTICK_BASE       , 0xE000E010
.EQU  NVIC1_BASE         , 0xE000E100
.EQU  SCB_BASE           , 0xE000ED00
.EQU  FPU_ACC_BASE       , 0xE000ED88
.EQU  MEMPROTECT_BASE    , 0xE000ED90
.EQU  NVIC2_BASE         , 0xE000EF00
.EQU  FPU_BASE           , 0xE000EF30
@.END


@.ITEM     SRAM_BASE
.EQU  SRAM1_BASE         , 0x20000000
.EQU  SRAM2_BASE         , 0x2001C000
.EQU  SRAM1_BB_BASE      , 0x22000000
.EQU  SRAM2_BB_BASE      , 0x2201C000
@.END
