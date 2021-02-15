@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                     Базовые константы RCC                        |
@ +------------------------------------------------------------------+
@.enddesc


.include "/src/inc/base.inc"

@.item AHB1PERIPH_BASE
.EQU  RCC_BASE           , ( AHBPERIPH_BASE + 0x1000 )       @ Базовый адрес RCC
@.end

@.item RCC_BASE
.EQU  RCC_CR             , 0x00                              @ RCC clock control register
.EQU  RCC_CFGR           , 0x04                              @ RCC clock configuration register
.EQU  RCC_CIR            , 0x08                              @ RCC clock interrupt register
.EQU  RCC_APB2RSTR       , 0x0C                              @ RCC AHB1 peripheral reset register
.EQU  RCC_APB1RSTR       , 0x10                              @ RCC AHB2 peripheral reset register
.EQU  RCC_AHBENR         , 0x14                              @ RCC AHB1 peripheral clock register
.EQU  RCC_APB2ENR        , 0x18                              @ RCC AHB2 peripheral clock enable register
.EQU  RCC_APB1ENR        , 0x1C                              @ RCC APB1 peripheral clock enable register
.EQU  RCC_BDCR           , 0x20                              @ RCC Backup domain control register
.EQU  RCC_CSR            , 0x24                              @ RCC clock control & status register
.EQU  RCC_CFGR2          , 0x2C                              @ RCC spread spectrum clock generation register
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
@.end

