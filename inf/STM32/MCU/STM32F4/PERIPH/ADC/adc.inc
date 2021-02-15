@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                     Базовые константы ADC                       |
@ +------------------------------------------------------------------+
@.enddesc

.include "/src/inc/base.inc"

@.ITEM     APB2PERIPH_BASE
.equ ADC1_BASE, APB2PERIPH_BASE + 0x2000
.equ ADC2_BASE, APB2PERIPH_BASE + 0x2100
.EQU  ADC3_BASE          , APB2PERIPH_BASE + 0x2200
.EQU  ADC1               , PERIPH_BASE + ADC1_BASE
.EQU  ADC2               , PERIPH_BASE + ADC2_BASE
.EQU  ADC3               , PERIPH_BASE + ADC3_BASE

@.item  ADC1_BASE    ADC2_BASE     ADC3_BASE
.equ ADC_SR, 0x00 @ ADC status register
.equ ADC_CR1, 0x04 @ ADC control register 1
.equ ADC_CR2, 0x08 @ ADC control register 2
.equ ADC_SMPR1, 0x0C @ ADC sample time register 1
.equ ADC_SMPR2, 0x10 @ ADC sample time register 2
.equ ADC_JOFR1, 0x14 @ ADC injected channel data offset register 1
.equ ADC_JOFR2, 0x18 @ ADC injected channel data offset register 2
.equ ADC_JOFR3, 0x1C @ ADC injected channel data offset register 3
.equ ADC_JOFR4, 0x20 @ ADC injected channel data offset register 4
.equ ADC_HTR, 0x24 @ ADC watchdog higher threshold register
.equ ADC_LTR, 0x28 @ ADC watchdog lower threshold register
.equ ADC_SQR1, 0x2C @ ADC regular sequence register 1
.equ ADC_SQR2, 0x30 @ ADC regular sequence register 2
.equ ADC_SQR3, 0x34 @ ADC regular sequence register 3
.equ ADC_JSQR, 0x38 @ ADC injected sequence register
.equ ADC_JDR1, 0x3C @ ADC injected data register 1
.equ ADC_JDR2, 0x40 @ ADC injected data register 2
.equ ADC_JDR3, 0x44 @ ADC injected data register 3
.equ ADC_JDR4, 0x48 @ ADC injected data register 4
.equ ADC_DR, 0x4C @ ADC regular data register
.equ ADC_CSR, 0x0300 @ ADC Common status register
.equ ADC_CCR, 0x0304 @ ADC common control register
.equ ADC_CDR, 0x0308 @ ADC common regular data register for dual AND triple modes

@****************************************************************************
@
@ Analog to Digital Converter
@
@****************************************************************************
@******************* Bit definition for ADC_SR register *******************
@.ITEM     ADC_SR
.equ ADC_SR_AWD, 0x01 @Analog watchdog flag
.equ ADC_SR_EOC, 0x02 @End of conversion
.equ ADC_SR_JEOC, 0x04 @Injected channel end of conversion
.equ ADC_SR_JSTRT, 0x08 @Injected channel Start flag
.equ ADC_SR_STRT, 0x10 @Regular channel Start flag
.equ ADC_SR_OVR, 0x20 @Overrun flag
@.end

