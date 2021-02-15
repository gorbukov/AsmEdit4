@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                     Базовые константы TIM2 - TIM5                |
@ +------------------------------------------------------------------+
@.enddesc

.include "/src/inc/base.inc"

@.ITEM     APB1PERIPH_BASE
.EQU  TIM13_BASE         , APB1PERIPH_BASE + 0x1C00
.EQU  TIM13              , PERIPH_BASE + TIM13_BASE
.EQU  TIM14_BASE         , APB1PERIPH_BASE + 0x2000
.EQU  TIM14              , PERIPH_BASE + TIM14_BASE

@.ITEM     APB2PERIPH_BASE
.EQU  TIM11_BASE         , APB2PERIPH_BASE + 0x4800
.EQU  TIM11              , PERIPH_BASE + TIM11_BASE
.EQU  TIM10_BASE         , APB2PERIPH_BASE + 0x4400
.EQU  TIM10              , PERIPH_BASE + TIM10_BASE

@.ITEM     TIM10_BASE TIM11_BASE TIM13_BASE TIM14_BASE TIM10 TIM11 TIM13 TIM14
.EQU  TIM10_11_13_14_CR1 , 0x00
.EQU  TIM10_11_13_14_SMCR, 0x08
.EQU  TIM10_11_13_14_DIER, 0x0C
.EQU  TIM10_11_13_14_SR  , 0x10
.EQU  TIM10_11_13_14_EGR , 0x14
.EQU  TIM10_11_13_14_CCMR1, 0x18
.EQU  TIM10_11_13_14_CCER, 0x20
.EQU  TIM10_11_13_14_CNT , 0x24
.EQU  TIM10_11_13_14_PSC , 0x28
.EQU  TIM10_11_13_14_ARR , 0x2C
.EQU  TIM10_11_13_14_CCR1, 0x34
.EQU  TIM11_OR           , 0x50

@.ITEM     TIM10_11_13_14_CR1
.EQU  TIM10_11_13_14_CR1_CKD_N, 8     @ Clock division
.EQU  TIM10_11_13_14_CR1_CKD_1, 0     @ tDTS = tCK_INT
.EQU  TIM10_11_13_14_CR1_CKD_2, 1 << 8    @ tDTS = 2 Ч tCK_INT
.EQU  TIM10_11_13_14_CR1_CKD_4, 2 << 8    @ tDTS = 4 Ч tCK_INT
.EQU  TIM10_11_13_14_CR1_APRE, 1 << 7    @  Auto-reload preload enable
.EQU  TIM10_11_13_14_CR1_OPM, 1 << 3    @ One-pulse mode
.EQU  TIM10_11_13_14_CR1_URS, 1 << 2    @ Update request source
.EQU  TIM10_11_13_14_CR1_UDIS, 1 << 1    @ Update disable
.EQU  TIM10_11_13_14_CR1_CEN, 1       @ Counter enable