@.item RCC_CFGR
.EQU  RCC_CFGR_SW_HSI    , 0x00000000                        @ Bits 1:0 SW: System clock switch
.EQU  RCC_CFGR_SW_HSE    , 0x00000001
.EQU  RCC_CFGR_SW_PLL    , 0x00000002
.EQU  RCC_CFGR_SWS_N     , 2                                 @ Bits 3:2 SWS: System clock switch status
.EQU  RCC_CFGR_SWS_HSI   , 0x00
.EQU  RCC_CFGR_SWS_HSE   , 0x04
.EQU  RCC_CFGR_SWS_PLL   , 0x08
.EQU  RCC_CFGR_HPRE_DIV1 , 0x00000000                        @ Bits 7:4 HPRE: AHB prescaler
.EQU  RCC_CFGR_HPRE_DIV2 , 0x00000080
.EQU  RCC_CFGR_HPRE_DIV4 , 0x00000090
.EQU  RCC_CFGR_HPRE_DIV8 , 0x000000A0
.EQU  RCC_CFGR_HPRE_DIV16, 0x000000B0
.EQU  RCC_CFGR_HPRE_DIV64, 0x000000C0
.EQU  RCC_CFGR_HPRE_DIV128, 0x000000D0
.EQU  RCC_CFGR_HPRE_DIV256, 0x000000E0
.EQU  RCC_CFGR_HPRE_DIV512, 0x000000F0
.EQU  RCC_CFGR_PPRE1_DIV1, 0x0000000
.EQU  RCC_CFGR_PPRE1_DIV2, 0x04 << 8
.EQU  RCC_CFGR_PPRE1_DIV4, 0x05 << 8
.EQU  RCC_CFGR_PPRE1_DIV8, 0x06 << 8
.EQU  RCC_CFGR_PPRE1_DIV16, 0x07 << 8
.EQU  RCC_CFGR_PPRE2_DIV1, 0x0000000
.EQU  RCC_CFGR_PPRE2_DIV2, 0x04 << 11
.EQU  RCC_CFGR_PPRE2_DIV4, 0x05 << 11
.EQU  RCC_CFGR_PPRE2_DIV8, 0x06 << 11
.EQU  RCC_CFGR_PPRE2_DIV16, 0x07 << 11
.EQU  RCC_CFGR_ADCPRE_DIV2, 0x00 << 14
.EQU  RCC_CFGR_ADCPRE_DIV4, 0x01 << 14
.EQU  RCC_CFGR_ADCPRE_DIV6, 0x02 << 14
.EQU  RCC_CFGR_ADCPRE_DIV8, 0x03 << 14
.EQU  RCC_CFGR_PLLSRC    , 0x01 << 16
.EQU  RCC_CFGR_PLLXTPRE  , 0x01 << 17
.EQU  RCC_CFGR_PLLMUL2   , 0x00 << 18                        @ PLL * 2
.EQU  RCC_CFGR_PLLMUL3   , 0x01 << 18                        @ PLL * 3
.EQU  RCC_CFGR_PLLMUL4   , 0x02 << 18                        @ PLL * 4
.EQU  RCC_CFGR_PLLMUL5   , 0x03 << 18                        @ PLL * 5
.EQU  RCC_CFGR_PLLMUL6   , 0x04 << 18                        @ PLL * 6
.EQU  RCC_CFGR_PLLMUL7   , 0x05 << 18                        @ PLL * 7
.EQU  RCC_CFGR_PLLMUL8   , 0x06 << 18                        @ PLL * 8
.EQU  RCC_CFGR_PLLMUL9   , 0x07 << 18                        @ PLL * 9
.EQU  RCC_CFGR_PLLMUL10  , 0x08 << 18                        @ PLL * 10
.EQU  RCC_CFGR_PLLMUL11  , 0x09 << 18                        @ PLL * 11
.EQU  RCC_CFGR_PLLMUL12  , 0x0A << 18                        @ PLL * 12
.EQU  RCC_CFGR_PLLMUL13  , 0x0B << 18                        @ PLL * 13
.EQU  RCC_CFGR_PLLMUL14  , 0x0C << 18                        @ PLL * 14
.EQU  RCC_CFGR_PLLMUL15  , 0x0D << 18                        @ PLL * 15
.EQU  RCC_CFGR_PLLMUL16  , 0x0E << 18                        @ PLL * 16
.EQU  RCC_CFGR_PLLMUL_16 , 0x0F << 18                        @ PLL * 16
.EQU  RCC_CFGR_MCO       , 0x00                              @ Bits 24:26 No clock
.EQU  RCC_CFGR_MCO_SYSCLK, 4 << 24                           @ SysClk
.EQU  RCC_CFGR_MCO_HSI   , 5 << 24                           @ HSI
.EQU  RCC_CFGR_MCO_HSE   , 6 << 24                           @ HSE
.EQU  RCC_CFGR_MCO_PLLD2 , 7 << 24                           @ PLL / 2
.EQU  RCC_CFGR_MCO_N     , 24
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
.EQU  RCC_CIR_LSIRDYC_N  , 16                                @ Bit 16 LSIRDYC: LSI ready interrupt clear
.EQU  RCC_CIR_LSIRDYC    , 0x01 << 16
.EQU  RCC_CIR_LSERDYC_N  , 17                                @ Bit 17 LSIRDYC: LSI ready interrupt clear
.EQU  RCC_CIR_LSERDYC    , 0x01 << 17
.EQU  RCC_CIR_HSIRDYC_N  , 18                                @ Bit 18 LSERDYC: LSE ready interrupt clear
.EQU  RCC_CIR_HSIRDYC    , 0x01 << 18
.EQU  RCC_CIR_HSERDYC_N  , 19                                @ Bit 19 HSIRDYC: HSI ready interrupt clear
.EQU  RCC_CIR_HSERDYC    , 0x01 << 19
.EQU  RCC_CIR_PLLRDYC_N  , 20                                @ Bit 20 HSERDYC: HSE ready interrupt clear
.EQU  RCC_CIR_PLLRDYC    , 0x01 << 20
.EQU  RCC_CIR_CSSC_N     , 23                                @ Bit 23 CSSC: Clock security system interrupt clear
.EQU  RCC_CIR_CSSC       , 0x01 << 23
@.end

@.ITEM     RCC_APB2RSTR
.EQU  RCC_APB2RSTR_TIM17RST, 1 << 18
.EQU  RCC_APB2RSTR_TIM16RST, 1 << 17
.EQU  RCC_APB2RSTR_TIM15RST, 1 << 16
.EQU  RCC_APB2RSTR_USART1RST, 1 << 14
.EQU  RCC_APB2RSTR_SPI1RST, 1 << 12
.EQU  RCC_APB2RSTR_TIM1RST, 1 << 11
.EQU  RCC_APB2RSTR_ADC1RST, 1 << 9
.EQU  RCC_APB2RSTR_IOPGRST, 1 << 8
.EQU  RCC_APB2RSTR_IOPFRST, 1 << 7
.EQU  RCC_APB2RSTR_IOPERST, 1 << 6
.EQU  RCC_APB2RSTR_IOPDRST, 1 << 5
.EQU  RCC_APB2RSTR_IOPCRST, 1 << 4
.EQU  RCC_APB2RSTR_IOPBRST, 1 << 3
.EQU  RCC_APB2RSTR_IOPARST, 1 << 2
.EQU  RCC_APB2RSTR_AFIORST, 1
@.END

