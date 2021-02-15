@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                     Базовые константы RCC                        |
@ +------------------------------------------------------------------+
@.enddesc


.include "/src/inc/base.inc"

@.item AHB1PERIPH_BASE
.equ     RCC_BASE     , (AHB1PERIPH_BASE + 0x3800) @ Базовый адрес RCC
@.end

@.item RCC_BASE
.equ RCC_CR       , 0x00 @ RCC clock control register
.equ RCC_PLLCFGR  , 0x04 @ RCC PLL configuration register
.equ RCC_CFGR     , 0x08 @ RCC clock configuration register
.equ RCC_CIR      , 0x0C @ RCC clock interrupt register
.equ RCC_AHB1RSTR , 0x10 @ RCC AHB1 peripheral reset register
.equ RCC_AHB2RSTR , 0x14 @ RCC AHB2 peripheral reset register
.equ RCC_AHB3RSTR , 0x18 @ RCC AHB3 peripheral reset register
.equ RCC_APB1RSTR , 0x20 @ RCC APB1 peripheral reset register
.equ RCC_APB2RSTR , 0x24 @ RCC APB2 peripheral reset register
.equ RCC_AHB1ENR  , 0x30 @ RCC AHB1 peripheral clock register
.equ RCC_AHB2ENR  , 0x34 @ RCC AHB2 peripheral clock enable register
.equ RCC_AHB3ENR  , 0x38 @ RCC AHB3 peripheral clock enable register
.equ RCC_APB1ENR  , 0x40 @ RCC APB1 peripheral clock enable register
.equ RCC_APB2ENR  , 0x44 @ RCC APB1 peripheral clock enable register
.equ RCC_AHB1LPENR, 0x50 @ RCC AHB1 peripheral clock enable in low power mode register
.equ RCC_AHB2LPENR, 0x54 @ RCC AHB2 peripheral clock enable in low power mode register
.equ RCC_AHB3LPENR, 0x58 @ RCC AHB3 peripheral clock enable in low power mode register
.equ RCC_APB1LPENR, 0x60 @ RCC APB1 peripheral clock enable in low power mode register
.equ RCC_APB2LPENR, 0x64 @ RCC APB2 peripheral clock enabled in low power mode register
.equ RCC_BDCR     , 0x70 @ RCC Backup domain control register
.equ RCC_CSR      , 0x74 @ RCC clock control & status register
.equ RCC_SSCGR    , 0x80 @ RCC spread spectrum clock generation register
.equ RCC_PLLI2SCFGR     , 0x84 @ RCC PLLI2S configuration register
.equ RCC_PLLSAICFGR, 0x88 @ RCC PLL configuration register
.equ RCC_DCKCFGR  , 0x8C @ RCC Dedicated Clock Configuration Register
@.end

@.item RCC_CR
.equ RCC_CR_HSION              , 0x00000001 @ Bit 0 HSION: Internal high-speed clock enable
.equ RCC_CR_HSION_N            , 0
.equ RCC_CR_HSIRDY             , 0x00000002 @ Bit 1 HSIRDY: Internal high-speed clock ready flag
.equ RCC_CR_HSIRDY_N           , 1
.equ RCC_CR_HSITRIM_N          , 3 @ Bits 7:3 HSITRIM[4:0]: Internal high-speed clock trimming
.equ RCC_CR_HSICAL_N           , 8 @ Bits 15:8 HSICAL[7:0]: Internal high-speed clock calibration
.equ RCC_CR_HSEON              , 0x00010000 @ Bit 16 HSEON: HSE clock enable
.equ RCC_CR_HSEON_N            , 16
.equ RCC_CR_HSERDY             , 0x00020000 @ Bit 17 HSERDY: HSE clock ready flag
.equ RCC_CR_HSERDY_N           , 17
.equ RCC_CR_HSEBYP             , 0x00040000 @ Bit 18 HSEBYP: HSE clock bypass
.equ RCC_CR_HSEBYP_N           , 18
.equ RCC_CR_CSSON              , 0x00080000 @ Bit 19 CSSON: Clock security system enable
.equ RCC_CR_CSSON_N            , 19
.equ RCC_CR_PLLON              , 0x01000000 @ Bit 24 PLLON: Main PLL (PLL) enable
.equ RCC_CR_PLLON_N            , 24
.equ RCC_CR_PLLRDY             , 0x02000000 @ Bit 25 PLLRDY: Main PLL (PLL) clock ready flag
.equ RCC_CR_PLLRDY_N           , 25
.equ RCC_CR_PLLI2SON           , 0x04000000 @ Bit 26 PLLI2SON: PLLI2S enable
.equ RCC_CR_PLLI2SON_N         , 26
.equ RCC_CR_PLLI2SRDY          , 0x08000000 @ Bit 27 PLLI2SRDY: PLLI2S clock ready flag
.equ RCC_CR_PLLI2SRDY_N        , 27
.equ RCC_CR_PLLSAION           , 0x10000000 @ Bit 28 PLLSAION: PLLSAI enable
.equ RCC_CR_PLLSAION_N         , 28
.equ RCC_CR_PLLSAIRDY          , 0x20000000 @ Bit 29 PLLSAIRDY: PLLSAI clock ready flag
.equ RCC_CR_PLLSAIRDY_N        , 29
@.end

@.item RCC_PLLCFGR
.equ  RCC_PLLCFGR_PLLM_N       , 0 @ Bits 5:0 PLLM: Division factor for the main PLL (PLL) and audio PLL (PLLI2S) input clock
.equ  RCC_PLLCFGR_PLLN_N       , 6 @ Bits 14:6 PLLN: Main PLL (PLL) multiplication factor for VCO
.equ  RCC_PLLCFGR_PLLP_N       , 16 @ Bits 17:16 PLLP: Main PLL (PLL) division factor for main system clock
.equ  RCC_PLLCFGR_PLLP_2       , 0x00000000
.equ  RCC_PLLCFGR_PLLP_4       , 0x00010000
.equ  RCC_PLLCFGR_PLLP_6       , 0x00020000
.equ  RCC_PLLCFGR_PLLP_8       , 0x00030000
.equ  RCC_PLLCFGR_PLLSRC_N     , 22 @ Bit 22 PLLSRC: Main PLL(PLL) and audio PLL (PLLI2S) entry clock source
.equ  RCC_PLLCFGR_PLLSRC_HSE   , 0x00400000
.equ  RCC_PLLCFGR_PLLSRC_HSI   , 0x00000000
.equ  RCC_PLLCFGR_PLLQ_N       , 24 @ Bits 27:24 PLLQ: Main PLL (PLL) division factor for USB OTG FS, SDIO and random number generator clocks
.equ  RCC_PLLCFGR_PLLQ_2       , 2<<24
.equ  RCC_PLLCFGR_PLLQ_3       , 3<<24
.equ  RCC_PLLCFGR_PLLQ_4       , 4<<24
.equ  RCC_PLLCFGR_PLLQ_5       , 5<<24
.equ  RCC_PLLCFGR_PLLQ_6       , 6<<24
.equ  RCC_PLLCFGR_PLLQ_7       , 7<<24
.equ  RCC_PLLCFGR_PLLQ_8       , 8<<24
.equ  RCC_PLLCFGR_PLLQ_9       , 9<<24
.equ  RCC_PLLCFGR_PLLQ_10      , 10<<24
.equ  RCC_PLLCFGR_PLLQ_11      , 11<<24
.equ  RCC_PLLCFGR_PLLQ_12      , 12<<24
.equ  RCC_PLLCFGR_PLLQ_13      , 13<<24
.equ  RCC_PLLCFGR_PLLQ_14      , 14<<24
.equ  RCC_PLLCFGR_PLLQ_15      , 15<<24
@.end