@.ITEM     TIM10_11_13_14_SMCR
.EQU  TIM10_11_13_14_SMCR_MSM       , 1 << 7     @ Master/Slave mode
.EQU  TIM10_11_13_14_SMCR_TS_N      , 4          @ Trigger selection
.EQU  TIM10_11_13_14_SMCR_TS_ITR0   , 0          @ Internal Trigger 0 (ITR0
.EQU  TIM10_11_13_14_SMCR_TS_ITR1   , 1 << 4     @ Internal Trigger 1 (ITR1)
.EQU  TIM10_11_13_14_SMCR_TS_ITR2   , 2 << 4     @ Internal Trigger 2 (ITR2)
.EQU  TIM10_11_13_14_SMCR_TS_ITR3   , 3 << 4     @Internal Trigger 3 (ITR3)
.EQU  TIM10_11_13_14_SMCR_TS_TI1F_ED, 4 << 4     @ TI1 Edge Detector (TI1F_ED)
.EQU  TIM10_11_13_14_SMCR_TS_TI1FP1 , 5 << 4     @  Filtered Timer Input 1 (TI1FP1)
.EQU  TIM10_11_13_14_SMCR_TS_TI2FP2 , 6 << 4     @ Filtered Timer Input 2 (TI2FP2)
.EQU  TIM10_11_13_14_SMCR_SMS_N     , 0          @ Slave mode selection
.EQU  TIM10_11_13_14_SMCR_SMS_SMD   , 0          @ Slave mode disabled - if CEN = 1 then the prescaler is clocked directly by the internal clock
.EQU  TIM10_11_13_14_SMCR_SMS_ENCM1 , 1          @ reserved
.EQU  TIM10_11_13_14_SMCR_SMS_ENCM2 , 2          @ reserved
.EQU  TIM10_11_13_14_SMCR_SMS_ENCM3 , 3          @ reserved
.EQU  TIM10_11_13_14_SMCR_SMS_RSTM  , 4          @  Reset mode - Rising edge of the selected trigger input (TRGI) reinitializes the counter and generates an update of the registers
.EQU  TIM10_11_13_14_SMCR_SMS_GTDM  , 5          @ Gated mode - The counter clock is enabled when the trigger input (TRGI) is high. The counter     stops ( but is not reset ) as soon as the trigger becomes low. Counter starts and stops are both controlled
.EQU  TIM10_11_13_14_SMCR_SMS_TRGM  , 6          @ Trigger mode - The counter starts on a rising edge of the trigger TRGI (but it is not reset). Only the start of the counter is controlled
.EQU  TIM10_11_13_14_SMCR_SMS_EXTCLK, 7          @  External clock mode 1 - Rising edges of the selected trigger (TRGI) clock the counter

@.ITEM     TIM10_11_13_14_DIER
.EQU  TIM10_11_13_14_DIER_CC1IE     , 1 << 1     @ Capture/Compare 1 interrupt enable
.EQU  TIM10_11_13_14_DIER_UIE       , 1          @ Update interrupt enable

@.ITEM     TIM10_11_13_14_SR
.EQU  TIM10_11_13_14_SR_CC1OF       , 1 << 9     @ Capture/Compare 1 overcapture flag
.EQU  TIM10_11_13_14_SR_CC1IF       , 1 << 1     @ Capture/compare 1 interrupt flag
.EQU  TIM10_11_13_14_SR_UIF         , 1          @ Update interrupt flag

@.ITEM     TIM10_11_13_14_EGR
.EQU  TIM10_11_13_14_EGR_CC1G       , 1 << 1     @ Capture/compare 1 generation
.EQU  TIM10_11_13_14_EGR_UG         , 1          @ Update generation

@.ITEM     TIM10_11_13_14_CCMR1
.EQU  TIM10_11_13_14_CCMR1_OUTPUT_COMPARE_MODE, 0
.EQU  TIM10_11_13_14_CCMR1_INPUT_CAPTURE_MODE, 0
.EQU  TIM10_11_13_14_CCMR1_CC1S_N   , 0
.EQU  TIM10_11_13_14_CCMR1_CC1S_OUT , 0          @ CC1 channel is configured as output
.EQU  TIM10_11_13_14_CCMR1_CC1S_TI3 , 1          @ CC1 channel is configured as input, IC3 is mapped on TI3
.EQU  TIM10_11_13_14_CCMR1_CC1S_TI4 , 2          @ CC1 channel is configured as input, IC3 is mapped on TI4
.EQU  TIM10_11_13_14_CCMR1_CC1S_TRC , 3          @ CC1 channel is configured as input, IC3 is mapped on TRC. This mode is working only if an internal trigger input is selected through TS bit (TIMx_SMCR register)

@.ITEM     TIM10_11_13_14_CCMR1_OUTPUT_COMPARE_MODE
.EQU  TIM10_11_13_14_CCMR1_OC1M_N   , 4          @  Output compare 1 mode
.EQU  TIM10_11_13_14_CCMR1_OC1M_FROZEN, 0        @ Frozen - The comparison between the output compare register TIMx_CCR1 and the counter     TIMx_CNT has no effect on the outputs. ( this mode is used to generate a timing base )
.EQU  TIM10_11_13_14_CCMR1_OC1M_ACT , 1 << 4     @ Set channel 1 to active level on match. OC1REF signal is forced high when the counter TIMx_CNT matches the capture/compare register 1 (TIMx_CCR1).
.EQU  TIM10_11_13_14_CCMR1_OC1M_INACT, 2 << 4    @ Set channel 1 to inactive level on match. OC1REF signal is forced low when the counter TIMx_CNT matches the capture/compare register 1 (TIMx_CCR1).
.EQU  TIM10_11_13_14_CCMR1_OC1M_TOGGLE, 3 << 4    @ Toggle - OC1REF toggles when TIMx_CNT=TIMx_CCR1.
.EQU  TIM10_11_13_14_CCMR1_OC1M_FORSEINACT, 4 << 4    @ Force inactive level - OC1REF is forced low.
.EQU  TIM10_11_13_14_CCMR1_OC1M_FORSEACT, 5 << 4    @ Force active level - OC1REF is forced high.
.EQU  TIM10_11_13_14_CCMR1_OC1M_PWM1, 6 << 4     @  PWM mode 1 - In upcounting, channel 1 is active as long as TIMx_CNT<TIMx_CCR1  else        inactive. In downcounting, channel 1 is inactive ( OC1REF = ‘0 ) as long as TIMx_CNT > TIMx_CCR1 else active ( OC1REF = 1 ) .
.EQU  TIM10_11_13_14_CCMR1_OC1M_PWM2, 7 << 4     @ PWM mode 2 - In upcounting, channel 1 is inactive as long as TIMx_CNT<TIMx_CCR1 else        active. In downcounting, channel 1 is active as long as TIMx_CNT > TIMx_CCR1 else inactive.
.EQU  TIM10_11_13_14_CCMR1_OC1PE    , 1 << 3     @ Output compare 1 preload enable
.EQU  TIM10_11_13_14_CCMR1_OC1FE    , 1 << 2     @ Output compare 1 fast enable

@.ITEM     TIM10_11_13_14_CCMR1_INPUT_CAPTURE_MODE
.EQU  TIM10_11_13_14_CCMR1_IC1F_N   , 4          @ Input capture 1 filter
.EQU  TIM10_11_13_14_CCMR1_IC1F_NOF , 0          @ No filter, sampling is done at fDTS
.EQU  TIM10_11_13_14_CCMR1_IC1F_N2  , 1 << 4     @ fSAMPLING=fCK_INT, N=2
.EQU  TIM10_11_13_14_CCMR1_IC1F_N4  , 2 << 4     @ fSAMPLING=fCK_INT, N=4
.EQU  TIM10_11_13_14_CCMR1_IC1F_N8  , 3 << 4     @ fSAMPLING=fCK_INT, N=8
.EQU  TIM10_11_13_14_CCMR1_IC1F_2N6 , 4 << 4     @ fSAMPLING=fDTS/2, N=6
.EQU  TIM10_11_13_14_CCMR1_IC1F_2N8 , 5 << 4     @ fSAMPLING=fDTS/2, N=8
.EQU  TIM10_11_13_14_CCMR1_IC1F_4N6 , 6 << 4     @ fSAMPLING=fDTS/4, N=6
.EQU  TIM10_11_13_14_CCMR1_IC1F_4N8 , 7 << 4     @ fSAMPLING=fDTS/4, N=8
.EQU  TIM10_11_13_14_CCMR1_IC1F_8N6 , 8 << 4     @ fSAMPLING=fDTS/8, N=6
.EQU  TIM10_11_13_14_CCMR1_IC1F_8N8 , 9 << 4     @ fSAMPLING=fDTS/8, N=8
.EQU  TIM10_11_13_14_CCMR1_IC1F_16N5, 10 << 4    @ fSAMPLING=fDTS/16, N=5
.EQU  TIM10_11_13_14_CCMR1_IC1F_16N6, 11 << 4    @ fSAMPLING=fDTS/16, N=6
.EQU  TIM10_11_13_14_CCMR1_IC1F_16N8, 12 << 4    @ fSAMPLING=fDTS/16, N=8
.EQU  TIM10_11_13_14_CCMR1_IC1F_32N5, 13 << 4    @ fSAMPLING=fDTS/32, N=5
.EQU  TIM10_11_13_14_CCMR1_IC1F_32N6, 14 << 4    @ fSAMPLING=fDTS/32, N=6
.EQU  TIM10_11_13_14_CCMR1_IC1F_32N8, 15 << 4    @ fSAMPLING=fDTS/32, N=8
.EQU  TIM10_11_13_14_CCMR1_IC1PSC_N , 2          @ Input capture 3 prescaler
.EQU  TIM10_11_13_14_CCMR1_IC1PSC_1 , 0          @ no prescaler, capture is done each time an edge is detected on the capture input
.EQU  TIM10_11_13_14_CCMR1_IC1PSC_2 , 1 << 2     @ capture is done once every 2 events
.EQU  TIM10_11_13_14_CCMR1_IC1PSC_4 , 2 << 2     @ capture is done once every 4 events
.EQU  TIM10_11_13_14_CCMR1_IC1PSC_8 , 3 << 2     @ capture is done once every 8 events

@.ITEM     TIM10_11_13_14_CCER
.EQU  TIM10_11_13_14_CCER_CC1NP     , 1 << 3     @  Capture/Compare 1 output Polarity
.EQU  TIM10_11_13_14_CCER_CC1P      , 1 << 1     @  Capture/Compare 1 output Polarity
.EQU  TIM10_11_13_14_CCER_CC1E      , 1 << 0     @  Capture/Compare 1 output Polarity

@.ITEM     TIM11_OR
.EQU  TIM11_OR_TI1_RMP_N , 0          @  TIM11 Input 1 remapping capability
.EQU  TIM11_OR_TI1_RMP_GPIO_0, 0      @ Channel1 is connected to the GPIO
.EQU  TIM11_OR_TI1_RMP_GPIO_1, 1      @ Channel1 is connected to the GPIO
.EQU  TIM11_OR_TI1_RMP_HSE_RTC, 2     @ HSE_RTC clock (HSE divided by programmable prescaler) is connected to the TIM11_CH1 input for measurement purposes
.EQU  TIM11_OR_TI1_RMP_GPIO_3, 3      @ Channel1 is connected to the GPIO



