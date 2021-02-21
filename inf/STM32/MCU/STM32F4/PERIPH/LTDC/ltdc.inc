@GNU AS
@.CharSet =CP1251 ( Cyrillic )
@.desc     type=module
@ +------------------------------------------------------------------+
@ |                     Базовые константы LCD-TFT
@ |  RM0090           Section 16.7.26: LTDC register map on page 512
@ +------------------------------------------------------------------+
@.enddesc

.include   "/src/inc/base.inc"

@.ITEM     APB2PERIPH_BASE
.equ  LTDC_BASE          , APB2PERIPH_BASE + 0x6800
.equ  LTDC              , PERIPH_BASE + LTDC_BASE

@.item     LTDC_BASE
.equ  LTDC_SSCR          , 0x08    @LTDC Synchronization Size Configuration Register
.equ  LTDC_BPCR          , 0x0C    @LTDC Back Porch Configuration Register
.equ  LTDC_AWCR          , 0x10    @LTDC Active Width Configuration Register
.equ  LTDC_TWCR          , 0x14    @LTDC Total Width Configuration Register
.equ  LTDC_GCR           , 0x18    @LTDC Global Control Register
.equ  LTDC_SRCR          , 0x24    @LTDC Shadow Reload Configuration Register
.equ  LTDC_BCCR          , 0x2C    @LTDC Background Color Configuration Register
.equ  LTDC_IER           , 0x34    @LTDC Interrupt Enable Register
.equ  LTDC_ICR           , 0x3C    @LTDC Interrupt Clear Register
.equ  LTDC_LIPCR         , 0x40    @LTDC Line Interrupt Position Configuration Register
.equ  LTDC_CPSR          , 0x44    @LTDC Current Position Status Register
.equ  LTDC_CDSR          , 0x48    @LTDC Current Display Status Register
.equ  LTDC_L1CR          , 0x84    @ LTDC Layerx Control Register
.equ  LTDC_L2CR          , 0x84 + 0x80    @Address offset: 0x84 + 0x80 x (Layerx -1), Layerx = 1 or 2
.equ  LTDC_L1WHPCR       , 0x88    @LTDC Layerx Window Horizontal Position Configuration Register
.equ  LTDC_L2WHPCR       , 0x88 + 0x80    @ Address offset: 0x88 + 0x80 x (Layerx -1), Layerx = 1 or 2
.equ  LTDC_L1WVPCR       , 0x8C    @LTDC Layerx Window Vertical Position Configuration Register
.equ  LTDC_L2WVPCR       , 0x8C + 0x80    @ Address offset: 0x88 + 0x80 x (Layerx -1), Layerx = 1 or 2
.equ  LTDC_L1CKCR        , 0x90    @LTDC Layerx Color Keying Configuration Register
.equ  LTDC_L2CKCR        , 0x90 + 0x80    @Address offset: 0x90 + 0x80 x (Layerx -1), Layerx = 1 or 2
.equ  LTDC_L1PFCR        , 0x94    @LTDC Layerx Pixel Format Configuration Register
.equ  LTDC_L2PFCR        , 0x94 + 0x80    @Address offset: 0x94 + 0x80 x (Layerx -1), Layerx = 1 or 2
.equ  LTDC_L1CACR        , 0x98    @LTDC Layerx Constant Alpha Configuration Register
.equ  LTDC_L2CACR        , 0x98 + 0x80    @Address offset: 0x98 + 0x80 x (Layerx -1), Layerx = 1 or 2
.equ  LTDC_L1DCCR        , 0x9C    @LTDC Layerx Default Color Configuration Register
.equ  LTDC_L2DCCR        , 0x9C + 0x80    @Address offset: 0x9C + 0x80 x (Layerx -1), Layerx = 1 or 2
.equ  LTDC_L1BFCR        , 0xA0    @LTDC Layerx Blending Factors Configuration Register
.equ  LTDC_L2BFCR        , 0xA0 + 0x80    @Address offset: 0xA0 + 0x80 x (Layerx -1), Layerx = 1 or 2
.equ  LTDC_L1CFBAR       , 0xAC    @LTDC Layerx Color Frame Buffer Address Register
.equ  LTDC_L2CFBAR       , 0xAC + 0x80    @Address offset: 0xAC + 0x80 x (Layerx -1), Layerx = 1 or 2
.equ  LTDC_L1CFBLR       , 0xB0    @LTDC Layerx Color Frame Buffer Length Register
.equ  LTDC_L2CFBLR       , 0xB0 + 0x80    @Address offset: 0xB0 + 0x80 x (Layerx -1), Layerx = 1 or 2
.equ  LTDC_L1CFBLNR      , 0xB4    @LTDC Layerx ColorFrame Buffer Line Number Register
.equ  LTDC_L2CFBLNR      , 0xB4 + 0x80    @Address offset: 0xB0 + 0x80 x (Layerx -1), Layerx = 1 or 2
.equ  LTDC_L1CLUTWR      , 0xC4    @LTDC Layerx CLUT Write Register
.equ  LTDC_L21CLUTWR     , 0xC4 + 0x80    @Address offset: 0xC4 + 0x80 x (Layerx -1), Layerx = 1 or 2

