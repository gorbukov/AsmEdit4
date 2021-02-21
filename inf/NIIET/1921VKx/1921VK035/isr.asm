@GNU AS
@.CHARSET  CP1251

.SYNTAX    unified              @ синтаксис исходного кода
.THUMB                          @ тип используемых инструкций Thumb
.CPU       cortex-m4            @ процессор
.FPU       fpv4-sp-d16          @ сопроцессор

.section .vectors

@ таблица векторов прерываний
                     .WORD       0x20020000       @ 0x0000 Вершина стека
                     .WORD       Start + 1        @ 0x0004 RESET


@ Таблица прерываний для ядра микроконтроллеров cortex-m4

                     .WORD       IRQ_NMI + 1      @ 0x0008 NMI
                     .WORD       IRQ_HardFault + 1    @ 0x000C Hard Fault
                     .WORD       IRQ_MemManage + 1    @ 0x0010 Memory management fault
                     .WORD       IRQ_BusFault + 1    @ 0x0014 Bus Fault
                     .WORD       IRQ_UsageFault + 1    @ 0x0018 Usage Fault
                     .WORD       0                @ 0x001C Reserved
                     .WORD       0                @ 0x0020 Reserved
                     .WORD       0                @ 0x0024 Reserved
                     .WORD       0                @ 0x0028 Reserved
                     .WORD       IRQ_SVCall + 1    @ 0x002C SVCall
                     .WORD       IRQ_DebugMonitor + 1    @ 0x0030 Debug Monitor
                     .WORD       0                @ 0x0034
                     .WORD       IRQ_PendSV + 1    @ 0x0038 PendSV
                     .WORD       IRQ_SysTick + 1    @ 0x003C SysTick

