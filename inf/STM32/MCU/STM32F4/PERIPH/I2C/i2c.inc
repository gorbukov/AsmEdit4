@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                         константы I2C                       |
@ +------------------------------------------------------------------+
@.enddesc

.include "/src/inc/base.inc"

@ константы I2C

.include "/src/inc/base.inc"

@.item     APB1PERIPH_BASE
.equ  I2C                , ( APB1PERIPH_BASE + 0x5400 )

@.item    I2C
.equ I2C1_BASE          , APB1PERIPH_BASE + 0x5400
.equ I2C2_BASE          , APB1PERIPH_BASE + 0x5800
.equ I2C3_BASE          , APB1PERIPH_BASE + 0x5C00
.equ I2C1               , PERIPH_BASE + I2C1_BASE
.equ I2C2               , PERIPH_BASE + I2C2_BASE
.equ I2C3               , PERIPH_BASE + I2C3_BASE

@.item     I2C1_BASE I2C2_BASE I2C3_BASE
.equ  I2C_CR1            , 0x00    @ I2C Control register 1
.equ  I2C_CR2            , 0x04    @ I2C Control register 2
.equ  I2C_OAR1           , 0x08    @ I2C Own address register 1
.equ  I2C_OAR2           , 0x0C    @ I2C Own address register 2
.equ  I2C_DR             , 0x10    @ I2C Data register
.equ  I2C_SR1            , 0x14    @ I2C Status register 1
.equ  I2C_SR2            , 0x18    @ I2C Status register 2
.equ  I2C_CCR            , 0x1C    @ I2C Clock control register
.equ  I2C_TRISE          , 0x20    @ I2C TRISE register
.equ  I2C_FLTR           , 0x24    @ I2C TRISE register

@ +------------------------------------------------------------------+
@ |                          Описание битов настройки регистров                      |
@ +------------------------------------------------------------------+

@.item     I2C_CR1
.equ  I2C_CR1_PE         , 0x0001    @   Bit 0 PE: Peripheral enable
.equ  I2C_CR1_SMBUS_N    , 1    @   Bit 1 SMBUS: SMBus mode
.equ  I2C_CR1_SMBUS_I2C  , 0 << 1    @   0: I2C mode
.equ  I2C_CR1_SMBUS      , 1 << 1    @   1: SMBus mode
.equ  I2C_CR1_SMBTYPE_N  , 3    @   Bit 3 SMBTYPE: SMBus type
.equ  I2C_CR1_SMBTYPE_D  , 0 << 3    @   0: SMBus Device
.equ  I2C_CR1_SMBTYPE_H  , 1 << 3    @   1: SMBus Host
.equ  I2C_CR1_ENARP_N    , 4    @   Bit 4 ENARP: ARP enable
.equ  I2C_CR1_ENARP_D    , 0 << 4    @   0: ARP disable
.equ  I2C_CR1_ENARP      , 1 << 4    @   1: ARP enable
.equ  I2C_CR1_ENPEC_N    , 5    @   Bit 5 ENPEC: PEC enable
.equ  I2C_CR1_ENPEC_D    , 0 << 5    @   0: PEC calculation disabled
.equ  I2C_CR1_ENPEC      , 1 << 5    @   1: PEC calculation enabled
.equ  I2C_CR1_ENGC_N     , 6    @   Bit 6 ENGC: General call enable
.equ  I2C_CR1_ENGC_D     , 0 << 6    @   0: General call disabled. Address 00h is NACKed.
.equ  I2C_CR1_ENGC       , 1 << 6    @   1: General call enabled. Address 00h is ACKed.
.equ  I2C_CR1_NOSTRETCH_N, 7    @   Bit 7 NOSTRETCH: Clock stretching disable (Slave mode).
.equ  I2C_CR1_NOSTRETCH_D, 0 << 7    @   0: General call disabled. Address 00h is NACKed.
.equ  I2C_CR1_NOSTRETCH  , 1 << 7    @   1: General call enabled. Address 00h is ACKed.
.equ  I2C_CR1_START_N    , 8    @   Bit 8 START: Start generation This bit is set and cleared by software and cleared by hardware
.equ  I2C_CR1_START_NOT  , 0 << 8    @   0: No Start generation
.equ  I2C_CR1_START      , 1 << 8    @ In Master Mode: 1: Repeated start generation In Slave mode: 1: Start generation when the bus is free
.equ  I2C_CR1_STOP_N     , 9    @   Bit 9 STOP: Stop generation.
.equ  I2C_CR1_STOP_NOT   , 0 << 9    @   0: No Stop generation.
.equ  I2C_CR1_STOP       , 1 << 9    @ In Master Mode: 1: Stop generation after the current byte transfer. In Slave mode:1: Release the SCL and SDA lines after the current byte transfer.
.equ  I2C_CR1_ACK_N      , 10    @   Bit 10 ACK: Acknowledge enable
.equ  I2C_CR1_ACK_NOACK  , 0 << 10    @  0: No acknowledge returned
.equ  I2C_CR1_ACK        , 1 << 10    @  1: Acknowledge returned after a byte is received
.equ  I2C_CR1_POS_N      , 11    @   Bit 11 POS: Acknowledge/PEC Position (for data reception)
.equ  I2C_CR1_POS_NOT    , 0 << 11    @   0: No acknowledge returned
.equ  I2C_CR1_POS        , 1 << 11    @  1: ACK bit controls the (N)ACK of the next byte which will be received in the shift register.
.equ  I2C_CR1_PEC_N      , 12    @   Bit 12 PEC: Packet error checking
.equ  I2C_CR1_PEC_NOT    , 0 << 12    @   0: No PEC transfer
.equ  I2C_CR1_PEC        , 1 << 12    @  1: PEC transfer (in Tx or Rx mode)
.equ  I2C_CR1_ALERT_N    , 13    @   Bit 13 ALERT: SMBus alert
.equ  I2C_CR1_ALERT_NACK , 0 << 13    @  0: Releases SMBA pin high.
.equ  I2C_CR1_ALERT      , 1 << 13    @  1: Drives SMBA pin low. Alert Response Address Header followed by ACK.
.equ  I2C_CR1_SWRST_N    , 15    @   Bit 15 SWRST: Software reset
.equ  I2C_CR1_SWRST_NOTRST, 0 << 15   @  0: I2C Peripheral not under reset
.equ  I2C_CR1_SWRST      , 1 << 15    @  1: I2C Peripheral under reset state


@.item     I2C_CR2
.equ  I2C_CR2_FREQ       , 0x003F    @    Bits 5:0 FREQ[5:0]: Peripheral clock frequency
.equ  I2C_CR2_FREQ_0     , 0x0001    @Bit 0
.equ  I2C_CR2_FREQ_1     , 0x0002    @Bit 1
.equ  I2C_CR2_FREQ_2     , 0x0004    @Bit 2
.equ  I2C_CR2_FREQ_3     , 0x0008    @Bit 3
.equ  I2C_CR2_FREQ_4     , 0x0010    @Bit 4
.equ  I2C_CR2_FREQ_5     , 0x0020    @Bit 5
.equ  I2C_CR2_ITERREN    , 0x0100    @Error Interrupt Enable
.equ  I2C_CR2_ITEVTEN    , 0x0200    @Event Interrupt Enable
.equ  I2C_CR2_ITBUFEN    , 0x0400    @Buffer Interrupt Enable
.equ  I2C_CR2_DMAEN      , 0x0800    @DMA Requests Enable
.equ  I2C_CR2_LAST       , 0x1000    @DMA Last Transfer

