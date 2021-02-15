@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                     Ѕазовые константы TIM2 - TIM5                |
@ +------------------------------------------------------------------+
@.enddesc

.include "/src/inc/base.inc"

@.ITEM     APB1PERIPH_BASE
.EQU  TIM2_BASE          , APB1PERIPH_BASE + 0
.EQU  TIM3_BASE          , APB1PERIPH_BASE + 0x400
.EQU  TIM4_BASE          , APB1PERIPH_BASE + 0x800
.EQU  TIM5_BASE          , APB1PERIPH_BASE + 0xC00
.EQU  TIM2               , PERIPH_BASE + APB1PERIPH_BASE + 0
.EQU  TIM3               , PERIPH_BASE + APB1PERIPH_BASE + 0x400
.EQU  TIM4               , PERIPH_BASE + APB1PERIPH_BASE + 0x800
.EQU  TIM5               , PERIPH_BASE + APB1PERIPH_BASE + 0xC00

@.ITEM     TIM2_BASE TIM3_BASE TIM4_BASE TIM5_BASE TIM2 TIM3 TIM4 TIM5
.EQU  TIM2T5_CR1         , 0x00
.EQU  TIM2T5_CR2         , 0x04
.EQU  TIM2T5_SMCR        , 0x08
.EQU  TIM2T5_DIER        , 0x0C
.EQU  TIM2T5_SR          , 0x10
.EQU  TIM2T5_EGR         , 0x14
.EQU  TIM2T5_CCMR1       , 0x18
.EQU  TIM2T5_CCMR2       , 0x1C
.EQU  TIM2T5_CCER        , 0x20
.EQU  TIM2T5_CNT         , 0x24
.EQU  TIM2T5_PSC         , 0x28
.EQU  TIM2T5_ARR         , 0x2C
.EQU  TIM2T5_CCR1        , 0x34
.EQU  TIM2T5_CCR2        , 0x38
.EQU  TIM2T5_CCR3        , 0x3C
.EQU  TIM2T5_CCR4        , 0x40
.EQU  TIM2T5_DCR         , 0x48
.EQU  TIM2T5_DMAR        , 0x4C
.EQU  TIM2_OR            , 0x50
.EQU  TIM5_OR            , 0x50


@.ITEM     TIM2T5_CR1
.EQU  TIM2T5_CR1_CKD_N   , 8
.EQU  TIM2T5_CR1_CKD_1   , 0
.EQU  TIM2T5_CR1_CKD_2   , 1 << 8
.EQU  TIM2T5_CR1_CKD_4   , 2 << 8
.EQU  TIM2T5_CR1_APRE    , 1 << 7
.EQU  TIM2T5_CR1_CMS_N   , 5
.EQU  TIM2T5_CR1_CMS_EDGE, 0
.EQU  TIM2T5_CR1_CMS_CENT1, 1 << 5
.EQU  TIM2T5_CR1_CMS_CENT2, 2 << 5
.EQU  TIM2T5_CR1_CMS_CENT3, 3 << 5
.EQU  TIM2T5_CR1_DIR     , 1 << 4
.EQU  TIM2T5_CR1_OPM     , 1 << 3
.EQU  TIM2T5_CR1_URS     , 1 << 2
.EQU  TIM2T5_CR1_UDIS    , 1 << 1
.EQU  TIM2T5_CR1_CEN     , 1

@.ITEM     TIM2T5_CR2
.EQU  TIM2T5_CR2_TI1S    , 1 << 7
.EQU  TIM2T5_CR2_MMS_N   , 1 << 4
.EQU  TIM2T5_CR2_MMS_RST , 0
.EQU  TIM2T5_CR2_MMS_ENB , 1 << 4
.EQU  TIM2T5_CR2_MMS_UPD , 2 << 4
.EQU  TIM2T5_CR2_MMS_COMP, 3 << 4
.EQU  TIM2T5_CR2_MMS_OC1REF, 4 << 4
.EQU  TIM2T5_CR2_MMS_OC2REF, 5 << 4
.EQU  TIM2T5_CR2_MMS_OC3REF, 6 << 4
.EQU  TIM2T5_CR2_MMS_OC4REF, 7 << 4
.EQU  TIM2T5_CR2_CCDS    , 1 << 3

