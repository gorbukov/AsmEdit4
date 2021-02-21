@.CharSet=CP1251
@GNU AS

.syntax unified     @ синтаксис исходного кода
.thumb              @ тип используемых инструкций Thumb
.cpu cortex-m4      @ процессор
.fpu fpv4-sp-d16    @ сопроцессор

 
.section .asmcode   

@ основная программа
.global Start       
Start:              @ поместите код своей программы ниже
                                 
MAIN_LOOP:          B    MAIN_LOOP



