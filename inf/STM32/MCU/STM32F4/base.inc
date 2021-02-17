@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                Базовые константы микроконтроллера                |
@ +------------------------------------------------------------------+
@.enddesc

@ базовые константы микроконтроллера

@.item STM32F4
.equ FLASH_BASE            ,0x08000000 @ Адрес Flash
.equ CCMDATARAM            ,0
.equ SRAM_BASE             ,0x20000000 @ Адрес SRAM
.equ PERIPH                ,0          @ Регистры настройки периферии микроконтроллера
.equ BKPSRAM               ,0
.equ FSMC_R_BASE           ,0xA0000000
.equ CORE                  ,0          @ Регистры настройки устройств ядра микроконтроллера
@.end

@.item CCMDATARAM
.equ CCMDATARAM_BASE       ,0x10000000
.equ CCMDATARAM_BB_BASE    ,0x12000000
@.end


@.item BKPSRAM
.equ BKPSRAM_BASE          ,0x40024000
.equ BKPSRAM_BB_BASE       ,0x42024000
@.end


@.item PERIPH
.equ PERIPH_BASE           ,0x40000000
.equ PERIPH_BB_BASE        ,0x42000000
.equ APB1PERIPH_BASE       ,0x00000000
.equ APB2PERIPH_BASE       ,0x00010000
.equ AHB1PERIPH_BASE       ,0x00020000
.equ AHB2PERIPH_BASE       ,0x10000000
@.end


@.item CORE
.equ CORE_BASE             ,0xE0000000
.equ SYSTICK_BASE          ,0xE000E010
.equ NVIC1_BASE            ,0xE000E100
.equ SCB_BASE              ,0xE000ED00
.equ FPU_ACC_BASE          ,0xE000ED88
.equ MEMPROTECT_BASE       ,0xE000ED90
.equ NVIC2_BASE            ,0xE000EF00
.equ FPU_BASE              ,0xE000EF30
@.end


@.item SRAM_BASE
.equ SRAM1_BASE            ,0x20000000
.equ SRAM2_BASE            ,0x2001C000
.equ SRAM1_BB_BASE         ,0x22000000
.equ SRAM2_BB_BASE         ,0x2201C000
@.end