@.ITEM     TIM2T5_SMCR
.EQU  TIM2T5_SMCR_ETR    , 1 << 15
.EQU  TIM2T5_SMCR_ECE    , 1 << 14
.EQU  TIM2T5_SMCR_ETPS_N , 12
.EQU  TIM2T5_SMCR_ETPS_OFF, 0
.EQU  TIM2T5_SMCR_ETPS_DIV2, 1 << 12
.EQU  TIM2T5_SMCR_ETPS_DIV4, 2 << 12
.EQU  TIM2T5_SMCR_ETPS_DIV8, 3 << 12
.EQU  TIM2T5_SMCR_ETF_N  , 8
.EQU  TIM2T5_SMCR_ETF_NOF, 0
.EQU  TIM2T5_SMCR_ETF_N2 , 1 << 8
.EQU  TIM2T5_SMCR_ETF_N4 , 2 << 8
.EQU  TIM2T5_SMCR_ETF_N8 , 3 << 8
.EQU  TIM2T5_SMCR_ETF_2N6, 4 << 8
.EQU  TIM2T5_SMCR_ETF_2N8, 5 << 8
.EQU  TIM2T5_SMCR_ETF_4N6, 6 << 8
.EQU  TIM2T5_SMCR_ETF_4N8, 7 << 8
.EQU  TIM2T5_SMCR_ETF_8N6, 8 << 8
.EQU  TIM2T5_SMCR_ETF_8N8, 9 << 8
.EQU  TIM2T5_SMCR_ETF_16N5, 10 << 8
.EQU  TIM2T5_SMCR_ETF_16N6, 11 << 8
.EQU  TIM2T5_SMCR_ETF_16N8, 12 << 8
.EQU  TIM2T5_SMCR_ETF_32N5, 13 << 8
.EQU  TIM2T5_SMCR_ETF_32N6, 14 << 8
.EQU  TIM2T5_SMCR_ETF_32N8, 15 << 8
.EQU  TIM2T5_SMCR_MSM    , 1 << 7
.EQU  TIM2T5_SMCR_TS_N   , 4
.EQU  TIM2T5_SMCR_TS_ITR0, 0
.EQU  TIM2T5_SMCR_TS_ITR1, 1 << 4
.EQU  TIM2T5_SMCR_TS_ITR2, 2 << 4
.EQU  TIM2T5_SMCR_TS_ITR3, 3 << 4
.EQU  TIM2T5_SMCR_TS_TI1F_ED, 4 << 4
.EQU  TIM2T5_SMCR_TS_TI1FP1, 5 << 4
.EQU  TIM2T5_SMCR_TS_TI2FP2, 6 << 4
.EQU  TIM2T5_SMCR_TS_ETRF, 7 << 4
.EQU  TIM2T5_SMCR_SMS_N     , 0
.EQU  TIM2T5_SMCR_SMS_SMD   , 0
.EQU  TIM2T5_SMCR_SMS_ENCM1 , 1
.EQU  TIM2T5_SMCR_SMS_ENCM2 , 2
.EQU  TIM2T5_SMCR_SMS_ENCM3 , 3
.EQU  TIM2T5_SMCR_SMS_RSTM  , 4
.EQU  TIM2T5_SMCR_SMS_GTDM  , 5
.EQU  TIM2T5_SMCR_SMS_TRGM, 6
.EQU  TIM2T5_SMCR_SMS_EXTCLK, 7



@         Table 98. TIMx internal trigger connection
@ Slave TIM     ITR0        ITR1        ITR2        ITR3
@            (TS = 000)  (TS = 001)  (TS = 010)  (TS = 011)
@  TIM2      TIM1_TRGO   TIM8_TRGO   TIM3_TRGO   TIM4_TRGO
@  TIM3      TIM1_TRGO   TIM2_TRGO   TIM5_TRGO   TIM4_TRGO
@  TIM4      TIM1_TRGO   TIM2_TRGO   TIM3_TRGO   TIM8_TRGO
@  TIM5      TIM2_TRGO   TIM3_TRGO   TIM4_TRGO   TIM8_TRGO

@.ITEM     TIM2T5_DIER
.EQU  TIM2T5_DIER_TDE       , 1 << 14
.EQU  TIM2T5_DIER_CC4DE     , 1 << 12
.EQU  TIM2T5_DIER_CC3DE     , 1 << 11
.EQU  TIM2T5_DIER_CC2DE     , 1 << 10
.EQU  TIM2T5_DIER_CC1DE     , 1 << 9
.EQU  TIM2T5_DIER_UDE       , 1 << 8
.EQU  TIM2T5_DIER_TIE       , 1 << 6
.EQU  TIM2T5_DIER_CC4IE     , 1 << 4
.EQU  TIM2T5_DIER_CC3IE     , 1 << 3
.EQU  TIM2T5_DIER_CC2IE     , 1 << 2
.EQU  TIM2T5_DIER_CC1IE     , 1 << 1
.EQU  TIM2T5_DIER_UIE       , 1

@.ITEM     TIM2T5_SR
.EQU  TIM2T5_SR_CC4OF       , 1 << 12
.EQU  TIM2T5_SR_CC3OF       , 1 << 11
.EQU  TIM2T5_SR_CC2OF       , 1 << 10
.EQU  TIM2T5_SR_CC1OF       , 1 << 9
.EQU  TIM2T5_SR_TIF         , 1 << 6
.EQU  TIM2T5_SR_CC4IF    , 1 << 4
.EQU  TIM2T5_SR_CC3IF    , 1 << 3
.EQU  TIM2T5_SR_CC2IF    , 1 << 2
.EQU  TIM2T5_SR_CC1IF    , 1 << 1
.EQU  TIM2T5_SR_UIF         , 1

