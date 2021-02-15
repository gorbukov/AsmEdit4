@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                     Базовые константы PWR                        |
@ +------------------------------------------------------------------+
@.enddesc


.include "/src/inc/base.inc"

@.item APB1PERIPH_BASE
.equ PWR_BASE            , (APB1PERIPH_BASE + 0x7000)
@.end

@.item PWR_BASE
.equ PWR_CR              , 0x00
.equ PWR_CSR             , 0x04
@.end

@.item PWR_CR
.equ PWR_CR_RST_VAL      , 0x00000000 @ значение по умолчанию
.equ PWR_CR_LPDS         , 0x01       @
.equ PWR_CR_PDDS         , 0x02       @ Enter Standby mode when the CPU enters Deepsleep
.equ PWR_CR_CWUF         , 0x04       @ Clear WUF Wakeup Flag after 2 system clock cycles
.equ PWR_CR_CSBF         , 0x08       @ Clear CSBF Standby Flag
.equ PWR_CR_PVDE         , 0x10       @ PVD Enabled
.EQU  PWR_CR_PLS_2D0V    , 0 << 5     @ 2.2 v
.EQU  PWR_CR_PLS_2D1V    , 1 << 5     @ 2.3 v
.equ PWR_CR_PLS_2D3V     , 2<<5       @ 2.4 v
.equ PWR_CR_PLS_2D5V     , 3<<5       @ 2.5 v
.equ PWR_CR_PLS_2D6V     , 4<<5       @ 2.6 v
.equ PWR_CR_PLS_2D7V     , 5<<5       @ 2.7 v
.equ PWR_CR_PLS_2D8V     , 6<<5       @ 2.8 v
.equ PWR_CR_PLS_2D9V     , 7<<5       @ 2.9 v
.equ PWR_CR_DBP          , 0x01<<8
@.end

@.item PWR_CSR
.EQU  PWR_CSR_RST_VAL    , 0x00000000                        @ значение по умолчанию
.EQU  PWR_CSR_EWUP       , 0x01 << 8
.equ PWR_CSR_PVDO        , 0x01<<2
.equ PWR_CSR_SBF         , 0x01<<1
.equ PWR_CSR_WUF         , 0x01
@.end
