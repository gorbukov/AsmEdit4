@GNU AS
@.CHARSET =CP1251 ( Cyrillic )
@.DESC     type=module
@ +------------------------------------------------------------------+
@ |                Базовые константы микроконтроллера                |
@ +------------------------------------------------------------------+
@.ENDDESC

@ базовые константы микроконтроллера 1921ВК035

@.ITEM     STM32F4
.EQU  FLASH_BASE     , 0x00000000                  @ Адрес Flash
.EQU  SRAM_BASE      , 0x20000000                  @ Адрес SRAM
.EQU  PERIPH         , 0                           @ Регистры настройки периферии микроконтроллера
.EQU  CORE           , 0                           @ Регистры настройки устройств ядра микроконтроллера
@.END

@.ITEM     PERIPH
.EQU  PERIPH_BASE    , 0x40000000
.EQU  ADC_BASE       , 0x40000000
.EQU  GPIOA_BASE     , 0x40010000
.EQU  GPIOB_BASE     , 0x40011000
.EQU  CAN_BASE       , 0x40020000
.EQU  MFLASH_BASE    , 0x40030000
.EQU  SIU_BASE       , 0x40040000
.EQU  RCU_BASE       , 0x40041000
.EQU  PMU_BASE       , 0x40042000
.EQU  WDT_BASE       , 0x40043000
.EQU  DMA_BASE       , 0x40044000
.EQU  UART0_BASE     , 0x40045000
.EQU  UART1_BASE     , 0x40046000
.EQU  SPI_BASE       , 0x40047000
.EQU  TMR0_BASE      , 0x40048000
.EQU  TMR1_BASE      , 0x40049000
.EQU  TMR2_BASE      , 0x4004A000
.EQU  TMR3_BASE      , 0x4004B000
.EQU  PWM0_BASE      , 0x4004C000
.EQU  PWM1_BASE      , 0x4004D000
.EQU  PWM2_BASE      , 0x4004E000
.EQU  QEP_BASE       , 0x4004F000
.EQU  I2C_BASE       , 0x40050000
.EQU  ESCAP0_BASE    , 0x40051000
.EQU  ESCAP1_BASE    , 0x40052000
.EQU  ESCAP2_BASE    , 0x40053000

@.ITEM     CORE
.EQU  CORE_BASE          , 0xE0000000
.EQU  SYSTICK_BASE       , 0xE000E010
.EQU  NVIC1_BASE         , 0xE000E100
.EQU  SCB_BASE           , 0xE000ED00
.EQU  FPU_ACC_BASE       , 0xE000ED88
.EQU  MEMPROTECT_BASE    , 0xE000ED90
.EQU  NVIC2_BASE         , 0xE000EF00
.EQU  FPU_BASE           , 0xE000EF30

