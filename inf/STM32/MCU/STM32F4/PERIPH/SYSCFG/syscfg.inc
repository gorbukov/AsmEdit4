@.CharSet=CP1251 (Cyrillic)
@GNU AS

.include "/src/inc/base.inc"

.equ SYSCFG_BASE                , (APB2PERIPH_BASE + 0x3800)


@ SYSCFG memory remap register (SYSCFG_MEMRMP)
.equ SYSCFG_MEMRMP              , 0x00

.equ SYSCFG_MEMRMP_MAIN_FLASH   , 0x00
.equ SYSCFG_MEMRMP_SYSTEM_FLASH , 0x01
.equ SYSCFG_MEMRMP_FSMC1_BANK1  , 0x02
.equ SYSCFG_MEMRMP_SRAM         , 0x03


@ SYSCFG peripheral mode configuration register (SYSCFG_PMC)
.equ SYSCFG_PMC                 , 0x04

.equ SYSCFG_MEMRMP_MII_RMII_SEL , 0x01<<23


@ SYSCFG external interrupt configuration register 1 (SYSCFG_EXTICR1)
.equ SYSCFG_EXTICR1             , 0x08

.equ SYSCFG_EXTICR1_EXTI0_N     , 0
.equ SYSCFG_EXTICR1_EXTI1_N     , 4
.equ SYSCFG_EXTICR1_EXTI2_N     , 8
.equ SYSCFG_EXTICR1_EXTI3_N     , 12


@ SYSCFG external interrupt configuration register 2 (SYSCFG_EXTICR2)
.equ SYSCFG_EXTICR2             , 0x0C

.equ SYSCFG_EXTICR2_EXTI4_N     , 0
.equ SYSCFG_EXTICR2_EXTI5_N     , 4
.equ SYSCFG_EXTICR2_EXTI6_N     , 8
.equ SYSCFG_EXTICR2_EXTI7_N     , 12


@ SYSCFG external interrupt configuration register 3 (SYSCFG_EXTICR3)
.equ SYSCFG_EXTICR3             , 0x10

.equ SYSCFG_EXTICR3_EXTI8_N     , 0
.equ SYSCFG_EXTICR3_EXTI9_N     , 4
.equ SYSCFG_EXTICR3_EXTI10_N    , 8
.equ SYSCFG_EXTICR3_EXTI11_N    , 12


@ SYSCFG external interrupt configuration register 4 (SYSCFG_EXTICR4)
.equ SYSCFG_EXTICR4             , 0x14

.equ SYSCFG_EXTICR4_EXTI12_N    , 0
.equ SYSCFG_EXTICR4_EXTI13_N    , 4
.equ SYSCFG_EXTICR4_EXTI14_N    , 8
.equ SYSCFG_EXTICR4_EXTI15_N    , 12


@ Compensation cell control register (SYSCFG_CMPCR)
.equ SYSCFG_CMPCR               , 0x20

.equ SYSCFG_CMPCR_READY         , 1<<8
.equ SYSCFG_CMPCR_CMP_PD        , 1
