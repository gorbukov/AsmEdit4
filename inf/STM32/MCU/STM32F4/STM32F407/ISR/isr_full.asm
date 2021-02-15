@GNU AS
@.CharSet=CP1251

.syntax unified		@ синтаксис исходного кода
.thumb			@ тип используемых инструкций Thumb
.cpu cortex-m4		@ процессор
.fpu fpv4-sp-d16	@ сопроцессор

.section .vectors

@ таблица векторов прерываний
	.word	0x20020000	        @ 0x0000 ¬ершина стека
	.word	Start+1		        @ 0x0004 RESET


@ “аблица прерываний дл€ €дра микроконтроллеров STM32F40x - F41x

	.word	IRQ_NMI+1               @ 0x0008 NMI
	.word	IRQ_HardFault+1         @ 0x000C Hard Fault
	.word	IRQ_MemFault+1          @ 0x0010 Memory management fault
	.word	IRQ_BusFault+1          @ 0x0014 Bus Fault
	.word	IRQ_UsageFault+1        @ 0x0018 Usage Fault
	.word	0			@ 0x001C Reserved
	.word	0			@ 0x0020 Reserved
	.word	0			@ 0x0024 Reserved
	.word	0			@ 0x0028 Reserved
	.word	IRQ_SVCall+1            @ 0x002C SVCall
        .word   IRQ_DebugMonitor+1      @ 0x0030 Debug Monitor
        .word   0                       @ 0x0034
	.word	IRQ_PendSV+1            @ 0x0038 PendSV
	.word	IRQ_SysTick+1		@ 0x003C SysTick