@.item     LTDC_SSCR
.equ  LTDC_SSCR_HSW_M    , 0x0FFF0000    @Bits 27:16 HSW[11:0]: Horizontal Synchronization Width
.equ  LTDC_SSCR_VSH_M    , 0x00007FFF    @Bits 10:0 VSH[10:0]: Vertical Synchronization Height

@.item    LTDC_BPCR
.equ  LTDC_BPCR_AHBP_M   , 0x0FFF0000    @Bits 27:16 AHBP[11:0]: Accumulated Horizontal back porch
.equ  LTDC_BPCR_AVBP_M   , 0x00007FFF    @Bits 10:0 AVBP[10:0]: Accumulated Vertical back porch

@.item    LTDC_AWCR
.equ  LTDC_AWCR_AAW_M    , 0x0FFF0000    @Bits 27:16 AAW[11:0]: Accumulated Active Width
.equ  LTDC_AWCR_AAH_M    , 0x00007FFF    @Bits 10:0 AAH[10:0]: Accumulated Active Height

@.item    LTDC_TWCR
.equ  LTDC_TWCR_TOTALW_M , 0x0FFF0000    @Bits 27:16 TOTALW[11:0]: Total Width
.equ  LTDC_TWCR_TOTALH_M , 0x00007FFF    @Bits 10:0 TOTALH[10:0]: Total Height

@.item    LTDC_GCR
.equ  LTDC_GCR_HSPOL     , 1 << 31    @Bit 31 HSPOL: Horizontal Synchronization Polarity
.equ  LTDC_GCR_VSPOL     , 1 << 30    @Bit 30 VSPOL: Vertical Synchronization Polarity
.equ  LTDC_GCR_DEPOL     , 1 << 29    @Bit 29 DEPOL: Data Enable Polarity
.equ  LTDC_GCR_PCPOL     , 1 << 28    @Bit 28 PCPOL: Pixel Clock Polarity
.equ  LTDC_GCR_DEN       , 1 << 16    @Bit 16 DEN: Dither Enable
.equ  LTDC_GCR_DRW       , 12    @Bits 14:12 DRW[2:0]: Dither Red Width
.equ  LTDC_GCR_DRW_2     , 4 << 12
.equ  LTDC_GCR_DRW_1     , 2 << 12
.equ  LTDC_GCR_DRW_0     , 1 << 12
.equ  LTDC_GCR_DGW       , 8    @ Bits 10:8 DGW[2:0]: Dither Green Width
.equ  LTDC_GCR_DGW_2     , 4 << 8
.equ  LTDC_GCR_DGW_1     , 2 << 8
.equ  LTDC_GCR_DGW_0     , 1 << 8
.equ  LTDC_GCR_DBW       , 4    @ Bits 6:4 DBW[2:0]: Dither Blue Width
.equ  LTDC_GCR_DBW_2     , 4 << 4
.equ  LTDC_GCR_DBW_1     , 2 << 4
.equ  LTDC_GCR_DBW_0     , 1 << 4
.equ  LTDC_GCR_LTDCEN    , 1 << 0    @Bit 0 LTDCEN: LCD-TFT controller enable bit

