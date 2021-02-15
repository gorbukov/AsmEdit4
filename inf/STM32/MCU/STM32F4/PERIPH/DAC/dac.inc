@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                         константы DAC                        |
@ +------------------------------------------------------------------+
@.enddesc

.include "/src/inc/base.inc"

@ константы DAC
@.item     APB1PERIPH_BASE
.equ  DAC_BASE           , APB1PERIPH_BASE + 0x7400
.equ  DAC                , PERIPH_BASE + DAC_BASE
.equ  DAC_BB             , PERIPH_BB_BASE + DAC_BASE

@.item    DAC_BASE
.equ  DAC_CR             , 0x00    @ DAC control register
.equ  DAC_SWTRIGR        , 0x04    @ DAC software trigger register
.equ  DAC_DHR12R1        , 0x08    @ DAC channel1 12-bit right-aligned data holding register
.equ  DAC_DHR12L1        , 0x0C    @ DAC channel1 12-bit left aligned data holding register
.equ  DAC_DHR8R1         , 0x10    @ DAC channel1 8-bit right aligned data holding register
.equ  DAC_DHR12R2        , 0x14    @ DAC channel2 12-bit right aligned data holding register
.equ  DAC_DHR12L2        , 0x18    @ DAC channel2 12-bit left aligned data holding register
.equ  DAC_DHR8R2         , 0x1C    @ DAC channel2 8-bit right-aligned data holding register
.equ  DAC_DHR12RD        , 0x20    @ Dual DAC 12-bit right-aligned data holding register
.equ  DAC_DHR12LD        , 0x24    @ DUAL DAC 12-bit left aligned data holding register
.equ  DAC_DHR8RD         , 0x28    @ DUAL DAC 8-bit right aligned data holding register
.equ  DAC_DOR1           , 0x2C    @ DAC channel1 data output register
.equ  DAC_DOR2           , 0x30    @ DAC channel2 data output register
.equ  DAC_SR             , 0x34    @ DAC status register

@ Описание битов настройки регистра  DAC_CR
@.item     DAC_CR
.equ  DAC_CR_EN1         , 0x00000001    @DAC channel1 enable
.equ  DAC_CR_BOFF1       , 0x00000002    @DAC channel1 output buffer disable
.equ  DAC_CR_TEN1        , 0x00000004    @DAC channel1 Trigger enable
.equ  DAC_CR_TSEL1       , 0x00000038    @TSEL1[2:0] (DAC channel1 Trigger selection)
.equ  DAC_CR_TSEL1_0     , 0x00000008    @Bit 0
.equ  DAC_CR_TSEL1_1     , 0x00000010    @Bit 1
.equ  DAC_CR_TSEL1_2     , 0x00000020    @Bit 2
.equ  DAC_CR_WAVE1       , 0x000000C0    @WAVE1[1:0] (DAC channel1 noise/triangle wave generation enable)
.equ  DAC_CR_WAVE1_0     , 0x00000040    @Bit 0
.equ  DAC_CR_WAVE1_1     , 0x00000080    @Bit 1
.equ  DAC_CR_MAMP1       , 0x00000F00    @MAMP1[3:0] (DAC channel1 Mask/Amplitude selector)
.equ  DAC_CR_MAMP1_0     , 0x00000100    @Bit 0
.equ  DAC_CR_MAMP1_1     , 0x00000200    @Bit 1
.equ  DAC_CR_MAMP1_2     , 0x00000400    @Bit 2
.equ  DAC_CR_MAMP1_3     , 0x00000800    @Bit 3
.equ  DAC_CR_DMAEN1      , 0x00001000    @DAC channel1 DMA enable
.equ  DAC_CR_EN2         , 0x00010000    @DAC channel2 enable
.equ  DAC_CR_BOFF2       , 0x00020000    @DAC channel2 output buffer disable
.equ  DAC_CR_TEN2        , 0x00040000    @DAC channel2 Trigger enable
.equ  DAC_CR_TSEL2       , 0x00380000    @TSEL2[2:0] (DAC channel2 Trigger selection)
.equ  DAC_CR_TSEL2_0     , 0x00080000    @Bit 0
.equ  DAC_CR_TSEL2_1     , 0x00100000    @Bit 1
.equ  DAC_CR_TSEL2_2     , 0x00200000    @Bit 2
.equ  DAC_CR_WAVE2       , 0x00C00000    @WAVE2[1:0] (DAC channel2 noise/triangle wave generation enable)
.equ  DAC_CR_WAVE2_0     , 0x00400000    @Bit 0
.equ  DAC_CR_WAVE2_1     , 0x00800000    @Bit 1
.equ  DAC_CR_MAMP2       , 0x0F000000    @MAMP2[3:0] (DAC channel2 Mask/Amplitude selector)
.equ  DAC_CR_MAMP2_0     , 0x01000000    @Bit 0
.equ  DAC_CR_MAMP2_1     , 0x02000000    @Bit 1
.equ  DAC_CR_MAMP2_2     , 0x04000000    @Bit 2
.equ  DAC_CR_MAMP2_3     , 0x08000000    @Bit 3
.equ  DAC_CR_DMAEN2      , 0x10000000    @DAC channel2 DMA enabled


