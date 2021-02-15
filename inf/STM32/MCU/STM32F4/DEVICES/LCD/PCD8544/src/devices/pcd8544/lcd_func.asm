@.CHARSET  CP1251
@GNU AS
@.DESC     type=module
@ ***************************************************************************
@ *               ������ �������������� ������� ������ LCD                  *
@ ***************************************************************************
@ * ���������:                                            *
@ *     LCD_PUTSTR:   ����� ������ �� �����������:                          *
@ *                   R0:Y, R1:X, R2:COLOR R4:ADR_TEXT                      *
@ *                   ����� ������ ������������� ������� ��������           *
@ *                   ����������� ���: 0x01, .short Y, .short X, .word col  *
@ *                                                                         *
@ *     LCD_PUTHEX:   ����� ������������������ �����:                       *
@ *                   R0:Y, R1:X, R2:COLOR R4:HEXVal, R5:DigitCol           *
@ *                                                                         *
@ *     LCD_PUTDEC:   ����� ����������� �����:                        *
@ *                   R0:Y, R1:X, R2:COLOR R4:DECVal, R5:DigitCol           *
@ *                                                                         *
@ *     LCD_LINE:     ����� �����:                                          *
@ *                   R0:Y1, R1:X1, R2:COLOR R3:Y2, R4:X2                   *
@ *                                                                         *
@ *     LCD_RECT:     ����� ��������������:                                 *
@ *                   R0:Y1, R1:X1, R2:COLOR R3:Y2, R4:X2                   *
@ *                                                                         *
@ *  ���������� !                                                           *
@ *  - ��� ��������� �� ������ ��������!                                    *
@ *                                                                         *
@ *  - ���������� ���������� � ��� ������ native ����������� ������������   *
@ *    � ����� lcd_param.inc ������� ������ ������ ����� � ������ ������    *
@ *                                                                         *
@ *  - ������� ������� ������ ��������� ������� ������������ ��� .global:   *
@ *    LCD_CHAR: (R0:Y, R1:X, R2:Color, R3:Char) - native ����� �������     *
@ *    LCD_PIXEL: (R0:Y, R1:X, R2:Color)         - native ����� �������     *
@ *                                                                         *
@ ***************************************************************************
@.ENDDESC

.SYNTAX unified                     @ ��������� ��������� ����
.THUMB                              @ ��� ������������ ���������� Thumb
.CPU    cortex-m4                   @ ���������
.FPU    fpv4-sp-d16                 @ �����������

.SECTION .asmcode

.INCLUDE  "src/devices/pcd8544/lcd_param.inc"                @ ��������� �������

@.DESC     name=LCD_PUTSTR type=proc
@ ***************************************************************************
@ *                       ������ ������ �� �����������                      *
@ ***************************************************************************
@ * R0:Y, R1:X, R2:COLOR R4:ADR_TEXT                                        *
@ ***************************************************************************
@ * ����� � ���� ����� ��������� string � 0x00 � ����� � �������� ��������� *
@ * ������ ����� ������� 0x01:                                              *
@ *   (.short) 0xYYYY      ���������� Y                                     *
@ *   (.short) 0xXXXX      ���������� X                                     *
@ *   (.word)  0xXXXXXXXX  ���� ������                                      *
@ ***************************************************************************
@.ENDDESC

.GLOBAL LCD_PUTSTR
LCD_PUTSTR:
                         PUSH        { R0, R1, R2, R3, R4, LR }
LCD_PUTSTR_loop:
                         LDRB        R3, [ R4 ], 1           @  ��������� ���� ��� ������

                         CMP         R3, 0                   @ ������ ����� ������
                         BEQ         LCD_PUTSTR_exit

                         CMP         R3, 1                   @ �������� ��������� � ������ ������
                         BNE         LCD_PUTSTR_char
                         ITTT        EQ
                         LDRHEQ      R0, [ R4 ], 2           @ Y
                         LDRHEQ      R1, [ R4 ], 2           @ X
                         LDREQ       R2, [ R4 ], 4           @ COLOR

                         BL          LCD_PUTSTR_loop
LCD_PUTSTR_char:
                         BL          LCD_CHAR

                         ADD         R1, R1, LCD_PARAM_char_stepx
                         CMP         R1, LCD_PARAM_size_px
                         BMI         LCD_PUTSTR_loop
                         MOV         R1, 0
                         ADD         R0, R0, LCD_PARAM_char_stepy
                         CMP         R0, LCD_PARAM_size_py
                         BMI         LCD_PUTSTR_loop