@.ITEM     RCC_APB1RSTR
.EQU  RCC_APB1RSTR_CECRST, 1 << 30
.EQU  RCC_APB1RSTR_DACRST, 1 << 29
.EQU  RCC_APB1RSTR_PWRRST, 1 << 28
.EQU  RCC_APB1RSTR_BKPRST, 1 << 27
.EQU  RCC_APB1RSTR_I2C2RST, 1 << 22
.EQU  RCC_APB1RSTR_I2C1RST, 1 << 21
.EQU  RCC_APB1RSTR_UART5RST, 1 << 20
.EQU  RCC_APB1RSTR_UART4RST, 1 << 19
.EQU  RCC_APB1RSTR_USART3RST, 1 << 18
.EQU  RCC_APB1RSTR_USART2RST, 1 << 17
.EQU  RCC_APB1RSTR_SPI3RST, 1 << 15
.EQU  RCC_APB1RSTR_SPI2RST, 1 << 14
.EQU  RCC_APB1RSTR_WWDGRST, 1 << 11
.EQU  RCC_APB1RSTR_TIM14RST, 1 << 8
.EQU  RCC_APB1RSTR_TIM13RST, 1 << 7
.EQU  RCC_APB1RSTR_TIM12RST, 1 << 6
.EQU  RCC_APB1RSTR_TIM7RST, 1 << 5
.EQU  RCC_APB1RSTR_TIM6RST, 1 << 4
.EQU  RCC_APB1RSTR_TIM5RST, 1 << 3
.EQU  RCC_APB1RSTR_TIM4RST, 1 << 2
.EQU  RCC_APB1RSTR_TIM3RST, 1 << 1
.EQU  RCC_APB1RSTR_TIM2RST, 1 << 0
@.END


@.ITEM     RCC_AHBENR
.EQU  RCC_AHBENR_FSMCEN  , 1 << 8
.EQU  RCC_AHBENR_CRCEN   , 1 << 6
.EQU  RCC_AHBENR_FLITFEN , 1 << 4
.EQU  RCC_AHBENR_SRAMEN  , 1 << 2
.EQU  RCC_AHBENR_DMA2EN  , 1 << 1
.EQU  RCC_AHBENR_DMA1EN  , 1
@.end

@.ITEM     RCC_APB2ENR
.EQU  RCC_APB2ENR_TIM17EN, 1 << 18
.EQU  RCC_APB2ENR_TIM16EN, 1 << 17
.EQU  RCC_APB2ENR_TIM15EN, 1 << 16
.EQU  RCC_APB2ENR_USART1EN, 1 << 14
.EQU  RCC_APB2ENR_SPI1EN , 1 << 12
.EQU  RCC_APB2ENR_TIM1EN , 1 << 11
.EQU  RCC_APB2ENR_ADC1EN , 1 << 9
.EQU  RCC_APB2ENR_IOPGEN , 1 << 8
.EQU  RCC_APB2ENR_IOPFEN , 1 << 7
.EQU  RCC_APB2ENR_IOPEEN , 1 << 6
.EQU  RCC_APB2ENR_IOPDEN , 1 << 5
.EQU  RCC_APB2ENR_IOPCEN , 1 << 4
.EQU  RCC_APB2ENR_IOPBEN , 1 << 3
.EQU  RCC_APB2ENR_IOPAEN , 1 << 2
.EQU  RCC_APB2ENR_AFIOEN , 1 << 1
@.end

