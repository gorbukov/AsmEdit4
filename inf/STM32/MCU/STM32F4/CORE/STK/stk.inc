@GNU AS
@.CharSet=CP1251 (Cyrillic)

@.desc type=module
@ +------------------------------------------------------------------+
@ |                    Константы таймера SysTick                     |
@ +------------------------------------------------------------------+
@.enddesc

@.item CORE
.equ STK_BASE         , 0xE000E010 @ SysTick (STK)

@.item STK_BASE
.equ STK_CTRL         , 0x00 @ SysTick control and status register (STK_CTRL)
.equ STK_LOAD         , 0x04 @ SysTick reload value register (STK_LOAD)
.equ STK_VAL          , 0x08 @ SysTick current value register (STK_VAL)
.equ STK_CALIB        , 0x0C @ SysTick ca libration va lue register (STK_CALIB)

@.item STK_CTRL
.equ STK_CTRL_ENABLE_N        , 0 @ Bit 0 ENABLE: Counter enable
.equ STK_CTRL_ENABLE          , 1
.equ STK_CTRL_TICKINT_N       , 1 @ Bit 1 TICKINT: SysTick exception request enable
.equ STK_CTRL_TICKINT         , 1<<1
.equ STK_CTRL_CLKSOURCE_N     , 2 @ Bit 2 CLKSOURCE: Clock source selection
.equ STK_CTRL_CLKSOURCE       , 1<<2 @ Processor clock (AHB)
.equ STK_CTRL_COUNTFLAG_N     , 16 @ Bit 16 COUNTFLAG:
.equ STK_CTRL_COUNTFLAG       , 1<<16

@.item STK_CALIB
.equ STK_CALIB_TENMS_N        , 0  @ Bits 23:0 TENMS[23:0]: Calibration value.
.equ STK_CALIB_SKEW_N         , 30 @ Bit 30 SKEW flag: Indicates whether the TENMS value is exact. Reads as one.
.equ STK_CALIB_SKEW           , 1<<30
.equ STK_CALIB_NOREF_N        , 31 @ Bit 31 NOREF flag. Reads as zero. Indicates that a separate reference clock is provided
.equ STK_CALIB_NOREF          , 1<<31