@.item RCC_CFGR
.equ  RCC_CFGR_SW_HSI          , 0x00000000 @ Bits 1:0 SW: System clock switch
.equ  RCC_CFGR_SW_HSE          , 0x00000001
.equ  RCC_CFGR_SW_PLL          , 0x00000002
.equ  RCC_CFGR_SWS_N           , 2 @ Bits 3:2 SWS: System clock switch status
.equ  RCC_CFGR_SWS_HSI         , 0x00
.equ  RCC_CFGR_SWS_HSE         , 0x04
.equ  RCC_CFGR_SWS_PLL         , 0x08
.equ  RCC_CFGR_HPRE_DIV1       , 0x00000000 @ Bits 7:4 HPRE: AHB prescaler
.equ  RCC_CFGR_HPRE_DIV2       , 0x00000080
.equ  RCC_CFGR_HPRE_DIV4       , 0x00000090
.equ  RCC_CFGR_HPRE_DIV8       , 0x000000A0
.equ  RCC_CFGR_HPRE_DIV16      , 0x000000B0
.equ  RCC_CFGR_HPRE_DIV64      , 0x000000C0
.equ  RCC_CFGR_HPRE_DIV128     , 0x000000D0
.equ  RCC_CFGR_HPRE_DIV256     , 0x000000E0
.equ  RCC_CFGR_HPRE_DIV512     , 0x000000F0
.equ  RCC_CFGR_PPRE1_DIV1      , 0x00000000 @ Bits 12:10 PPRE1: APB Low speed prescaler (APB1)
.equ  RCC_CFGR_PPRE1_DIV2      , 0x00001000
.equ  RCC_CFGR_PPRE1_DIV4      , 0x00001400
.equ  RCC_CFGR_PPRE1_DIV8      , 0x00001800
.equ  RCC_CFGR_PPRE1_DIV16     , 0x00001C00
.equ  RCC_CFGR_PPRE2_DIV1      , 0x00000000 @ Bits 15:13 PPRE2: APB high-speed prescaler (APB2)
.equ  RCC_CFGR_PPRE2_DIV2      , 0x00008000
.equ  RCC_CFGR_PPRE2_DIV4      , 0x0000A000
.equ  RCC_CFGR_PPRE2_DIV8      , 0x0000C000
.equ  RCC_CFGR_PPRE2_DIV16     , 0x0000E000
.equ  RCC_CFGR_RTCPRE_N        , 16 @ Bits 20:16 RTCPRE: HSE division factor for RTC clock
.equ  RCC_CFGR_MCO1_HSI        , 0x00 @ Bits 22:21 MCO1: Microcontroller clock output 1
.equ  RCC_CFGR_MCO1_LSE        , 0x01<<21
.equ  RCC_CFGR_MCO1_HSE        , 0x02<<21
.equ  RCC_CFGR_MCO1_PLL        , 0x03<<21
.equ  RCC_CFGR_I2SSRC          , 0x00800000 @ Bit 23 I2SSRC: I2S clock selection
.equ  RCC_CFGR_MCO1PRE_DIV1    , 0x00 @ Bits 24:26 MCO1PRE: MCO1 prescaler
.equ  RCC_CFGR_MCO1PRE_DIV2    , 4<<24
.equ  RCC_CFGR_MCO1PRE_DIV3    , 5<<24
.equ  RCC_CFGR_MCO1PRE_DIV4    , 6<<24
.equ  RCC_CFGR_MCO1PRE_DIV5    , 7<<24
.equ  RCC_CFGR_MCO1PRE_N       , 24
.equ  RCC_CFGR_MCO2PRE_DIV1    , 0x00 @ Bits 27:29 MCO2PRE: MCO2 prescaler
.equ  RCC_CFGR_MCO2PRE_DIV2    , 4<<27
.equ  RCC_CFGR_MCO2PRE_DIV3    , 5<<27
.equ  RCC_CFGR_MCO2PRE_DIV4    , 6<<27
.equ  RCC_CFGR_MCO2PRE_DIV5    , 7<<27
.equ  RCC_CFGR_MCO2PRE_N       , 27
.equ  RCC_CFGR_MCO2_SYSCLK     , 0x00 @ Bits 31:30 MCO2[1:0]: Microcontroller clock output 2
.equ  RCC_CFGR_MCO2_PLLI2S     , 1<<30
.equ  RCC_CFGR_MCO2_HSE        , 2<<30
.equ  RCC_CFGR_MCO2_PLL        , 3<<30
.equ  RCC_CFGR_MCO2_N          , 30
@.end

@.item RCC_CIR
.equ  RCC_CIR_LSIRDYF_N           , 0 @ Bit 0 LSIRDYF: LSI ready interrupt flag
.equ  RCC_CIR_LSIRDYF            , 0x00000001
.equ  RCC_CIR_LSERDYF_N          , 1 @ Bit 1 LSERDYF: LSE ready interrupt flag
.equ  RCC_CIR_LSERDYF            , 0x00000002
.equ  RCC_CIR_HSIRDYF_N          , 2 @ Bit 2 HSIRDYF: HSI ready interrupt flag
.equ  RCC_CIR_HSIRDYF            , 0x00000004
.equ  RCC_CIR_HSERDYF_N          , 3 @ Bit 3 HSERDYF: HSE ready interrupt flag
.equ  RCC_CIR_HSERDYF            , 0x00000008
.equ  RCC_CIR_PLLRDYF_N          , 4 @ Bit 4 PLLRDYF: Main PLL (PLL) ready interrupt flag
.equ  RCC_CIR_PLLRDYF            , 0x00000010
.equ  RCC_CIR_PLLI2SRDYF_N       , 5 @ Bit 5 PLLI2SRDYF: PLLI2S ready interrupt flag
.equ  RCC_CIR_PLLI2SRDYF         , 0x00000020
.equ  RCC_CIR_PLLSAIRDYF_N      , 6 @ Bit 6 PLLSAIRDYF: PLLSAI Ready Interrupt flag
.equ  RCC_CIR_PLLSAIRDYF         , 0x00000040
.equ  RCC_CIR_CSSF_N             , 7 @ Bit 7 CSSF: Clock security system interrupt flag
.equ  RCC_CIR_CSSF               , 0x00000080
.equ  RCC_CIR_LSIRDYIE_N         , 8 @ Bit 8 LSIRDYIE: LSI ready interrupt enable
.equ  RCC_CIR_LSIRDYIE           , 0x00000100
.equ  RCC_CIR_LSERDYIE_N         , 9 @ Bit 9 LSERDYIE: LSE ready interrupt enable
.equ  RCC_CIR_LSERDYIE           , 0x00000200
.equ  RCC_CIR_HSIRDYIE_N         , 10 @ Bit 10 HSIRDYIE: HSI ready interrupt enable
.equ  RCC_CIR_HSIRDYIE           , 0x00000400
.equ  RCC_CIR_HSERDYIE_N         , 11 @ Bit 11 HSERDYIE: HSE ready interrupt enable
.equ  RCC_CIR_HSERDYIE           , 0x00000800
.equ  RCC_CIR_PLLRDYIE_N         , 12 @ Bit 12 PLLRDYIE: Main PLL (PLL) ready interrupt enable
.equ  RCC_CIR_PLLRDYIE           , 0x00001000
.equ  RCC_CIR_PLLI2SRDYIE_N      , 13 @ Bit 13 PLLI2SRDYIE: PLLI2S ready interrupt enable
.equ  RCC_CIR_PLLI2SRDYIE        , 0x00002000
.equ  RCC_CIR_LSIRDYC_N          , 14 @ Bit 14 PLLSAIRDYIE: PLLSAI Ready Interrupt Enable
.equ  RCC_CIR_LSIRDYC            , 0x00004000
.equ  RCC_CIR_LSERDYC_N          , 16 @ Bit 16 LSIRDYC: LSI ready interrupt clear
.equ  RCC_CIR_LSERDYC            , 0x00010000
.equ  RCC_CIR_HSIRDYC_N          , 17 @ Bit 17 LSERDYC: LSE ready interrupt clear
.equ  RCC_CIR_HSIRDYC            , 0x00020000
.equ  RCC_CIR_HSERDYC_N          , 18 @ Bit 18 HSIRDYC: HSI ready interrupt clear
.equ  RCC_CIR_HSERDYC            , 0x00040000
.equ  RCC_CIR_PLLRDYC_N          , 19 @ Bit 19 HSERDYC: HSE ready interrupt clear
.equ  RCC_CIR_PLLRDYC            , 0x00080000
.equ  RCC_CIR_PLLI2SRDYC_N       , 20 @ Bit 20 PLLRDYC: Main PLL(PLL) ready interrupt clear
.equ  RCC_CIR_PLLI2SRDYC         , 0x00100000
.equ  RCC_CIR_PLLI2SRDYC_N       , 21 @ Bit 21 PLLI2SRDYC: PLLI2S ready interrupt clear
.equ  RCC_CIR_PLLI2SRDYC         , 0x00200000
.equ  RCC_CIR_PLLSAIRDYC_N       , 22 @ Bit 22 PLLSAIRDYC: PLLSAI Ready Interrupt Clear
.equ  RCC_CIR_PLLSAIRDYC         , 0x00400000
.equ  RCC_CIR_CSSC_N             , 23 @ Bit 23 CSSC: Clock security system interrupt clear
.equ  RCC_CIR_CSSC               , 0x00800000
@.end