@****************** Bit definition for ADC_CR1 register *******************
@.ITEM     ADC_CR1
.equ ADC_CR1_AWDCH, 0x0000001F @AWDCH[4:0] bits (Analog watchdog channel select bits)
.equ ADC_CR1_AWDCH_0, 0x00000001 @Bit 0
.equ ADC_CR1_AWDCH_1, 0x00000002 @Bit 1
.equ ADC_CR1_AWDCH_2, 0x00000004 @Bit 2
.equ ADC_CR1_AWDCH_3, 0x00000008 @Bit 3
.equ ADC_CR1_AWDCH_4, 0x00000010 @Bit 4
.equ ADC_CR1_EOCIE, 0x00000020 @Interrupt enable for EOC
.equ ADC_CR1_AWDIE, 0x00000040 @AAnalog Watchdog interrupt enable
.equ ADC_CR1_JEOCIE, 0x00000080 @Interrupt enable for injected channels
.equ ADC_CR1_SCAN, 0x00000100 @Scan mode
.equ ADC_CR1_AWDSGL, 0x00000200 @Enable the watchdog on a single channel in scan mode
.equ ADC_CR1_JAUTO, 0x00000400 @Automatic injected group conversion
.equ ADC_CR1_DISCEN, 0x00000800 @Discontinuous mode on regular channels
.equ ADC_CR1_JDISCEN, 0x00001000 @Discontinuous mode on injected channels
.equ ADC_CR1_DISCNUM, 0x0000E000 @DISCNUM[2:0] bits (Discontinuous mode channel count)
.equ ADC_CR1_DISCNUM_0, 0x00002000 @Bit 0
.equ ADC_CR1_DISCNUM_1, 0x00004000 @Bit 1
.equ ADC_CR1_DISCNUM_2, 0x00008000 @Bit 2
.equ ADC_CR1_JAWDEN, 0x00400000 @Analog watchdog enable on injected channels
.equ ADC_CR1_AWDEN, 0x00800000 @Analog watchdog enable on regular channels
.equ ADC_CR1_RES, 0x03000000 @RES[2:0] bits (Resolution)
.equ ADC_CR1_RES_0, 0x01000000 @Bit 0
.equ ADC_CR1_RES_1, 0x02000000 @Bit 1
.equ ADC_CR1_OVRIE, 0x04000000 @overrun interrupt enable

@****************** Bit definition for ADC_CR2 register *******************
@.ITEM     ADC_CR2
.equ ADC_CR2_ADON, 0x00000001 @A/D Converter ON / OFF
.equ ADC_CR2_CONT, 0x00000002 @Continuous Conversion
.equ ADC_CR2_DMA, 0x00000100 @Direct Memory access mode
.equ ADC_CR2_DDS, 0x00000200 @DMA disable selection (Single ADC)
.equ ADC_CR2_EOCS, 0x00000400 @End of conversion selection
.equ ADC_CR2_ALIGN, 0x00000800 @Data Alignment
.equ ADC_CR2_JEXTSEL, 0x000F0000 @JEXTSEL[3:0] bits (External event select for injected group)
.equ ADC_CR2_JEXTSEL_0, 0x00010000 @Bit 0
.equ ADC_CR2_JEXTSEL_1, 0x00020000 @Bit 1
.equ ADC_CR2_JEXTSEL_2, 0x00040000 @Bit 2
.equ ADC_CR2_JEXTSEL_3, 0x00080000 @Bit 3
.equ ADC_CR2_JEXTEN, 0x00300000 @JEXTEN[1:0] bits (External Trigger Conversion mode for injected channelsp)
.equ ADC_CR2_JEXTEN_0, 0x00100000 @Bit 0
.equ ADC_CR2_JEXTEN_1, 0x00200000 @Bit 1
.equ ADC_CR2_JSWSTART, 0x00400000 @Start Conversion of injected channels
.equ ADC_CR2_EXTSEL, 0x0F000000 @EXTSEL[3:0] bits (External Event Select for regular group)
.equ ADC_CR2_EXTSEL_0, 0x01000000 @Bit 0
.equ ADC_CR2_EXTSEL_1, 0x02000000 @Bit 1
.equ ADC_CR2_EXTSEL_2, 0x04000000 @Bit 2
.equ ADC_CR2_EXTSEL_3, 0x08000000 @Bit 3
.equ ADC_CR2_EXTEN, 0x30000000 @EXTEN[1:0] bits (External Trigger Conversion mode for regular channelsp)
.equ ADC_CR2_EXTEN_0, 0x10000000 @Bit 0
.equ ADC_CR2_EXTEN_1, 0x20000000 @Bit 1
.equ ADC_CR2_SWSTART, 0x40000000 @Start Conversion of regular channels