@.item     I2C_OAR1
.equ  I2C_OAR1_ADD1_7    , 0x00FE    @Interface Address
.equ  I2C_OAR1_ADD8_9    , 0x0300    @Interface Address
.equ  I2C_OAR1_ADD_0     , 0x0001    @Bit 0
.equ  I2C_OAR1_ADD_1     , 0x0002    @Bit 1
.equ  I2C_OAR1_ADD_2     , 0x0004    @Bit 2
.equ  I2C_OAR1_ADD_3     , 0x0008    @Bit 3
.equ  I2C_OAR1_ADD_4     , 0x0010    @Bit 4
.equ  I2C_OAR1_ADD_5     , 0x0020    @Bit 5
.equ  I2C_OAR1_ADD_6     , 0x0040    @Bit 6
.equ  I2C_OAR1_ADD_7     , 0x0080    @Bit 7
.equ  I2C_OAR1_ADD_8     , 0x0100    @Bit 8
.equ  I2C_OAR1_ADD_9     , 0x0200    @Bit 9
.equ  I2C_OAR1_ADDMODE   , 0x8000    @Addressing Mode (Slave mode)

@.item     I2C_OAR1
.equ  I2C_OAR2_ENDUAL    , 0x01    @Dual addressing mode enable
.equ  I2C_OAR2_ADD2      , 0xFE    @Interface address

@.item     I2C_DR_DR
.equ  I2C_DR_DR          , 0xFF    @8-bit Data Register

@.item     I2C_SR1
.equ  I2C_SR1_SB         , 0x0001    @Start Bit (Master mode)
.equ  I2C_SR1_ADDR       , 0x0002    @Address sent (master mode)/matched (slave mode)
.equ  I2C_SR1_BTF        , 0x0004    @Byte Transfer Finished
.equ  I2C_SR1_ADD10      , 0x0008    @10-bit header sent (Master mode)
.equ  I2C_SR1_STOPF      , 0x0010    @Stop detection (Slave mode)
.equ  I2C_SR1_RXNE       , 0x0040    @Data Register not Empty (receivers)
.equ  I2C_SR1_TXE        , 0x0080    @Data Register Empty (transmitters)
.equ  I2C_SR1_BERR       , 0x0100    @Bus Error
.equ  I2C_SR1_ARLO       , 0x0200    @Arbitration Lost (master mode)
.equ  I2C_SR1_AF         , 0x0400    @Acknowledge Failure
.equ  I2C_SR1_OVR        , 0x0800    @Overrun/Underrun
.equ  I2C_SR1_PECERR     , 0x1000    @PEC Error in reception
.equ  I2C_SR1_TIMEOUT    , 0x4000    @Timeout or Tlow Error
.equ  I2C_SR1_SMBALERT   , 0x8000    @SMBus Alert

@.item     I2C_SR2
.equ  I2C_SR2_MSL        , 0x0001    @Master/Slave
.equ  I2C_SR2_BUSY       , 0x0002    @Bus Busy
.equ  I2C_SR2_TRA        , 0x0004    @Transmitter/Receiver
.equ  I2C_SR2_GENCALL    , 0x0010    @General Call Address (Slave mode)
.equ  I2C_SR2_SMBDEFAULT , 0x0020    @SMBus Device Default Address (Slave mode)
.equ  I2C_SR2_SMBHOST    , 0x0040    @SMBus Host Header (Slave mode)
.equ  I2C_SR2_DUALF      , 0x0080    @Dual Flag (Slave mode)
.equ  I2C_SR2_PEC        , 0xFF00    @Packet Error Checking Register

@.item     I2C_CCR
.equ  I2C_CCR_CCR        , 0x0FFF    @Clock Control Register in Fast/Standard mode (Master mode)
.equ  I2C_CCR_DUTY       , 0x4000    @Fast Mode Duty Cycle
.equ  I2C_CCR_FS         , 0x8000    @I2C Master Mode Selection

@.item     I2C_TRISE
.equ  I2C_TRISE_TRISE    , 0x3F    @Maximum Rise Time in Fast/Standard mode (Master mode)


