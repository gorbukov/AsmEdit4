@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                     Базовые константы EXTI                       |
@ +------------------------------------------------------------------+
@.enddesc

.include "/src/inc/base.inc"

@.ITEM     APB2PERIPH_BASE
.EQU  EXTI_BASE          , APB2PERIPH_BASE + 0x3C00
.EQU  EXTI               , PERIPH_BASE + EXTI_BASE

@.ITEM     EXTI_BASE EXIT
.EQU  EXTI_IMR           , 0x00                              @ Interrupt mask register (EXTI_IMR)
.EQU  EXTI_EMR           , 0x04                              @  Event m ask re gister (EXTI_EMR)
.EQU  EXTI_RSTR          , 0x08                              @  Rising tr igger s election register (EXTI_RTSR)
.EQU  EXTI_FSTR          , 0x0C                              @ Falling tr igger s election register (EXTI_FTSR)
.EQU  EXTI_SWIER         , 0x10                              @ Software in terrupt e vent register (EXTI_SWIER)
.EQU  EXTI_PR            , 0x14                              @ Pending register (EXTI_PR)

@.ITEM     EXTI_IMR
.EQU  EXTI_IMR_M         , 0x007FFFFF

@.ITEM     EXTI_EMR
.EQU  EXTI_EMR_M         , 0x007FFFFF

@.ITEM     EXTI_RSTR
.EQU  EXTI_RSTR_M        , 0x007FFFFF

@.ITEM     EXTI_FSTR
.EQU  EXTI_FSTR_M        , 0x007FFFFF

@.ITEM     EXTI_SWIER
.EQU  EXTI_SWIER_M       , 0x007FFFFF

@.ITEM     EXTI_PR
.EQU  EXTI_PR_M          , 0x007FFFFF