@.item RCC_AHB1RSTR
.equ  RCC_AHB1RSTR_GPIOARST      ,0x00000001
.equ  RCC_AHB1RSTR_GPIOBRST      ,0x00000002
.equ  RCC_AHB1RSTR_GPIOCRST      ,0x00000004
.equ  RCC_AHB1RSTR_GPIODRST      ,0x00000008
.equ  RCC_AHB1RSTR_GPIOERST      ,0x00000010
.equ  RCC_AHB1RSTR_GPIOFRST      ,0x00000020
.equ  RCC_AHB1RSTR_GPIOGRST      ,0x00000040
.equ  RCC_AHB1RSTR_GPIOHRST      ,0x00000080
.equ  RCC_AHB1RSTR_GPIOIRST      ,0x00000100
.equ  RCC_AHB1RSTR_CRCRST        ,0x00001000
.equ  RCC_AHB1RSTR_DMA1RST       ,0x00200000
.equ  RCC_AHB1RSTR_DMA2RST       ,0x00400000
.equ  RCC_AHB1RSTR_ETHMACRST     ,0x02000000
.equ  RCC_AHB1RSTR_OTGHRST       ,0x10000000
@.end

@.item RCC_AHB2RSTR
.equ  RCC_AHB2RSTR_DCMIRST       ,0x00000001
.equ  RCC_AHB2RSTR_CRYPRST       ,0x00000010
.equ  RCC_AHB2RSTR_HSAHRST       ,0x00000020
.equ  RCC_AHB2RSTR_RNGRST        ,0x00000040
.equ  RCC_AHB2RSTR_OTGFSRST      ,0x00000080
@.end

@.item RCC_AHB3RSTR
.equ  RCC_AHB3RSTR_FSMCRST       ,0x00000001
@.end

@.item RCC_APB1RSTR
.equ  RCC_APB1RSTR_TIM2RST       ,0x00000001
.equ  RCC_APB1RSTR_TIM3RST       ,0x00000002
.equ  RCC_APB1RSTR_TIM4RST       ,0x00000004
.equ  RCC_APB1RSTR_TIM5RST       ,0x00000008
.equ  RCC_APB1RSTR_TIM6RST       ,0x00000010
.equ  RCC_APB1RSTR_TIM7RST       ,0x00000020
.equ  RCC_APB1RSTR_TIM12RST      ,0x00000040
.equ  RCC_APB1RSTR_TIM13RST      ,0x00000080
.equ  RCC_APB1RSTR_TIM14RST      ,0x00000100
.equ  RCC_APB1RSTR_WWDGEN        ,0x00000800
.equ  RCC_APB1RSTR_SPI2RST       ,0x00008000
.equ  RCC_APB1RSTR_SPI3RST       ,0x00010000
.equ  RCC_APB1RSTR_USART2RST     ,0x00020000
.equ  RCC_APB1RSTR_USART3RST     ,0x00040000
.equ  RCC_APB1RSTR_UART4RST      ,0x00080000
.equ  RCC_APB1RSTR_UART5RST      ,0x00100000
.equ  RCC_APB1RSTR_I2C1RST       ,0x00200000
.equ  RCC_APB1RSTR_I2C2RST       ,0x00400000
.equ  RCC_APB1RSTR_I2C3RST       ,0x00800000
.equ  RCC_APB1RSTR_CAN1RST       ,0x02000000
.equ  RCC_APB1RSTR_CAN2RST       ,0x04000000
.equ  RCC_APB1RSTR_PWRRST        ,0x10000000
.equ  RCC_APB1RSTR_DACRST        ,0x20000000
@.end

@.item RCC_APB2RSTR
.equ  RCC_APB2RSTR_TIM1RST       ,0x00000001
.equ  RCC_APB2RSTR_TIM8RST       ,0x00000002
.equ  RCC_APB2RSTR_USART1RST     ,0x00000010
.equ  RCC_APB2RSTR_USART6RST     ,0x00000020
.equ  RCC_APB2RSTR_ADCRST        ,0x00000100
.equ  RCC_APB2RSTR_SDIORST       ,0x00000800
.equ  RCC_APB2RSTR_SPI1RST       ,0x00001000
.equ  RCC_APB2RSTR_SYSCFGRST     ,0x00004000
.equ  RCC_APB2RSTR_TIM9RST       ,0x00010000
.equ  RCC_APB2RSTR_TIM10RST      ,0x00020000
.equ  RCC_APB2RSTR_TIM11RST      ,0x00040000
@.end

@.item RCC_AHB1ENR
.equ  RCC_AHB1ENR_GPIOAEN        ,0x00000001 @ Bit 0 GPIOAEN: IO port A clock enable
.equ  RCC_AHB1ENR_GPIOAEN_N      ,0x00
.equ  RCC_AHB1ENR_GPIOBEN        ,0x00000002 @ Bit 1 GPIOBEN: IO port B clock enable
.equ  RCC_AHB1ENR_GPIOBEN_N      ,0x01
.equ  RCC_AHB1ENR_GPIOCEN        ,0x00000004 @ Bit 2 GPIOCEN: IO port C clock enable
.equ  RCC_AHB1ENR_GPIOCEN_N      ,0x02
.equ  RCC_AHB1ENR_GPIODEN        ,0x00000008 @ Bit 3 GPIODEN: IO port D clock enable
.equ  RCC_AHB1ENR_GPIODEN_N      ,0x03
.equ  RCC_AHB1ENR_GPIOEEN        ,0x00000010 @ Bit 4 GPIOEEN: IO port E clock enable
.equ  RCC_AHB1ENR_GPIOEEN_N      ,0x04
.equ  RCC_AHB1ENR_GPIOFEN_N      ,0x05 @ Bit 5 GPIOFEN: IO port F clock enable
.equ  RCC_AHB1ENR_GPIOFEN        ,0x00000020
.equ  RCC_AHB1ENR_GPIOGEN_N      ,0x06 @ Bit 6 GPIOGEN: IO port G clock enable
.equ  RCC_AHB1ENR_GPIOGEN        ,0x00000040
.equ  RCC_AHB1ENR_GPIOHEN_N      ,0x07 @ Bit 7 GPIOHEN: IO port H clock enable
.equ  RCC_AHB1ENR_GPIOHEN        ,0x00000080
.equ  RCC_AHB1ENR_GPIOIEN_N      ,0x08 @ Bit 8 GPIOIEN: IO port I clock enable
.equ  RCC_AHB1ENR_GPIOIEN        ,0x00000100
.equ  RCC_AHB1ENR_GPIOJEN_N      ,0x09 @ Bit 9 GPIOJEN: IO port J clock enable
.equ  RCC_AHB1ENR_GPIOJEN        ,0x00000200
.equ  RCC_AHB1ENR_GPIOKEN_N      ,10 @ Bit 10 GPIOKEN: IO port J clock enable
.equ  RCC_AHB1ENR_GPIOKEN        ,0x00000400
.equ  RCC_AHB1ENR_CRCEN_N        ,12 @ Bit 12 CRCEN: CRC clock enable
.equ  RCC_AHB1ENR_CRCEN          ,0x00001000
.equ  RCC_AHB1ENR_BKPSRAMEN_N    ,18 @ Bit 18 BKPSRAMEN: Backup SRAM interface clock enable
.equ  RCC_AHB1ENR_BKPSRAMEN      ,0x00040000
.equ  RCC_AHB1ENR_CCMDATARAMEN_N ,20 @ Bit 20 CCMDATARAMEN: CCM data RAM clock enable
.equ  RCC_AHB1ENR_CCMDATARAMEN   ,0x00100000
.equ  RCC_AHB1ENR_DMA1EN_N       ,21 @ Bit 21 DMA1EN: DMA1 clock enable
.equ  RCC_AHB1ENR_DMA1EN         ,0x00200000
.equ  RCC_AHB1ENR_DMA2EN_N       ,22 @ Bit 22 DMA2EN: DMA2 clock enable
.equ  RCC_AHB1ENR_DMA2EN         ,0x00400000
.equ  RCC_AHB1ENR_DMA2DEN_N      ,23 @ Bit 23 DMA2DEN: DMA2D clock enable
.equ  RCC_AHB1ENR_DMA2DEN        ,0x00800000
.equ  RCC_AHB1ENR_ETHMACEN_N     ,25 @ Bit 25 ETHMACEN: Ethernet MAC clock enable
.equ  RCC_AHB1ENR_ETHMACEN       ,0x02000000
.equ  RCC_AHB1ENR_ETHMACTXEN_N   ,26 @ Bit 26 ETHMACTXEN: Ethernet Transmission clock enable
.equ  RCC_AHB1ENR_ETHMACTXEN     ,0x04000000
.equ  RCC_AHB1ENR_ETHMACRXEN_N   ,27 @ Bit 27 ETHMACRXEN: Ethernet Reception clock enable
.equ  RCC_AHB1ENR_ETHMACRXEN     ,0x08000000
.equ  RCC_AHB1ENR_ETHMACPTPEN_N  ,28 @ Bit 28 ETHMACPTPEN: Ethernet PTP clock enable
.equ  RCC_AHB1ENR_ETHMACPTPEN    ,0x10000000
.equ  RCC_AHB1ENR_OTGHSEN_N      ,29 @ Bit 29 OTGHSEN: USB OTG HS clock enable
.equ  RCC_AHB1ENR_OTGHSEN        ,0x20000000
.equ  RCC_AHB1ENR_OTGHSULPIEN_N  ,30 @ Bit 30 OTGHSULPIEN: USB OTG HSULPI clock enable
.equ  RCC_AHB1ENR_OTGHSULPIEN    ,0x40000000
@.end

