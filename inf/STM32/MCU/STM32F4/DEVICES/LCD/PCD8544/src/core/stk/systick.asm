@GNU AS
@.CHARSET CP1251

@.desc type=module
@ +------------------------------------------------------------------+
@ |                      ������ ������� SysTick                      |
@ +------------------------------------------------------------------+
@ | ��� ������������� ���������� ���������������� ������ �������:    |
@ |     BL   SYSTICK_START                                           |
@ |                                                                  |
@ | � ���������� ��� ������������� ������������� ��������:           |
@ |    MOV R0, <����� �������� � ������������>                       |
@ |    BL  SYSTICK_DELAY                                             |
@ +------------------------------------------------------------------+
@.enddesc

.syntax unified      @ ��������� ��������� ����
.thumb               @ ��� ������������ ���������� Thumb
.cpu cortex-m4       @ ���������
.fpu fpv4-sp-d16     @ �����������

@ ����������� ��������
.equ SCB_BASE           ,0xE000ED00   @ System control block (SCB)
.equ SHPR3              ,0x20         @ System handler priority registers (SHPRx)
.equ SYSTICK_BASE       ,0xE000E010   @ System timer
.equ STK_CTRL           ,0x00         @ ������� ������� � ����������
.equ STK_LOAD           ,0x00000004   @ �������� ��� ������������ ��������
.equ STK_VAL            ,0x00000008   @ ������� �������� ��������
.equ STK_CTRL_CLKSOURSE ,0x00000004   @ (RW) �������� ������������: 0: AHB/8; 1: AHB
.equ STK_CTRL_TICKINT   ,0x00000002   @ (RW) ��� ��������� ���������� ���������� ��� �������� ����� 0
.equ STK_CTRL_ENABLE    ,0x00000001   @ (RW) �������� �������.


.section .bss
@ ���������� � ���
SYSTICK_COUNTER:
          .word     0             @ �������� ����������� ��������

.section .asmcode

@.DEBUG type=DEBUGINFO  label=debug  path=ROOT
.align 4
debug:
      .word SYSTICK_COUNTER  @.DEBUG name=SysTick_Counter type=word

@.ENDDEBUG

@.desc name=IRQ_SysTick type=proc
@ ****************************************************************************
@ *             ���������� ���������� ���������� ������� SysTick             *
@ ****************************************************************************
@ ���������� ��������� �������� �������� SYSTICK_COUNTER �� "1" (� ������ ����
@ �������� �������� ������ "0"
@.enddesc

.global IRQ_SysTick

IRQ_SysTick:
          PUSH     { R0 , R1 , LR }
          LDR      R1 , =SYSTICK_COUNTER
          LDR     R0 , [R1 , 0]
          ORRS     R0 , R0 , 0       @ �������� R0 �� 0
          ITT     NE                           @ ���� R0<>0 ��������� ��� �� 1
          SUBNE     R0 , R0 , 1
          STRNE     R0 , [R1 , 0]
          POP     { R0 , R1 , PC }

@.desc name=SYSTICK_START type=proc
@ ****************************************************************************
@ *                 ������������� ���������� ������� SysTick                 *
@ ****************************************************************************
@ ��� ������� AHB=168 ���
@ ������� ����� 1000 ��
@
@.enddesc

@ ��������� SysTick
.global SYSTICK_START

SYSTICK_START:
          PUSH     { R0 , R1 , LR }
          LDR     R0 , =SYSTICK_BASE

     @ ��������� �������� ��������� ��� ��������� ������� 1000 ��
          LDR     R1 , =168000 - 1
          STR     R1 , [ R0 , STK_LOAD]

     @ �������� ������� AHB (168 ���) + ���������� + �������� SYSTICK
          LDR     R1 , =(STK_CTRL_CLKSOURSE +  STK_CTRL_TICKINT + STK_CTRL_ENABLE)
          STR     R1 , [ R0 , STK_CTRL]

     @ ��������� ���������� ���������� �� SysTick
          LDR     R0 , =SCB_BASE
          LDR     R1 , [ R0, SHPR3]
          ORR     R1 , R1 , 0x0F << 12
          STR     R1 , [ R0 , SHPR3]

         POP     { R0 , R1 , PC }

@.desc name=SYSTICK_DELAY type=proc
@ ****************************************************************************
@ *             �������� ���������� ���������� ������� SysTick               *
@ ****************************************************************************
@ ������� ��������: R0 - �������� � ������������
@ �������� ��������: R0 = 0
@ ��������� ������ ���������: ���
@
@.enddesc

.global SYSTICK_DELAY

SYSTICK_DELAY:
          PUSH      {R1, R2, LR}

          LDR     R2, =SYSTICK_BASE   @ ������� ������� �������
          STR     R0, [R2, STK_VAL]

          LDR      R1, =SYSTICK_COUNTER   @ ����� ��������
          STR     R0, [R1 , 0]           @ �������� ��������� ��������
DELAY_LOOP:
          LDR     R0, [R1 , 0]     @ ���� ��������� ��������
          ORRS     R0, R0 , 0
          BNE     DELAY_LOOP
          POP      { R1 , R2, PC }