@ Прерывания периферии микроконтроллера 1921ВК035
                     .WORD       IRQ_WDT + 1      @ 0x0040 Прерывание блока сторожевого таймера
                     .WORD       IRQ_RCU + 1      @ 0x0044 Прерывание блока RCU
                     .WORD       IRQ_MFLASH + 1    @ 0x0048 Прерывание контроллера Flash-памяти
                     .WORD       IRQ_GPIOA + 1    @ 0x004C Прерывание порта А
                     .WORD       IRQ_GPIOB + 1    @ 0x0050 Прерывание порта В
                     .WORD       IRQ_DMA_CH0 + 1    @ 0x0054 Прерывание контроллера DMA
                     .WORD       IRQ_DMA_CH1 + 1    @ 0x0058
                     .WORD       IRQ_DMA_CH2 + 1    @ 0x005C
                     .WORD       IRQ_DMA_CH3 + 1    @ 0x0060
                     .WORD       IRQ_DMA_CH4 + 1    @ 0x0064
                     .WORD       IRQ_DMA_CH5 + 1    @ 0x0068
                     .WORD       IRQ_DMA_CH6 + 1    @ 0x006C
                     .WORD       IRQ_DMA_CH7 + 1    @ 0x0070
                     .WORD       IRQ_DMA_CH8 + 1    @ 0x0074
                     .WORD       IRQ_DMA_CH9 + 1    @ 0x0078
                     .WORD       IRQ_DMA_CH10 + 1    @ 0x007C
                     .WORD       IRQ_DMA_CH11 + 1    @ 0x0080
                     .WORD       IRQ_DMA_CH12 + 1    @ 0x0084
                     .WORD       IRQ_DMA_CH13 + 1    @ 0x0088
                     .WORD       IRQ_DMA_CH14 + 1    @ 0x008C
                     .WORD       IRQ_DMA_CH15 + 1    @ 0x0090
                     .WORD       IRQ_TMR0 + 1     @ 0x0094 Прерывания таймера 0
                     .WORD       IRQ_TMR1 + 1     @ 0x0098 Прерывания таймера 1
                     .WORD       IRQ_TMR2 + 1     @ 0x009C Прерывания таймера 2
                     .WORD       IRQ_TMR3 + 1     @ 0x00A0 Прерывания таймера 3
                     .WORD       IRQ_UART0_TD + 1    @ 0x00A4 Прерывания UART0 по окончанию передачи
                     .WORD       IRQ_UART0_RX + 1    @ 0x00A8 Прерывания UART0 по заполнению FIFO
                     .WORD       IRQ_UART0_TX + 1    @ 0x00AC Прерывания UART0 по опустошению FIFO
                     .WORD       IRQ_UART0 + 1    @ 0x00B0 Общее прерывание UART0
                     .WORD       IRQ_UART1_TD + 1    @ 0x00B4 Прерывания UART1 по окончанию передачи
                     .WORD       IRQ_UART1_RX + 1    @ 0x00B8 Прерывания UART1 по заполнению FIFO
                     .WORD       IRQ_UART1_TX + 1    @ 0x00BC Прерывания UART1 по опустошению FIFO
                     .WORD       IRQ_UART1 + 1    @ 0x00C0 Общее прерывание UART0
                     .WORD       IRQ_SPI + 1      @ 0x00C4 Общее прерывание SPI
                     .WORD       IRQ_SPI_RX + 1    @ 0x00C8 Прерывание SPI по заполнению FIFO
                     .WORD       IRQ_SPI_TX + 1    @ 0x00CC Прерывание SPI по опустошению FIFO
                     .WORD       IRQ_I2C + 1      @ 0x00D0 Прерывание I2C
                     .WORD       IRQ_ECAP0 + 1    @ 0x00D4 Прерывание блока захвата 0
                     .WORD       IRQ_ECAP1 + 1    @ 0x00D8  Прерывание блока захвата 1
                     .WORD       IRQ_ECAP2 + 1    @ 0x00DC  Прерывание блока захвата 2
                     .WORD       IRQ_PWM0 + 1     @ 0x00E0 Общее прерывание блока ШИМ 0
                     .WORD       IRQ_PWM0_HD + 1    @ 0x00E4 Прерывание схемы удержания блока ШИМ 0
                     .WORD       IRQ_PWM0_TZ + 1    @ 0x00E8 Прерывание детектора аварии блока ШИМ 0
                     .WORD       IRQ_PWM1 + 1     @ 0x00EC Общее прерывание блока ШИМ 1
                     .WORD       IRQ_PWM1_HD + 1    @ 0x00F0 Прерывание схемы удержания блока ШИМ 1
                     .WORD       IRQ_PWM1_TZ + 1    @ 0x00F4 Прерывание детектора аварии блока ШИМ 1
                     .WORD       IRQ_PWM2 + 1     @ 0x00F8 Общее прерывание блока ШИМ 2
                     .WORD       IRQ_PWM2_HD + 1    @ 0x00FC Прерывание схемы удержания блока ШИМ 2
                     .WORD       IRQ_PWM2_TZ + 1    @ 0x0100 Прерывание детектора аварии блока ШИМ 2
                     .WORD       IRQ_QEP + 1      @ 0x0104 Прерывание квадратурного декодера
                     .WORD       IRQ_ADC_SEQ0 + 1    @ 0x0108 Прерывание секвенсора 0 блока АЦП
                     .WORD       IRQ_ADC_SEQ1 + 1    @ 0x010C Прерывание секвенсора 1 блока АЦП
                     .WORD       IRQ_ADC_DC + 1    @ 0x0110 Прерывание компараторов блоув АЦП
                     .WORD       IRQ_CAN0 + 1     @ 0x0114 Прерывания контроллера CAN
                     .WORD       IRQ_CAN1 + 1     @ 0x0118
                     .WORD       IRQ_CAN2 + 1     @ 0x011C
                     .WORD       IRQ_CAN3 + 1     @ 0x0120
                     .WORD       IRQ_CAN4 + 1     @ 0x0124
                     .WORD       IRQ_CAN5 + 1     @ 0x0128
                     .WORD       IRQ_CAN6 + 1     @ 0x012C
                     .WORD       IRQ_CAN7 + 1     @ 0x0130
                     .WORD       IRQ_CAN8 + 1     @ 0x0134
                     .WORD       IRQ_CAN9 + 1     @ 0x0138
                     .WORD       IRQ_CAN10 + 1    @ 0x013C
                     .WORD       IRQ_CAN11 + 1    @ 0x0140
                     .WORD       IRQ_CAN12 + 1    @ 0x0144
                     .WORD       IRQ_CAN13 + 1    @ 0x0148
                     .WORD       IRQ_CAN14 + 1    @ 0x014C
                     .WORD       IRQ_CAN15 + 1    @ 0x0150
                     .WORD       IRQ_FPU + 1      @ 0x0154 Прерывание исключений блока FPU

@ Заглушки для любых необрабатываемых прерываний

@ Прерывания ядра микроконтроллера

                     .WEAK       IRQ_NMI
IRQ_NMI:

                     .WEAK       IRQ_HardFault
IRQ_HardFault:

                     .WEAK       IRQ_MemManage
IRQ_MemManage:

                     .WEAK       IRQ_BusFault
IRQ_BusFault:

                     .WEAK       IRQ_UsageFault
IRQ_UsageFault:

                     .WEAK       IRQ_SVCall
IRQ_SVCall:

                     .WEAK       IRQ_DebugMonitor
IRQ_DebugMonitor:

                     .WEAK       IRQ_PendSV
IRQ_PendSV:

                     .WEAK       IRQ_SysTick
IRQ_SysTick:

@ прерывания периферии микроконтроллера

                     .WEAK       IRQ_WDT
IRQ_WDT:

                     .WEAK       IRQ_RCU
IRQ_RCU:

                     .WEAK       IRQ_MFLASH
IRQ_MFLASH:

                     .WEAK       IRQ_GPIOA
IRQ_GPIOA:

                     .WEAK       IRQ_GPIOB
IRQ_GPIOB:

                     .WEAK       IRQ_DMA_CH0
IRQ_DMA_CH0:

                     .WEAK       IRQ_DMA_CH1
IRQ_DMA_CH1:

                     .WEAK       IRQ_DMA_CH2
