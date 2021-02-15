@.CHARSET CP1251
@GNU AS
@.DESC     type=module
@ ***************************************************************************
@ *                  ������ ���������� LCD �� ST7735                        *
@ ***************************************************************************
@ * ���������:                                                              *
@ *     LCD_INIT:     ������������� SPI, LCD (������������� GPIO ��� !)     *
@ *     LCD_FILLREC   ���������� ������� ������                             *
@ *     LCD_CHAR:     ����� �������                                         *
@ *                                                                         *
@ *  ���������� !                                                           *
@ *  - ���������� ����������: 0<X<159, 0<Y<127                              *
@ *  - ����� �������� LCD_CHAR � ��������� �� �������                       *
@ *  - � ��������������� ��� ��������� (���������) ����                     *
@ *                                                                         *
@ ***************************************************************************
@.ENDDESC

.SYNTAX unified                     @ ��������� ��������� ����
.THUMB                              @ ��� ������������ ���������� Thumb
.CPU    cortex-m4                   @ ���������
.FPU    fpv4-sp-d16                 @ �����������

.INCLUDE  "/src/inc/rcc.inc"
.INCLUDE  "/src/inc/gpio.inc"
.INCLUDE  "/src/inc/spi.inc"

@ ����������� �������

.EQU  pCS                           , 11
.EQU  pCS_GPIO_BASE                 , GPIOB_BASE

.EQU  pDC                           , 12
.EQU  pDC_GPIO_BASE                 , GPIOB_BASE

.EQU  pRST                          , 14
.EQU  pRst_GPIO_BASE                , GPIOB_BASE

@ ���������� SPI (�������� ���� ��������� GPIO ��� ���������� SPI)
.EQU  LCD_SPI                       , SPI2_BASE

.SECTION .asmcode
@.DESC     name=LCD_INIT type=proc
@ +--------------------------------------------------------------------+
@ |               ��������� ������������� ������� ST7735               |
@ +--------------------------------------------------------------------+
@ | ��������� �������� �������������: SPI, � ������ �������            |
@ | ������������� GPIO ����� ��������� �� ������ ���� ���������        |
@ +--------------------------------------------------------------------+
@.ENDDESC
.GLOBAL LCD_INIT
LCD_INIT:                LKU:
                         PUSH        { R0, R1, LR }
                    @ ������� SPI 2
                         MOV         R0, 1
                         LDR         R1, = ( PERIPH_BB_BASE + ( RCC_BASE + RCC_APB1ENR ) * 32 + RCC_APB1ENR_SPI2EN_N * 4 )
                         STR         R0, [ R1 ]

          @ ��������� � ��������� ���������� SPI
.EQU  spi_dir            , SPI_CR1_BIDIOE | SPI_CR1_BIDIMODE    @ SPI_Direction_1Line_Tx
.EQU  spi_mode_master    , SPI_CR1_MSTR | SPI_CR1_SPE        @ SPI_Mode_Master & SPI_Enable
.EQU  spi_nss            , SPI_CR1_SSM | SPI_CR1_SSI         @ SPI_NSS_Soft
.EQU  spi_brpresc        , SPI_CR1_BR_DIV_2                  @ �������� ������� ��� SPI

                    @ �������� SPI2 � ���������� ���� �����������
                         LDR         R1, = ( PERIPH_BASE + LCD_SPI )
                         LDR         R0, = ( spi_dir | spi_mode_master | spi_nss | spi_brpresc )
                         STR         R0, [ R1, SPI_CR1 ]

          @ ������ ������ � ��������

                    @ ������ ������� ��� �������� � ���
                         BL          LCD_CS0

                    @ ���������� ����� LCD
                         @ ��������� ����� RST=0
                         MOV         R0, 0
                         LDR         R1, = ( PERIPH_BB_BASE + ( pRst_GPIO_BASE + GPIO_ODR ) * 32 + pRST * 4 )
                         STR         R0, [ R1 ]
                     @ ����� ��� �������� ������� ������ �����������
                         MOV         R0, 10
                         BL          SYSTICK_DELAY
                         @ ��������� ����� RST=1
                         MOV         R0, 1
                         STR         R0, [ R1 ]
                     @ ����� ����� ������
                         MOV         R0, 10
                         BL          SYSTICK_DELAY

          @ �������� ������ ������������� LCD
                         MOV         R0, 0x11               @ �������� ������� ����� ������
                         BL          LCD_SENDCOM

                         MOV         R0, 10                 @ �������� ���� ���������
                         BL          SYSTICK_DELAY

                         MOV         R0, 0x3A               @ ����� �����
                         BL          LCD_SENDCOM
                         MOV         R0, 0x05               @ 16�� ������ ����
                         BL          LCD_SENDDATA

                         MOV         R0, 0x36               @ ����������� ������ ����������� � ������ rgb
                         BL          LCD_SENDCOM
                         MOV         R0, 0X1C
                         BL          LCD_SENDDATA

                         MOV         R0, 0x29               @ �������� �����������
                         BL          LCD_SENDCOM

                         BL          LCD_CS1

          @ ���������� �� �������, �� ��� ������������������
                         POP         { R0, R1, PC }



