/* @.CHARSET CP1251 */

/* STM32F429, flash 512 mb, sram 256 kb, bkpsram 4 kb */

MEMORY
{
     /* FLASH - ����������� flash ������ */
     FLASH      (RX)  : ORIGIN = 0x08000000, LENGTH = 512K

     /* SRAM1 - ��� ������ ����������, �.2.3.1 RM0090, ���.68 */
     SRAM       (RW)  : ORIGIN = 0x20000000, LENGTH = 192K

     /* CCM - ������� ������ ����, �.2.3.1 RM0090, ���.68 */
     CCMDATARAM (RWX) : ORIGIN = 0x10000000, LENGTH = 64K

     /* BKPSRAM- backup sram, �.2.3 RM0090, ���.65 */
     BKPSRAM    (RW)  : ORIGIN = 0x40024000, LENGTH = 4K
}
SECTIONS
{
     .code : {
          . = ALIGN(4);
          *(.vectors);   /* ��������� �������� ���������� */
          *(.text);      /*  */
          *(.asmcode);   /* ����� ��������� */
          *(.rodata);    /* ���������  */
     } > FLASH
     .bss : {
          . = ALIGN(1);
          *(.bss);        /* ���������� � SRAM */
      } > SRAM
     .ccmdataram : {
          . = ALIGN(4);
          *(.ccmdataram); /* SRAM ����, ��� ���� � ���������� */
      } > CCMDATARAM
     .bkpsram : {
          . = ALIGN(1);
          *(.bkpsram);     /* SRAM � ����������������� �������� */
     } > BKPSRAM
}
