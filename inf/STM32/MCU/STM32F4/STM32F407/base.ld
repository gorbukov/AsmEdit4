/* @.CHARSET CP1251 */

/* STM32F407VE, flash 512 mb, sram 192 kb, bkpsram 4 kb */

MEMORY
{
     /* FLASH - Программная flash память */
     FLASH      (RX)  : ORIGIN = 0x08000000, LENGTH = 512K

     /* SRAM1 - ОЗУ общего назначения, п.2.3.1 RM0090, стр.68 */
     SRAM       (RW)  : ORIGIN = 0x20000000, LENGTH = 128K

     /* CCM - быстрая память ядра, п.2.3.1 RM0090, стр.68 */
     CCMDATARAM (RWX) : ORIGIN = 0x10000000, LENGTH = 64K

     /* BKPSRAM- backup sram, п.2.3 RM0090, стр.65 */
     BKPSRAM    (RW)  : ORIGIN = 0x40024000, LENGTH = 4K
}
SECTIONS
{
     .code : {
          . = ALIGN(4);
          *(.vectors);   /* Указатели векторов прерываний */
          *(.text);      /*  */
          *(.asmcode);   /* Текст программы */
          *(.rodata);    /* Константы  */
     } > FLASH
     .bss : {
          . = ALIGN(1);
          *(.bss);        /* Переменные в SRAM */
      } > SRAM
     .ccmdataram : {
          . = ALIGN(4);
          *(.ccmdataram); /* SRAM ядра, для кода и переменных */
      } > CCMDATARAM
     .bkpsram : {
          . = ALIGN(1);
          *(.bkpsram);     /* SRAM с энергонезависимым питанием */
     } > BKPSRAM
}
