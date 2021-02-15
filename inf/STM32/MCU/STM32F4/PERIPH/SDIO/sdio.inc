@GNU AS
@.CharSet =CP1251 ( Cyrillic )
@.desc     type=module
@ +------------------------------------------------------------------+
@ |                     Базовые константы SDIO                     |
@ +------------------------------------------------------------------+
@.enddesc

.include   "/src/inc/base.inc"

@.ITEM     APB2PERIPH_BASE
.equ  SDIO_BASE          , APB2PERIPH_BASE + 0x2C00
.equ  SDIO               , PERIPH_BASE + SDIO_BASE

@.item     SDIO_BASE
.equ SDIO_POWER, 0x00 @ SDIO power control register
.equ SDIO_CLKCR, 0x04 @ SDI clock control register
.equ SDIO_ARG, 0x08 @ SDIO argument register
.equ SDIO_CMD, 0x0C @ SDIO command register
.equ SDIO_RESPCMD, 0x10 @ SDIO command response register
.equ SDIO_RESP1, 0x14 @ SDIO response 1 register
.equ SDIO_RESP2, 0x18 @ SDIO response 2 register
.equ SDIO_RESP3, 0x1C @ SDIO response 3 register
.equ SDIO_RESP4, 0x20 @ SDIO response 4 register
.equ SDIO_DTIMER, 0x24 @ SDIO data timer register
.equ SDIO_DLEN, 0x28 @ SDIO data length register
.equ SDIO_DCTRL, 0x2C @ SDIO data control register
.equ SDIO_DCOUNT, 0x30 @ SDIO data counter register
.equ SDIO_STA, 0x34 @ SDIO status register
.equ SDIO_ICR, 0x38 @ SDIO interrupt clear register
.equ SDIO_MASK, 0x3C @ SDIO mask register
.equ SDIO_FIFOCNT, 0x48 @ SDIO FIFO counter register
.equ SDIO_FIFO, 0x80 @ SDIO data FIFO register

@ Описание битов настройки регистра SDIO_POWER
@.item     SDIO_POWER
.equ  SDIO_POWER_PWRCTRL_N, 0    @  Bits 1:0 PWRCTRL: Power supply control bits.
.equ  SDIO_POWER_PWRCTRL , 0x03    @PWRCTRL[1:0] bits
.equ  SDIO_POWER_PWRCTRL_0, 0x01    @Bit 0
.equ  SDIO_POWER_PWRCTRL_1, 0x02    @Bit 1

@ Описание битов настройки регистра SDIO_CLKCR
@.item     SDIO_CLKCR
.equ  SDIO_CLKCR_HWFC_EN , 1 << 14    @ Bit 14 HWFC_EN: HW Flow Control eable
.equ  SDIO_CLKCR_NEGEDGE , 1 << 13    @ Bit 13 NEGEDGE:SDIO_CK dephasing selection bit
.equ  SDIO_CLKCR_WIDBUS_N, 11    @  Bits 12:11 WIDBUS: Wide bus mode enable bit
.equ SDIO_CLKCR_WIDBUS_0, 0x0800 @ Bit 0
.equ SDIO_CLKCR_WIDBUS_1, 0x1000 @ Bit 1
.equ  SDIO_CLKCR_BYPASS  , 1 << 10    @ Bit 10 BYPASS: Clock divider bypass enable bit
.equ  SDIO_CLKCR_PWRSAV  , 1 << 9    @ Bit 9 PWRSAV: Power saving configuration bit
.equ  SDIO_CLKCR_CLKEN   , 1 << 8    @ Bit 8 CLKEN: Clock enable bit
.equ SDIO_CLKCR_CLKDIV, 0x00FF @ Bits 7:0 CLKDIV: Clock divide factor

@ Описание битов настройки регистра SDIO_ARG
@.item     SDIO_ARG
.equ  SDIO_ARG_CMDARG    , 0xFFFFFFFF    @ Bits 31:0 CMDARG: Command argument