@.ITEM     TIM2T5_EGR
.EQU  TIM2T5_EGR_TG         , 1 << 6
.EQU  TIM2T5_EGR_CC4G       , 1 << 4
.EQU  TIM2T5_EGR_CC3G       , 1 << 3
.EQU  TIM2T5_EGR_CC2G       , 1 << 2
.EQU  TIM2T5_EGR_CC1G       , 1 << 1
.EQU  TIM2T5_EGR_UG         , 1

@.ITEM     TIM2T5_CCMR1
.EQU  TIM2T5_CCMR1_OUTPUT_COMPARE_MODE, 0
.EQU  TIM2T5_CCMR1_INPUT_CAPTURE_MODE, 0
.EQU  TIM2T5_CCMR1_CC2S_N, 8          @ Capture/Compare 2 selection
.EQU  TIM2T5_CCMR1_CC2S_OUT, 0        @ CC2 channel is configured as output
.EQU  TIM2T5_CCMR1_CC2S_TI2, 1 << 8    @ CC2 channel is configured as input, IC4 is mapped on TI4
.EQU  TIM2T5_CCMR1_CC2S_TI1, 2 << 8    @ CC2 channel is configured as input, IC4 is mapped on TI3
.EQU  TIM2T5_CCMR1_CC2S_TRC, 3 << 8    @ CC2 channel is configured as input, IC4 is mapped on TRC. This mode is working only if an internal trigger input is selected through TS bit (TIMx_SMCR register)
.EQU  TIM2T5_CCMR1_CC1S_N, 0
.EQU  TIM2T5_CCMR1_CC1S_OUT, 0        @ CC1 channel is configured as output
.EQU  TIM2T5_CCMR1_CC1S_TI3, 1        @ CC1 channel is configured as input, IC3 is mapped on TI3
.EQU  TIM2T5_CCMR1_CC1S_TI4, 2        @ CC1 channel is configured as input, IC3 is mapped on TI4
.EQU  TIM2T5_CCMR1_CC1S_TRC, 3        @ CC1 channel is configured as input, IC3 is mapped on TRC. This mode is working only if an internal trigger input is selected through TS bit (TIMx_SMCR register)

@.ITEM     TIM2T5_CCMR1_OUTPUT_COMPARE_MODE
.EQU  TIM2T5_CCMR1_OC2CE , 1 << 15    @ Output compare 2 clear enable
.EQU  TIM2T5_CCMR1_OC2M_N, 12         @ Output compare 2 mode
.EQU  TIM2T5_CCMR1_OC2M_FROZEN, 0     @ Frozen - The comparison between the output compare register TIMx_CCR1 and the counter     TIMx_CNT has no effect on the outputs. ( this mode is used to generate a timing base )
.EQU  TIM2T5_CCMR1_OC2M_ACT, 1 << 12    @ Set channel 2 to active level on match. OC1REF signal is forced high when the counter TIMx_CNT matches the capture/compare register 1 (TIMx_CCR1).
.EQU  TIM2T5_CCMR1_OC2M_INACT, 2 << 12    @ Set channel 2 to inactive level on match. OC1REF signal is forced low when the counter TIMx_CNT matches the capture/compare register 1 (TIMx_CCR1).
.EQU  TIM2T5_CCMR1_OC2M_TOGGLE, 3 << 12    @ Toggle - OC2REF toggles when TIMx_CNT=TIMx_CCR1.
.EQU  TIM2T5_CCMR1_OC2M_FORSEINACT, 4 << 12    @ Force inactive level - OC2REF is forced low.
.EQU  TIM2T5_CCMR1_OC2M_FORSEACT, 5 << 12    @ Force active level - OC2REF is forced high.
.EQU  TIM2T5_CCMR1_OC2M_PWM1, 6 << 12    @  PWM mode 1 - In upcounting, channel 2 is active as long as TIMx_CNT<TIMx_CCR1  else        inactive. In downcounting, channel 1 is inactive ( OC1REF = С0 ) as long as TIMx_CNT > TIMx_CCR1 else active ( OC1REF = 1 ) .
.EQU  TIM2T5_CCMR1_OC2M_PWM2, 7 << 12    @ PWM mode 2 - In upcounting, channel 2 is inactive as long as TIMx_CNT<TIMx_CCR1 else        active. In downcounting, channel 1 is active as long as TIMx_CNT > TIMx_CCR1 else inactive.
.EQU  TIM2T5_CCMR1_OC2PE , 1 << 11    @ Output compare 2 preload enable
.EQU  TIM2T5_CCMR1_OC2FE , 1 << 10    @ Output compare 2 fast enable
.EQU  TIM2T5_CCMR1_OC1CE , 1 << 7     @ Output compare 1 clear enable
.EQU  TIM2T5_CCMR1_OC1M_N, 4          @  Output compare 1 mode
.EQU  TIM2T5_CCMR1_OC1M_FROZEN, 0     @ Frozen - The comparison between the output compare register TIMx_CCR1 and the counter     TIMx_CNT has no effect on the outputs. ( this mode is used to generate a timing base )
.EQU  TIM2T5_CCMR1_OC1M_ACT, 1 << 4    @ Set channel 1 to active level on match. OC1REF signal is forced high when the counter TIMx_CNT matches the capture/compare register 1 (TIMx_CCR1).
.EQU  TIM2T5_CCMR1_OC1M_INACT, 2 << 4    @ Set channel 1 to inactive level on match. OC1REF signal is forced low when the counter TIMx_CNT matches the capture/compare register 1 (TIMx_CCR1).
.EQU  TIM2T5_CCMR1_OC1M_TOGGLE, 3 << 4    @ Toggle - OC1REF toggles when TIMx_CNT=TIMx_CCR1.
.EQU  TIM2T5_CCMR1_OC1M_FORSEINACT, 4 << 4    @ Force inactive level - OC1REF is forced low.
.EQU  TIM2T5_CCMR1_OC1M_FORSEACT, 5 << 4    @ Force active level - OC1REF is forced high.
.EQU  TIM2T5_CCMR1_OC1M_PWM1, 6 << 4    @  PWM mode 1 - In upcounting, channel 1 is active as long as TIMx_CNT<TIMx_CCR1  else        inactive. In downcounting, channel 1 is inactive ( OC1REF = С0 ) as long as TIMx_CNT > TIMx_CCR1 else active ( OC1REF = 1 ) .
.EQU  TIM2T5_CCMR1_OC1M_PWM2, 7 << 4    @ PWM mode 2 - In upcounting, channel 1 is inactive as long as TIMx_CNT<TIMx_CCR1 else        active. In downcounting, channel 1 is active as long as TIMx_CNT > TIMx_CCR1 else inactive.
.EQU  TIM2T5_CCMR1_OC1PE , 1 << 3     @ Output compare 1 preload enable
.EQU  TIM2T5_CCMR1_OC1FE , 1 << 2     @ Output compare 1 fast enable