LCD_SENDCOM:  @ �������� ������� � ���������������  ��������� BSY
                         PUSH        { R1, R2, R3, LR }

                    @ �������� ����� ���������� ������ ��� �������
                         BL          SPI_WAIT_TXE
                         BL          SPI_WAIT_BSY            @ �������� ��������� ������� ��������

                    @ ��������� � ����� ������  DC=0
                         MOV         R2, 0
                         LDR         R3, = ( PERIPH_BB_BASE + ( pDC_GPIO_BASE + GPIO_ODR ) * 32 + pDC * 4 )
                         STR         R2, [ R3 ]

                         STR         R0, [ R1, SPI_DR ]     @ �������� �������
                    @ �������� ����� �������
                         BL          SPI_WAIT_TXE           @ ���� ����� ������ ����� �� ��������
                         BL          SPI_WAIT_BSY           @ ���� ����������� ��������� ��������

                    @ ��������� � ����� ������ DC=1
                         MOV         R2, 1
                         STR         R2, [ R3 ]

                         POP         { R1, R2, R3, PC }


LCD_SENDDATA:            @ �������� ������ � ��������������� ��������� TXE
                         PUSH        { R1, R2, LR }
                         BL          SPI_WAIT_TXE           @ �������� ��� ������� ���� ���� �� ��������
                         STR         R0, [ R1, SPI_DR ]
                         POP         { R1, R2, PC }


SPI_WAIT_BSY:            @ �������� ����� ���������� ��������
                         LDR         R2, [ R1, SPI_SR ]
                         TST         R2, SPI_SR_BSY
                         BNE         SPI_WAIT_BSY
                         BX          LR

SPI_WAIT_TXE:            @ �������� ������ ������ �� spi_dr � shift
                         LDR         R1, = ( PERIPH_BASE + LCD_SPI )
spi_TXE_wait:
                         LDR         R2, [ R1, SPI_SR ]
                         TST         R2, SPI_SR_TXE
                         BEQ         spi_TXE_wait

                         BX          LR

     @ ���������� ������ CS - - - - - - - - - - - - - - - - - - - - - - -
LCD_CS0:
                         PUSH        { R0, R1 }
                         MOV         R0, 0
                         LDR         R1, = ( PERIPH_BB_BASE + ( pCS_GPIO_BASE + GPIO_ODR ) * 32 + pCS * 4 )
                         STR         R0, [ R1 ]
                         POP         { R0, R1 }
                         BX          LR

LCD_CS1:
                         MOV         R0, 1
                         LDR         R1, = ( PERIPH_BB_BASE + ( pCS_GPIO_BASE + GPIO_ODR ) * 32 + pCS * 4 )
                         STR         R0, [ R1 ]
                         BX          LR


@.DESC     name=LCD_AT type=proc
@ ***************************************************************************
@ *                  ������� ������������� ������� ������                   *
@ ***************************************************************************
@ | ������� ������� ������ ��� ��������                                     |
@ | ���������:                                                              |
@ |  R2 - ���������� X: 31:16 - SX, 15:0 - EX                               |
@ |  R3 - ���������� Y: 31:16 - SY, 15:0 - EY                               |
@ +-------------------------------------------------------------------------+
@.ENDDESC
LCD_AT:                  @ ����������� ������������� ������� ������
                         PUSH        { R0, LR }

                         MOV         R0, 0x2A               @ ������ ���������� StartX, EndX
                         BL          LCD_SENDCOM            @ �������� �������

                         UBFX        R0, R2, 24, 8          @ �������� StartX
                         BL          LCD_SENDDATA
                         UBFX        R0, R2, 16, 8          @ �������� StartX
                         BL          LCD_SENDDATA

                         UBFX        R0, R2, 8, 8           @ �������� EndX
                         BL          LCD_SENDDATA
                         UBFX        R0, R2, 0, 8           @ �������� EndX
                         BL          LCD_SENDDATA

                         MOV         R0, 0x2B               @ ������ ���������� StartY, EndY
                         BL          LCD_SENDCOM            @ �������� �������

                         UBFX        R0, R3, 24, 8          @ �������� StartY
                         BL          LCD_SENDDATA
                         UBFX        R0, R3, 16, 8          @ �������� StartY
                         BL          LCD_SENDDATA

                         UBFX        R0, R3, 8, 8           @ �������� EndY
                         BL          LCD_SENDDATA
                         UBFX        R0, R3, 0, 8           @ �������� EndY
                         BL          LCD_SENDDATA

                         MOV         R0, 0x2C               @ ������� ���������� �������
                         BL          LCD_SENDCOM

                         POP         { R0, PC }