@***************** Bit definition for ADC_SMPR1 register ******************
@.ITEM     ADC_SMPR1
.equ ADC_SMPR1_SMP10, 0x00000007 @SMP10[2:0] bits (Channel 10 Sample time selection)
.equ ADC_SMPR1_SMP10_0, 0x00000001 @Bit 0
.equ ADC_SMPR1_SMP10_1, 0x00000002 @Bit 1
.equ ADC_SMPR1_SMP10_2, 0x00000004 @Bit 2
.equ ADC_SMPR1_SMP11, 0x00000038 @SMP11[2:0] bits (Channel 11 Sample time selection)
.equ ADC_SMPR1_SMP11_0, 0x00000008 @Bit 0
.equ ADC_SMPR1_SMP11_1, 0x00000010 @Bit 1
.equ ADC_SMPR1_SMP11_2, 0x00000020 @Bit 2
.equ ADC_SMPR1_SMP12, 0x000001C0 @SMP12[2:0] bits (Channel 12 Sample time selection)
.equ ADC_SMPR1_SMP12_0, 0x00000040 @Bit 0
.equ ADC_SMPR1_SMP12_1, 0x00000080 @Bit 1
.equ ADC_SMPR1_SMP12_2, 0x00000100 @Bit 2
.equ ADC_SMPR1_SMP13, 0x00000E00 @SMP13[2:0] bits (Channel 13 Sample time selection)
.equ ADC_SMPR1_SMP13_0, 0x00000200 @Bit 0
.equ ADC_SMPR1_SMP13_1, 0x00000400 @Bit 1
.equ ADC_SMPR1_SMP13_2, 0x00000800 @Bit 2
.equ ADC_SMPR1_SMP14, 0x00007000 @SMP14[2:0] bits (Channel 14 Sample time selection)
.equ ADC_SMPR1_SMP14_0, 0x00001000 @Bit 0
.equ ADC_SMPR1_SMP14_1, 0x00002000 @Bit 1
.equ ADC_SMPR1_SMP14_2, 0x00004000 @Bit 2
.equ ADC_SMPR1_SMP15, 0x00038000 @SMP15[2:0] bits (Channel 15 Sample time selection)
.equ ADC_SMPR1_SMP15_0, 0x00008000 @Bit 0
.equ ADC_SMPR1_SMP15_1, 0x00010000 @Bit 1
.equ ADC_SMPR1_SMP15_2, 0x00020000 @Bit 2
.equ ADC_SMPR1_SMP16, 0x001C0000 @SMP16[2:0] bits (Channel 16 Sample time selection)
.equ ADC_SMPR1_SMP16_0, 0x00040000 @Bit 0
.equ ADC_SMPR1_SMP16_1, 0x00080000 @Bit 1
.equ ADC_SMPR1_SMP16_2, 0x00100000 @Bit 2
.equ ADC_SMPR1_SMP17, 0x00E00000 @SMP17[2:0] bits (Channel 17 Sample time selection)
.equ ADC_SMPR1_SMP17_0, 0x00200000 @Bit 0
.equ ADC_SMPR1_SMP17_1, 0x00400000 @Bit 1
.equ ADC_SMPR1_SMP17_2, 0x00800000 @Bit 2
.equ ADC_SMPR1_SMP18, 0x07000000 @SMP18[2:0] bits (Channel 18 Sample time selection)
.equ ADC_SMPR1_SMP18_0, 0x01000000 @Bit 0
.equ ADC_SMPR1_SMP18_1, 0x02000000 @Bit 1
.equ ADC_SMPR1_SMP18_2, 0x04000000 @Bit 2

