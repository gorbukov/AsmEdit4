@.CHARSET CP866
@GNU AS
@.desc type=module
@ ***************************************************************************
@ *                  ������ ���������� LCD �� PCD8544                       *
@ ***************************************************************************
@ * ��楤���:                                                              *
@ *     LCD_INIT:     ���樠������ SPI, LCD (���樠����樨 GPIO ��� !)     *
@ *     LCD_REFRESH:  �뢮� ᮤ�ন���� ���� �� LCD                       *
@ *     LCD_CLEAR:    ���⪠ ����                                        *
@ *     LCD_PIXEL:    �뢮� ���ᥫ� (R0:Y, R1:X, R2:[1/0])                  *
@ *     LCD_CHAR:     �뢮� ᨬ���� (R0:Y, R1:X, R2:[1/0], R3:char)         *
@ *                                                                         *
@ *  ���������� !                                                           *
@ *  - �� ��楤��� �� ������ ॣ�����!                                    *
@ *  - �����⨬� ���न����: 0<X<84, 0<Y<48                                *
@ *  - �뢮� ᨬ����� LCD_CHAR � �筮���� �� ��᪥��                       *
@ *  - � ������������ ��� �ய���� (�����쪨�) �㪢                     *
@ *                                                                         *
@ ***************************************************************************
@.enddesc

.syntax unified     @ ᨭ⠪�� ��室���� ����
.thumb              @ ⨯ �ᯮ��㥬�� ������権 Thumb
.cpu cortex-m4      @ ������
.fpu fpv4-sp-d16    @ ᮯ�����

.include             "/src/inc/rcc.inc"
.include             "/src/inc/gpio.inc"
.include             "/src/inc/spi.inc"

@ ������祭�� ��ᯫ��

.equ pCS            , 11
.equ pCS_GPIO_BASE  , GPIOB_BASE

.equ pDC            , 12
.equ pDC_GPIO_BASE  , GPIOB_BASE

.equ pRST           , 14
.equ pRst_GPIO_BASE , GPIOB_BASE

@ ������� SPI
.equ LCD_SPI        , SPI2_BASE


.section .asmcode
@.desc name=LCD_INIT type=proc
@ +--------------------------------------------------------------------+
@ |               ��楤�� ���樠����樨 ��ᯫ�� PCD8544              |
@ +--------------------------------------------------------------------+
@ | ��楤�� �஢���� ���樠������: SPI, � ᠬ��� ��ᯫ��            |
@ | ���樠������ GPIO �㦭� �믮����� �� �맮�� �⮩ ��楤���        |
@ +--------------------------------------------------------------------+
@.enddesc
.global LCD_INIT
LCD_INIT:
                    PUSH     { R0, R1, R2, R3, R4, R5, LR }

                    MOV     R0, 0
                    MOV     R1, 1

          @ ����稬 SPI 2
                    LDR     R2, =(PERIPH_BB_BASE+(RCC_BASE+RCC_APB1ENR)*32+RCC_APB1ENR_SPI2EN_N*4)
                    STR     R1, [ R2 ]

     @ ����ன�� � ����祭�� ����䥩� SPI
.equ spi_dir        , SPI_CR1_BIDIOE | SPI_CR1_BIDIMODE    @ SPI_Direction_1Line_Tx
.equ spi_mode_master, SPI_CR1_MSTR   | SPI_CR1_SSI         @ SPI_Mode_Master
.equ spi_nss        , SPI_CR1_SSM    | SPI_CR1_SPE         @ SPI_NSS_Soft & SPI_Enable
.equ spi_brpresc    , SPI_CR1_BR_DIV_4                     @ ����⥫� ����� ��� SPI

          @ ����砥� SPI2 � �㦭�� ���䨣��樥�
                    LDR       R2, =( PERIPH_BASE + LCD_SPI )
                    LDR       R3, =( spi_dir | spi_mode_master | spi_nss | spi_brpresc )
                    LDR       R4, [ R2, SPI_CR1 ]
                    ORR       R3, R3, R4
                    STR       R3, [ R2, SPI_CR1 ]

          @ ࠡ�� � ��ᯫ���
          @ ������� ��� LCD
                    BL        LCD_CS0
                    BL        LCD_DC0

                    BL        LCD_RST0

                    MOV       R0, 1
                    BL        SYSTICK_DELAY

                    BL        LCD_RST1

