/* @.CHARSET CP1251 */

/* STM32F100RBT, flash 128�� , sram 8�� */

MEMORY
{
     /* FLASH - ����������� flash ������ */
     FLASH      (RX)  : ORIGIN = 0x08000000, LENGTH = 128K

     /* SRAM  - ��� ������ ���������� */
     SRAM       (RW)  : ORIGIN = 0x20000000, LENGTH = 8K

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
}