@.item     LTDC_SRCR
.equ  LTDC_SRCR_VBR      , 1 << 1    @Bit 1 VBR: Vertical Blanking Reload
.equ  LTDC_SRCR_IMR      , 1 << 0    @Bit 0 IMR: Immediate Reload

@.item     LTDC_BCCR
.equ  LTDC_BCCR_BCRED_M    , 0x00FF0000    @Bits 23:16 BCRED[7:0]: Background Color Red value
.equ  LTDC_BCCR_BCGREEN_M  , 0x0000FF00    @Bits 15:8 BCGREEN[7:0]: Background Color Green value
.equ  LTDC_BCCR_BCBLUE_M   , 0x000000FF    @Bits 7:0 BCBLUE[7:0]: Background Color Blue value

@.item   LTDC_IER
.equ  LTDC_IER_RRIE      , 1 << 3    @Bit 3 RRIE: Register Reload interrupt enable
.equ  LTDC_IER_TERRIE    , 1 << 2    @Bit 2 TERRIE: Transfer Error Interrupt Enable
.equ  LTDC_IER_FUIE      , 1 << 1    @Bit 1 FUIE: FIFO Underrun Interrupt Enable
.equ  LTDC_IER_LIE       , 1 << 0    @Bit 0 LIE: Line Interrupt Enable

@.item     LTDC_ISR
.equ  LTDC_ISR_RRIF      , 1 << 3    @Bit 3 RRIF: Register Reload Interrupt Flag
.equ  LTDC_ISR_TERRIF    , 1 << 2    @Bit 2 TERRIF: Transfer Error interrupt flag
.equ  LTDC_ISR_FUIF      , 1 << 1    @Bit 1 FUIF: FIFO Underrun Interrupt flag
.equ  LTDC_ISR_LIF       , 1 << 0    @Bit 0 LIF: Line Interrupt flag

@.item     LTDC_ICR
.equ  LTDC_ICR_RRIF      , 1 << 3    @Bit 3 CRRIF: Clears Register Reload Interrupt Flaglag
.equ  LTDC_ICR_TERRIF    , 1 << 2    @Bit 2 CTERRIF: Clears the Transfer Error Interrupt Flag
.equ  LTDC_ICR_FUIF      , 1 << 1    @Bit 1 CFUIF: Clears the FIFO Underrun Interrupt flag
.equ  LTDC_ICR_LIF       , 1 << 0    @Bit 0 CLIF: Clears the Line Interrupt Flag

@.item     LTDC_LIPCR
.equ  LTDC_LIPCR_LIPOS_M   , 0x0000007F    @Bits 10:0 LIPOS[10:0]: Line Interrupt Position

@.item     LTDC_CPSR
.equ  LTDC_CPSR_CXPOS    , 0xFFFF0000    @Bits 31:16: CXPOS[15:0]: Current X Position
.equ  LTDC_CPSR_CYPOS    , 0x0000FFFF    @ Bits 15:0 CYPOS[15:0]: Current Y Position

@.item     LTDC_CDSR
.equ  LTDC_CDSR_HSYNCS   , 1 << 3    @Bit 3 HSYNCS: Horizontal Synchronization display Status
.equ  LTDC_CDSR_VSYNCS   , 1 << 2    @Bit 2 VSYNCS: Vertical Synchronization display Status
.equ  LTDC_CDSR_HDES     , 1 << 1    @Bit 1 HDES: Horizontal Data Enable display Status
.equ  LTDC_CDSR_VDES     , 1 << 0    @Bit 0 VDES: Vertical Data Enable display Status