@ ѕрерывани€ периферии микроконтроллера
 	.word	IRQ_WWDG+1              @ 0x0040 Window Watchdog interrupt 
	.word	IRQ_PVD+1               @ 0x0044 PVD through EXTI line detection interrupt
	.word	IRQ_TAMP_STAMP+1        @ 0x0048 Tamper and TimeStamp interrupts through the EXTI line
	.word	IRQ_WTC_WKUP+1          @ 0x004C RTC Wakeup interrupt through the EXTI line
	.word	IRQ_FLASH+1             @ 0x0050 Flash global interrupt
	.word	IRQ_RCC+1               @ 0x0054 RCC global interrupt
	.word	IRQ_EXTI0+1             @ 0x0058 EXTI Line0 interrupt
        .word	IRQ_EXTI1+1             @ 0x005C EXTI Line1 interrupt
        .word	IRQ_EXTI2+1             @ 0x0060 EXTI Line2 interrupt
        .word	IRQ_EXTI3+1             @ 0x0064 EXTI Line3 interrupt
        .word	IRQ_EXTI4+1             @ 0x0068 EXTI Line4 interrupt
        .word	DMA1_Stream0+1          @ 0x006C DMA1 Stream0 global interrupt  
        .word	DMA1_Stream1+1          @ 0x0070 DMA1 Stream1 global interrupt 
        .word	DMA1_Stream2+1          @ 0x0074 DMA1 Stream2 global interrupt 
	.word	DMA1_Stream3+1          @ 0x0078 DMA1 Stream3 global interrupt 
        .word	DMA1_Stream4+1          @ 0x007C DMA1 Stream4 global interrupt 
	.word	DMA1_Stream5+1          @ 0x0080 DMA1 Stream5 global interrupt 
        .word	DMA1_Stream6+1          @ 0x0084 DMA1 Stream6 global interrupt 
        .word	IRQ_ADC+1               @ 0x0088 ADC1, ADC2 and ADC3 global interrupts
        .word	IRQ_CAN1_TX+1           @ 0x008C CAN1 TX interrupts 
	.word	IRQ_CAN1_RX0+1          @ 0x0090 CAN1 RX0 interrupts 
	.word	IRQ_CAN1_RX1+1          @ 0x0094 CAN1 RX1 interrupt 
	.word	IRQ_CAN1_SCE+1          @ 0x0098 CAN1 SCE interrupt 
	.word	IRQ_EXTI9_5+1           @ 0x009C EXTI Line[9:5] interrupts 
        .word	IRQ_TIM1_BRK_TIM9+1     @ 0x00A0 TIM1 Break interrupt and TIM9 global interrupt
        .word	IRQ_TIM1_UP_TIM10+1	@ 0x00A4 TIM1 Update interrupt and TIM10 global interrupt
        .word	IRQ_TIM1_TRG_COM_TIM11+1 @ 0x00A8 TIM1 Trigger and Commutation interrupts and TIM11 global interrupt
        .word	IRQ_TIM1_CC+1           @ 0x00AC TIM1 Capture Compare interrupt 
        .word	IRQ_TIM2+1              @ 0x00B0 TIM2 global interrupt 
        .word	IRQ_TIM3+1              @ 0x00B4 TIM3 global interrupt 
        .word	IRQ_TIM4+1              @ 0x00B8 TIM4 global interrupt 
        .word	IRQ_I2C1_EV+1           @ 0x00BC I2C1 event interrupt
        .word	IRQ_I2C1_ER+1           @ 0x00C0 I2C1 error interrupt
        .word	IRQ_I2C2_EV+1           @ 0x00C4 I2C2 event interrupt
        .word	IRQ_I2C2_ER+1           @ 0x00C8 I2C2 error interrupt
        .word	IRQ_SPI1+1              @ 0x00CC SPI1 global interrupt
        .word	IRQ_SPI2+1              @ 0x00D0 SPI2 global interrupt
        .word	IRQ_USART1+1            @ 0x00D4 USART1 global interrupt
        .word	IRQ_USART2+1            @ 0x00D8 USART2 global interrupt
        .word	IRQ_USART3+1            @ 0x00DC USART3 global interrupt
        .word	IRQ_EXTI15_10+1         @ 0x00E0 EXTI Line[15:10] interrupts
        .word	IRQ_RTC_Alarm+1         @ 0x00E4 RTC Alarms (A and B) through EXTI line interrupt
        .word	IRQ_OTG_FS_WKUP+1       @ 0x00E8 USB On-The-Go FS Wakeup through EXTI line interrupt
        .word	IRQ_TIM8_BRK_TIM12+1	@ 0x00EC TIM8 Break interrupt and TIM12 global interrupt
        .word	IRQ_TIM8_UP_TIM13+1	@ 0x00F0 TIM8 Update interrupt and TIM13 global interrupt
        .word	IRQ_TIM8_TRG_COM_TIM14+1 @ 0x00F4 TIM8 Trigger and Commutation interrupts and TIM14 global interrupt
        .word	IRQ_TIM8_CC+1     	@ 0x00F8 TIM8 Capture Compare interrupt 
        .word	IRQ_DMA1_Stream7+1	@ 0x00FC DMA1 Stream7 global interrupt  
        .word	IRQ_FSMC+1              @ 0x0100 FSMC global interrupt
        .word	IRQ_SDIO+1              @ 0x0104 SDIO global interrupt
        .word	IRQ_TIM5+1              @ 0x0108 TIM5 global interrupt
        .word	IRQ_SPI3+1              @ 0x010C SPI3 global interrupt
        .word	IRQ_UART4+1             @ 0x0110 UART4 global interrupt
        .word	IRQ_UART5+1             @ 0x0114 UART5 global interrupt
        .word	IRQ_TIM6_DAC+1          @ 0x0118 TIM6 global interrupt, DAC1 and DAC2 underrun error interrupts
        .word	IRQ_TIM7+1              @ 0x011C TIM7 global interrupt
        .word	IRQ_DMA2_Stream0+1	@ 0x0120 DMA2 Stream0 global interrupt  
        .word	IRQ_DMA2_Stream1+1	@ 0x0124 DMA2 Stream1 global interrupt 
        .word	IRQ_DMA2_Stream2+1	@ 0x0128 DMA2 Stream2 global interrupt 
        .word	IRQ_DMA2_Stream3+1	@ 0x012C DMA2 Stream3 global interrupt 
        .word	IRQ_DMA2_Stream4+1	@ 0x0130 DMA2 Stream4 global interrupt 
        .word	IRQ_ETH+1               @ 0x0134 Ethernet global interrupt 
        .word	IRQ_ETH_WKUP+1          @ 0x0138 Ethernet Wakeup through EXTI line interrupt
        .word	IRQ_CAN2_TX+1           @ 0x013C CAN2 TX interrupts 
	.word	IRQ_CAN2_RX0+1          @ 0x0140 CAN2 RX0 interrupts 
	.word	IRQ_CAN2_RX1+1          @ 0x0144 CAN2 RX1 interrupt 
	.word	IRQ_CAN2_SCE+1          @ 0x0148 CAN2 SCE interrupt 
        .word	IRQ_OTG_FS+1            @ 0x014C USB On The Go FS global interrupt
        .word	IRQ_DMA2_Stream5+1	@ 0x0150 DMA2 Stream5 global interrupt  
        .word	IRQ_DMA2_Stream6+1	@ 0x0154 DMA2 Stream6 global interrupt  
        .word	IRQ_DMA2_Stream7+1	@ 0x0158 DMA2 Stream7 global interrupt  
        .word	IRQ_USART6+1            @ 0x015C USART6 global interrupt 
        .word	IRQ_I2C3_EV+1           @ 0x0160 I2C3 event interrupt
        .word	IRQ_I2C3_ER+1           @ 0x0164 I2C3 error interrupt
        .word	IRQ_OTG_HS_EP1_OUT+1	@ 0x0168 USB On The Go HS End Point 1 Out global interrupt 
        .word	IRQ_OTG_HS_EP1_IN+1	@ 0x016C USB On The Go HS End Point 1 In global interrupt 
        .word	IRQ_OTG_HS_WKUP+1	@ 0x0170 USB On The Go HS Wakeup through EXTI interrupt 
        .word	IRQ_OTG_HS+1            @ 0x0174 USB On The Go HS global interrupt 
        .word	IRQ_DCMI+1              @ 0x0178 DCMI global interrupt 
        .word	IRQ_CRYP+1              @ 0x017C CRYP crypto global interrupt 
        .word	IRQ_HASH_RNG+1          @ 0x0180 Hash and Rng global interrupt  
        .word	IRQ_FPU+1               @ 0x0184 FPU global interrupt