@.item RCC_AHB2ENR
.equ  RCC_AHB2ENR_DCMIEN_N       , 0 @ Bit 0 DCMIEN: Camera interface enable
.equ  RCC_AHB2ENR_DCMIEN         ,0x00000001
.equ  RCC_AHB2ENR_CRYPEN_N       , 4 @ Bit 4 CRYPEN: Cryptographic modules clock enable
.equ  RCC_AHB2ENR_CRYPEN         ,0x00000010
.equ  RCC_AHB2ENR_HASHEN_N       , 5 @ Bit 5 HASHEN: Hash modules clock enable
.equ  RCC_AHB2ENR_HASHEN         ,0x00000020
.equ  RCC_AHB2ENR_RNGEN_N        , 6 @ Bit 6 RNGEN: Random number generator clock enable
.equ  RCC_AHB2ENR_RNGEN          ,0x00000040
.equ  RCC_AHB2ENR_OTGFSEN_N      , 7 @ Bit 7 OTGFSEN: USB OTG FS clock enable
.equ  RCC_AHB2ENR_OTGFSEN        ,0x00000080
@.end

@.item RCC_AHB3ENR
.equ  RCC_AHB3ENR_FSMCEN_N       , 0 @ Bit 0 FMCEN: Flexible memory controller module clock enable
.equ  RCC_AHB3ENR_FSMCEN         ,0x00000001
@.end

@.item RCC_APB1ENR
.equ  RCC_APB1ENR_TIM2EN_N       , 0 @ Bit 0 TIM2EN: TIM2 clock enable
.equ  RCC_APB1ENR_TIM2EN         ,0x00000001
.equ  RCC_APB1ENR_TIM3EN_N       , 1 @ Bit 1 TIM3EN: TIM3 clock enable
.equ  RCC_APB1ENR_TIM3EN         ,0x00000002
.equ  RCC_APB1ENR_TIM4EN_N       , 2 @ Bit 2 TIM4EN: TIM4 clock enable
.equ  RCC_APB1ENR_TIM4EN         ,0x00000004
.equ  RCC_APB1ENR_TIM5EN_N       , 3 @ Bit 3 TIM5EN: TIM5 clock enable
.equ  RCC_APB1ENR_TIM5EN         ,0x00000008
.equ  RCC_APB1ENR_TIM6EN_N       , 4 @ Bit 4 TIM6EN: TIM6 clock enable
.equ  RCC_APB1ENR_TIM6EN         ,0x00000010
.equ  RCC_APB1ENR_TIM7EN_N       , 5 @ Bit 5 TIM7EN: TIM7 clock enable
.equ  RCC_APB1ENR_TIM7EN         ,0x00000020
.equ  RCC_APB1ENR_TIM12EN_N      , 6 @ Bit 6 TIM12EN: TIM12 clock enable
.equ  RCC_APB1ENR_TIM12EN        ,0x00000040
.equ  RCC_APB1ENR_TIM13EN_N      , 7 @ Bit 7 TIM13EN: TIM13 clock enable
.equ  RCC_APB1ENR_TIM13EN        ,0x00000080
.equ  RCC_APB1ENR_TIM14EN_N      , 8 @ Bit 8 TIM14EN: TIM14 clock enable
.equ  RCC_APB1ENR_TIM14EN        ,0x00000100
.equ  RCC_APB1ENR_WWDGEN_N       , 11 @ Bit 11 WWDGEN: Window watchdog clock enable
.equ  RCC_APB1ENR_WWDGEN         ,0x00000800
.equ  RCC_APB1ENR_SPI2EN_N       , 14 @ Bit 14 SPI2EN: SPI2 clock enable
.equ  RCC_APB1ENR_SPI2EN         ,0x00004000
.equ  RCC_APB1ENR_SPI3EN_N       , 15 @ Bit 15 SPI3EN: SPI3 clock enable
.equ  RCC_APB1ENR_SPI3EN         ,0x00008000
.equ  RCC_APB1ENR_USART2EN_N     , 17 @ Bit 17 USART2EN: USART2 clock enable
.equ  RCC_APB1ENR_USART2EN       ,0x00020000
.equ  RCC_APB1ENR_USART3EN_N     , 18 @ Bit 18 USART3EN: USART3 clock enable
.equ  RCC_APB1ENR_USART3EN       ,0x00040000
.equ  RCC_APB1ENR_UART4EN_N      , 19 @ Bit 19 UART4EN: UART4 clock enable
.equ  RCC_APB1ENR_UART4EN        ,0x00080000
.equ  RCC_APB1ENR_UART5EN_N      , 20 @ Bit 20 UART5EN: UART5 clock enable
.equ  RCC_APB1ENR_UART5EN        ,0x00100000
.equ  RCC_APB1ENR_I2C1EN_N       , 21 @ Bit 21 I2C1EN: I2C1 clock enable
.equ  RCC_APB1ENR_I2C1EN         ,0x00200000
.equ  RCC_APB1ENR_I2C2EN_N       , 22 @ Bit 22 I2C2EN: I2C2 clock enable
.equ  RCC_APB1ENR_I2C2EN         ,0x00400000
.equ  RCC_APB1ENR_I2C3EN_N       , 23 @ Bit 23 I2C3EN: I2C3 clock enable
.equ  RCC_APB1ENR_I2C3EN         ,0x00800000
.equ  RCC_APB1ENR_CAN1EN_N       , 25 @ Bit 25 CAN1EN: CAN 1 clock enable
.equ  RCC_APB1ENR_CAN1EN         ,0x02000000
.equ  RCC_APB1ENR_CAN2EN_N       , 26 @ Bit 26 CAN2EN: CAN 2 clock enable
.equ  RCC_APB1ENR_CAN2EN         ,0x04000000
.equ  RCC_APB1ENR_PWREN_N        , 28 @ Bit 28 PWREN: PWR clock enable
.equ  RCC_APB1ENR_PWREN          ,0x10000000
.equ  RCC_APB1ENR_DACEN_N        , 29 @ Bit 29 DACEN: DAC interface clock enable
.equ  RCC_APB1ENR_DACEN          ,0x20000000
.equ  RCC_APB1ENR_UART7EN_N      , 30 @ Bit 30 UART7EN: UART7 clock enable
.equ  RCC_APB1ENR_UART7EN        ,0x40000000
.equ  RCC_APB1ENR_UART8EN_N      , 31 @ Bit 31 UART8EN: UART8 clock enable
.equ  RCC_APB1ENR_UART8EN        ,0x80000000
@.end