@ Описание битов настройки регистра SDIO_CMD
@.item     SDIO_CMD
.equ  SDIO_CMD_ATACMD    , 1 << 14    @ Bit 14 ATACMD: CE-ATA command
.equ  SDIO_CMD_NIEN      , 1 << 13    @ Bit 13 nIEN: not Interrupt Enable
.equ  SDIO_CMD_ENCMDCOMPL, 1 << 12    @ Bit 12 ENCMDcompl: Enable CMD completion
.equ  SDIO_CMD_SDIOSUSPEND, 1 << 11    @ Bit 11 SDIOSuspend: SD I/O suspend command
.equ  SDIO_CMD_CPSMEN    , 1 << 10    @ Bit 10 CPSMEN: Command path state machine (CPSM) Enable bitt
.equ  SDIO_CMD_WAITPEND  , 1 << 9    @ Bit 9 WAITPEND: CPSM Waits for ends of data transfer (CmdPend internal signal).
.equ  SDIO_CMD_WAITINT   , 1 << 8    @ Bit 8 WAITINT: CPSM waits for interrupt request
.equ  SDIO_CMD_WAITRESP_N, 6    @ Bits 7:6 WAITRESP: Wait for response bits
.equ  SDIO_CMD_WAITRESP_0, 4 << 6    @ Bit 0
.equ  SDIO_CMD_WAITRESP_1, 8 << 6    @ Bit 1
.equ  SDIO_CMD_CMDINDEX  , 0x003F    @ Bits 5:0 CMDINDEX: Command index

@ Описание битов настройки регистра SDIO_CMD
@.item  SDIO_RESPCMD
.equ  SDIO_RESPCMD_RESPCMD, 0x3F    @ Bits 5:0 RESPCMD: Response command index

@ Описание битов настройки регистра SDIO_RESP1 SDIO_RESP2 SDIO_RESP3 SDIO_RESP4
@.item     SDIO_RESP1 SDIO_RESP2 SDIO_RESP3 SDIO_RESP4
.equ  SDIO_RESP1_CARDSTATUS1, 0xFFFFFFFF    @Card Status
.equ  SDIO_RESP2_CARDSTATUS2, 0xFFFFFFFF    @Card Status
.equ  SDIO_RESP3_CARDSTATUS3, 0xFFFFFFFF    @Card Status
.equ  SDIO_RESP4_CARDSTATUS4, 0xFFFFFFFF    @Card Status

@ Описание битов настройки регистра SDIO_DTIMER
@.item   SDIO_DTIMER
.equ  SDIO_DTIMER_DATATIME, 0xFFFFFFFF    @ Bits 31:0 DATATIME: Data timeout period


@ Описание битов настройки регистра SDIO_DLEN
@.item     SDIO_DLEN
.equ  SDIO_DLEN_DATALENGTH, 0x01FFFFFF    @ Bits 24:0 DATALENGTH: Data length value

@ Описание битов настройки регистра SDIO_DCTRL
@.item     SDIO_DCTRL
.equ  SDIO_DCTRL_SDIOEN  , 1 << 11    @ Bit 11 SDIOEN: SD I/O enable functions
.equ  SDIO_DCTRL_RWMOD   , 1 << 10    @ Bit 10 RWMOD: Read wait mode
.equ  SDIO_DCTRL_RWSTOP  , 1 << 9    @ Bit 9 RWSTOP: Read wait stop
.equ  SDIO_DCTRL_RWSTART , 1 << 8    @ Bit 8 RWSTART: Read wait start
.equ  SDIO_DCTRL_DBLOCKSIZE_N, 4    @ Bits 7:4 DBLOCKSIZE: Data block size
.equ  SDIO_DCTRL_DBLOCKSIZE, 0x00F0    @
.equ  SDIO_DCTRL_DBLOCKSIZE_0, 1 << 4    @ Bit 0
.equ  SDIO_DCTRL_DBLOCKSIZE_1, 2 << 4    @ Bit 1
.equ  SDIO_DCTRL_DBLOCKSIZE_2, 4 << 4    @ Bit 2
.equ  SDIO_DCTRL_DBLOCKSIZE_3, 8 << 4    @ Bit 3
.equ  SDIO_DCTRL_DMAEN   , 0x0008    @ Bit 3 DMAEN: DMA enable bit
.equ  SDIO_DCTRL_DTMODE  , 0x0004    @ Bit 2 DTMODE: Data transfer mode selection 1: Stream or SDIO multibyte data transfer.
.equ  SDIO_DCTRL_DTDIR   , 0x0002    @ Bit 1 DTDIR: Data transfer direction selection
.equ  SDIO_DCTRL_DTEN    , 0x0001    @ Bit 0 DTEN: Data transfer enabled bit

@ Описание битов настройки регистра SDIO_DCOUNT
@.item     SDIO_DCOUNT
.equ  SDIO_DCOUNT_DATACOUNT, 0x01FFFFFF    @ Bits 24:0 DATACOUNT: Data count value