@ «аглушки дл€ любых необрабатываемых прерываний

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

@ прерывани€ периферии микроконтроллера

.weak IRQ_WWDG
IRQ_WWDG:

.weak IRQ_PVD
IRQ_PVD:

.weak IRQ_TAMP_STAMP
IRQ_TAMP_STAMP:

.weak IRQ_WTC_WKUP
IRQ_WTC_WKUP:

.weak IRQ_FLASH
IRQ_FLASH:

.weak IRQ_RCC
IRQ_RCC:

.weak IRQ_EXTI0
IRQ_EXTI0:

.weak IRQ_EXTI1
IRQ_EXTI1:

.weak IRQ_EXTI2
IRQ_EXTI2:

.weak IRQ_EXTI3
IRQ_EXTI3:

.weak IRQ_EXTI4
IRQ_EXTI4:

.weak DMA1_Stream0
DMA1_Stream0:

.weak DMA1_Stream1
DMA1_Stream1:

.weak DMA1_Stream2
DMA1_Stream2:

.weak DMA1_Stream3
DMA1_Stream3:

.weak DMA1_Stream4
DMA1_Stream4:

.weak DMA1_Stream5
DMA1_Stream5:

.weak DMA1_Stream6
DMA1_Stream6:

.weak IRQ_ADC
IRQ_ADC:

.weak IRQ_CAN1_TX
IRQ_CAN1_TX:

.weak IRQ_CAN1_RX0
IRQ_CAN1_RX0:

.weak IRQ_CAN1_RX1
IRQ_CAN1_RX1:

.weak IRQ_CAN1_SCE
IRQ_CAN1_SCE:

.weak IRQ_EXTI9_5
IRQ_EXTI9_5:

.weak IRQ_TIM1_BRK_TIM9
IRQ_TIM1_BRK_TIM9:

.weak IRQ_TIM1_UP_TIM10
IRQ_TIM1_UP_TIM10:

.weak IRQ_TIM1_TRG_COM_TIM11
IRQ_TIM1_TRG_COM_TIM11:

.weak IRQ_TIM1_CC
IRQ_TIM1_CC:

.weak IRQ_TIM2
IRQ_TIM2:

.weak IRQ_TIM3
IRQ_TIM3:

.weak IRQ_TIM4
IRQ_TIM4:

.weak IRQ_I2C1_EV
IRQ_I2C1_EV:

.weak IRQ_I2C1_ER
IRQ_I2C1_ER:

.weak IRQ_I2C2_EV
IRQ_I2C2_EV:

.weak IRQ_I2C2_ER
IRQ_I2C2_ER:

.weak IRQ_SPI1
IRQ_SPI1:

.weak IRQ_SPI2
IRQ_SPI2:

.weak IRQ_USART1
IRQ_USART1:

.weak IRQ_USART2
IRQ_USART2:

.weak IRQ_USART3
IRQ_USART3:

.weak IRQ_EXTI15_10
IRQ_EXTI15_10:

.weak IRQ_RTC_Alarm
IRQ_RTC_Alarm:

.weak IRQ_OTG_FS_WKUP
IRQ_OTG_FS_WKUP:

.weak IRQ_TIM8_BRK_TIM12
IRQ_TIM8_BRK_TIM12:

.weak IRQ_TIM8_UP_TIM13
IRQ_TIM8_UP_TIM13:

.weak IRQ_TIM8_TRG_COM_TIM14
IRQ_TIM8_TRG_COM_TIM14:

.weak IRQ_TIM8_CC
IRQ_TIM8_CC:

.weak IRQ_DMA1_Stream7
IRQ_DMA1_Stream7:

.weak IRQ_FSMC
IRQ_FSMC:

.weak IRQ_SDIO
IRQ_SDIO:

.weak IRQ_TIM5
IRQ_TIM5:

.weak IRQ_SPI3
IRQ_SPI3:

.weak IRQ_UART4
IRQ_UART4:

.weak IRQ_UART5
IRQ_UART5:

.weak IRQ_TIM6_DAC
IRQ_TIM6_DAC:

.weak IRQ_TIM7
IRQ_TIM7:

.weak IRQ_DMA2_Stream0
IRQ_DMA2_Stream0:

.weak IRQ_DMA2_Stream1
IRQ_DMA2_Stream1:

.weak IRQ_DMA2_Stream2
IRQ_DMA2_Stream2:

.weak IRQ_DMA2_Stream3
IRQ_DMA2_Stream3:

.weak IRQ_DMA2_Stream4
IRQ_DMA2_Stream4:

.weak IRQ_ETH
IRQ_ETH:

.weak IRQ_ETH_WKUP
IRQ_ETH_WKUP:

.weak IRQ_CAN2_TX
IRQ_CAN2_TX:

.weak IRQ_CAN2_RX0
IRQ_CAN2_RX0:

.weak IRQ_CAN2_RX1
IRQ_CAN2_RX1:

.weak IRQ_CAN2_SCE
IRQ_CAN2_SCE:

.weak IRQ_OTG_FS
IRQ_OTG_FS:

.weak IRQ_DMA2_Stream5
IRQ_DMA2_Stream5:

.weak IRQ_DMA2_Stream6
IRQ_DMA2_Stream6:

.weak IRQ_DMA2_Stream7
IRQ_DMA2_Stream7:

.weak IRQ_USART6
IRQ_USART6:

.weak IRQ_I2C3_EV
IRQ_I2C3_EV:

.weak IRQ_I2C3_ER
IRQ_I2C3_ER:

.weak IRQ_OTG_HS_EP1_OUT
IRQ_OTG_HS_EP1_OUT:

.weak IRQ_OTG_HS_EP1_IN
IRQ_OTG_HS_EP1_IN:

.weak IRQ_OTG_HS_WKUP
IRQ_OTG_HS_WKUP:

.weak IRQ_OTG_HS
IRQ_OTG_HS:

.weak IRQ_DCMI
IRQ_DCMI:

.weak IRQ_CRYP
IRQ_CRYP:

.weak IRQ_HASH_RNG
IRQ_HASH_RNG:

.weak IRQ_FPU
IRQ_FPU:

int_vect_terminator:
		B	int_vect_terminator