@.item RCC_APB2ENR
.equ  RCC_APB2ENR_TIM1EN_N       , 0 @ Bit 0 TIM1EN: TIM1 clock enable
.equ  RCC_APB2ENR_TIM1EN         ,0x00000001
.equ  RCC_APB2ENR_TIM8EN_N       , 1 @ Bit 1 TIM8EN: TIM8 clock enable
.equ  RCC_APB2ENR_TIM8EN         ,0x00000002
.equ  RCC_APB2ENR_USART1EN_N     , 4 @ Bit 4 USART1EN: USART1 clock enable
.equ  RCC_APB2ENR_USART1EN       ,0x00000010
.equ  RCC_APB2ENR_USART6EN_N     , 5 @ Bit 5 USART6EN: USART6 clock enable
.equ  RCC_APB2ENR_USART6EN       ,0x00000020
.equ  RCC_APB2ENR_ADC1EN_N       , 8 @ Bit 8 ADC1EN: ADC1 clock enable
.equ  RCC_APB2ENR_ADC1EN         ,0x00000100
.equ  RCC_APB2ENR_ADC2EN_N       , 9 @ Bit 9 ADC2EN: ADC2 clock enable
.equ  RCC_APB2ENR_ADC2EN         ,0x00000200
.equ  RCC_APB2ENR_ADC3EN_N       , 10 @ Bit 10 ADC3EN: ADC3 clock enable
.equ  RCC_APB2ENR_ADC3EN         ,0x00000400
.equ  RCC_APB2ENR_SDIOEN_N       , 11 @ Bit 11 SDIOEN: SDIO clock enable
.equ  RCC_APB2ENR_SDIOEN         ,0x00000800
.equ  RCC_APB2ENR_SPI1EN_N       , 12 @ Bit 12 SPI1EN: SPI1 clock enable
.equ  RCC_APB2ENR_SPI1EN         ,0x00001000
.equ  RCC_APB2ENR_SPI4EN_N       , 13 @ Bit 13 SPI4EN: SPI4 clock enable
.equ  RCC_APB2ENR_SPI4EN         ,0x00002000
.equ  RCC_APB2ENR_SYSCFGEN_N     , 14 @ Bit 14 SYSCFGEN: System configuration controller clock enable
.equ  RCC_APB2ENR_SYSCFGEN       ,0x00004000
.equ  RCC_APB2ENR_TIM9EN_N       , 16 @ Bit 16 TIM9EN: TIM9 clock enable
.equ  RCC_APB2ENR_TIM9EN         ,0x00010000
.equ  RCC_APB2ENR_TIM10EN_N      , 17 @ Bit 17 TIM10EN: TIM10 clock enable
.equ  RCC_APB2ENR_TIM10EN        ,0x00020000
.equ  RCC_APB2ENR_TIM11EN_N      , 18 @ Bit 18 TIM11EN: TIM11 clock enable
.equ  RCC_APB2ENR_TIM11EN        ,0x00040000
.equ  RCC_APB2ENR_SPI5EN_N       , 20 @ Bit 20 SPI5EN: SPI5 clock enable
.equ  RCC_APB2ENR_SPI5EN         ,0x00100000
.equ  RCC_APB2ENR_SPI6EN_N       , 21 @ Bit 21 SPI6EN: SPI6 clock enable
.equ  RCC_APB2ENR_SPI6EN         ,0x00200000
.equ  RCC_APB2ENR_SAI1EN_N       , 22 @ Bit 22 SAI1EN: SAI1 clock enable
.equ  RCC_APB2ENR_SAI1EN         ,0x00400000
.equ  RCC_APB2ENR_LTDCEN_N       , 26 @ Bit 26 LTDCEN: LTDC clock enable
.equ  RCC_APB2ENR_LTDCEN         ,0x04000000
@.end

@.item RCC_AHB1LPENR
.equ  RCC_AHB1LPENR_GPIOALPEN_N  , 0 @ Bit 0 GPIOALPEN: IO port A clock enable during sleep mode
.equ  RCC_AHB1LPENR_GPIOALPEN    ,0x00000001
.equ  RCC_AHB1LPENR_GPIOBLPEN_N  , 1 @ Bit 1 GPIOBLPEN: IO port B clock enable during Sleep mode
.equ  RCC_AHB1LPENR_GPIOBLPEN    ,0x00000002
.equ  RCC_AHB1LPENR_GPIOCLPEN_N  , 2 @ Bit 2 GPIOCLPEN: IO port C clock enable during Sleep mode
.equ  RCC_AHB1LPENR_GPIOCLPEN    ,0x00000004
.equ  RCC_AHB1LPENR_GPIODLPEN_N  , 3 @ Bit 3 GPIODLPEN: IO port D clock enable during Sleep mode
.equ  RCC_AHB1LPENR_GPIODLPEN    ,0x00000008
.equ  RCC_AHB1LPENR_GPIOELPEN_N  , 4 @ Bit 4 GPIOELPEN: IO port E clock enable during Sleep mode
.equ  RCC_AHB1LPENR_GPIOELPEN    ,0x00000010
.equ  RCC_AHB1LPENR_GPIOFLPEN_N  , 5 @ Bit 5 GPIOFLPEN: IO port F clock enable during Sleep mode
.equ  RCC_AHB1LPENR_GPIOFLPEN    ,0x00000020
.equ  RCC_AHB1LPENR_GPIOGLPEN_N  , 6 @ Bits 6 GPIOGLPEN: IO port G clock enable during Sleep mode
.equ  RCC_AHB1LPENR_GPIOGLPEN    ,0x00000040
.equ  RCC_AHB1LPENR_GPIOHLPEN_N  , 7 @ Bit 7 GPIOHLPEN: IO port H clock enable during Sleep mode
.equ  RCC_AHB1LPENR_GPIOHLPEN    ,0x00000080
.equ  RCC_AHB1LPENR_GPIOILPEN_N  , 8 @ Bit 8 GPIOILPEN: IO port I clock enable during Sleep mode
.equ  RCC_AHB1LPENR_GPIOILPEN    ,0x00000100
.equ  RCC_AHB1LPENR_GPIOHLPEN_N  , 9 @ Bit 9 GPIOJLPEN: IO port J clock enable during Sleep mode
.equ  RCC_AHB1LPENR_GPIOHLPEN    ,0x00000200
.equ  RCC_AHB1LPENR_GPIOILPEN_N  , 10 @ Bit 10 GPIOKLPEN: IO port K clock enable during Sleep mode
.equ  RCC_AHB1LPENR_GPIOILPEN    ,0x00000400
.equ  RCC_AHB1LPENR_CRCLPEN_N    , 12 @ Bit 12 CRCLPEN: CRC clock enable during Sleep mode
.equ  RCC_AHB1LPENR_CRCLPEN      ,0x00001000
.equ  RCC_AHB1LPENR_FLITFLPEN_N  , 15 @ Bit 15 FLITFLPEN: Flash interface clock enable during Sleep mode
.equ  RCC_AHB1LPENR_FLITFLPEN    ,0x00008000
.equ  RCC_AHB1LPENR_SRAM1LPEN_N  , 16 @ Bit 16 SRAM1LPEN: SRAM1 interface clock enable during Sleep mode
.equ  RCC_AHB1LPENR_SRAM1LPEN    ,0x00010000
.equ  RCC_AHB1LPENR_SRAM2LPEN_N  , 17 @ Bit 17 SRAM2LPEN: SRAM2 interface clock enable during Sleep mode
.equ  RCC_AHB1LPENR_SRAM2LPEN    ,0x00020000
.equ  RCC_AHB1LPENR_BKPSRAMLPEN_N, 18 @ Bit 18 BKPSRAMLPEN: Backup SRAM interface clock enable during Sleep mode
.equ  RCC_AHB1LPENR_BKPSRAMLPEN  ,0x00040000
.equ  RCC_AHB1LPENR_SRAM3LPEN_N  , 19 @ Bit 19 SRAM3LPEN: SRAM3 interface clock enable during Sleep mode
.equ  RCC_AHB1LPENR_SRAM3LPEN    ,0x00080000
.equ  RCC_AHB1LPENR_DMA1LPEN_N   , 21 @ Bit 21 DMA1LPEN: DMA1 clock enable during Sleep mode
.equ  RCC_AHB1LPENR_DMA1LPEN     ,0x00200000
.equ  RCC_AHB1LPENR_DMA2LPEN_N   , 22 @ Bit 22 DMA2LPEN: DMA2 clock enable during Sleep mode
.equ  RCC_AHB1LPENR_DMA2LPEN     ,0x00400000
.equ  RCC_AHB1LPENR_DMA2DPEN_N   , 23 @ Bit 23 DMA2DLPEN: DMA2D clock enable during Sleep mode
.equ  RCC_AHB1LPENR_DMA2DPEN     ,0x00800000
.equ  RCC_AHB1LPENR_ETHMACLPEN_N , 25 @ Bit 25 ETHMACLPEN: Ethernet MAC clock enable during Sleep mode
.equ  RCC_AHB1LPENR_ETHMACLPEN   ,0x02000000
.equ  RCC_AHB1LPENR_ETHMACTXLPEN_N, 26 @ Bit 26 ETHMACTXLPEN: Ethernet transmission clock enable during Sleep mode
.equ  RCC_AHB1LPENR_ETHMACTXLPEN ,0x04000000
.equ  RCC_AHB1LPENR_ETHMACRXLPEN_N, 27 @ Bit 27 ETHMACRXLPEN: Ethernet reception clock enable during Sleep mode
.equ  RCC_AHB1LPENR_ETHMACRXLPEN ,0x08000000
.equ  RCC_AHB1LPENR_ETHMACPTPLPEN_N, 28 @ Bit 28 ETHMACPTPLPEN: Ethernet PTP clock enable during Sleep mode
.equ  RCC_AHB1LPENR_ETHMACPTPLPEN,0x10000000
.equ  RCC_AHB1LPENR_OTGHSLPEN_N  , 29 @ Bit 29 OTGHSLPEN: USB OTG HS clock enable during Sleep mode
.equ  RCC_AHB1LPENR_OTGHSLPEN    ,0x20000000
.equ  RCC_AHB1LPENR_OTGHSULPILPEN_N, 30 @ Bit 30 OTGHSULPILPEN: USB OTG HS ULPI clock enable during Sleep mode
.equ  RCC_AHB1LPENR_OTGHSULPILPEN,0x40000000
@.end