@***************** Bit definition for ADC_SMPR2 register ******************
@.ITEM     ADC_SMPR2
.equ ADC_SMPR2_SMP0, 0x00000007 @SMP0[2:0] bits (Channel 0 Sample time selection)
.equ ADC_SMPR2_SMP0_0, 0x00000001 @Bit 0
.equ ADC_SMPR2_SMP0_1, 0x00000002 @Bit 1
.equ ADC_SMPR2_SMP0_2, 0x00000004 @Bit 2
.equ ADC_SMPR2_SMP1, 0x00000038 @SMP1[2:0] bits (Channel 1 Sample time selection)
.equ ADC_SMPR2_SMP1_0, 0x00000008 @Bit 0
.equ ADC_SMPR2_SMP1_1, 0x00000010 @Bit 1
.equ ADC_SMPR2_SMP1_2, 0x00000020 @Bit 2
.equ ADC_SMPR2_SMP2, 0x000001C0 @SMP2[2:0] bits (Channel 2 Sample time selection)
.equ ADC_SMPR2_SMP2_0, 0x00000040 @Bit 0
.equ ADC_SMPR2_SMP2_1, 0x00000080 @Bit 1
.equ ADC_SMPR2_SMP2_2, 0x00000100 @Bit 2
.equ ADC_SMPR2_SMP3, 0x00000E00 @SMP3[2:0] bits (Channel 3 Sample time selection)
.equ ADC_SMPR2_SMP3_0, 0x00000200 @Bit 0
.equ ADC_SMPR2_SMP3_1, 0x00000400 @Bit 1
.equ ADC_SMPR2_SMP3_2, 0x00000800 @Bit 2
.equ ADC_SMPR2_SMP4, 0x00007000 @SMP4[2:0] bits (Channel 4 Sample time selection)
.equ ADC_SMPR2_SMP4_0, 0x00001000 @Bit 0
.equ ADC_SMPR2_SMP4_1, 0x00002000 @Bit 1
.equ ADC_SMPR2_SMP4_2, 0x00004000 @Bit 2
.equ ADC_SMPR2_SMP5, 0x00038000 @SMP5[2:0] bits (Channel 5 Sample time selection)
.equ ADC_SMPR2_SMP5_0, 0x00008000 @Bit 0
.equ ADC_SMPR2_SMP5_1, 0x00010000 @Bit 1
.equ ADC_SMPR2_SMP5_2, 0x00020000 @Bit 2
.equ ADC_SMPR2_SMP6, 0x001C0000 @SMP6[2:0] bits (Channel 6 Sample time selection)
.equ ADC_SMPR2_SMP6_0, 0x00040000 @Bit 0
.equ ADC_SMPR2_SMP6_1, 0x00080000 @Bit 1
.equ ADC_SMPR2_SMP6_2, 0x00100000 @Bit 2
.equ ADC_SMPR2_SMP7, 0x00E00000 @SMP7[2:0] bits (Channel 7 Sample time selection)
.equ ADC_SMPR2_SMP7_0, 0x00200000 @Bit 0
.equ ADC_SMPR2_SMP7_1, 0x00400000 @Bit 1
.equ ADC_SMPR2_SMP7_2, 0x00800000 @Bit 2
.equ ADC_SMPR2_SMP8, 0x07000000 @SMP8[2:0] bits (Channel 8 Sample time selection)
.equ ADC_SMPR2_SMP8_0, 0x01000000 @Bit 0
.equ ADC_SMPR2_SMP8_1, 0x02000000 @Bit 1
.equ ADC_SMPR2_SMP8_2, 0x04000000 @Bit 2
.equ ADC_SMPR2_SMP9, 0x38000000 @SMP9[2:0] bits (Channel 9 Sample time selection)
.equ ADC_SMPR2_SMP9_0, 0x08000000 @Bit 0
.equ ADC_SMPR2_SMP9_1, 0x10000000 @Bit 1
.equ ADC_SMPR2_SMP9_2, 0x20000000 @Bit 2

@***************** Bit definition for ADC_JOFR1 register ******************
@.ITEM     ADC_JOFR1
.equ ADC_JOFR1_JOFFSET1, 0x0FFF @Data offset for injected channel 1

@***************** Bit definition for ADC_JOFR2 register ******************
@.ITEM     ADC_JOFR2
.equ ADC_JOFR2_JOFFSET2, 0x0FFF @Data offset for injected channel 2

@***************** Bit definition for ADC_JOFR3 register ******************
@.ITEM     ADC_JOFR3
.equ ADC_JOFR3_JOFFSET3, 0x0FFF @Data offset for injected channel 3

@***************** Bit definition for ADC_JOFR4 register ******************
@.ITEM     ADC_JOFR4
.equ ADC_JOFR4_JOFFSET4, 0x0FFF @Data offset for injected channel 4

@****************** Bit definition for ADC_HTR register *******************
@.ITEM     ADC_HTR
.equ ADC_HTR_HT, 0x0FFF @Analog watchdog high threshold

@****************** Bit definition for ADC_LTR register *******************
@.ITEM     ADC_LTR
.equ ADC_LTR_LT, 0x0FFF @Analog watchdog low threshold