LCD_PUTSTR_exit:
                         POP         { R0, R1, R2, R3, R4, PC }

@.DESC     name=LCD_PUTHEX type=proc
@ ***************************************************************************
@ *                       ������ ������������������ �����                   *
@ ***************************************************************************
@ * R0:Y, R1:X, R2:COLOR R4:HEXVal, R5:DigitCol                             *
@ ***************************************************************************
@.ENDDESC

.GLOBAL LCD_PUTHEX
LCD_PUTHEX:
                         PUSH        { R0, R1, R2, R3, R4, R5, R6, R7, LR }
                         ADD         R5, R5, 1
                         MOV         R7, 8
LCD_PUTHEX_loop:
                         MOV         R3, R4                  @ ����� �������� �����
                         AND         R3, R3, 0xF0000000      @ ��������� ������� 4 ����

                         LSL         R4, R4, 4               @ �������� ����� �� 4 ���� �����
                         LSR         R3, R3, 28              @ ������� 4 ���� � ������ �����

                         CMP         R3, 10                  @ ��������������� ����� � ������
                         ITE         MI
                         ADDMI       R3, R3, 48              @ ��� 0..9 �������� 48 (��� "0")
                         ADDPL       R3, R3, 55              @ ��� �..F �������� 55 (��� "A"-10)

                         MOV         R6, 0                   @ ��� X
                         CMP         R7, R5                  @ ���� ����� ������� ������ ��������
                         ITT         MI                      @ ��
                         ADDMI       R6, R6, LCD_PARAM_char_stepx @ -�������� ������� X �� stepx ����� ������
                         BLMI        LCD_CHAR                @ -�������� �����

                         ADD         R1, R1, R6              @ �=�+stepx (��� X=X+0 ���� ������ �� ����)

                         SUBS        R7, R7, 1               @ ��������� ����� �������
                         BNE         LCD_PUTHEX_loop         @ ���� �� ����, �� ��������

                         POP         { R0, R1, R2, R3, R4, R5, R6, R7, PC }

@.DESC     name=LCD_LINE type=proc
@ ***************************************************************************
@ *                                ����� �����                              *
@ ***************************************************************************
@ * R0:Y1, R1:X1, R2:COLOR R3:Y2, R4:X2                                     *
@ ***************************************************************************
@.ENDDESC

.GLOBAL LCD_LINE
LCD_LINE:
                         PUSH        { R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, LR }

          @ ������ ��������� dx � s1
                         MOV         R5, 0
                         MOV         R7, 0
                         CMP         R1, R4
                         BEQ         LCD_LINE_dx_s1
                         ITTEE       MI
                         SUBMI       R5, R4, R1
                         MOVMI       R7, 1
                         SUBPL       R5, R1, R4
                         MOVPL       R7, - 1
                @ R5 = dx ( |X2-X1| )
LCD_LINE_dx_s1:
                @ ������ ��������� dy � s2
                         MOV         R6, 0
                         MOV         R8, 0
                         CMP         R0, R3
                         BEQ         LCD_LINE_dy_s2
                         ITTEE       MI
                         SUBMI       R6, R3, R0
                         MOVMI       R8, 1
                         SUBPL       R6, R0, R3
                         MOVPL       R8, - 1
                @ R6 = dy ( |Y2-Y1| )
LCD_LINE_dy_s2:
                @ ����� �������� dx � dy � ����������� �� �������� ������������ ������� �������
                         MOV         R4, 0
                         CMP         R6, R5
                         ITTTT       PL
                         MOVPL       R9, R5
                         MOVPL       R5, R6
                         MOVPL       R6, R9
                         MOVPL       R4, 1

                         MOV         R3, R6, LSL 1           @ e=2*dy
                         SUB         R3, R3, R5              @ e=2*dy-dx

                         MOV         R9, R5                  @ ���������� �����
LCD_LINE_LOOP:           @  ���� ��������� �����

                         BL          LCD_PIXEL               @ R1-x, R0-y, R2-color

LCD_LINE_WHILE:
                         ORRS        R3, R3, R3
                         BMI         LCD_LINE_WHILE_END

                         CMP         R4, 1
                         ITE         EQ
                         ADDEQ       R1, R1, R7
                         ADDNE       R0, R0, R8

                         SUB         R3, R3, R5, lsl 1
                         B           LCD_LINE_WHILE