@.item     LTDC_L1CR   LTDC_L2CR
.equ  LTDC_L1CR_CLUTEN   , 1 << 4    @Bit 4 CLUTEN: Color Look-Up Table Enable
.equ  LTDC_L1CR_COLKEN   , 1 << 1    @Bit 1 COLKEN: Color Keying Enable
.equ  LTDC_L1CR_LEN      , 1 << 0    @Bit 0 LEN: Layer Enable
.equ  LTDC_L2CR_CLUTEN   , 1 << 4    @Bit 4 CLUTEN: Color Look-Up Table Enable
.equ  LTDC_L2CR_COLKEN   , 1 << 1    @Bit 1 COLKEN: Color Keying Enable
.equ  LTDC_L2CR_LEN      , 1 << 0    @Bit 0 LEN: Layer Enable

@.item     LTDC_L1WHPCR  LTDC_L2WHPCR
.equ  LTDC_L1WHPCR_WHSPPOS, 0x0FFF0000    @Bits 27:16 WHSPPOS[11:0]: Window Horizontal Stop Position
.equ  LTDC_L1WHPCR_WHSTPOS, 0x00000FFF    @Bits 11:0 WHSTPOS[11:0]: Window Horizontal Start Position
.equ  LTDC_L2WHPCR_WHSPPOS, 0x0FFF0000    @Bits 27:16 WHSPPOS[11:0]: Window Horizontal Stop Position
.equ  LTDC_L2WHPCR_WHSTPOS, 0x00000FFF    @Bits 11:0 WHSTPOS[11:0]: Window Horizontal Start Position

@.item     LTDC_L1WVPCR   LTDC_L2WVPCR
.equ  LTDC_L1WVPCR_WVSPPOS, 0x0FFF0000    @Bits 27:16 WHSPPOS[11:0]: Window Horizontal Stop Position
.equ  LTDC_L1WVPCR_WVSTPOS, 0x00000FFF    @Bits 11:0 WHSTPOS[11:0]: Window Horizontal Start Position
.equ  LTDC_L2WVPCR_WVSPPOS, 0x07FF0000    @Bits 27:16 WHSPPOS[11:0]: Window Horizontal Stop Position
.equ  LTDC_L2WVPCR_WVSTPOS, 0x000007FF    @Bits 11:0 WHSTPOS[11:0]: Window Horizontal Start Position

@.item     LTDC_L1CKCR  LTDC_L2CKCR
.equ  LTDC_L1CKCR_CKRED  , 0x00FF0000    @Bits 23:16 CKRED[7:0]: Color Key Red value
.equ  LTDC_L1CKCR_CKGREEN, 0x0000FF00    @Bits 15:8 CKGREEN[7:0]: Color Key Green value
.equ  LTDC_L1CKCR_CKBLUE , 0x000000FF    @Bits 7:0 CKBLUE[7:0]: Color Key Blue value
.equ  LTDC_L2CKCR_CKRED  , 0x00FF0000    @Bits 23:16 CKRED[7:0]: Color Key Red value
.equ  LTDC_L2CKCR_CKGREEN, 0x0000FF00    @Bits 15:8 CKGREEN[7:0]: Color Key Green value
.equ  LTDC_L2CKCR_CKBLUE , 0x000000FF    @Bits 7:0 CKBLUE[7:0]: Color Key Blue value

@.item     LTDC_L1PFCR LTDC_L2PFCR
.equ  LTDC_L1PFCR_PF     , 0x00000007    @Bits 2:0 PF[2:0]: Pixel Format
.equ  LTDC_L2PFCR_PF     , 0x00000007    @Bits 2:0 PF[2:0]: Pixel Format

@.item     LTDC_L1CACR LTDC_L2CACR
.equ  LTDC__L1CACR_CONSTA, 0x000000FF    @7:0 CONSTA[7:0]: Constant Alpha
.equ  LTDC__L2CACR_CONSTA, 0x000000FF    @7:0 CONSTA[7:0]: Constant Alpha

