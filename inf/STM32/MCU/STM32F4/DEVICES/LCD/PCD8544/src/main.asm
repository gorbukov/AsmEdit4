@.CharSet CP1251
@GNU AS

.syntax unified     @ ��������� ��������� ����
.thumb              @ ��� ������������ ���������� Thumb
.cpu cortex-m4      @ ���������
.fpu fpv4-sp-d16    @ �����������


.SECTION .asmcode

@ �������� ���������
.GLOBAL Start
Start:
                         BL          SYSCLK168_START         @ ���������  ������������
                         BL          SYSTICK_START           @ ������ SysTick

.INCLUDE  "/src/periph/rcc/rcc_ahb1enr_gpio_set.inc"         @ ������������ gpio
.INCLUDE  "/src/periph/gpio/gpio_b_conf.inc"                 @ ������������ gpio b

                         BL          LCD_INIT                @ ������������� �������

                         BL          LCD_CLEAR

                         MOV         R0, 0                   @ Y1
                         MOV         R1, 0                   @ X1
                         MOV         R2, 1
                         MOV         R3, 47                  @ Y2
                         MOV         R4, 83                  @ X2
                         BL          LCD_RECT                @ ������ �������������

                         ADR         R4, ADR_TEXT1           @ ������� ����� STM32 �� ����������
                         BL          LCD_PUTSTR              @

                         BL          LCD_REFRESH

LOOP:                    B           LOOP

ADR_TEXT1:
                         .byte       1                       @ ������ ����������
                         .short      18, 20                  @ X, Y
                         .word       1                       @ ����
                         .ascii      "STM32F4"               @ �����

                         .byte       1
                         .short      28, 38
                         .word       1
                         .ascii      "��"

                         .byte       1
                         .short      38, 8
                         .word       1
                         .ascii      "����������"
                         .byte       0                       @ ��������� �����


