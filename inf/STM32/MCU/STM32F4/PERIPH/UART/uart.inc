@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                     Базовые константы USART и UART              |
@ +------------------------------------------------------------------+
@.enddesc

.include "/src/inc/base.inc"

@.item     APB1PERIPH_BASE
.equ  USART2_BASE        , APB1PERIPH_BASE + 0x4400
.equ  USART3_BASE        , APB1PERIPH_BASE + 0x4800
.equ  UART4_BASE         , APB1PERIPH_BASE + 0x4C00
.equ  UART5_BASE         , APB1PERIPH_BASE + 0x5000
.equ  UART7_BASE         , APB1PERIPH_BASE + 0x7800
.equ  UART8_BASE         , APB1PERIPH_BASE + 0x7C00
.equ  USART2             , PERIPH_BASE + USART2_BASE
.equ  USART3             , PERIPH_BASE + USART3_BASE
.equ  USART4             , PERIPH_BASE + USART4_BASE
.equ  USART5             , PERIPH_BASE + USART5_BASE
.equ  USART7             , PERIPH_BASE + USART7_BASE
.equ  USART8             , PERIPH_BASE + USART8_BASE

@.item     APB2PERIPH_BASE
.equ  USART1_BASE        , APB2PERIPH_BASE + 0x1000
.equ  USART6_BASE        , APB2PERIPH_BASE + 0x1400
.equ  USART1             , PERIPH_BASE + USART1_BASE
.equ  USART6             , PERIPH_BASE + USART6_BASE

@.item     USART2_BASE USART3_BASE UART4_BASE UART5_BASE UART7_BASE UART8_BASE
.equ  USART_SR           , 0x00    @ USART Status register
.equ  USART_DR           , 0x04    @ USART Data register
.equ  USART_BRR          , 0x08    @ USART Baud rate register
.equ  USART_CR1          , 0x0C    @ USART Control register 1
.equ  USART_CR2          , 0x10    @ USART Control register 2
.equ  USART_CR3          , 0x14    @ USART Control register 3
.equ  USART_GTPR         , 0x18    @ USART Guard time and prescaler register

@ +------------------------------------------------------------------+
@ |                    Bit definition for  USART и UART  register            |
@ +------------------------------------------------------------------+
@.item     USART_SR
.equ  USART_SR_PE        , 0x0001    @Parity Error
.equ  USART_SR_FE        , 0x0002    @Framing Error
.equ  USART_SR_NE        , 0x0004    @Noise Error Flag
.equ  USART_SR_ORE       , 0x0008    @OverRun Error
.equ  USART_SR_IDLE      , 0x0010    @IDLE line detected
.equ  USART_SR_RXNE      , 0x0020    @Read Data Register Not Empty
.equ  USART_SR_TC        , 0x0040    @Transmission Complete
.equ  USART_SR_TXE       , 0x0080    @Transmit Data Register Empty
.equ  USART_SR_LBD       , 0x0100    @LIN Break Detection Flag
.equ  USART_SR_CTS       , 0x0200    @CTS Flag
.equ  USART_SR_PE_N      , 0    @Bit 0  Parity error
.equ  USART_SR_FE_N      , 1    @Bit 1  Framing error
.equ  USART_SR_NE_N      , 2    @Bit 2 NF: Noise detected flag
.equ  USART_SR_ORE_N     , 3    @Bit 3 ORE: Overrun error
.equ  USART_SR_IDLE_N    , 4    @Bit 4 IDLE: IDLE line detected
.equ  USART_SR_RXNE_N    , 5    @Bit 5 RXNE: Read data register not empty
.equ  USART_SR_TC_N      , 6    @Bit 6 TC: Transmission complete
.equ  USART_SR_TXE_N     , 7    @Bit 7 TXE: Transmit data register empty
.equ  USART_SR_LBD_N     , 8    @Bit 8 LBD: LIN break detection flag
.equ  USART_SR_CTS_N     , 9    @Bit 9 CTS: CTS flag

@.item     USART_DR
.equ  USART_DR_DR        , 0x01FF    @Data value

@.item     USART_BRR
.equ  USART_BRR_DIV_Fraction, 0x000F    @Fraction of USARTDIV
.equ  USART_BRR_DIV_Mantissa, 0xFFF0    @Mantissa of USARTDIV