IRQ_DMA_CH2:

                     .WEAK       IRQ_DMA_CH3
IRQ_DMA_CH3:

                     .WEAK       IRQ_DMA_CH4
IRQ_DMA_CH4:

                     .WEAK       IRQ_DMA_CH5
IRQ_DMA_CH5:

                     .WEAK       IRQ_DMA_CH6
IRQ_DMA_CH6:

                     .WEAK       IRQ_DMA_CH7
IRQ_DMA_CH7:

                     .WEAK       IRQ_DMA_CH8
IRQ_DMA_CH8:

                     .WEAK       IRQ_DMA_CH9
IRQ_DMA_CH9:

                     .WEAK       IRQ_DMA_CH10
IRQ_DMA_CH10:

                     .WEAK       IRQ_DMA_CH11
IRQ_DMA_CH11:

                     .WEAK       IRQ_DMA_CH12
IRQ_DMA_CH12:

                     .WEAK       IRQ_DMA_CH13
IRQ_DMA_CH13:

                     .WEAK       IRQ_DMA_CH14
IRQ_DMA_CH14:

                     .WEAK       IRQ_DMA_CH15
IRQ_DMA_CH15:

                     .WEAK       IRQ_TMR0
IRQ_TMR0:

                     .WEAK       IRQ_TMR1
IRQ_TMR1:

                     .WEAK       IRQ_TMR2
IRQ_TMR2:

                     .WEAK       IRQ_TMR3
IRQ_TMR3:

                     .WEAK       IRQ_UART0_TD
IRQ_UART0_TD:

                     .WEAK       IRQ_UART0_RX
IRQ_UART0_RX:

                     .WEAK       IRQ_UART0_TX
IRQ_UART0_TX:

                     .WEAK       IRQ_UART0
IRQ_UART0:

                     .WEAK       IRQ_UART1_TD
IRQ_UART1_TD:

                     .WEAK       IRQ_UART1_RX
IRQ_UART1_RX:

                     .WEAK       IRQ_UART1_TX
IRQ_UART1_TX:

                     .WEAK       IRQ_UART1
IRQ_UART1:

                     .WEAK       IRQ_SPI
IRQ_SPI:

                     .WEAK       IRQ_SPI_RX
IRQ_SPI_RX:

                     .WEAK       IRQ_SPI_TX
IRQ_SPI_TX:

                     .WEAK       IRQ_I2C
IRQ_I2C:

                     .WEAK       IRQ_ECAP0
IRQ_ECAP0:

                     .WEAK       IRQ_ECAP1
IRQ_ECAP1:

                     .WEAK       IRQ_ECAP2
IRQ_ECAP2:

                     .WEAK       IRQ_PWM0
IRQ_PWM0:

                     .WEAK       IRQ_PWM0_HD
IRQ_PWM0_HD:

                     .WEAK       IRQ_PWM0_TZ
IRQ_PWM0_TZ:

                     .WEAK       IRQ_PWM1
IRQ_PWM1:

                     .WEAK       IRQ_PWM1_HD
IRQ_PWM1_HD:

                     .WEAK       IRQ_PWM1_TZ
IRQ_PWM1_TZ:

                     .WEAK       IRQ_PWM2
IRQ_PWM2:

                     .WEAK       IRQ_PWM2_HD
IRQ_PWM2_HD:

                     .WEAK       IRQ_PWM2_TZ
IRQ_PWM2_TZ:

                     .WEAK       IRQ_QEP
IRQ_QEP:

                     .WEAK       IRQ_ADC_SEQ0
IRQ_ADC_SEQ0:

                     .WEAK       IRQ_ADC_SEQ1
IRQ_ADC_SEQ1:

                     .WEAK       IRQ_ADC_DC
IRQ_ADC_DC:

                     .WEAK       IRQ_CAN0
IRQ_CAN0:

                     .WEAK       IRQ_CAN1
IRQ_CAN1:

                     .WEAK       IRQ_CAN2
IRQ_CAN2:

                     .WEAK       IRQ_CAN3
IRQ_CAN3:

                     .WEAK       IRQ_CAN4
IRQ_CAN4:

                     .WEAK       IRQ_CAN5
IRQ_CAN5:

                     .WEAK       IRQ_CAN6
IRQ_CAN6:

                     .WEAK       IRQ_CAN7
IRQ_CAN7:

                     .WEAK       IRQ_CAN8
IRQ_CAN8:

                     .WEAK       IRQ_CAN9
IRQ_CAN9:

                     .WEAK       IRQ_CAN10
IRQ_CAN10:

                     .WEAK       IRQ_CAN11
IRQ_CAN11:

                     .WEAK       IRQ_CAN12
IRQ_CAN12:

                     .WEAK       IRQ_CAN13
IRQ_CAN13:

                     .WEAK       IRQ_CAN14
IRQ_CAN14:

                     .WEAK       IRQ_CAN15
IRQ_CAN15:

                     .WEAK       IRQ_FPU
IRQ_FPU:

int_vect_terminator:
          B     int_vect_terminator
