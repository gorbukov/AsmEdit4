@GNU AS
@.CHARSET =CP1251 ( Cyrillic )
@.DESC     type=module
@ +------------------------------------------------------------------+
@ |                     Базовые константы PWR                        |
@ +------------------------------------------------------------------+
@.ENDDESC


.INCLUDE  "/src/inc/base.inc"

@.ITEM     APB1PERIPH_BASE
.EQU  PWR_BASE                      , ( APB1PERIPH_BASE + 0x7000 )
@.END

@.ITEM     PWR_BASE
.EQU  PWR_CR                        , 0x00
.EQU  PWR_CSR                       , 0x04
@.END

@.ITEM     PWR_CR
.EQU  PWR_CR_RST_VAL                , 0x00004000             @ значение по умолчанию
.EQU  PWR_CR_LPDS                   , 0x01
.EQU  PWR_CR_PDDS                   , 0x02
.EQU  PWR_CR_CWUF                   , 0x04
.EQU  PWR_CR_CSBF                   , 0x08
.EQU  PWR_CR_PVDE                   , 0x10
.EQU  PWR_CR_PLS_2D0V               , 0 << 5
.EQU  PWR_CR_PLS_2D1V               , 1 << 5
.EQU  PWR_CR_PLS_2D3V               , 2 << 5
.EQU  PWR_CR_PLS_2D5V               , 3 << 5
.EQU  PWR_CR_PLS_2D6V               , 4 << 5
.EQU  PWR_CR_PLS_2D7V               , 5 << 5
.EQU  PWR_CR_PLS_2D8V               , 6 << 5
.EQU  PWR_CR_PLS_2D9V               , 7 << 5
.EQU  PWR_CR_DBP                    , 0x01 << 8
.EQU  PWR_CR_FPDS                   , 0x01 << 9
.EQU  PWR_CR_VOS                    , 0x01 << 14
@.END

@.ITEM     PWR_CSR
.EQU  PWR_CSR_VOSRDY                , 0x01 << 14
.EQU  PWR_CSR_BRE                   , 0x01 << 9
.EQU  PWR_CSR_EWUP                  , 0x01 << 8
.EQU  PWR_CSR_BRR                   , 0x01 << 3
.EQU  PWR_CSR_PVDO                  , 0x01 << 2
.EQU  PWR_CSR_SBF                   , 0x01 << 1
.EQU  PWR_CSR_WUF                   , 0x01
@.END