@.item RCC_AHB2LPENR
.equ  RCC_AHB2LPENR_DCMILPEN_N   , 0 @ Bit 0 DCMILPEN: Camera interface enable during Sleep mode
.equ  RCC_AHB2LPENR_DCMILPEN     ,0x00000001
.equ  RCC_AHB2LPENR_CRYPLPEN_N   , 4 @ Bit 4 CRYPLPEN: Cryptography modules clock enable during Sleep mode
.equ  RCC_AHB2LPENR_CRYPLPEN     ,0x00000010
.equ  RCC_AHB2LPENR_HASHLPEN_N   , 5 @ Bit 5 HASHLPEN: Hash modules clock enable during Sleep mode
.equ  RCC_AHB2LPENR_HASHLPEN     ,0x00000020
.equ  RCC_AHB2LPENR_RNGLPEN_N    , 6 @ Bit 6 RNGLPEN: Random number generator clock enable during Sleep mode
.equ  RCC_AHB2LPENR_RNGLPEN      ,0x00000040
.equ  RCC_AHB2LPENR_OTGFSLPEN_N  , 7 @ Bit 7 OTGFSLPEN: USB OTG FS clock enable during Sleep mode
.equ  RCC_AHB2LPENR_OTGFSLPEN    ,0x00000080
@.end

@.item RCC_AHB3LPENR
.equ  RCC_AHB3LPENR_FSMCLPEN_N   , 0 @ FMCLPEN: Flexible memory controller module clock enable during Sleep mode
.equ  RCC_AHB3LPENR_FSMCLPEN     ,0x00000001
@.end

@.item RCC_APB1LPENR
.equ  RCC_APB1LPENR_TIM2LPEN_N   , 0 @ Bit 0 TIM2LPEN: TIM2 clock enable during Sleep mode
.equ  RCC_APB1LPENR_TIM2LPEN     ,0x00000001
.equ  RCC_APB1LPENR_TIM3LPEN_N   , 1 @ Bit 1 TIM3LPEN: TIM3 clock enable during Sleep mode
.equ  RCC_APB1LPENR_TIM3LPEN     ,0x00000002
.equ  RCC_APB1LPENR_TIM4LPEN_N   , 2 @ Bit 2 TIM4LPEN: TIM4 clock enable during Sleep mode
.equ  RCC_APB1LPENR_TIM4LPEN     ,0x00000004
.equ  RCC_APB1LPENR_TIM5LPEN_N   , 3 @ Bit 3 TIM5LPEN: TIM5 clock enable during Sleep mode
.equ  RCC_APB1LPENR_TIM5LPEN     ,0x00000008
.equ  RCC_APB1LPENR_TIM6LPEN_N   , 4 @ Bit 4 TIM6LPEN: TIM6 clock enable during Sleep mode
.equ  RCC_APB1LPENR_TIM6LPEN     ,0x00000010
.equ  RCC_APB1LPENR_TIM7LPEN_N   , 5 @ Bit 5 TIM7LPEN: TIM7 clock enable during Sleep mode
.equ  RCC_APB1LPENR_TIM7LPEN     ,0x00000020
.equ  RCC_APB1LPENR_TIM12LPEN_N  , 6 @ Bit 6 TIM12LPEN: TIM12 clock enable during Sleep mode
.equ  RCC_APB1LPENR_TIM12LPEN    ,0x00000040
.equ  RCC_APB1LPENR_TIM13LPEN_N  , 7 @ Bit 7 TIM13LPEN: TIM13 clock enable during Sleep mode
.equ  RCC_APB1LPENR_TIM13LPEN    ,0x00000080
.equ  RCC_APB1LPENR_TIM14LPEN_N  , 8 @ Bit 8 TIM14LPEN: TIM14 clock enable during Sleep mode
.equ  RCC_APB1LPENR_TIM14LPEN    ,0x00000100
.equ  RCC_APB1LPENR_WWDGLPEN_N   , 11 @ Bit 11 WWDGLPEN: Window watchdog clock enable during Sleep mode
.equ  RCC_APB1LPENR_WWDGLPEN     ,0x00000800
.equ  RCC_APB1LPENR_SPI2LPEN_N   , 14 @ Bit 14 SPI2LPEN: SPI2 clock enable during Sleep mode
.equ  RCC_APB1LPENR_SPI2LPEN     ,0x00004000
.equ  RCC_APB1LPENR_SPI3LPEN_N   , 15 @ Bit 15 SPI3LPEN: SPI3 clock enable during Sleep mode
.equ  RCC_APB1LPENR_SPI3LPEN     ,0x00008000
.equ  RCC_APB1LPENR_USART2LPEN_N , 17 @ Bit 17 USART2LPEN: USART2 clock enable during Sleep mode
.equ  RCC_APB1LPENR_USART2LPEN   ,0x00020000
.equ  RCC_APB1LPENR_USART3LPEN_N , 18 @ Bit 18 USART3LPEN: USART3 clock enable during Sleep mode
.equ  RCC_APB1LPENR_USART3LPEN   ,0x00040000
.equ  RCC_APB1LPENR_UART4LPEN_N  , 19 @ Bit 19 UART4LPEN: UART4 clock enable during Sleep mode
.equ  RCC_APB1LPENR_UART4LPEN    ,0x00080000
.equ  RCC_APB1LPENR_UART5LPEN_N  , 20 @ Bit 20 UART5LPEN: UART5 clock enable during Sleep mode
.equ  RCC_APB1LPENR_UART5LPEN    ,0x00100000
.equ  RCC_APB1LPENR_I2C1LPEN_N   , 21 @ Bit 21 I2C1LPEN: I2C1 clock enable during Sleep mode
.equ  RCC_APB1LPENR_I2C1LPEN     ,0x00200000
.equ  RCC_APB1LPENR_I2C2LPEN_N   , 22 @ Bit 22 I2C2LPEN: I2C2 clock enable during Sleep mode
.equ  RCC_APB1LPENR_I2C2LPEN     ,0x00400000
.equ  RCC_APB1LPENR_I2C3LPEN_N   , 23 @ Bit 23 I2C3LPEN: I2C3 clock enable during Sleep mode
.equ  RCC_APB1LPENR_I2C3LPEN     ,0x00800000
.equ  RCC_APB1LPENR_CAN1LPEN_N   , 25 @ Bit 25 CAN1LPEN: CAN 1 clock enable during Sleep mode
.equ  RCC_APB1LPENR_CAN1LPEN     ,0x02000000
.equ  RCC_APB1LPENR_CAN2LPEN_N   , 26 @ Bit 26 CAN2LPEN: CAN 2 clock enable during Sleep mode
.equ  RCC_APB1LPENR_CAN2LPEN     ,0x04000000
.equ  RCC_APB1LPENR_PWRLPEN_N    , 28 @ Bit 28 PWRLPEN: Power interface clock enable during Sleep mode
.equ  RCC_APB1LPENR_PWRLPEN      ,0x10000000
.equ  RCC_APB1LPENR_DACLPEN_N    , 29 @ Bit 29 DACLPEN: DAC interface clock enable during Sleep mode
.equ  RCC_APB1LPENR_DACLPEN      ,0x20000000
.equ  RCC_APB1LPENR_UART7LPEN_N  , 30 @ Bit 30 UART7LPEN: UART7 clock enable during Sleep mode
.equ  RCC_APB1LPENR_UART7LPEN    ,0x40000000
.equ  RCC_APB1LPENR_UART8LPEN_N  , 31 @ Bit 31 UART8LPEN: UART8 clock enable during Sleep mode
.equ  RCC_APB1LPENR_UART8LPEN    ,0x80000000
@.end