@.ITEM     TIM2T5_CCMR1_INPUT_CAPTURE_MODE
.EQU  TIM2T5_CCMR1_IC2F_N, 12         @ Input capture 2 filter
.EQU  TIM2T5_CCMR1_IC2F_NOF, 0        @ No filter, sampling is done at fDTS
.EQU  TIM2T5_CCMR1_IC2F_N2, 1 << 12    @ fSAMPLING=fCK_INT, N=2
.EQU  TIM2T5_CCMR1_IC2F_N4, 2 << 12    @ fSAMPLING=fCK_INT, N=4
.EQU  TIM2T5_CCMR1_IC2F_N8, 3 << 12    @ fSAMPLING=fCK_INT, N=8
.EQU  TIM2T5_CCMR1_IC2F_2N6, 4 << 12    @ fSAMPLING=fDTS/2, N=6
.EQU  TIM2T5_CCMR1_IC2F_2N8, 5 << 12    @ fSAMPLING=fDTS/2, N=8
.EQU  TIM2T5_CCMR1_IC2F_4N6, 6 << 12    @ fSAMPLING=fDTS/4, N=6
.EQU  TIM2T5_CCMR1_IC2F_4N8, 7 << 12    @ fSAMPLING=fDTS/4, N=8
.EQU  TIM2T5_CCMR1_IC2F_8N6, 8 << 12    @ fSAMPLING=fDTS/8, N=6
.EQU  TIM2T5_CCMR1_IC2F_8N8, 9 << 12    @ fSAMPLING=fDTS/8, N=8
.EQU  TIM2T5_CCMR1_IC2F_16N5, 10 << 12    @ fSAMPLING=fDTS/16, N=5
.EQU  TIM2T5_CCMR1_IC2F_16N6, 11 << 12    @ fSAMPLING=fDTS/16, N=6
.EQU  TIM2T5_CCMR1_IC2F_16N8, 12 << 12    @ fSAMPLING=fDTS/16, N=8
.EQU  TIM2T5_CCMR1_IC2F_32N5, 13 << 12    @ fSAMPLING=fDTS/32, N=5
.EQU  TIM2T5_CCMR1_IC2F_32N6, 14 << 12    @ fSAMPLING=fDTS/32, N=6
.EQU  TIM2T5_CCMR1_IC2F_32N8, 15 << 12    @ fSAMPLING=fDTS/32, N=8
.EQU  TIM2T5_CCMR1_IC2PSC_N, 8        @ Input capture 2 prescaler
.EQU  TIM2T5_CCMR1_IC2PSC_1, 0        @ no prescaler, capture is done each time an edge is detected on the capture input
.EQU  TIM2T5_CCMR1_IC2PSC_2, 1 << 8    @ capture is done once every 2 events
.EQU  TIM2T5_CCMR1_IC2PSC_4, 2 << 8    @ capture is done once every 4 events
.EQU  TIM2T5_CCMR1_IC2PSC_8, 3 << 8    @ capture is done once every 8 events
.EQU  TIM2T5_CCMR1_IC1F_N, 4          @ Input capture 1 filter
.EQU  TIM2T5_CCMR1_IC1F_NOF, 0        @ No filter, sampling is done at fDTS
.EQU  TIM2T5_CCMR1_IC1F_N2, 1 << 4    @ fSAMPLING=fCK_INT, N=2
.EQU  TIM2T5_CCMR1_IC1F_N4, 2 << 4    @ fSAMPLING=fCK_INT, N=4
.EQU  TIM2T5_CCMR1_IC1F_N8, 3 << 4    @ fSAMPLING=fCK_INT, N=8
.EQU  TIM2T5_CCMR1_IC1F_2N6, 4 << 4    @ fSAMPLING=fDTS/2, N=6
.EQU  TIM2T5_CCMR1_IC1F_2N8, 5 << 4    @ fSAMPLING=fDTS/2, N=8
.EQU  TIM2T5_CCMR1_IC1F_4N6, 6 << 4    @ fSAMPLING=fDTS/4, N=6
.EQU  TIM2T5_CCMR1_IC1F_4N8, 7 << 4    @ fSAMPLING=fDTS/4, N=8
.EQU  TIM2T5_CCMR1_IC1F_8N6, 8 << 4    @ fSAMPLING=fDTS/8, N=6
.EQU  TIM2T5_CCMR1_IC1F_8N8, 9 << 4    @ fSAMPLING=fDTS/8, N=8
.EQU  TIM2T5_CCMR1_IC1F_16N5, 10 << 4    @ fSAMPLING=fDTS/16, N=5
.EQU  TIM2T5_CCMR1_IC1F_16N6, 11 << 4    @ fSAMPLING=fDTS/16, N=6
.EQU  TIM2T5_CCMR1_IC1F_16N8, 12 << 4    @ fSAMPLING=fDTS/16, N=8
.EQU  TIM2T5_CCMR1_IC1F_32N5, 13 << 4    @ fSAMPLING=fDTS/32, N=5
.EQU  TIM2T5_CCMR1_IC1F_32N6, 14 << 4    @ fSAMPLING=fDTS/32, N=6
.EQU  TIM2T5_CCMR1_IC1F_32N8, 15 << 4    @ fSAMPLING=fDTS/32, N=8
.EQU  TIM2T5_CCMR1_IC1PSC_N, 2        @ Input capture 3 prescaler
.EQU  TIM2T5_CCMR1_IC1PSC_1, 0        @ no prescaler, capture is done each time an edge is detected on the capture input
.EQU  TIM2T5_CCMR1_IC1PSC_2, 1 << 2    @ capture is done once every 2 events
.EQU  TIM2T5_CCMR1_IC1PSC_4, 2 << 2    @ capture is done once every 4 events
.EQU  TIM2T5_CCMR1_IC1PSC_8, 3 << 2    @ capture is done once every 8 events



