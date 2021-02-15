@GNU AS
@.CharSet=CP1251

.syntax unified      @ синтаксис исходного кода
.thumb               @ тип используемых инструкций Thumb
.cpu cortex-m4       @ процессор
.fpu fpv4-sp-d16     @ сопроцессор

.section .vectors

@ таблица векторов прерываний
     .word     0x20020000             @ 0x0000 ¬ершина стека
     .word     Start+1                  @ 0x0004 RESET


@ “аблица прерываний дл€ €дра микроконтроллеров STM32F40x - F41x

     .word     IRQ_NMI+1               @ 0x0008 NMI
     .word     IRQ_HardFault+1         @ 0x000C Hard Fault
     .word     IRQ_MemFault+1          @ 0x0010 Memory management fault
     .word     IRQ_BusFault+1          @ 0x0014 Bus Fault
     .word     IRQ_UsageFault+1        @ 0x0018 Usage Fault
     .word     0               @ 0x001C Reserved
     .word     0               @ 0x0020 Reserved
     .word     0               @ 0x0024 Reserved
     .word     0               @ 0x0028 Reserved
     .word     IRQ_SVCall+1            @ 0x002C SVCall
     .word     IRQ_DebugMonitor+1      @ 0x0030 Debug Monitor
     .word     0                       @ 0x0034
     .word     IRQ_PendSV+1            @ 0x0038 PendSV
     .word     IRQ_SysTick+1           @ 0x003C SysTick

@ «аглушки дл€ необрабатываемых прерываний

@ ѕрерывани€ €дра микроконтроллера

.weak IRQ_NMI
IRQ_NMI:

.weak IRQ_HardFault
IRQ_HardFault:

.weak IRQ_MemFault
IRQ_MemFault:

.weak IRQ_BusFault
IRQ_BusFault:

.weak IRQ_UsageFault
IRQ_UsageFault:

.weak IRQ_SVCall
IRQ_SVCall:

.weak IRQ_DebugMonitor
IRQ_DebugMonitor:

.weak IRQ_PendSV
IRQ_PendSV:

.weak IRQ_SysTick
IRQ_SysTick:

int_vect_terminator:
                              B     int_vect_terminator