@.item RCC_APB2LPENR
.equ  RCC_APB2LPENR_TIM1LPEN_N   , 0 @ Bit 0 TIM1LPEN: TIM1 clock enable during Sleep mode
.equ  RCC_APB2LPENR_TIM1LPEN     ,0x00000001
.equ  RCC_APB2LPENR_TIM8LPEN_N   , 1 @ Bit 1 TIM8LPEN: TIM8 clock enable during Sleep mode
.equ  RCC_APB2LPENR_TIM8LPEN     ,0x00000002
.equ  RCC_APB2LPENR_USART1LPEN_N , 4 @ Bit 4 USART1LPEN: USART1 clock enable during Sleep mode
.equ  RCC_APB2LPENR_USART1LPEN   ,0x00000010
.equ  RCC_APB2LPENR_USART6LPEN_N , 5 @ Bit 5 USART6LPEN: USART6 clock enable during Sleep mode
.equ  RCC_APB2LPENR_USART6LPEN   ,0x00000020
.equ  RCC_APB2LPENR_ADC1LPEN_N   , 8 @ Bit 8 ADC1LPEN: ADC1 clock enable during Sleep mode
.equ  RCC_APB2LPENR_ADC1LPEN     ,0x00000100
.equ  RCC_APB2LPENR_ADC2PEN_N    , 9 @ Bit 9 ADC2LPEN: ADC2 clock enable during Sleep mode
.equ  RCC_APB2LPENR_ADC2PEN      , 0x00000200
.equ  RCC_APB2LPENR_ADC3LPEN_N   , 10 @ Bit 10 ADC3LPEN: ADC 3 clock enable during Sleep mode
.equ  RCC_APB2LPENR_ADC3LPEN     , 0x00000400
.equ  RCC_APB2LPENR_SDIOLPEN_N   , 11 @ Bit 11 SDIOLPEN: SDIO clock enable during Sleep mode
.equ  RCC_APB2LPENR_SDIOLPEN     , 0x00000800
.equ  RCC_APB2LPENR_SPI1LPEN_N   , 12 @ Bit 12 SPI1LPEN: SPI1 clock enable during Sleep mode
.equ  RCC_APB2LPENR_SPI1LPEN     , 0x00001000
.equ  RCC_APB2LPENR_SPI4LPEN_N   , 13 @ Bit 13 SPI4LPEN: SPI4 clock enable during Sleep mode
.equ  RCC_APB2LPENR_SPI4LPEN     ,0x00002000
.equ  RCC_APB2LPENR_SYSCFGLPEN_N , 14 @ Bit 14 SYSCFGLPEN: System configuration controller clock enable during Sleep mode
.equ  RCC_APB2LPENR_SYSCFGLPEN   ,0x00004000
.equ  RCC_APB2LPENR_TIM9LPEN_N   , 16 @ Bit 16 TIM9LPEN: TIM9 clock enable during sleep mode
.equ  RCC_APB2LPENR_TIM9LPEN     ,0x00010000
.equ  RCC_APB2LPENR_TIM10LPEN_N  , 17 @ Bit 17 TIM10LPEN: TIM10 clock enable during Sleep mode
.equ  RCC_APB2LPENR_TIM10LPEN    ,0x00020000
.equ  RCC_APB2LPENR_TIM11LPEN_N  , 18 @ Bit 18 TIM11LPEN: TIM11 clock enable during Sleep mode
.equ  RCC_APB2LPENR_TIM11LPEN    ,0x00040000
.equ  RCC_APB2LPENR_SPI5LPEN_N   , 20 @ Bit 20 SPI5LPEN: SPI5 clock enable during Sleep mode
.equ  RCC_APB2LPENR_SPI5LPEN     ,0x00100000
.equ  RCC_APB2LPENR_SPI6LPEN_N   , 21 @ Bit 21 SPI6LPEN: SPI6 clock enable during Sleep mode
.equ  RCC_APB2LPENR_SPI6LPEN     ,0x00200000
.equ  RCC_APB2LPENR_SAI1LPEN_N   , 22 @ Bit 22 SAI1LPEN: SAI1 clock enable during Sleep mode
.equ  RCC_APB2LPENR_SAI1LPEN     ,0x00400000
.equ  RCC_APB2LPENR_LTDCLPEN_N   , 26 @ Bit 26 LTDCLPEN: LTDC clock enable during Sleep mode
.equ  RCC_APB2LPENR_LTDCLPEN     ,0x04000000
@.end

@.item RCC_BDCR
.equ  RCC_BDCR_LSEON_N           , 0 @ Bit 0 LSEON: External low-speed oscillator enable
.equ  RCC_BDCR_LSEON             ,0x00000001
.equ  RCC_BDCR_LSERDY_N          , 1 @ Bit 1 LSERDY: External low-speed oscillator ready
.equ  RCC_BDCR_LSERDY            ,0x00000002
.equ  RCC_BDCR_LSEBYP_N          , 2 @ Bit 2 LSEBYP: External low-speed oscillator bypass
.equ  RCC_BDCR_LSEBYP            ,0x00000004
.equ  RCC_BDCR_RTCSEL_NO_CLOCK   , 0x00<<8 @ Bits 9:8 RTCSEL[1:0]: RTC clock source selection
.equ  RCC_BDCR_RTCSEL_LSE        , 0x01<<8
.equ  RCC_BDCR_RTCSEL_LSI        , 0x02<<8
.equ  RCC_BDCR_RTCSEL_HSE        , 0x03<<8
.equ  RCC_BDCR_RTCEN_N           , 15 @ Bit 15 RTCEN: RTC clock enable
.equ  RCC_BDCR_RTCEN             ,0x00008000
.equ  RCC_BDCR_BDRST_N           ,16 @ Bit 16 BDRST: Backup domain software reset
.equ  RCC_BDCR_BDRST             ,0x00010000
@.end

@.item RCC_CSR
.equ  RCC_CSR_LSION_N            , 0 @ Bit 0 LSION: Internal low-speed oscillator enable
.equ  RCC_CSR_LSION              ,0x00000001
.equ  RCC_CSR_LSIRDY_N           , 1 @ Bit 1 LSIRDY: Internal low-speed oscillator ready
.equ  RCC_CSR_LSIRDY             ,0x00000002
.equ  RCC_CSR_RMVF_N             , 24 @ Bit 24 RMVF: Remove reset flag
.equ  RCC_CSR_RMVF               ,0x01000000
.equ  RCC_CSR_BORRSTF_N          , 25 @ Bit 25 BORRSTF: BOR reset flag
.equ  RCC_CSR_BORRSTF            ,0x02000000
.equ  RCC_CSR_PADRSTF_N          , 26 @ Bit 26 PINRSTF: PIN reset flag
.equ  RCC_CSR_PADRSTF            ,0x04000000
.equ  RCC_CSR_PORRSTF_N          , 27 @ Bit 27 PORRSTF: POR/PDR reset flag
.equ  RCC_CSR_PORRSTF            ,0x08000000
.equ  RCC_CSR_SFTRSTF_N          , 28 @ Bit 28 SFTRSTF: Software reset flag
.equ  RCC_CSR_SFTRSTF            ,0x10000000
.equ  RCC_CSR_WDGRSTF_N          , 29 @ Bit 29 IWDGRSTF: Independent watchdog reset flag
.equ  RCC_CSR_WDGRSTF            ,0x20000000
.equ  RCC_CSR_WWDGRSTF_N         , 30 @ Bit 30 WWDGRSTF: Window watchdog reset flag
.equ  RCC_CSR_WWDGRSTF           ,0x40000000
.equ  RCC_CSR_LPWRRSTF_N         , 31 @Bit 31 LPWRRSTF: Low-power reset flag
.equ  RCC_CSR_LPWRRSTF           ,0x80000000
@.end