@.ITEM     TIM2T5_CCMR2
.EQU  TIM2T5_CCMR2_OUTPUT_COMPARE_MODE, 0
.EQU  TIM2T5_CCMR2_INPUT_CAPTURE_MODE, 0
.EQU  TIM2T5_CCMR2_CC4S_N, 8          @ Capture/Compare 4 selection
.EQU  TIM2T5_CCMR2_CC4S_OUT, 0        @ CC4 channel is configured as output
.EQU  TIM2T5_CCMR2_CC4S_TI2, 1 << 8    @ CC4 channel is configured as input, IC4 is mapped on TI4
.EQU  TIM2T5_CCMR2_CC4S_TI1, 2 << 8    @  CC4 channel is configured as input, IC4 is mapped on TI3
.EQU  TIM2T5_CCMR2_CC4S_TRC, 3 << 8    @ CC4 channel is configured as input, IC4 is mapped on TRC. This mode is working only if an internal trigger input is selected through TS bit (TIMx_SMCR register)
.EQU  TIM2T5_CCMR2_CC3S_N, 0
.EQU  TIM2T5_CCMR2_CC3S_OUT, 0        @ CC3 channel is configured as output
.EQU  TIM2T5_CCMR2_CC3S_TI3, 1        @ CC3 channel is configured as input, IC3 is mapped on TI3
.EQU  TIM2T5_CCMR2_CC3S_TI4, 2        @ CC3 channel is configured as input, IC3 is mapped on TI4
.EQU  TIM2T5_CCMR2_CC3S_TRC, 3        @ CC3 channel is configured as input, IC3 is mapped on TRC. This mode is working only if an internal trigger input is selected through TS bit (TIMx_SMCR register)

