/* @.CHARSET CP1251 */

/* STM32F100RBT, flash 128кб , sram 8кб */

MEMORY
{
     /* FLASH - Программная flash память */
     FLASH      (RX)  : ORIGIN = 0x08000000, LENGTH = 128K

     /* SRAM  - ОЗУ общего назначения */
     SRAM       (RW)  : ORIGIN = 0x20000000, LENGTH = 8K

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
}
