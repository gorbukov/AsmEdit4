@.CharSet=CP1251
@GNU AS

.syntax unified     @ ��������� ��������� ����
.thumb              @ ��� ������������ ���������� Thumb
.cpu cortex-m3      @ ���������


.section .asmcode

@ �������� ���������
.global Start
Start:              @ ��������� ��� ����� ��������� ����

MAIN_LOOP:          B    MAIN_LOOP