@****************** Bit definition for ADC_SQR1 register ******************
@.ITEM     ADC_SQR1
.equ ADC_SQR1_SQ13, 0x0000001F @SQ13[4:0] bits (13th conversion in regular sequence)
.equ ADC_SQR1_SQ13_0, 0x00000001 @Bit 0
.equ ADC_SQR1_SQ13_1, 0x00000002 @Bit 1
.equ ADC_SQR1_SQ13_2, 0x00000004 @Bit 2
.equ ADC_SQR1_SQ13_3, 0x00000008 @Bit 3
.equ ADC_SQR1_SQ13_4, 0x00000010 @Bit 4
.equ ADC_SQR1_SQ14, 0x000003E0 @SQ14[4:0] bits (14th conversion in regular sequence)
.equ ADC_SQR1_SQ14_0, 0x00000020 @Bit 0
.equ ADC_SQR1_SQ14_1, 0x00000040 @Bit 1
.equ ADC_SQR1_SQ14_2, 0x00000080 @Bit 2
.equ ADC_SQR1_SQ14_3, 0x00000100 @Bit 3
.equ ADC_SQR1_SQ14_4, 0x00000200 @Bit 4
.equ ADC_SQR1_SQ15, 0x00007C00 @SQ15[4:0] bits (15th conversion in regular sequence)
.equ ADC_SQR1_SQ15_0, 0x00000400 @Bit 0
.equ ADC_SQR1_SQ15_1, 0x00000800 @Bit 1
.equ ADC_SQR1_SQ15_2, 0x00001000 @Bit 2
.equ ADC_SQR1_SQ15_3, 0x00002000 @Bit 3
.equ ADC_SQR1_SQ15_4, 0x00004000 @Bit 4
.equ ADC_SQR1_SQ16, 0x000F8000 @SQ16[4:0] bits (16th conversion in regular sequence)
.equ ADC_SQR1_SQ16_0, 0x00008000 @Bit 0
.equ ADC_SQR1_SQ16_1, 0x00010000 @Bit 1
.equ ADC_SQR1_SQ16_2, 0x00020000 @Bit 2
.equ ADC_SQR1_SQ16_3, 0x00040000 @Bit 3
.equ ADC_SQR1_SQ16_4, 0x00080000 @Bit 4
.equ ADC_SQR1_L, 0x00F00000 @L[3:0] bits (Regular channel sequence length)
.equ ADC_SQR1_L_0, 0x00100000 @Bit 0
.equ ADC_SQR1_L_1, 0x00200000 @Bit 1
.equ ADC_SQR1_L_2, 0x00400000 @Bit 2
.equ ADC_SQR1_L_3, 0x00800000 @Bit 3

@****************** Bit definition for ADC_SQR2 register ******************
@.ITEM     ADC_SQR2
.equ ADC_SQR2_SQ7, 0x0000001F @SQ7[4:0] bits (7th conversion in regular sequence)
.equ ADC_SQR2_SQ7_0, 0x00000001 @Bit 0
.equ ADC_SQR2_SQ7_1, 0x00000002 @Bit 1
.equ ADC_SQR2_SQ7_2, 0x00000004 @Bit 2
.equ ADC_SQR2_SQ7_3, 0x00000008 @Bit 3
.equ ADC_SQR2_SQ7_4, 0x00000010 @Bit 4
.equ ADC_SQR2_SQ8, 0x000003E0 @SQ8[4:0] bits (8th conversion in regular sequence)
.equ ADC_SQR2_SQ8_0, 0x00000020 @Bit 0
.equ ADC_SQR2_SQ8_1, 0x00000040 @Bit 1
.equ ADC_SQR2_SQ8_2, 0x00000080 @Bit 2
.equ ADC_SQR2_SQ8_3, 0x00000100 @Bit 3
.equ ADC_SQR2_SQ8_4, 0x00000200 @Bit 4
.equ ADC_SQR2_SQ9, 0x00007C00 @SQ9[4:0] bits (9th conversion in regular sequence)
.equ ADC_SQR2_SQ9_0, 0x00000400 @Bit 0
.equ ADC_SQR2_SQ9_1, 0x00000800 @Bit 1
.equ ADC_SQR2_SQ9_2, 0x00001000 @Bit 2
.equ ADC_SQR2_SQ9_3, 0x00002000 @Bit 3
.equ ADC_SQR2_SQ9_4, 0x00004000 @Bit 4
.equ ADC_SQR2_SQ10, 0x000F8000 @SQ10[4:0] bits (10th conversion in regular sequence)
.equ ADC_SQR2_SQ10_0, 0x00008000 @Bit 0
.equ ADC_SQR2_SQ10_1, 0x00010000 @Bit 1
.equ ADC_SQR2_SQ10_2, 0x00020000 @Bit 2
.equ ADC_SQR2_SQ10_3, 0x00040000 @Bit 3
.equ ADC_SQR2_SQ10_4, 0x00080000 @Bit 4
.equ ADC_SQR2_SQ11, 0x01F00000 @SQ11[4:0] bits (11th conversion in regular sequence)
.equ ADC_SQR2_SQ11_0, 0x00100000 @Bit 0
.equ ADC_SQR2_SQ11_1, 0x00200000 @Bit 1
.equ ADC_SQR2_SQ11_2, 0x00400000 @Bit 2
.equ ADC_SQR2_SQ11_3, 0x00800000 @Bit 3
.equ ADC_SQR2_SQ11_4, 0x01000000 @Bit 4
.equ ADC_SQR2_SQ12, 0x3E000000 @SQ12[4:0] bits (12th conversion in regular sequence)
.equ ADC_SQR2_SQ12_0, 0x02000000 @Bit 0
.equ ADC_SQR2_SQ12_1, 0x04000000 @Bit 1
.equ ADC_SQR2_SQ12_2, 0x08000000 @Bit 2
.equ ADC_SQR2_SQ12_3, 0x10000000 @Bit 3
.equ ADC_SQR2_SQ12_4, 0x20000000 @Bit 4