@ Описание битов настройки регистра SDIO_STA
@.item   SDIO_STA
.equ  SDIO_STA_CEATAEND  , 1 << 23    @ Bit 23 CEATAEND: CE-ATA command completion signal received for CMD61
.equ  SDIO_STA_SDIOIT    , 1 << 22    @Bit 22 SDIOIT: SDIO interrupt received
.equ  SDIO_STA_RXDAVL    , 1 << 21    @Bit 21 RXDAVL: Data available in receive FIFO
.equ  SDIO_STA_TXDAVL    , 1 << 20    @Bit 20 TXDAVL: Data available in transmit FIFO
.equ  SDIO_STA_RXFIFOE   , 1 << 19    @Bit 19 RXFIFOE: Receive FIFO empty
.equ  SDIO_STA_TXFIFOE   , 1 << 18    @Bit 18 TXFIFOE: Transmit FIFO empty
.equ  SDIO_STA_RXFIFOF   , 1 << 17    @Bit 17 RXFIFOF: Receive FIFO full
.equ  SDIO_STA_TXFIFOF   , 1 << 16    @Bit 16 TXFIFOF: Transmit FIFO full
.equ  SDIO_STA_RXFIFOHF  , 1 << 15    @Bit 15 RXFIFOHF: Receive FIFO half full: there are at least 8 words in the FIFO
.equ  SDIO_STA_TXFIFOHE  , 1 << 14    @Bit 14 TXFIFOHE: Transmit FIFO half empty: at least 8 words can be written into the FIFO
.equ  SDIO_STA_RXACT     , 1 << 13    @Bit 13 RXACT: Data receive in progress
.equ  SDIO_STA_TXACT     , 1 << 12    @Bit 12 TXACT: Data transmit in progress
.equ  SDIO_STA_CMDACT    , 1 << 11    @Bit 11 CMDACT: Command transfer in progress
.equ  SDIO_STA_DBCKEND   , 1 << 10    @Bit 10 DBCKEND: Data block sent/received (CRC check passed)
.equ  SDIO_STA_STBITERR  , 1 << 9    @Bit 9 STBITERR: Start bit not detected on all data signals in wide bus mode
.equ  SDIO_STA_DATAEND   , 1 << 8    @Bit 8 DATAEND: Data end (data counter, SDIDCOUNT, is zero)
.equ  SDIO_STA_CMDSENT   , 1 << 7    @Bit 7 CMDSENT: Command sent (no response required)
.equ  SDIO_STA_CMDREND   , 1 << 6    @Bit 6 CMDREND: Command response received (CRC check passed)
.equ  SDIO_STA_RXOVERR   , 1 << 5    @Bit 5 RXOVERR: Received FIFO overrun error
.equ  SDIO_STA_TXUNDERR  , 1 << 4    @Bit 4 TXUNDERR: Transmit FIFO underrun error
.equ  SDIO_STA_DTIMEOUT  , 0x00000008    @Bit 3 DTIMEOUT: Data timeout
.equ  SDIO_STA_CTIMEOUT  , 0x00000004    @Bit 2 CTIMEOUT: Command response timeout
.equ  SDIO_STA_DCRCFAIL  , 0x00000002    @Bit 1 DCRCFAIL: Data block sent/received (CRC check failed)
.equ  SDIO_STA_CCRCFAIL  , 0x00000001    @Bit 0 CCRCFAIL: Command response received (CRC check failed)

@ Описание    битов настройки регистра SDIO_ICR
@.item     SDIO_ICR
.equ  SDIO_ICR_CEATAENDC , 1 << 23    @Bit 23 CEATAENDIE: CE-ATA command completion signal received interrupt enable
.equ  SDIO_ICR_SDIOITC   , 1 << 22    @Bit 22 SDIOITIE : SDIO mode interrupt received interrupt enable
.equ  SDIO_ICR_DBCKENDC  , 1 << 10    @Bit 10 DBCKENDIE : Data block end interrupt enable
.equ  SDIO_ICR_STBITERRC , 1 << 9    @Bit 9 STBITERRIE: Start bit error interrupt enable
.equ  SDIO_ICR_DATAENDC  , 1 << 8    @Bit 8 DATAENDIE: Data end interrupt enable
.equ  SDIO_ICR_CMDSENTC  , 1 << 7    @Bit 7 CMDSENTIE: Command sent interrupt enable
.equ  SDIO_ICR_CMDRENDC  , 1 << 6    @Bit 6 CMDRENDIE: Command response received interrupt enable
.equ  SDIO_ICR_RXOVERRC  , 1 << 5    @Bit 5 RXOVERRIE: Rx FIFO overrun error interrupt enable
.equ  SDIO_ICR_TXUNDERRC , 1 << 4    @Bit 4 TXUNDERRIE: Tx FIFO underrun error interrupt enable
.equ SDIO_ICR_DTIMEOUTC, 0x00000008 @Bit 3 DTIMEOUTIE: Data timeout interrupt enable
.equ SDIO_ICR_CTIMEOUTC, 0x00000004 @Bit 2 CTIMEOUTIE: Command timeout interrupt enable
.equ SDIO_ICR_DCRCFAILC, 0x00000002 @Bit 1 DCRCFAILIE: Data CRC fail interrupt enable
.equ SDIO_ICR_CCRCFAILC, 0x00000001 @Bit 0 CCRCFAILIE: Command CRC fail interrupt enable


