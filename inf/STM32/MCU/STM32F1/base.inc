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
.equ SRAM_BASE             ,0x20000000 @ Адрес SRAM
.equ PERIPH_BASE           ,0x40000000 @ Регистры настройки периферии микроконтроллера
.equ FSMC_R_BASE           ,0xA0000000
.equ CORE_BASE             ,0xE0000000 @ Регистры настройки устройств ядра микроконтроллера
@.end


@.item PERIPH_BASE
.equ PERIPH_BB_BASE        ,0x02000000
.equ APB1PERIPH_BASE       ,0x00000000
.equ APB2PERIPH_BASE       ,0x00010000
.equ AHBPERIPH_BASE        ,0x00020000
@.end


@.item CORE_BASE
.equ SYSTICK_BASE          ,0x0000E010
.equ NVIC1_BASE            ,0x0000E100
.equ SCB_BASE              ,0x0000ED00
.equ MEMPROTECT_BASE       ,0x0000ED90
.equ NVIC2_BASE            ,0x0000EF00
@.end


@.item SRAM_BASE
.equ SRAM_BB_BASE         ,0x02000000
@.end