@****************** Bit definition for ADC_SQR3 register ******************
@.ITEM     ADC_SQR3
.equ ADC_SQR3_SQ1, 0x0000001F @SQ1[4:0] bits (1st conversion in regular sequence)
.equ ADC_SQR3_SQ1_0, 0x00000001 @Bit 0
.equ ADC_SQR3_SQ1_1, 0x00000002 @Bit 1
.equ ADC_SQR3_SQ1_2, 0x00000004 @Bit 2
.equ ADC_SQR3_SQ1_3, 0x00000008 @Bit 3
.equ ADC_SQR3_SQ1_4, 0x00000010 @Bit 4
.equ ADC_SQR3_SQ2, 0x000003E0 @SQ2[4:0] bits (2nd conversion in regular sequence)
.equ ADC_SQR3_SQ2_0, 0x00000020 @Bit 0
.equ ADC_SQR3_SQ2_1, 0x00000040 @Bit 1
.equ ADC_SQR3_SQ2_2, 0x00000080 @Bit 2
.equ ADC_SQR3_SQ2_3, 0x00000100 @Bit 3
.equ ADC_SQR3_SQ2_4, 0x00000200 @Bit 4
.equ ADC_SQR3_SQ3, 0x00007C00 @SQ3[4:0] bits (3rd conversion in regular sequence)
.equ ADC_SQR3_SQ3_0, 0x00000400 @Bit 0
.equ ADC_SQR3_SQ3_1, 0x00000800 @Bit 1
.equ ADC_SQR3_SQ3_2, 0x00001000 @Bit 2
.equ ADC_SQR3_SQ3_3, 0x00002000 @Bit 3
.equ ADC_SQR3_SQ3_4, 0x00004000 @Bit 4
.equ ADC_SQR3_SQ4, 0x000F8000 @SQ4[4:0] bits (4th conversion in regular sequence)
.equ ADC_SQR3_SQ4_0, 0x00008000 @Bit 0
.equ ADC_SQR3_SQ4_1, 0x00010000 @Bit 1
.equ ADC_SQR3_SQ4_2, 0x00020000 @Bit 2
.equ ADC_SQR3_SQ4_3, 0x00040000 @Bit 3
.equ ADC_SQR3_SQ4_4, 0x00080000 @Bit 4
.equ ADC_SQR3_SQ5, 0x01F00000 @SQ5[4:0] bits (5th conversion in regular sequence)
.equ ADC_SQR3_SQ5_0, 0x00100000 @Bit 0
.equ ADC_SQR3_SQ5_1, 0x00200000 @Bit 1
.equ ADC_SQR3_SQ5_2, 0x00400000 @Bit 2
.equ ADC_SQR3_SQ5_3, 0x00800000 @Bit 3
.equ ADC_SQR3_SQ5_4, 0x01000000 @Bit 4
.equ ADC_SQR3_SQ6, 0x3E000000 @SQ6[4:0] bits (6th conversion in regular sequence)
.equ ADC_SQR3_SQ6_0, 0x02000000 @Bit 0
.equ ADC_SQR3_SQ6_1, 0x04000000 @Bit 1
.equ ADC_SQR3_SQ6_2, 0x08000000 @Bit 2
.equ ADC_SQR3_SQ6_3, 0x10000000 @Bit 3
.equ ADC_SQR3_SQ6_4, 0x20000000 @Bit 4

