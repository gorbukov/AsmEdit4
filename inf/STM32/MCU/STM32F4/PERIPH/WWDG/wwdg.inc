@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                     Базовые константы WWDG
@ |RM0090      Section 22.6.4: WWDG register map on page 719
@ +------------------------------------------------------------------+
@.enddesc

.include   "/src/inc/base.inc"

@.item     APB1PERIPH_BASE
.equ  WWDG_BASE          , APB1PERIPH_BASE + 0x2C00
.equ  WWDG               , PERIPH_BASE + WWDG_BASE


@.item    WWDG_BASE
.equ WWDG_CR, 0x00 @ WWDG Control register
.equ WWDG_CFR, 0x04 @ WWDG Configuration register
.equ WWDG_SR, 0x08 @ WWDG Status register

@.item     WWDG_CR
.equ  WWDG_CR_WDGA       , 1 << 7    @Bit 7 WDGA: Activation bit
.equ  WWDG_CR_T          , 0x7F    @Bits 6:0 T[6:0]: 7-bit counter (MSB to LSB)
.equ  WWDG_CR_T0         , 0x01    @Bit 0
.equ  WWDG_CR_T1         , 0x02    @Bit 1
.equ  WWDG_CR_T2         , 0x04    @Bit 2
.equ  WWDG_CR_T3         , 0x08    @Bit 3
.equ  WWDG_CR_T4         , 1 << 4    @Bit 4
.equ  WWDG_CR_T5         , 1 << 5    @Bit 5
.equ  WWDG_CR_T6         , 1 << 6    @Bit 6

@.item     WWDG_CFR
.equ  WWDG_CFR_EWI       , 0x0200    @Bit 9 EWI: Early wakeup interrupt
.equ  WWDG_CFR_WDGTB     , 0x0180    @Bits 8:7 WDGTB[1:0]: Timer base
.equ  WWDG_CFR_WDGTB_N   , 7
.equ  WWDG_CFR_WDGTB1    , 1 << 8    @Bit 1
.equ  WWDG_CFR_WDGTB0    , 1 << 7    @Bit 0
.equ  WWDG_CFR_W         , 0x7F    @Bits 6:0 W[6:0]: 7-bit window value
.equ  WWDG_CFR_W6        , 1 << 6    @Bit 6
.equ  WWDG_CFR_W5        , 1 << 5    @Bit 5
.equ  WWDG_CFR_W4        , 1 << 4    @Bit 4
.equ  WWDG_CFR_W3        , 0x0008    @Bit 3
.equ  WWDG_CFR_W1        , 0x0002    @Bit 1
.equ  WWDG_CFR_W0        , 0x0001    @Bit 0

@.item     WWDG_SR
.equ WWDG_SR_EWIF, 0x01 @Bit 0 EWIF: Early wakeup interrupt flag