@.ITEM TIM2T5_CCMR2_OUTPUT_COMPARE_MODE
.EQU  TIM2T5_CCMR2_OC4CE , 1 << 15    @ Output compare 4 clear enable
.EQU  TIM2T5_CCMR2_OC4M_N, 12         @ Output compare 4 mode
.EQU  TIM2T5_CCMR2_OC4M_FROZEN, 0     @ Frozen - The comparison between the output compare register TIMx_CCR1 and the counter     TIMx_CNT has no effect on the outputs. ( this mode is used to generate a timing base )
.EQU  TIM2T5_CCMR2_OC4M_ACT, 1 << 12    @ Set channel 4 to active level on match. OC1REF signal is forced high when the counter TIMx_CNT matches the capture/compare register 1 (TIMx_CCR1).
.EQU  TIM2T5_CCMR2_OC4M_INACT, 2 << 12    @ Set channel 4 to inactive level on match. OC1REF signal is forced low when the counter TIMx_CNT matches the capture/compare register 1 (TIMx_CCR1).
.EQU  TIM2T5_CCMR2_OC4M_TOGGLE, 3 << 12    @ Toggle - OC4REF toggles when TIMx_CNT=TIMx_CCR1.
.EQU  TIM2T5_CCMR2_OC4M_FORSEINACT, 4 << 12    @ Force inactive level - OC4REF is forced low.
.EQU  TIM2T5_CCMR2_OC4M_FORSEACT, 5 << 12    @ Force active level - OC4REF is forced high.
.EQU  TIM2T5_CCMR2_OC4M_PWM1, 6 << 12    @  PWM mode 1 - In upcounting, channel 4 is active as long as TIMx_CNT<TIMx_CCR1  else        inactive. In downcounting, channel 1 is inactive ( OC1REF = С0 ) as long as TIMx_CNT > TIMx_CCR1 else active ( OC1REF = 1 ) .
.EQU  TIM2T5_CCMR2_OC4M_PWM2, 7 << 12    @ PWM mode 2 - In upcounting, channel 4 is inactive as long as TIMx_CNT<TIMx_CCR1 else        active. In downcounting, channel 1 is active as long as TIMx_CNT > TIMx_CCR1 else inactive.
.EQU  TIM2T5_CCMR2_OC4PE , 1 << 11    @ Output compare 4 preload enable
.EQU  TIM2T5_CCMR2_OC4FE , 1 << 10    @ Output compare 4 fast enable
.EQU  TIM2T5_CCMR2_OC3CE , 1 << 7     @ Output compare 3 clear enable
.EQU  TIM2T5_CCMR2_OC3M_N, 4          @  Output compare 3 mode
.EQU  TIM2T5_CCMR2_OC3M_FROZEN, 0     @ Frozen - The comparison between the output compare register TIMx_CCR1 and the counter     TIMx_CNT has no effect on the outputs. ( this mode is used to generate a timing base )
.EQU  TIM2T5_CCMR2_OC3M_ACT, 1 << 4    @ Set channel 3 to active level on match. OC1REF signal is forced high when the counter TIMx_CNT matches the capture/compare register 1 (TIMx_CCR1).
.EQU  TIM2T5_CCMR2_OC3M_INACT, 2 << 4    @ Set channel 3 to inactive level on match. OC1REF signal is forced low when the counter TIMx_CNT matches the capture/compare register 1 (TIMx_CCR1).
.EQU  TIM2T5_CCMR2_OC3M_TOGGLE, 3 << 4    @ Toggle - OC3REF toggles when TIMx_CNT=TIMx_CCR1.
.EQU  TIM2T5_CCMR2_OC3M_FORSEINACT, 4 << 4    @ Force inactive level - OC3REF is forced low.
.EQU  TIM2T5_CCMR2_OC3M_FORSEACT, 5 << 4    @ Force active level - OC3REF is forced high.
.EQU  TIM2T5_CCMR2_OC3M_PWM1, 6 << 4    @  PWM mode 1 - In upcounting, channel 3 is active as long as TIMx_CNT<TIMx_CCR1  else        inactive. In downcounting, channel 1 is inactive ( OC1REF = С0 ) as long as TIMx_CNT > TIMx_CCR1 else active ( OC1REF = 1 ) .
.EQU  TIM2T5_CCMR2_OC3M_PWM2, 7 << 4    @ PWM mode 2 - In upcounting, channel 3 is inactive as long as TIMx_CNT<TIMx_CCR1 else        active. In downcounting, channel 1 is active as long as TIMx_CNT > TIMx_CCR1 else inactive.
.EQU  TIM2T5_CCMR2_OC3PE , 1 << 3     @ Output compare 3 preload enable
.EQU  TIM2T5_CCMR2_OC3FE , 1 << 2     @ Output compare 3 fast enable

