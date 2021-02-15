@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                     Базовые константы BKP                        |
@ +------------------------------------------------------------------+
@.enddesc


.include "/src/inc/base.inc"

@.item APB1PERIPH_BASE
.EQU  BKP_BASE           , ( APB1PERIPH_BASE + 0x6C00 )
@.end

@.ITEM     PWR_BASE
.EQU  BKP_DR1            , 0x04
.EQU  BKP_DR2            , 0x08
.EQU  BKP_DR3            , 0x0C
.EQU  BKP_DR4            , 0x10
.EQU  BKP_DR5            , 0x14
.EQU  BKP_DR6            , 0x18
.EQU  BKP_DR7            , 0x1C
.EQU  BKP_DR8            , 0x20
.EQU  BKP_DR9            , 0x24
.EQU  BKP_DR10           , 0x28
.EQU  BKP_RTCCR          , 0x2C
.EQU  BKP_CR             , 0x30
.EQU  BKP_CSR            , 0x34
@.end

@.ITEM     BKP_RTCCR
.EQU  BKP_RTCCR_RST_VAL  , 0x00000000
.EQU  BKP_RTCCR_ASOS     , 1 << 9
.EQU  BKP_RTCCR_ASOE     , 1 << 8
.EQU  BKP_RTCCR_CCO      , 1 << 7
.EQU  BKP_RTCCR_CAL_MSK  , 0X7F
@.end

@.ITEM     BKP_CR
.EQU  BKP_CR_TPAL        , 0X02
.EQU  BKP_CR_TPE         , 0x01
@.end

@.ITEM     BKP_CSR
.EQU  BKP_CR_TIF         , 1 << 9
.EQU  BKP_CR_TEF         , 1 << 8
.EQU  BKP_CR_TPIE        , 1 << 2
.EQU  BKP_CR_CTI         , 1 << 1
.EQU  BKP_CR_CTE         , 1
@.end