@          MOV     R0, 2           @ ������� ��ᯫ�� ��᫥ ��� ⮦�
@          BL     SYSTICK_DELAY   @ �ॡ��� ����প�, �� �� pcd8544

          @ ��ࠢ�� ������ ����ன�� LCD
                    MOV       R5, 0x21
                    BL        LCD_SENDDATA

                    MOV       R5, 0xC1
                    BL        LCD_SENDDATA

                    MOV       R5, 0x06
                    BL        LCD_SENDDATA

                    MOV       R5, 0x13
                    BL        LCD_SENDDATA

                    MOV       R5, 0x20
                    BL        LCD_SENDDATA

                    MOV       R5, 0x0C
                    BL        LCD_SENDDATA

                    BL        SPI_WAIT_BSY     @ �������� ���� ���뫪� ����ன��

                    BL        LCD_CS1

                    POP       {R0, R1, R2, R3, R4,  R5, PC}


     @ ��ࠢ�� ���� �� spi � ��������� 䫠�� TXE - - - - - - - - - - - -
LCD_SENDDATA:
                    LDR       R2, =(PERIPH_BASE + LCD_SPI)
spi2_txe_wait:
                    LDR       R3, [R2, SPI_SR]
                    TST       R3, SPI_SR_TXE
                    BEQ       spi2_txe_wait
                    STR       R5, [R2, SPI_DR]
                    BX        LR

     @ �������� ���� ��।�� - - - - - - - - - - - - - - - - - - - - - -
SPI_WAIT_BSY:
                    LDR       R2, =(PERIPH_BASE + LCD_SPI)
spi_bsy_wait:
                    LDR       R3, [R2, SPI_SR]
                    TST       R3, SPI_SR_BSY
                    BNE       spi_bsy_wait
                    BX        LR

     @ �ࠢ����� ������ CS - - - - - - - - - - - - - - - - - - - - - - -
LCD_CS0:
                    LDR       R2, =(PERIPH_BB_BASE + (pCS_GPIO_BASE + GPIO_ODR)*32 + pCS*4)
                    STR       R0, [R2]
                    BX        LR

LCD_CS1:
                    LDR       R2, =(PERIPH_BB_BASE + (pCS_GPIO_BASE + GPIO_ODR)*32 + pCS*4)
                    STR       R1, [R2]
                    BX        LR

     @ �ࠢ����� ������ DC - - - - - - - - - - - - - - - - - - - - - - - -
LCD_DC0:
                    LDR       R2, =(PERIPH_BB_BASE + (pDC_GPIO_BASE + GPIO_ODR)*32 + pDC*4)
                    STR       R0, [R2]
                    BX        LR

LCD_DC1:
                    LDR       R2, =(PERIPH_BB_BASE + (pDC_GPIO_BASE + GPIO_ODR)*32 + pDC*4)
                    STR       R1, [R2]
                    BX        LR

     @ �ࠢ����� ������ RST - - - - - - - - - - - - - - - - - - - - - - -
LCD_RST0:
                    LDR       R2, =(PERIPH_BB_BASE + (pRst_GPIO_BASE + GPIO_ODR)*32 + pRST*4)
                    STR       R0, [R2]
                    BX        LR

LCD_RST1:
                    LDR       R2, =(PERIPH_BB_BASE + (pRst_GPIO_BASE + GPIO_ODR)*32 + pRST*4)
                    STR       R1, [R2]
                    BX        LR


@.desc name=LCD_CLEAR type=proc
@ ***************************************************************************
@ *                             ������� ������                              *
@ ***************************************************************************
@ ��楤�� ��頥� ���� �࠭� � ���, ������� ������ �� ��ᯫ�� �� ��ࠢ-
@ ��� (��� �⮣� �ᯮ���� LCD_Refresh)
@ �室�� ��ࠬ����: ���
@ ��室�� ��ࠬ����: ���
@ �����塞� ॣ����� �� ��室�: ���
@
@.enddesc
.section .bss
.align(4)
LCD_BUFF:
                    .space    84*6, 0                  @ ���� ��ᯫ�� � SRAM

.section .asmcode

.global LCD_CLEAR