@.item     USART_CR1
.equ  USART_CR1_SBK      , 0x0001    @Send Break
.equ  USART_CR1_RWU      , 0x0002    @Receiver wakeup
.equ  USART_CR1_RE       , 0x0004    @Receiver Enable
.equ  USART_CR1_TE       , 0x0008    @Transmitter Enable
.equ  USART_CR1_IDLEIE   , 0x0010    @IDLE Interrupt Enable
.equ  USART_CR1_RXNEIE   , 0x0020    @RXNE Interrupt Enable
.equ  USART_CR1_TCIE     , 0x0040    @Transmission Complete Interrupt Enable
.equ  USART_CR1_TXEIE    , 0x0080    @PE Interrupt Enable
.equ  USART_CR1_PEIE     , 0x0100    @PE Interrupt Enable
.equ  USART_CR1_PS       , 0x0200    @Parity Selection
.equ  USART_CR1_PCE      , 0x0400    @Parity Control Enable
.equ  USART_CR1_WAKE     , 0x0800    @Wakeup method
.equ  USART_CR1_M        , 0x1000    @Word length
.equ  USART_CR1_UE       , 0x2000    @USART Enable
.equ  USART_CR1_OVER8    , 0x8000    @USART Oversampling by 8 enable

@.item     USART_CR2
.equ  USART_CR2_ADD      , 0x000F    @Address of the USART node
.equ  USART_CR2_LBDL     , 0x0020    @LIN Break Detection Length
.equ  USART_CR2_LBDIE    , 0x0040    @LIN Break Detection Interrupt Enable
.equ  USART_CR2_LBCL     , 0x0100    @Last Bit Clock pulse
.equ  USART_CR2_CPHA     , 0x0200    @Clock Phase
.equ  USART_CR2_CPOL     , 0x0400    @Clock Polarity
.equ  USART_CR2_CLKEN    , 0x0800    @Clock Enable
.equ  USART_CR2_STOP     , 0x3000    @STOP[1:0] bits (STOP bits)
.equ  USART_CR2_STOP_0   , 0x1000    @Bit 0
.equ  USART_CR2_STOP_1   , 0x2000    @Bit 1
.equ  USART_CR2_LINEN    , 0x4000    @LIN mode enable

@.item     USART_CR3
.equ  USART_CR3_EIE      , 0x0001    @Error Interrupt Enable
.equ  USART_CR3_IREN     , 0x0002    @IrDA mode Enable
.equ  USART_CR3_IRLP     , 0x0004    @IrDA Low-Power
.equ  USART_CR3_HDSEL    , 0x0008    @Half-Duplex Selection
.equ  USART_CR3_NACK     , 0x0010    @Smartcard NACK enable
.equ  USART_CR3_SCEN     , 0x0020    @Smartcard mode enable
.equ  USART_CR3_DMAR     , 0x0040    @DMA Enable Receiver
.equ  USART_CR3_DMAT     , 0x0080    @DMA Enable Transmitter
.equ  USART_CR3_RTSE     , 0x0100    @RTS Enable
.equ  USART_CR3_CTSE     , 0x0200    @CTS Enable
.equ  USART_CR3_CTSIE    , 0x0400    @CTS Interrupt Enable
.equ  USART_CR3_ONEBIT   , 0x0800    @USART One bit method enable

@.item     USART_GTPR
.equ  USART_GTPR_PSC     , 0x00FF    @PSC[7:0] bits (Prescaler value)
.equ  USART_GTPR_PSC_0   , 0x0001    @Bit 0
.equ  USART_GTPR_PSC_1   , 0x0002    @Bit 1
.equ  USART_GTPR_PSC_2   , 0x0004    @Bit 2
.equ  USART_GTPR_PSC_3   , 0x0008    @Bit 3
.equ  USART_GTPR_PSC_4   , 0x0010    @Bit 4
.equ  USART_GTPR_PSC_5   , 0x0020    @Bit 5
.equ  USART_GTPR_PSC_6   , 0x0040    @Bit 6
.equ  USART_GTPR_PSC_7   , 0x0080    @Bit 7
.equ  USART_GTPR_GT      , 0xFF00    @Guard time value