@****************** Bit definition for ADC_JSQR register ******************
@.ITEM     ADC_JSQR
.equ ADC_JSQR_JSQ1, 0x0000001F @JSQ1[4:0] bits (1st conversion in injected sequence)
.equ ADC_JSQR_JSQ1_0, 0x00000001 @Bit 0
.equ ADC_JSQR_JSQ1_1, 0x00000002 @Bit 1
.equ ADC_JSQR_JSQ1_2, 0x00000004 @Bit 2
.equ ADC_JSQR_JSQ1_3, 0x00000008 @Bit 3
.equ ADC_JSQR_JSQ1_4, 0x00000010 @Bit 4
.equ ADC_JSQR_JSQ2, 0x000003E0 @JSQ2[4:0] bits (2nd conversion in injected sequence)
.equ ADC_JSQR_JSQ2_0, 0x00000020 @Bit 0
.equ ADC_JSQR_JSQ2_1, 0x00000040 @Bit 1
.equ ADC_JSQR_JSQ2_2, 0x00000080 @Bit 2
.equ ADC_JSQR_JSQ2_3, 0x00000100 @Bit 3
.equ ADC_JSQR_JSQ2_4, 0x00000200 @Bit 4
.equ ADC_JSQR_JSQ3, 0x00007C00 @JSQ3[4:0] bits (3rd conversion in injected sequence)
.equ ADC_JSQR_JSQ3_0, 0x00000400 @Bit 0
.equ ADC_JSQR_JSQ3_1, 0x00000800 @Bit 1
.equ ADC_JSQR_JSQ3_2, 0x00001000 @Bit 2
.equ ADC_JSQR_JSQ3_3, 0x00002000 @Bit 3
.equ ADC_JSQR_JSQ3_4, 0x00004000 @Bit 4
.equ ADC_JSQR_JSQ4, 0x000F8000 @JSQ4[4:0] bits (4th conversion in injected sequence)
.equ ADC_JSQR_JSQ4_0, 0x00008000 @Bit 0
.equ ADC_JSQR_JSQ4_1, 0x00010000 @Bit 1
.equ ADC_JSQR_JSQ4_2, 0x00020000 @Bit 2
.equ ADC_JSQR_JSQ4_3, 0x00040000 @Bit 3
.equ ADC_JSQR_JSQ4_4, 0x00080000 @Bit 4
.equ ADC_JSQR_JL, 0x00300000 @JL[1:0] bits (Injected Sequence length)
.equ ADC_JSQR_JL_0, 0x00100000 @Bit 0
.equ ADC_JSQR_JL_1, 0x00200000 @Bit 1

@****************** Bit definition for ADC_JDR1 register ******************
@.ITEM     ADC_JDR1
.equ ADC_JDR1_JDATA, 0xFFFF @Injected data

@****************** Bit definition for ADC_JDR2 register ******************
@.ITEM     ADC_JDR2
.equ ADC_JDR2_JDATA, 0xFFFF @Injected data

@****************** Bit definition for ADC_JDR3 register ******************
@.ITEM     ADC_JDR3
.equ ADC_JDR3_JDATA, 0xFFFF @Injected data

@****************** Bit definition for ADC_JDR4 register ******************
@.ITEM     ADC_JDR4
.equ ADC_JDR4_JDATA, 0xFFFF @Injected data

@******************* Bit definition for ADC_DR register *******************
@.ITEM     ADC_DR
.equ ADC_DR_DATA, 0x0000FFFF @Regular data
.equ ADC_DR_ADC2DATA, 0xFFFF0000 @ADC2 data