@.ITEM     RCC_APB1ENR
.EQU  RCC_APB1ENR_CECEN  , 1 << 30
.EQU  RCC_APB1ENR_DACEN     , 1 << 29
.EQU  RCC_APB1ENR_PWREN     , 1 << 28
.EQU  RCC_APB1ENR_BKPEN     , 1 << 27
.EQU  RCC_APB1ENR_I2C2EN    , 1 << 22
.EQU  RCC_APB1ENR_I2C1EN    , 1 << 21
.EQU  RCC_APB1ENR_UART5EN   , 1 << 20
.EQU  RCC_APB1ENR_UART4EN   , 1 << 19
.EQU  RCC_APB1ENR_USART3EN  , 1 << 18
.EQU  RCC_APB1ENR_USART2EN  , 1 << 17
.EQU  RCC_APB1ENR_SPI3EN    , 1 << 15
.EQU  RCC_APB1ENR_SPI2EN    , 1 << 14
.EQU  RCC_APB1ENR_WWDGEN    , 1 << 11
.EQU  RCC_APB1ENR_TIM14EN   , 1 << 8
.EQU  RCC_APB1ENR_TIM13EN   , 1 << 7
.EQU  RCC_APB1ENR_TIM12EN   , 1 << 6
.EQU  RCC_APB1ENR_TIM7EN    , 1 << 5
.EQU  RCC_APB1ENR_TIM6EN    , 1 << 4
.EQU  RCC_APB1ENR_TIM5EN    , 1 << 3
.EQU  RCC_APB1ENR_TIM4EN    , 1 << 2
.EQU  RCC_APB1ENR_TIM3EN    , 1 << 1
.EQU  RCC_APB1ENR_TIM2EN    , 1 << 0
@.END


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
.EQU  RCC_BDCR_BDRST     , 1 << 16
@.end

@.item RCC_CSR
.equ  RCC_CSR_LSION_N            , 0 @ Bit 0 LSION: Internal low-speed oscillator enable
.equ  RCC_CSR_LSION              ,0x00000001
.equ  RCC_CSR_LSIRDY_N           , 1 @ Bit 1 LSIRDY: Internal low-speed oscillator ready
.equ  RCC_CSR_LSIRDY             ,0x00000002
.equ  RCC_CSR_RMVF_N             , 24 @ Bit 24 RMVF: Remove reset flag
.equ  RCC_CSR_RMVF               ,0x01000000
.EQU  RCC_CSR_PINRSTF_N  , 26                                @ Bit 26 PINRSTF: PIN reset flag
.EQU  RCC_CSR_PINRSTF    , 1 << 26
.equ  RCC_CSR_PORRSTF_N          , 27 @ Bit 27 PORRSTF: POR/PDR reset flag
.equ  RCC_CSR_PORRSTF            ,0x08000000
.equ  RCC_CSR_SFTRSTF_N          , 28 @ Bit 28 SFTRSTF: Software reset flag
.equ  RCC_CSR_SFTRSTF            ,0x10000000
.EQU  RCC_CSR_IWDGRSTF_N , 29                                @ Bit 29 IWDGRSTF: Independent watchdog reset flag
.EQU  RCC_CSR_IWDGRSTF   , 0x20000000
.equ  RCC_CSR_WWDGRSTF_N         , 30 @ Bit 30 WWDGRSTF: Window watchdog reset flag
.equ  RCC_CSR_WWDGRSTF           ,0x40000000
.equ  RCC_CSR_LPWRRSTF_N         , 31 @Bit 31 LPWRRSTF: Low-power reset flag
.equ  RCC_CSR_LPWRRSTF           ,0x80000000
@.end

@.ITEM     RCC_CFGR2
.EQU  RCC_CFGR2_PREDIV1  , 0                                 @ DIV 1
.EQU  RCC_CFGR2_PREDIV2  , 1                                 @ DIV 2
.EQU  RCC_CFGR2_PREDIV3  , 2                                 @ DIV 3
.EQU  RCC_CFGR2_PREDIV4  , 3                                 @ DIV 4
.EQU  RCC_CFGR2_PREDIV5  , 4                                 @ DIV 5
.EQU  RCC_CFGR2_PREDIV6  , 5                                 @ DIV 6
.EQU  RCC_CFGR2_PREDIV7  , 6                                 @ DIV 7
.EQU  RCC_CFGR2_PREDIV8  , 7                                 @ DIV 8
.EQU  RCC_CFGR2_PREDIV9  , 8                                 @ DIV 9
.EQU  RCC_CFGR2_PREDIV10 , 9                                 @ DIV 10
.EQU  RCC_CFGR2_PREDIV11 , 10                                @ DIV 11
.EQU  RCC_CFGR2_PREDIV12 , 11                                @ DIV 12
.EQU  RCC_CFGR2_PREDIV13 , 12                                @ DIV 13
.EQU  RCC_CFGR2_PREDIV14 , 13                                @ DIV 14
.EQU  RCC_CFGR2_PREDIV15 , 14                                @ DIV 15
.EQU  RCC_CFGR2_PREDIV16 , 15                                @ DIV 16
@.end