@.ITEM TIM2T5_CCMR2_INPUT_CAPTURE_MODE
.EQU  TIM2T5_CCMR2_IC4F_N, 12         @ Input capture 4 filter
.EQU  TIM2T5_CCMR2_IC4F_NOF, 0        @ No filter, sampling is done at fDTS
.EQU  TIM2T5_CCMR2_IC4F_N2, 1 << 12    @ fSAMPLING=fCK_INT, N=2
.EQU  TIM2T5_CCMR2_IC4F_N4, 2 << 12    @ fSAMPLING=fCK_INT, N=4
.EQU  TIM2T5_CCMR2_IC4F_N8, 3 << 12    @ fSAMPLING=fCK_INT, N=8
.EQU  TIM2T5_CCMR2_IC4F_2N6, 4 << 12    @ fSAMPLING=fDTS/2, N=6
.EQU  TIM2T5_CCMR2_IC4F_2N8, 5 << 12    @ fSAMPLING=fDTS/2, N=8
.EQU  TIM2T5_CCMR2_IC4F_4N6, 6 << 12    @ fSAMPLING=fDTS/4, N=6
.EQU  TIM2T5_CCMR2_IC4F_4N8, 7 << 12    @ fSAMPLING=fDTS/4, N=8
.EQU  TIM2T5_CCMR2_IC4F_8N6, 8 << 12    @ fSAMPLING=fDTS/8, N=6
.EQU  TIM2T5_CCMR2_IC4F_8N8, 9 << 12    @ fSAMPLING=fDTS/8, N=8
.EQU  TIM2T5_CCMR2_IC4F_16N5, 10 << 12    @ fSAMPLING=fDTS/16, N=5
.EQU  TIM2T5_CCMR2_IC4F_16N6, 11 << 12    @ fSAMPLING=fDTS/16, N=6
.EQU  TIM2T5_CCMR2_IC4F_16N8, 12 << 12    @ fSAMPLING=fDTS/16, N=8
.EQU  TIM2T5_CCMR2_IC4F_32N5, 13 << 12    @ fSAMPLING=fDTS/32, N=5
.EQU  TIM2T5_CCMR2_IC4F_32N6, 14 << 12    @ fSAMPLING=fDTS/32, N=6
.EQU  TIM2T5_CCMR2_IC4F_32N8, 15 << 12    @ fSAMPLING=fDTS/32, N=8
.EQU  TIM2T5_CCMR2_IC4PSC_N, 2        @ Input capture 4 prescaler
.EQU  TIM2T5_CCMR2_IC4PSC_1, 0        @ no prescaler, capture is done each time an edge is detected on the capture input
.EQU  TIM2T5_CCMR2_IC4PSC_2, 1 << 2    @ capture is done once every 2 events
.EQU  TIM2T5_CCMR2_IC4PSC_4, 2 << 2    @ capture is done once every 4 events
.EQU  TIM2T5_CCMR2_IC4PSC_8, 3 << 2    @ capture is done once every 8 events
.EQU  TIM2T5_CCMR2_IC3F_N, 4          @ Input capture 3 filter
.EQU  TIM2T5_CCMR2_IC3F_NOF, 0        @ No filter, sampling is done at fDTS
.EQU  TIM2T5_CCMR2_IC3F_N2, 1 << 4    @ fSAMPLING=fCK_INT, N=2
.EQU  TIM2T5_CCMR2_IC3F_N4, 2 << 4    @ fSAMPLING=fCK_INT, N=4
.EQU  TIM2T5_CCMR2_IC3F_N8, 3 << 4    @ fSAMPLING=fCK_INT, N=8
.EQU  TIM2T5_CCMR2_IC3F_2N6, 4 << 4    @ fSAMPLING=fDTS/2, N=6
.EQU  TIM2T5_CCMR2_IC3F_2N8, 5 << 4    @ fSAMPLING=fDTS/2, N=8
.EQU  TIM2T5_CCMR2_IC3F_4N6, 6 << 4    @ fSAMPLING=fDTS/4, N=6
.EQU  TIM2T5_CCMR2_IC3F_4N8, 7 << 4    @ fSAMPLING=fDTS/4, N=8
.EQU  TIM2T5_CCMR2_IC3F_8N6, 8 << 4    @ fSAMPLING=fDTS/8, N=6
.EQU  TIM2T5_CCMR2_IC3F_8N8, 9 << 4    @ fSAMPLING=fDTS/8, N=8
.EQU  TIM2T5_CCMR2_IC3F_16N5, 10 << 4    @ fSAMPLING=fDTS/16, N=5
.EQU  TIM2T5_CCMR2_IC3F_16N6, 11 << 4    @ fSAMPLING=fDTS/16, N=6
.EQU  TIM2T5_CCMR2_IC3F_16N8, 12 << 4    @ fSAMPLING=fDTS/16, N=8
.EQU  TIM2T5_CCMR2_IC3F_32N5, 13 << 4    @ fSAMPLING=fDTS/32, N=5
.EQU  TIM2T5_CCMR2_IC3F_32N6, 14 << 4    @ fSAMPLING=fDTS/32, N=6
.EQU  TIM2T5_CCMR2_IC3F_32N8, 15 << 4    @ fSAMPLING=fDTS/32, N=8
.EQU  TIM2T5_CCMR2_IC3PSC_N, 2        @ Input capture 3 prescaler
.EQU  TIM2T5_CCMR2_IC3PSC_1, 0        @ no prescaler, capture is done each time an edge is detected on the capture input
.EQU  TIM2T5_CCMR2_IC3PSC_2, 1 << 2    @ capture is done once every 2 events
.EQU  TIM2T5_CCMR2_IC3PSC_4, 2 << 2    @ capture is done once every 4 events
.EQU  TIM2T5_CCMR2_IC3PSC_8, 3 << 2    @ capture is done once every 8 events

