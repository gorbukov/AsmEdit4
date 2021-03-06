@.CHARSET  CP1251
@ GNU AS

@.DESC     type=module
@ +------------------------------------------------------------------+
@ |      SET - ��������� ������������ GPIO ��������� RCC_AHB1ENR     |
@ +------------------------------------------------------------------+
@ | ������ ��������� ������������ ������������ � AHB1ENR GPIO A-I    |
@ |                                                                  |
@ | ��������!                                                        |
@ | ���������� ������ ���������� �������� RCC_AHB1ENR !              |
@ |                                                                  |
@ | ��� ������������� �������� � ����������� ������:                 |
@ |     .include "��� ����� ������"                                  |
@ |                                                                  |
@ | ��� ������ ������ ���������� �������� ���������:                 |
@ |    R0, R1                                                        |
@ | ���� � ���������� ��������� ������ �������� - ���������   ��  �� |
@ | ����� �� ��������� .include � ������������ �������� �����        |
@ |                                                                  |
@ +------------------------------------------------------------------+
@.ENDDESC

.EQU  GPIOA_EN                      , DISABLE * RCC_AHB1ENR_GPIOAEN @ ������������ GPIO_A
.EQU  GPIOB_EN                      , ENABLE * RCC_AHB1ENR_GPIOBEN @ ������������ GPIO_B
.EQU  GPIOC_EN                      , DISABLE * RCC_AHB1ENR_GPIOCEN @ ������������ GPIO_C
.EQU  GPIOD_EN                      , DISABLE * RCC_AHB1ENR_GPIODEN @ ������������ GPIO_D
.EQU  GPIOE_EN                      , DISABLE * RCC_AHB1ENR_GPIOEEN @ ������������ GPIO_E
.EQU  GPIOF_EN                      , DISABLE * RCC_AHB1ENR_GPIOFEN @ ������������ GPIO_F
.EQU  GPIOG_EN                      , DISABLE * RCC_AHB1ENR_GPIOGEN @ ������������ GPIO_G
.EQU  GPIOH_EN                      , DISABLE * RCC_AHB1ENR_GPIOHEN @ ������������ GPIO_H
.EQU  GPIOI_EN                      , DISABLE * RCC_AHB1ENR_GPIOIEN @ ������������ GPIO_I

@ --------------------------  ������ �������� ��� ----------------------
@.ITEM     SWITCH
.EQU  ENABLE                        , 1                      @ ��������
.EQU  DISABLE                       , 0                      @ ���������
@.END

@.CONFIG   GPIOA_EN=SWITCH GPIOB_EN=SWITCH GPIOC_EN=SWITCH GPIOD_EN=SWITCH GPIOE_EN=SWITCH GPIOF_EN=SWITCH GPIOG_EN=SWITCH GPIOH_EN=SWITCH GPIOI_EN=SWITCH
.INCLUDE  "/src/inc/rcc.inc"

.EQU  ahb1enr_v2                    , GPIOA_EN + GPIOB_EN + GPIOC_EN + GPIOD_EN + GPIOE_EN + GPIOF_EN + GPIOG_EN + GPIOH_EN + GPIOI_EN

                         LDR         R0, = PERIPH_BASE + RCC_BASE + RCC_AHB1ENR
                         LDR         R1, [ R0 ]
                         BFC         R1, 0, 9
                         ADD         R1, ahb1enr_v2
                         STR         R1, [ R0 ]


