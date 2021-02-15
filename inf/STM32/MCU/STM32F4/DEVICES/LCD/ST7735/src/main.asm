@.CHARSET  CP1251
@GNU AS

.SYNTAX unified                     @ ��������� ��������� ����
.THUMB                              @ ��� ������������ ���������� Thumb
.CPU    cortex-m4                   @ ���������
.FPU    fpv4-sp-d16                 @ �����������

.SECTION .asmcode

@ �������� ���������
.GLOBAL    Start
Start:
                         BL          SYSCLK168_START         @ ���������  ������������
                         BL          SYSTICK_START           @ ������ SysTick

.INCLUDE  "/src/periph/rcc/rcc_ahb1enr_gpio_set.inc"         @ ������������ gpio
.INCLUDE  "/src/periph/gpio/gpio_b_conf.inc"                 @ ������������ gpio b

                         BL          LCD_INIT                @ ������������� �������

                         MOV         R8, 0
LOOP:
                         MOV         R1, 0XF800
                         @ ������� ������������� ������� ����������
                         LDR         R2, = ( 0 << 16 ) | ( 127 << 0 )    @ Y
                         LDR         R3, = ( 0 << 16 ) | ( 159 << 0 )    @ X
                         BL          LCD_FILLRECT

                         MOV         R1, 'S'                @ ������ ��� ������
                         MOV         R2, 64                 @ ���������� Y
                         MOV         R3, R8                 @ ���������� X
                         LDR         R4, = 0xffff0000       @ �����
                         bl          LCD_CHAR
                         MOV         R1, 'T'                @ ������ ��� ������
                         ADD         R3, 7                  @ ���������� X
                         bl          LCD_CHAR
                         MOV         R1, '7'                @ ������ ��� ������
                         ADD         R3, 7                  @ ���������� X
                         bl          LCD_CHAR
                         MOV         R1, '7'                @ ������ ��� ������
                         ADD         R3, 7                  @ ���������� X
                         bl          LCD_CHAR
                         MOV         R1, '3'                @ ������ ��� ������
                         ADD         R3, 7                  @ ���������� X
                         bl          LCD_CHAR
                         MOV         R1, '5'                @ ������ ��� ������
                         ADD         R3, 7                  @ ���������� X
                         bl          LCD_CHAR

                         ADD         R8, R8, 1
                         AND         R8, 0x7f

                         MOV         R0, 255
                         BL          SYSTICK_DELAY

                         B           LOOP


