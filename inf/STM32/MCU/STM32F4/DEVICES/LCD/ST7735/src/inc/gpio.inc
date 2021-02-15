@GNU AS
@.CHARSET =CP1251 ( Cyrillic )
@.DESC     type=module
@ +------------------------------------------------------------------+
@ |                         Константы GPIO                           |
@ +------------------------------------------------------------------+
@.ENDDESC

.INCLUDE  "/src/inc/base.inc"

@ константы GPIO
@.ITEM     AHB1PERIPH_BASE
.EQU  GPIO                          , AHB1PERIPH_BASE + 0x0000 @ GPIO Controls Registers


@ регистры gpio для использования в том числе в bit band
@.ITEM     GPIO
.EQU  GPIOA_BASE                    , AHB1PERIPH_BASE + 0x0000
.EQU  GPIOB_BASE                    , AHB1PERIPH_BASE + 0x0400
.EQU  GPIOC_BASE                    , AHB1PERIPH_BASE + 0x0800
.EQU  GPIOD_BASE                    , AHB1PERIPH_BASE + 0x0C00
.EQU  GPIOE_BASE                    , AHB1PERIPH_BASE + 0x1000
.EQU  GPIOF_BASE                    , AHB1PERIPH_BASE + 0x1400
.EQU  GPIOG_BASE                    , AHB1PERIPH_BASE + 0x1800
.EQU  GPIOH_BASE                    , AHB1PERIPH_BASE + 0x1C00
.EQU  GPIOI_BASE                    , AHB1PERIPH_BASE + 0x2000
.EQU  GPIOA                         , PERIPH_BASE + GPIOA_BASE
.EQU  GPIOB                         , PERIPH_BASE + GPIOB_BASE
.EQU  GPIOC                         , PERIPH_BASE + GPIOC_BASE
.EQU  GPIOD                         , PERIPH_BASE + GPIOD_BASE
.EQU  GPIOE                         , PERIPH_BASE + GPIOE_BASE
.EQU  GPIOF                         , PERIPH_BASE + GPIOF_BASE
.EQU  GPIOG                         , PERIPH_BASE + GPIOG_BASE
.EQU  GPIOH                         , PERIPH_BASE + GPIOH_BASE
.EQU  GPIOI                         , PERIPH_BASE + GPIOI_BASE


@.ITEM     GPIOA GPIOB GPIOC GPIOD GPIOE GPIOF GPIOG GPIOH GPIOI
.EQU  GPIO_MODER                    , 0x00                   @ GPIO port mode register
.EQU  GPIO_OTYPER                   , 0x04                   @ GPIO port output type register
.EQU  GPIO_OSPEEDR                  , 0x08                   @ GPIO port output speed register
.EQU  GPIO_PUPDR                    , 0x0C                   @ GPIO port pull-up/pull-down register
.EQU  GPIO_IDR                      , 0x10                   @ GPIO port input data register
.EQU  GPIO_ODR                      , 0x14                   @ GPIO port output data register
.EQU  GPIO_BSRR                     , 0x18                   @ GPIO port bit set/reset register
.EQU  GPIO_LCKR                     , 0x1C                   @ GPIO port configuration lock register
.EQU  GPIO_AFRL                     , 0x20                   @ GPIO alternate function low register
.EQU  GPIO_AFRH                     , 0x24                   @ GPIO alternate function high register


@ Описание битов настройки
@.ITEM     GPIO_MODER
.EQU  GPIO_MODER_INPUT              , 0x00                   @ Вход
.EQU  GPIO_MODER_GENERAL_OUT        , 0x01                   @ Выход
.EQU  GPIO_MODER_ALT_MODE           , 0x02                   @ Альтернативные функции
.EQU  GPIO_MODER_ANALOG             , 0x03                   @ Аналоговый ввод/вывод


@ Описание битов настройки
@.ITEM     GPIO_OTYPER
.EQU  GPIO_OTYPER_PP                , 0x00                   @ Push-Pull
.EQU  GPIO_OTYPER_OD                , 0x01                   @ Open Drain


@ Описание битов настройки
@.ITEM     GPIO_OSPEEDR
.EQU  GPIO_OSPEEDR_LOW_SPEED        , 0x00                   @ LOW SPEED
.EQU  GPIO_OSPEEDR_MEDIUM_SPEED     , 0x01                   @ MEDIUM SPEED
.EQU  GPIO_OSPEEDR_HIGH_SPEED       , 0x02                   @ HIGH SPEED
.EQU  GPIO_OSPEEDR_VERY_HIGH_SPEED  , 0x03                   @ VERY HIGH SPEED


@ Описание битов настройки
@.ITEM     GPIO_PUPDR
.EQU  GPIO_PUPDR_NPU_NPD            , 0x00                   @ Нет подтяжки
.EQU  GPIO_PUPDR_PU                 , 0x01                   @ Подтяжка к питанию
.EQU  GPIO_PUPDR_PD                 , 0x02                   @ Подтяжка к земле
.EQU  GPIO_PUPDR_RESERVED           , 0x03


@ Описание битов настройки
@.ITEM     GPIO_AFRH GPIO_AFRL
.EQU  GPIO_AFR_0_SYS                , 0x00
.EQU  GPIO_AFR_1_TIM1_2             , 0x01
.EQU  GPIO_AFR_2_TIM3_4_5           , 0x02
.EQU  GPIO_AFR_3_TIM8_9_10_11       , 0x03
.EQU  GPIO_AFR_4_I2C1_2_3           , 0x04
.EQU  GPIO_AFR_5_SPI1_2_I2S2        , 0x05
.EQU  GPIO_AFR_6_SPI3_I2S2_3        , 0x06
.EQU  GPIO_AFR_7_USART1_2_3_I2S3    , 0x07
.EQU  GPIO_AFR_8_UART4_5_USART6     , 0x08
.EQU  GPIO_AFR_9_CAN1_2_TIM12_13_14 , 0x09
.EQU  GPIO_AFR_A_OTG_FS_OTG_HS      , 0x0A
.EQU  GPIO_AFR_B_ETH                , 0x0B
.EQU  GPIO_AFR_C_FSMC_SDIO_OTG_FS   , 0x0C
.EQU  GPIO_AFR_D_DCMI               , 0x0D
.EQU  GPIO_AFR_E                    , 0x0E
.EQU  GPIO_AFR_F_EVENTOUT           , 0x0F