LCD_CLEAR:
                    PUSH      { R0, R1, R2 }

                    MOV       R0, 0                  @ �����뢠���� ���祭��
                    MOV       R1, ( 84 * 6 ) / 4     @ ������⢮ ᫮� ��� �����

                    LDR       R2, =LCD_BUFF            @ ���� ����

LCD_CLEAR_loop: @ ����塞 ���� ������� �� 4 ���� (⠪ ����॥)
                    STR       R0, [R2], 4

                    SUBS      R1, R1, 1
                    BNE       LCD_CLEAR_loop

                    POP       { R0, R1, R2 }
                    BX        LR

@.desc name=LCD_REFRESH type=proc
@ **************************************************************************
@ *                 ���������� ������ ���������� ������                    *
@ **************************************************************************
@.enddesc
.global LCD_REFRESH

LCD_REFRESH:
@ ���⪠ �࠭� (�⫠���)
                    PUSH      { R0, R1, R2, R4, R5, R6, LR }
                    MOV       R0, 0
                    MOV       R1, 1

                    BL        LCD_CS0
                    BL        LCD_DC0

                    MOV       R5, 0x40
                    BL        LCD_SENDDATA

                    MOV       R5, 0x80
                    BL        LCD_SENDDATA

                    BL        SPI_WAIT_BSY

                    BL        LCD_DC1

                    MOV       R4, 84 * 6
                    LDR       R6, =LCD_BUFF

LCD_REFRESH_loop:
                    LDRB      R5, [R6], 1
                    BL        LCD_SENDDATA

                    SUBS      R4, R4, 1
                    BNE       LCD_REFRESH_loop

                    BL        SPI_WAIT_BSY

                    BL        LCD_CS1

                    POP       { R0, R1, R2, R4, R5, R6, PC }

@.desc name=LCD_PIXEL type=proc
@ ***************************************************************************
@ *                           ����� �������                                 *
@ ***************************************************************************
@ * R0 - Y                                                                  *
@ * R1 - X                                                                  *
@ * R2 - 梥� (0: ����, 1: ���)                                         *
@ ***************************************************************************
@.enddesc

.global LCD_PIXEL
LCD_PIXEL:
                    PUSH      { R0, R1, R2, R3, R4, R5, LR }

                    CMP       R0, 48          @ �஢�ਬ �����⨬���� ���न���
                    BPL       LCD_PIXEL_exit
                    CMP       R1, 84
                    BPL       LCD_PIXEL_exit

                    @ ����塞 ���� ���ᥫ�
                    LSR       R3, R0, 3        @  y >> 3
                    MOV       R4, 84
                    MUL       R3, R3, R4       @ (y >> 3) * 84
                    ADD       R5, R3, R1       @ (y >> 3) * 84 + x
                    LDR       R4, =LCD_BUFF
                    ADD       R5, R5, R4      @ � R5 ���� ���
                    LDRB      R4, [ R5 ]         @ �⠥� ���� ���

          @ ����塞 ���� ��� ���������
                    MOV       R3, 1
                    AND       R0, R0, 0x07
                    LSL       R3, R3, R0

          @ � ����ᨬ��� �� 梥�: ��ࠥ� ��� ������뢠�� ����
                    CMP       R2, 0x01     @ �뢮�/��࠭�� ?
                    ITEE      EQ
                    ORREQ     R4, R4, R3      @ �뢮� ��᪨
                    RSBNE     R3, R3, 0xFF    @ ������� ��᪨
                    ANDNE     R4, R4, R3      @ ��� �� ��᪥

                    STRB      R4, [ R5 ]     @ ������ � ����

LCD_PIXEL_exit:
                    POP       { R0, R1, R2, R3, R4, R5, PC }

@.desc name=LCD_CHAR type=proc
@ ***************************************************************************
@ *                           ����� �������                                 *
@ ***************************************************************************
@ * R0 - Y                                                                  *
@ * R1 - X                                                                  *
@ * R2 - 梥� (0: �������, 1: ���)                                      *
@ * R3 - ᨬ���                                                             *
@ ***************************************************************************
@.enddesc

.include "/src/devices/pcd8544/font6x8.inc"  @ 䠩� ������������

.global LCD_CHAR
LCD_CHAR:
                    PUSH      { R0 - R12, LR }

                    CMP       R0, 48          @ �஢�ਬ �����⨬���� ���न���
                    BPL       LCD_CHAR_exit
                    CMP       R1, 84
                    BPL       LCD_CHAR_exit

                    CMP       R2, 0           @ �᫨ �뢮��� ᨬ��� � �����ᨨ
                    BNE       LCD_CHAR_noleftline
                    PUSH      { R0, R1, R2 }
                    MOV       R4, 8           @ � ��㥬 ᫥�� �� ᨬ����
                    SUB       R1, R1, 1       @ ���⨪����� �����
                    SUB       R0, R0, 1       @ �⮡� ᨬ��� �� ᫨�����
                    MOV       R2, 1           @ � 䮭��

LCD_CHAR_leftline:
                    BL        LCD_PIXEL
                    ADD       R0, R0, 1
                    SUBS      R4, R4, 1
                    BNE       LCD_CHAR_leftline
                    POP       { R0, R1, R2 }

LCD_CHAR_noleftline:
          @ �����⠥� ��� char ��� ��襣� ������������
                    CMP       R3, 127
                    ITTEE     MI
                    ADRMI     R12, LCD_LAT_CHARS
                    SUBMI     R3, R3, 32
                    ADRPL     R12, LCD_RUS_CHARS
                    SUBPL     R3, R3, 192
          @ � R3:ᨬ��� R12:���� ������������

                    AND       R4, R0, 0x07
                    MOV       R7, 7
                    SUB       R4, R7, R4      @ � R4 ��⮢�� ������ � ����

                    LSR       R5, R0, 3       @ � R5 ���⮢�� ������ �� �࠭�

                    MOV       R6, 0           @ ���稪 横��

LCD_CHAR_loop:
                    MOV       R7, 6
                    MUL       R8, R3, R7     @ ��� ᨬ���� * 6

                    ADD       R8, R8, R6     @ �ਡ����� ����� �⮫�� ᨬ����
                    ADD       R8, R8, R12     @ �ਡ����� ���� ������������

                    LDRB      R8, [ R8 ]     @ �⮫��� (���� ᨬ����)

                    CMP       R2, 0          @ � ����ᨬ��� �� 梥�
                    BNE       LCD_CHAR_noinv
                    RSB       R8, R8, 0xFF    @ �������㥬 ���� ᨬ����
                    PUSH      { R0, R1, R2 }
                    SUB       R0, R0, 1       @ ᢥ��� �뢮� ������⭮� �窨
                    MOV       R2, 1           @ �⮡� ᨬ��� �� ᫨����� �
                    BL        LCD_PIXEL       @ � 䮭��
                    POP       { R0, R1, R2 }

LCD_CHAR_noinv:
                    AND       R8, R8, 0x7F

                    LDR       R9, =LCD_BUFF
                    MOV       R7, 84
                    MUL       R7, R7, R5
                    ADD       R9, R9, R7
                    ADD       R9, R9, R1      @ ���� � ����

                    RSB       R10, R4, 7      @ �뢮� ���孥� ��� ᨬ����
                    LSL       R11, R8, R10
                    LDR       R10, [ R9 ]
                    ORR       R11, R10, R11
                    STRB      R11, [ R9 ]

                    CMP       R4, 7                @ �஢��塞 �㦭� �� �뢮����
                    BEQ       LCD_CHAR_loop_end  @ ������ ���� ᨬ����

                    ADD       R5, R5, 1       @ �᫨ �࠭�� ��ப� ���稫���
                    CMP       R5, 6
                    BEQ       LCD_CHAR_loop_end  @ � �ய�᪠�� �� �뢮�

                    LDR       R9, =LCD_BUFF
                    MOV       R7, 84
                    MUL       R7, R7, R5
                    ADD       R9, R9, R7
                    ADD       R9, R9, R1
                    SUB       R5, R5, 1

                    ADD       R10, R4, 1     @ �뢮� ������ ��� ᨬ����
                    LSR       R11, R8, R10
                    LDR       R10, [ R9 ]
                    ORR       R11, R10, R11
                    STRB      R11, [ R9 ]

LCD_CHAR_loop_end:
                    ADD       R1, R1, 1
                    CMP       R1, 84
                    BPL       LCD_CHAR_exit

                    ADD       R6, R6, 1
                    CMP       R6, 6
                    BNE       LCD_CHAR_loop

LCD_CHAR_exit:
                    POP       { R0 - R12, PC }