@****************** Bit definition for ADC_CSR register *******************
@.ITEM     ADC_CSR
.equ ADC_CSR_AWD1, 0x00000001 @ADC1 Analog watchdog flag
.equ ADC_CSR_EOC1, 0x00000002 @ADC1 End of conversion
.equ ADC_CSR_JEOC1, 0x00000004 @ADC1 Injected channel end of conversion
.equ ADC_CSR_JSTRT1, 0x00000008 @ADC1 Injected channel Start flag
.equ ADC_CSR_STRT1, 0x00000010 @ADC1 Regular channel Start flag
.equ ADC_CSR_DOVR1, 0x00000020 @ADC1 DMA overrun flag
.equ ADC_CSR_AWD2, 0x00000100 @ADC2 Analog watchdog flag
.equ ADC_CSR_EOC2, 0x00000200 @ADC2 End of conversion
.equ ADC_CSR_JEOC2, 0x00000400 @ADC2 Injected channel end of conversion
.equ ADC_CSR_JSTRT2, 0x00000800 @ADC2 Injected channel Start flag
.equ ADC_CSR_STRT2, 0x00001000 @ADC2 Regular channel Start flag
.equ ADC_CSR_DOVR2, 0x00002000 @ADC2 DMA overrun flag
.equ ADC_CSR_AWD3, 0x00010000 @ADC3 Analog watchdog flag
.equ ADC_CSR_EOC3, 0x00020000 @ADC3 End of conversion
.equ ADC_CSR_JEOC3, 0x00040000 @ADC3 Injected channel end of conversion
.equ ADC_CSR_JSTRT3, 0x00080000 @ADC3 Injected channel Start flag
.equ ADC_CSR_STRT3, 0x00100000 @ADC3 Regular channel Start flag
.equ ADC_CSR_DOVR3, 0x00200000 @ADC3 DMA overrun flag

@****************** Bit definition for ADC_CCR register *******************
@.ITEM     ADC_CCR
.equ ADC_CCR_MULTI, 0x0000001F @MULTI[4:0] bits (Multi-ADC mode selection)
.equ ADC_CCR_MULTI_0, 0x00000001 @Bit 0
.equ ADC_CCR_MULTI_1, 0x00000002 @Bit 1
.equ ADC_CCR_MULTI_2, 0x00000004 @Bit 2
.equ ADC_CCR_MULTI_3, 0x00000008 @Bit 3
.equ ADC_CCR_MULTI_4, 0x00000010 @Bit 4
.equ ADC_CCR_DELAY, 0x00000F00 @DELAY[3:0] bits (Delay between 2 sampling phases)
.equ ADC_CCR_DELAY_0, 0x00000100 @Bit 0
.equ ADC_CCR_DELAY_1, 0x00000200 @Bit 1
.equ ADC_CCR_DELAY_2, 0x00000400 @Bit 2
.equ ADC_CCR_DELAY_3, 0x00000800 @Bit 3
.equ ADC_CCR_DDS, 0x00002000 @DMA disable selection (Multi-ADC mode)
.equ ADC_CCR_DMA, 0x0000C000 @DMA[1:0] bits (Direct Memory Access mode for multimode)
.equ ADC_CCR_DMA_0, 0x00004000 @Bit 0
.equ ADC_CCR_DMA_1, 0x00008000 @Bit 1
.equ ADC_CCR_ADCPRE, 0x00030000 @ADCPRE[1:0] bits (ADC prescaler)
.equ ADC_CCR_ADCPRE_0, 0x00010000 @Bit 0
.equ ADC_CCR_ADCPRE_1, 0x00020000 @Bit 1
.equ ADC_CCR_VBATE, 0x00400000 @VBAT Enable
.equ ADC_CCR_TSVREFE, 0x00800000 @Temperature Sensor and VREFINT Enable

@****************** Bit definition for ADC_CDR register *******************
@.ITEM     ADC_CDR
.equ ADC_CDR_DATA1, 0x0000FFFF @1st data of a pair of regular conversions
.equ ADC_CDR_DATA2, 0xFFFF0000 @2nd data of a pair of regular conversions