@.item     LTDC_L1DCCR LTDC_L2DCCR
.equ  LTDC_L1DCCR_DCALPHA, 0xFF000000    @ Bits 31:24 DCALPHA[7:0]: Default Color Alpha
.equ  LTDC_L1DCCR_DCRED  , 0x00FF0000    @ Bits 23:16 DCRED[7:0]: Default Color Red
.equ  LTDC_L1DCCR_DCGREEN, 0x0000FF00    @ Bits 15:8 DCGREEN[7:0]: Default Color Green
.equ  LTDC_L1DCCR_DCBLUE , 0x000000FF    @ Bits 7:0 DCBLUE[7:0]: Default Color Blue
.equ  LTDC_L2DCCR_DCALPHA, 0xFF000000    @ Bits 31:24 DCALPHA[7:0]: Default Color Alpha
.equ  LTDC_L2DCCR_DCRED  , 0x00FF0000    @ Bits 23:16 DCRED[7:0]: Default Color Red
.equ  LTDC_L2DCCR_DCGREEN, 0x0000FF00    @ Bits 15:8 DCGREEN[7:0]: Default Color Green
.equ  LTDC_L2DCCR_DCBLUE , 0x000000FF    @ Bits 7:0 DCBLUE[7:0]: Default Color Blue

@.item     LTDC_L1BFCR LTDC_L2BFCR
.equ  LTDC_L1BFCR_PF     , 0x00000700    @Bits 10:8 BF1[2:0]: Blending Factor 1
.equ  LTDC_L2BFCR_PF     , 0x00000007    @Bits 2:0 BF2[2:0]: Blending Factor 2

@.item     LTDC_L1CFBAR LTDC_L2CFBAR
.equ  LTDC_L1CFBAR_CFBADD, 0xFFFFFFFF    @Bits 31:0 CFBADD[31:0]: Color Frame Buffer Start Address
.equ  LTDC_L2CFBAR_CFBADD, 0xFFFFFFFF    @These bits defines the color frame buffer start address.

@.item     LTDC_L1CFBLR LTDC_L2CFBLR
.equ  LTDC_L1CFBLR_CFBP  , 0x1FFF0000    @ Bits 28:16 CFBP[12:0]: Color Frame Buffer Pitch in bytes
.equ  LTDC_L1CFBLR_CFBLL , 0x00001FFF    @ Bits 12:0 CFBLL[12:0]: Color Frame Buffer Line Length
.equ  LTDC_L2CFBLR_CFBP  , 0x1FFF0000    @ Bits 28:16 CFBP[12:0]: Color Frame Buffer Pitch in bytes
.equ  LTDC_L2CFBLR_CFBLL , 0x00001FFF    @  its 12:0 CFBLL[12:0]: Color Frame Buffer Line Length

@.item     LTDC_L1CFBLR LTDC_L2CFBLR
.equ  LTDC_L1CFBLNR_CFBLNBR, 0x000007FF    @Bits 10:0 CFBLNBR[10:0]: Frame Buffer Line Number
.equ  LTDC_L2CFBLNR_CFBLNBR, 0x000007FF    @Bits 10:0 CFBLNBR[10:0]: Frame Buffer Line Number

@.item     LTDC_L1CLUTWR LTDC_L2CLUTWR
.equ  LTDC_L1CLUTWR_CLUTADD, 0xFF000000    @Bits 31:24 CLUTADD[7:0]: CLUT Address
.equ  LTDC_L1CLUTWR_RED  , 0x00FF0000    @ Bits 23:16 RED[7:0]: Red value
.equ  LTDC_L1CLUTWR_GREEN, 0x0000FF00    @ Bits 15:8 GREEN[7:0]: Green value
.equ  LTDC_L1CLUTWR_BLUE , 0x000000FF    @ Bits 7:0 BLUE[7:0]: Blue value
.equ  LTDC_L2CLUTWR_CLUTADD, 0xFF000000    @Bits 31:24 CLUTADD[7:0]: CLUT Address
.equ  LTDC_L2CLUTWR_RED  , 0x00FF0000    @ Bits 23:16 RED[7:0]: Red value
.equ  LTDC_L2CLUTWR_GREEN, 0x0000FF00    @ Bits 15:8 GREEN[7:0]: Green value
.equ  LTDC_L2CLUTWR_BLUE , 0x000000FF    @ Bits 7:0 BLUE[7:0]: Blue value