LCD_LINE_WHILE_END:
                         CMP         R4, 1
                         ITE         EQ
                         ADDEQ       R0, R0, R8
                         ADDNE       R1, R1, R7

                         ADD         R3, R3, R6, lsl 1

                         SUBS        R9, R9, 1
                         BNE         LCD_LINE_LOOP

                         POP         { R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, PC }

@.DESC     name=LCD_RECT type=proc
@ ***************************************************************************
@ *                            ����� ��������������                         *
@ ***************************************************************************
@ * R0:Y1, R1:X1, R2:COLOR R3:Y2, R4:X2                                     *
@ ***************************************************************************
@.ENDDESC

.GLOBAL LCD_RECT
LCD_RECT:
                         PUSH        { R0, R1, R3, R4, R5, LR }

          @ ����� �������������� ������� �����
                         MOV         R5, R3                  @ �������� Y2
                         MOV         R3, R0
                         BL          LCD_LINE

          @ ����� �������������� ������ �����
                         MOV         R3, R5                  @ ����������� Y2
                         MOV         R5, R0                  @ �������� Y1
                         MOV         R0, R3
                         BL          LCD_LINE

          @ ����� ������������ ����� �����
                         MOV         R0, R5                  @ ����������� Y1
                         MOV         R5, R4                  @ �������� �2
                         MOV         R4, R1
                         BL          LCD_LINE

          @ ����� ������������ ������ �����
                         MOV         R4, R5                  @ ����������� �2
                         MOV         R1, R4
                         BL          LCD_LINE
                         POP         { R0, R1, R3, R4, R5, PC }

@.DESC     name=LCD_PUTDEC type=proc
@ ***************************************************************************
@ *                        ������ ����������� �����                         *
@ ***************************************************************************
@ * R0:Y, R1:X, R2:COLOR R4:DECVal, R5:DigitCol                             *
@ ***************************************************************************
@.ENDDESC

.GLOBAL LCD_PUTDEC
LCD_PUTDEC:
                         PUSH        { R0, R1, R2, R3, R4, R5, R6, R7, R8, LR }
                         MOV         R8, 0                   @ ���������� �������� ����������� �����
LCD_DEC_loop:
                         MOV         R6, R4                  @ �������

                         CMP         R6, 0
                         BEQ         LCD_DEC_null            @ ���� ������� =0 �� ������� ���������

                         LSR         R6, R6, 1               @ �������� ����� �� 0.8
                         ADD         R6, R6, R6, LSR 1       @
                         ADD         R6, R6, R6, LSR 4       @
                         ADD         R6, R6, R6, LSR 8       @
                         ADD         R6, R6, R6, LSR 16      @

                         LSR         R6, R6, 3               @ ����� ����� �� 8

                         MOV         R7, 10                  @ ��������� ���������
                         MUL         R3, R6, R7
                         SUB         R3, R4, R3
                         CMP         R3, 10                  @ ��������� ����������
                         IT          PL
                         ADDPL       R6, R6, 1               @ R6 ����� �������

                         MUL         R3, R6, R7
                         SUB         R7, R4, R3              @ R7 ������� �� �������
                         PUSH        { R7 }
                         ADD         R8, R8, 1               @ ��������� ������� ��������
                         MOV         R4, R6
                         B           LCD_DEC_loop

LCD_DEC_null:            @ �������� ���������� ���� ���� �����
                         CMP         R5, R8                  @ R5:����� ����� ����, R8:���������� ����
                         BEQ         LCD_DEC_prn
                         BMI         LCD_DEC_prn
                         MOV         R3, '0'
                         BL          LCD_CHAR
                         ADD         R1, R1, LCD_PARAM_char_stepx @ X+stepx
                         SUB         R5, R5, 1
                         B           LCD_DEC_null

LCD_DEC_prn:             @ �������� ������������ �����
                         CMP         R8, 0
                         BEQ         LCD_DEC_exit
                         POP         { R3 }                  @ ������ ��������
                         ADD         R3, R3, '0'
                         BL          LCD_CHAR
                         ADD         R1, R1, LCD_PARAM_char_stepx @ X+stepx
                         SUB         R8, R8, 1
                         B           LCD_DEC_prn
LCD_DEC_exit:
                         POP         { R0, R1, R2, R3, R4, R5, R6, R7, R8, PC }