@.DESC     name=LCD_FILLRECT type=proc
@ ***************************************************************************
@ *                  ������� ������������� ������� ������                   *
@ ***************************************************************************
@ | ������� ������� ������ � ������� ������                                 |
@ | ���������:                                                              |
@ |  R1 - ���� �������                                                      |
@ |  R2 - ���������� Y: 31:16 - START_Y, 15:0 - END_Y                       |
@ |  R3 - ���������� X: 31:16 - START_X, 15:0 - END_X                       |
@ +-------------------------------------------------------------------------+
@.ENDDESC
.GLOBAL LCD_FILLRECT
LCD_FILLRECT:
                         PUSH        { R0, R4, R5, R6, LR }

                         BL          LCD_CS0

                         BL          LCD_AT        @ ��������� ������� ������� �� ���� �����

                         @ ��������� ������ �� Y
                         UBFX        R5, R2, 0, 16
                         UBFX        R6, R2, 16, 16
                         SUB         R5, R5, R6
                         @ ��������� ������ �� X
                         UBFX        R0, R3, 0, 16
                         UBFX        R6, R3, 16, 16
                         SUB         R6, R0, R6
                         ADD         R5, R5, 1
                         ADD         R6, R6, 1
                         MUL         R4, R5, R6    @ ����� ���������� ����� ����������

LCD_CLEAR_loop:
                         UBFX        R0, R1, 8, 8
                         BL          LCD_SENDDATA
                         UBFX        R0, R1, 0, 8
                         BL          LCD_SENDDATA

                         SUBS        R4, R4, 1
                         BNE         LCD_CLEAR_loop

                         BL          SPI_WAIT_TXE
                         BL          SPI_WAIT_BSY

                         BL          LCD_CS1                 @ �������� ����� ������ � ��������

                         POP         { R0, R4, R5, R6, PC }

@.DESC     name=LCD_CHAR type=proc
@ ***************************************************************************
@ *                       ����� ������� �� �����������                      *
@ ***************************************************************************
@ | ������� ������� ������ � ������� ������                                 |
@ | ���������:                                                              |
@ |  R1 - ��� ������� ��� ������                                            |
@ |  R2 - Y                                                                 |
@ |  R3 - X                                                                 |
@ |  R4 - colors                                                            |
@ | R2, R3, R4 - ��������� �������� ��� ������, R1 �������� ������          |
@ +-------------------------------------------------------------------------+
@.ENDDESC
.GLOBAL LCD_CHAR
LCD_CHAR:
                         PUSH        { R0, R2, R3, R4, R5, R6, R7, R8, LR }

                         BL          LCD_CS0                @ ��������� � lcd

                     @ ���������� ����� �������
                         @ � ����������� �� ���� ������� ������� ������ ����� ���������������
                         CMP         R1, 192
                         ITTEE       CC
                         LDRCC       R5, = LCD_LAT_CHARS
                         SUBCC       R1, R1, 32
                         LDRCS       R5, = LCD_RUS_CHARS
                         SUBCS       R1, R1, 192

                         MOV         R0, 6
                         MUL         R1, R1, R0
                         ADD         R5, R5, R1             @ � R5 ����� �������

                     @ �������� ������� ������
                         @ ����������� ���������� Y
                         MOV         R0, R2
                         PKHBT       R2, R2, R2, LSL 16
                         ADD         R2, R2, 7
                         @ ����������� ���������� X
                         MOV         R0, R3
                         PKHBT       R3, R3, R3, LSL 16
                         ADD         R3, R3, 5
                         BL          LCD_AT

                    @ R1 - ���� �������
                    @ R2 - Y
                    @ R3 - X
                    @ R4 - color
                    @ R5 - ����� ����� ������� ��� ������
                    @ R6 - ������� ����� ������� ��� ������
                    @ R7 - ������� ���

                         MOV         R6, 6
LCD_line_loop:
                      @ �������� ����� ������ �������
                         MOV         R7, 8

                         LDRB        R1, [ R5 ], 1

LCD_pix_loop:
                     @ �������� ���� �����
                         TST         R1, 0x80
                         ITE         EQ
                         UBFXEQ      R8, R4, 0, 16
                         UBFXNE      R8, R4, 16, 16
                     @ �������� ����
                         UBFX        R0, R8, 8, 8
                         BL          LCD_SENDDATA
                         UBFX        R0, R8, 0, 8
                         BL          LCD_SENDDATA
                     @ ��������� � ���������� ����
                         LSL         R1, R1, 1
                     @ ���� �������� ��� (����� �����)
                         SUBS        R7, R7, 1
                         BNE         LCD_pix_loop
                     @ ���� �������� ����� (����� �� �����)
                         SUBS        R6, R6, 1
                         BNE         LCD_line_loop

                         BL          SPI_WAIT_TXE
                         bl          SPI_WAIT_BSY

                         BL          LCD_CS1

                         POP         { R0, R2, R3, R4, R5, R6, R7, R8, PC }

.INCLUDE  "/src/devices/ST7735/font6x8.inc"                  @ ����� ��� ������



