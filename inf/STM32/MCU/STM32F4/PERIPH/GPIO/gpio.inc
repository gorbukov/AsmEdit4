@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                         Константы GPIO                           |
@ +------------------------------------------------------------------+
@.enddesc

.include "/src/inc/base.inc"

@ константы GPIO
@.item AHB1PERIPH_BASE
.equ GPIO                  , AHB1PERIPH_BASE + 0x0000 @ GPIO Controls Registers


@ регистры gpio для использования в том числе в bit band
@.item GPIO
.equ GPIOA_BASE                    , AHB1PERIPH_BASE + 0x0000
.equ GPIOB_BASE                    , AHB1PERIPH_BASE + 0x0400
.equ GPIOC_BASE                    , AHB1PERIPH_BASE + 0x0800
.equ GPIOD_BASE                    , AHB1PERIPH_BASE + 0x0C00
.equ GPIOE_BASE                    , AHB1PERIPH_BASE + 0x1000
.equ GPIOF_BASE                    , AHB1PERIPH_BASE + 0x1400
.equ GPIOG_BASE                    , AHB1PERIPH_BASE + 0x1800
.equ GPIOH_BASE                    , AHB1PERIPH_BASE + 0x1C00
.equ GPIOI_BASE                    , AHB1PERIPH_BASE + 0x2000
.equ GPIOA                         , PERIPH_BASE + GPIOA_BASE
.equ GPIOB                         , PERIPH_BASE + GPIOB_BASE
.equ GPIOC                         , PERIPH_BASE + GPIOC_BASE
.equ GPIOD                         , PERIPH_BASE + GPIOD_BASE
.equ GPIOE                         , PERIPH_BASE + GPIOE_BASE
.equ GPIOF                         , PERIPH_BASE + GPIOF_BASE
.equ GPIOG                         , PERIPH_BASE + GPIOG_BASE
.equ GPIOH                         , PERIPH_BASE + GPIOH_BASE
.equ GPIOI                         , PERIPH_BASE + GPIOI_BASE


@.item GPIOA GPIOB GPIOC GPIOD GPIOE GPIOF GPIOG GPIOH GPIOI
.equ GPIO_MODER                    , 0x00 @ GPIO port mode register
.equ GPIO_OTYPER                   , 0x04 @ GPIO port output type register
.equ GPIO_OSPEEDR                  , 0x08 @ GPIO port output speed register
.equ GPIO_PUPDR                    , 0x0C @ GPIO port pull-up/pull-down register
.equ GPIO_IDR                      , 0x10 @ GPIO port input data register
.equ GPIO_ODR                      , 0x14 @ GPIO port output data register
.equ GPIO_BSRR                     , 0x18 @ GPIO port bit set/reset register
.equ GPIO_LCKR                     , 0x1C @ GPIO port configuration lock register
.equ GPIO_AFRL                     , 0x20 @ GPIO alternate function low register
.equ GPIO_AFRH                     , 0x24 @ GPIO alternate function high register


@ Описание битов настройки
@.item GPIO_MODER
.equ GPIO_MODER_INPUT              , 0x00 @ Вход
.equ GPIO_MODER_GENERAL_OUT        , 0x01 @ Выход
.equ GPIO_MODER_ALT_MODE           , 0x02 @ Альтернативные функции
.equ GPIO_MODER_ANALOG             , 0x03 @ Аналоговый ввод/вывод


@ Описание битов настройки
@.item GPIO_OTYPER
.equ GPIO_OTYPER_PP                , 0x00 @ Push-Pull
.equ GPIO_OTYPER_OD                , 0x01 @ Open Drain


@ Описание битов настройки
@.item GPIO_OSPEEDR
.equ GPIO_OSPEEDR_LOW_SPEED        , 0x00 @ LOW SPEED
.equ GPIO_OSPEEDR_MEDIUM_SPEED     , 0x01 @ MEDIUM SPEED
.equ GPIO_OSPEEDR_HIGH_SPEED       , 0x02 @ HIGH SPEED
.equ GPIO_OSPEEDR_VERY_HIGH_SPEED  , 0x03 @ VERY HIGH SPEED


@ Описание битов настройки
@.item GPIO_PUPDR
.equ GPIO_PUPDR_NPU_NPD            , 0x00 @ Нет подтяжки
.equ GPIO_PUPDR_PU                 , 0x01 @ Подтяжка к питанию
.equ GPIO_PUPDR_PD                 , 0x02 @ Подтяжка к земле
.equ GPIO_PUPDR_RESERVED           , 0x03


@ Описание битов настройки
@.item GPIO_AFRH GPIO_AFRL
.equ GPIO_AFR_0_SYS                , 0x00
.equ GPIO_AFR_1_TIM1_2             , 0x01
.equ GPIO_AFR_2_TIM3_4_5           , 0x02
.equ GPIO_AFR_3_TIM8_9_10_11       , 0x03
.equ GPIO_AFR_4_I2C1_2_3           , 0x04
.equ GPIO_AFR_5_SPI1_2_I2S2        , 0x05
.equ GPIO_AFR_6_SPI3_I2S2_3        , 0x06
.equ GPIO_AFR_7_USART1_2_3_I2S3    , 0x07
.equ GPIO_AFR_8_UART4_5_USART6     , 0x08
.equ GPIO_AFR_9_CAN1_2_TIM12_13_14 , 0x09
.equ GPIO_AFR_A_OTG_FS_OTG_HS      , 0x0A
.equ GPIO_AFR_B_ETH                , 0x0B
.equ GPIO_AFR_C_FSMC_SDIO_OTG_FS   , 0x0C
.equ GPIO_AFR_D_DCMI               , 0x0D
.equ GPIO_AFR_E                    , 0x0E
.equ GPIO_AFR_F_EVENTOUT           , 0x0F