@ +------------------------------------------------------------------+
@ |                       Описание битов настройки регистров                   |
@ +------------------------------------------------------------------+

@.ITEM     DAC_SWTRIGR
.equ  DAC_SWTRIGR_SWTRIG1, 0x01    @DAC channel1 software trigger  enabled
.equ  DAC_SWTRIGR_SWTRIG2, 0x02    @DAC channel2 Software trigger enabled

@.item     DAC_DHR12R1
.equ DAC_DHR12R1_DACC1DHR, 0x0FFF @DAC channel1 12-bit Right aligned data

@.item     DAC_DHR12L1
.equ DAC_DHR12L1_DACC1DHR, 0xFFF0 @DAC channel1 12-bit Left aligned data

@.ITEM     DAC_DHR8R1
.EQU  DAC_DHR8R1_DACC1DHR, 0xFF                              @DAC channel1 8-bit Right aligned data

@.ITEM     DAC_DHR12R2
.EQU  DAC_DHR12R2_DACC2DHR, 0x0FFF                           @DAC channel2 12-bit Right aligned data

@.ITEM     DAC_DHR12L2
.equ DAC_DHR12L2_DACC2DHR, 0xFFF0 @DAC channel2 12-bit Left aligned data

@.item     DAC_DHR8R2
.equ DAC_DHR8R2_DACC2DHR, 0xFF @DAC channel2 8-bit Right aligned data

@.item     DAC_DHR12RD
.equ DAC_DHR12RD_DACC1DHR, 0x00000FFF @DAC channel1 12-bit Right aligned data
.equ DAC_DHR12RD_DACC2DHR, 0x0FFF0000 @DAC channel2 12-bit Right aligned data

@.item     DAC_DHR12LD
.equ DAC_DHR12LD_DACC1DHR, 0x0000FFF0 @DAC channel1 12-bit Left aligned data
.equ DAC_DHR12LD_DACC2DHR, 0xFFF00000 @DAC channel2 12-bit Left aligned data

@.item     DAC_DHR8RD
.equ DAC_DHR8RD_DACC1DHR, 0x00FF @DAC channel1 8-bit Right aligned data
.equ DAC_DHR8RD_DACC2DHR, 0xFF00 @DAC channel2 8-bit Right aligned data

@.item     DAC_DOR1
.equ DAC_DOR1_DACC1DOR, 0x0FFF @DAC channel1 data output

@.item     DAC_DOR2
.equ DAC_DOR2_DACC2DOR, 0x0FFF @DAC channel2 data output

@.item     DAC_SR
.equ DAC_SR_DMAUDR1, 0x00002000 @DAC channel1 DMA underrun flag
.equ DAC_SR_DMAUDR2, 0x20000000 @DAC channel2 DMA underrun flag