@ Описание    битов настройки регистра SDIO_MASK
@.item     SDIO_MASK
.equ  SDIO_MASK_CEATAENDIE, 1 << 23    @Bit 23 CEATAENDIE: CE-ATA command completion signal received interrupt enable
.equ  SDIO_MASK_SDIOITIE , 1 << 22    @Bit 22 SDIOITIE: SDIO mode interrupt received interrupt enable
.equ  SDIO_MASK_RXDAVLIE , 1 << 21    @Bit 21 RXDAVLIE: Data available in Rx FIFO interrupt enable
.equ  SDIO_MASK_TXDAVLIE , 1 << 20    @Bit 20 TXDAVLIE: Data available in Tx FIFO interrupt enable
.equ  SDIO_MASK_RXFIFOEIE, 1 << 19    @Bit 19 RXFIFOEIE: Rx FIFO empty interrupt enable
.equ  SDIO_MASK_TXFIFOEIE, 1 << 18    @Bit 18 TXFIFOEIE: Tx FIFO empty interrupt enable
.equ  SDIO_MASK_RXFIFOFIE, 1 << 17    @Bit 17 RXFIFOFIE: Rx FIFO full interrupt enable
.equ  SDIO_MASK_TXFIFOFIE, 1 << 16    @Bit 16 TXFIFOFIE: Tx FIFO full interrupt enable
.equ  SDIO_MASK_RXFIFOHFIE, 1 << 15    @Bit 15 RXFIFOHFIE: Rx FIFO half full interrupt enable
.equ  SDIO_MASK_TXFIFOHEIE, 1 << 14    @Bit 14 TXFIFOHEIE: Tx FIFO half empty interrupt enable
.equ  SDIO_MASK_RXACTIE  , 1 << 13    @Bit 13 RXACTIE: Data receive acting interrupt enable
.equ  SDIO_MASK_TXACTIE  , 1 << 12    @Bit 12 TXACTIE: Data transmit acting interrupt enable
.equ  SDIO_MASK_CMDACTIE , 1 << 11    @Bit 11 CMDACTIE: Command acting interrupt enable
.equ  SDIO_MASK_DBCKENDIE, 1 << 10    @Bit 10 DBCKENDIE: Data block end interrupt enable
.equ  SDIO_MASK_STBITERRIE, 1 << 9    @Bit 9 STBITERRIE: Start bit error interrupt enable
.equ  SDIO_MASK_DATAENDIE, 1 << 8    @Bit 8 DATAENDIE: Data end interrupt enable
.equ  SDIO_MASK_CMDSENTIE, 1 << 7    @Bit 7 CMDSENTIE: Command sent interrupt enable
.equ  SDIO_MASK_CMDRENDIE, 1 << 6    @Bit 6 CMDRENDIE: Command response received interrupt enable
.equ  SDIO_MASK_RXOVERRIE, 1 << 5    @Bit 5 RXOVERRIE: Rx FIFO overrun error interrupt enable
.equ  SDIO_MASK_TXUNDERRIE, 1 << 4    @Bit 4 TXUNDERRIE : Tx FIFO underrun error interrupt enable
.equ  SDIO_MASK_DTIMEOUTIE, 1 << 3    @Bit 3 DTIMEOUTIE: Data timeout interrupt enable
.equ  SDIO_MASK_CTIMEOUTIE, 1 << 2    @Bit 2 CTIMEOUTIE: Command timeout interrupt enable
.equ  SDIO_MASK_DCRCFAILIE, 1 << 1    @Bit 1 DCRCFAILIE: Data CRC fail interrupt enable
.equ  SDIO_MASK_CCRCFAILIE, 0x00000001    @Bit 0 CCRCFAILIE: Command CRC fail interrupt enable

@ Описание    битов настройки регистра SDIO_FIFOCNT
@.item     SDIO_FIFOCNT
.equ  SDIO_FIFOCNT_FIFOCOUNT, 0x00FFFFFF    @Bits 23:0 FIFOCOUNT: Remaining number of words to be written to or read from the FIFO.

@ Описание    битов настройки регистра SDIO_FIFO
@.item     SDIO_FIFO
.equ  SDIO_FIFO_FIFODATA , 0xFFFFFFFF    @bits 31:0 FIFOData: Receive and transmit FIFO data
