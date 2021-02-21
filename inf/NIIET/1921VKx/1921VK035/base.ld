/* @.CHARSET CP1251 */

/* 1921ВК035, flash 64 kb, sram 16 kb */

MEMORY
{
     /* FLASH - Программная flash память */
     FLASH      (RX)  : ORIGIN = 0x00000000, LENGTH = 64K

     /* SRAM1 - ОЗУ общего назначения */
     SRAM       (RWX)  : ORIGIN = 0x20000000, LENGTH = 16K

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