@.item RCC_SSCGR
.equ  RCC_SSCGR_MODPER_N         , 0 @ Bits 12:0 MODPER: Modulation period
.equ  RCC_SSCGR_INCSTEP_N        , 13 @ Bits 27:13 INCSTEP: Incrementation step
.equ  RCC_SSCGR_SPREADSEL_DOWN   ,0x40000000 @ Bit 30 SPREADSEL: Spread Select
.equ  RCC_SSCGR_SPREADSEL_CENTER ,0x00000000
.equ  RCC_SSCGR_SSCGEN_N         , 31 @ Bit 31 SSCGEN: Spread spectrum modulation enable
.equ  RCC_SSCGR_SSCGEN           ,0x80000000
@.end

@.item RCC_PLLI2SCFGR
.equ  RCC_PLLI2SCFGR_PLLI2SN_N   , 6 @ Bits 14:6 PLLI2SN: PLLI2S multiplication factor for VCO (2..432; 434..510)
.equ  RCC_PLLI2SCFGR_PLLI2SQ_2   , 0x02<<24 @ Bits 27:24 PLLI2SQ: PLLI2S division factor for SAI1 clock
.equ  RCC_PLLI2SCFGR_PLLI2SQ_3   , 0x03<<24
.equ  RCC_PLLI2SCFGR_PLLI2SQ_4   , 0x04<<24
.equ  RCC_PLLI2SCFGR_PLLI2SQ_5   , 0x05<<24
.equ  RCC_PLLI2SCFGR_PLLI2SQ_6   , 0x06<<24
.equ  RCC_PLLI2SCFGR_PLLI2SQ_7   , 0x07<<24
.equ  RCC_PLLI2SCFGR_PLLI2SQ_8   , 0x08<<24
.equ  RCC_PLLI2SCFGR_PLLI2SQ_9   , 0x09<<24
.equ  RCC_PLLI2SCFGR_PLLI2SQ_10  , 10<<24
.equ  RCC_PLLI2SCFGR_PLLI2SQ_11  , 11<<24
.equ  RCC_PLLI2SCFGR_PLLI2SQ_12  , 12<<24
.equ  RCC_PLLI2SCFGR_PLLI2SQ_13  , 13<<24
.equ  RCC_PLLI2SCFGR_PLLI2SQ_14  , 14<<24
.equ  RCC_PLLI2SCFGR_PLLI2SQ_15  , 15<<24
.equ  RCC_PLLI2SCFGR_PLLI2SR_PLLR_2, 0x02<<28 @ Bits 30:28 PLLI2SR: PLLI2S division factor for I2S clocks
.equ  RCC_PLLI2SCFGR_PLLI2SR_PLLR_3, 0x03<<28
.equ  RCC_PLLI2SCFGR_PLLI2SR_PLLR_4, 0x04<<28
.equ  RCC_PLLI2SCFGR_PLLI2SR_PLLR_5, 0x05<<28
.equ  RCC_PLLI2SCFGR_PLLI2SR_PLLR_6, 0x06<<28
.equ  RCC_PLLI2SCFGR_PLLI2SR_PLLR_7, 0x07<<28
@.end

@.item RCC_PLLSAICFGR
.equ  RCC_PLLSAICFGR_PLLSAIR_2     , 2<<28 @ Bits 30:28 PLLSAIR: PLLSAI division factor for LCD clock
.equ  RCC_PLLSAICFGR_PLLSAIR_3     , 3<<28
.equ  RCC_PLLSAICFGR_PLLSAIR_4     , 4<<28
.equ  RCC_PLLSAICFGR_PLLSAIR_5     , 5<<28
.equ  RCC_PLLSAICFGR_PLLSAIR_6     , 6<<28
.equ  RCC_PLLSAICFGR_PLLSAIR_7     , 7<<28
.equ  RCC_PLLSAICFGR_PLLSAIQ_2     , 2<<24 @ Bits 27:24 PLLSAIQ: PLLSAI division factor for SAI1 clock
.equ  RCC_PLLSAICFGR_PLLSAIQ_3     , 3<<24
.equ  RCC_PLLSAICFGR_PLLSAIQ_4     , 4<<24
.equ  RCC_PLLSAICFGR_PLLSAIQ_5     , 5<<24
.equ  RCC_PLLSAICFGR_PLLSAIQ_6     , 6<<24
.equ  RCC_PLLSAICFGR_PLLSAIQ_7     , 7<<24
.equ  RCC_PLLSAICFGR_PLLSAIQ_8     , 8<<24
.equ  RCC_PLLSAICFGR_PLLSAIQ_9     , 9<<24
.equ  RCC_PLLSAICFGR_PLLSAIQ_10     , 10<<24
.equ  RCC_PLLSAICFGR_PLLSAIQ_11     , 11<<24
.equ  RCC_PLLSAICFGR_PLLSAIQ_12     , 12<<24
.equ  RCC_PLLSAICFGR_PLLSAIQ_13     , 13<<24
.equ  RCC_PLLSAICFGR_PLLSAIQ_14     , 14<<24
.equ  RCC_PLLSAICFGR_PLLSAIQ_15     , 15<<24
.equ  RCC_PLLSAICFGR_PLLSAIN_N     , 6 @ Bits 14:6 PLLSAIN: PLLSAI division factor for VCO (2..432; 434..510)
@.end

@.item RCC_DCKCFGR
.equ  RCC_DCKCFGR_TIMPRE_0           ,0 @ Bit 24  TIMPRE: Timers clocks prescalers selection
.equ  RCC_DCKCFGR_TIMPRE_1           ,1<<24
.equ  RCC_DCKCFGR_SAI1ASRC_PLLSAI_Q_DIV_PLLSAIDIVQ  ,0<<20 @ Bits 23:22 SAI1BSRC: SAI1-B clock source selection
.equ  RCC_DCKCFGR_SAI1ASRC_PLLI2S_Q_DIV_PLLI2SDIVQ  ,1<<20
.equ  RCC_DCKCFGR_SAI1ASRC_ALTERNATE_INPUT            ,2<<20
.equ  RCC_DCKCFGR_SAI1BSRC_PLLSAI_Q_DIV_PLLSAIDIVQ  ,0<<20 @ Bits 21:20 SAI1ASRC: SAI1-A clock source selection
.equ  RCC_DCKCFGR_SAI1BSRC_PLLI2S_Q_DIV_PLLI2SDIVQ  ,1<<20
.equ  RCC_DCKCFGR_SAI1BSRC_ALTERNATE_INPUT            ,2<<20
.equ  RCC_DCKCFGR_PLLSAIDIVR_DIV_2, 0<<16 @ Bits 17:16 PLLSAIDIVR: division factor for LCD_CLK
.equ  RCC_DCKCFGR_PLLSAIDIVR_DIV_4, 1<<16
.equ  RCC_DCKCFGR_PLLSAIDIVR_DIV_8, 2<<16
.equ  RCC_DCKCFGR_PLLSAIDIVR_DIV_16, 3<<16
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_1, 0<<8 @ Bits 12:8 PLLSAIDIVQ: PLLSAI division factor for SAI1 clock
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_2, 1<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_3, 2<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_4, 3<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_5, 4<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_6, 5<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_7, 6<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_8, 7<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_9, 8<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_10, 9<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_11, 10<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_12, 11<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_13, 12<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_14, 13<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_15, 14<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_16, 15<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_17, 16<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_18, 17<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_19, 18<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_20, 19<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_21, 20<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_22, 21<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_23, 22<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_24, 23<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_25, 24<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_26, 25<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_27, 26<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_28, 27<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_29, 28<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_30, 29<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_31, 30<<8
.equ  RCC_DCKCFGR_PLLSAIDIVQ_DIV_32, 31<<8
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_1, 0 @ Bits 4:0 PLLI2SDIVQ: PLLI2S division factor for SAI1 clock
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_2, 1
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_3, 2
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_4, 3
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_5, 4
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_6, 5
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_7, 6
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_8, 7
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_9, 8
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_10, 9
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_11, 10
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_12, 11
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_13, 12
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_14, 13
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_15, 14
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_16, 15
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_17, 16
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_18, 17
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_19, 18
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_20, 19
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_21, 20
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_22, 21
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_23, 22
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_24, 23
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_25, 24
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_26, 25
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_27, 26
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_28, 27
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_29, 28
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_30, 29
.equ  RCC_DCKCFGR_PLLI2SDIVQ_DIV_31, 30