@.ITEM TIM2T5_CCER
.EQU  TIM2T5_CCER_CC4NP  , 1 << 15    @  Capture/Compare 4 output Polarity
.EQU  TIM2T5_CCER_CC4P   , 1 << 13    @  Capture/Compare 4 output Polarity
.EQU  TIM2T5_CCER_CC4E   , 1 << 12    @  Capture/Compare 4 output Polarity
.EQU  TIM2T5_CCER_CC3NP  , 1 << 11    @  Capture/Compare 3 output Polarity
.EQU  TIM2T5_CCER_CC3P   , 1 << 9     @  Capture/Compare 3 output Polarity
.EQU  TIM2T5_CCER_CC3E   , 1 << 8     @  Capture/Compare 3 output Polarity
.EQU  TIM2T5_CCER_CC2NP  , 1 << 7     @  Capture/Compare 2 output Polarity
.EQU  TIM2T5_CCER_CC2P   , 1 << 5     @  Capture/Compare 2 output Polarity
.EQU  TIM2T5_CCER_CC2E   , 1 << 4     @  Capture/Compare 2 output Polarity
.EQU  TIM2T5_CCER_CC1NP  , 1 << 3     @  Capture/Compare 1 output Polarity
.EQU  TIM2T5_CCER_CC1P   , 1 << 1     @  Capture/Compare 1 output Polarity
.EQU  TIM2T5_CCER_CC1E   , 1 << 0     @  Capture/Compare 1 output Polarity

@.ITEM     TIM2T5_DCR
.EQU  TIM2T5_DCR_DBL_N   , 8          @ DMA burst length
.EQU  TIM2T5_DCR_1TR     , 0          @ 1 transfer
.EQU  TIM2T5_DCR_2TR     , 1 << 8     @ 2 transfer
.EQU  TIM2T5_DCR_3TR     , 2 << 8
.EQU  TIM2T5_DCR_4TR     , 3 << 8
.EQU  TIM2T5_DCR_5TR     , 4 << 8
.EQU  TIM2T5_DCR_6TR     , 5 << 8
.EQU  TIM2T5_DCR_7TR     , 6 << 8
.EQU  TIM2T5_DCR_8TR     , 7 << 8
.EQU  TIM2T5_DCR_9TR     , 8 << 8
.EQU  TIM2T5_DCR_10TR    , 9 << 8
.EQU  TIM2T5_DCR_11TR    , 10 << 8
.EQU  TIM2T5_DCR_12TR    , 11 << 8
.EQU  TIM2T5_DCR_13TR    , 12 << 8
.EQU  TIM2T5_DCR_14TR    , 13 << 8
.EQU  TIM2T5_DCR_15TR    , 14 << 8
.EQU  TIM2T5_DCR_16TR    , 15 << 8
.EQU  TIM2T5_DCR_17TR    , 16 << 8
.EQU  TIM2T5_DCR_18TR    , 17 << 8
.EQU  TIM2T5_DCR_DBA_N   , 0          @ DMA base adress

@.ITEM     TIM2_OR
.EQU  TIM2_OR_ITR1_RMP_N , 10         @ Internal trigger 1 remap
.EQU  TIM2_OR_ITR1_RMP_TRGOUT, 0
.EQU  TIM2_OR_ITR1_RMP_PTR_TO_ITR1, 1 << 10
.EQU  TIM2_OR_ITR1_RMP_FS_TO_ITR1, 2 << 10
.EQU  TIM2_OR_ITR1_RMP_HS_TO_ITR1, 3 << 10

@.ITEM     TIM5_OR
.EQU  TIM5_OR_TI4_RMP_N  , 6          @ Timer Input 4 remap
.EQU  TIM5_OR_TI4_RMP_TRGOUT, 0       @ TIM5 Channel4 is connected to the GPIO: Refer to the Alternate function mapping table in the datasheets
.EQU  TIM5_OR_TI4_RMP_LSI_TO_CH4, 1 << 6
.EQU  TIM5_OR_TI4_RMP_LSE_TO_CH4, 2 << 6
.EQU  TIM5_OR_TI4_RMP_RTC_TO_CH4, 3 << 6



