@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                       Êîíñòàíòû DMA                              |
@ +------------------------------------------------------------------+
@.enddesc

.include "/src/inc/base.inc"


@.ITEM     AHB1PERIPH_BASE
.EQU  DMA1_BASE          , AHB1PERIPH_BASE + 0x6000
.EQU  DMA2_BASE          , AHB1PERIPH_BASE + 0x6400
.EQU  DMA1               , PERIPH_BASE + DMA1_BASE
.EQU  DMA2               , PERIPH_BASE + DMA2_BASE

@.ITEM     DMA1_BASE DMA2_BASE
.EQU  DMA_LISR           , 0x00                              @ DMA low interrupt status register (DMA_LISR)
.EQU  DMA_HISR           , 0x04                              @ DMA high interrupt status register (DMA_HISR)
.EQU  DMA_LIFCR          , 0x08                              @ DMA low interrupt flag clear register (DMA_LIFCR)
.EQU  DMA_HIFCR          , 0x0C                              @ DMA high interrupt flag clear register (DMA_HIFCR)
.EQU  DMA_S0CR           , 0x10                              @ DMA stream 0 configuration register (DMA_SxCR)
.EQU  DMA_S0NDTR         , 0x14                              @ DMA stream 0 number of data register (DMA_SxNDTR)
.EQU  DMA_S0PAR          , 0x18                              @ DMA stream 0 peripheral address register (DMA_SxPAR)
.EQU  DMA_S0M0AR         , 0x1C                              @ DMA stream 0 memory 0 address register (DMA_SxM0AR)
.EQU  DMA_S0M1AR         , 0x20                              @ DMA stream 0 memory 1 address register (DMA_SxM1AR)
.EQU  DMA_S0FCR          , 0x24                              @ DMA stream 0 FIFO control register (DMA_SxFCR)
.EQU  DMA_S1CR           , 0x28                              @ DMA stream 1 configuration register (DMA_SxCR)
.EQU  DMA_S1NDTR         , 0x2C                              @ DMA stream 1 number of data register (DMA_SxNDTR)
.EQU  DMA_S1PAR          , 0x30                              @ DMA stream 1 peripheral address register (DMA_SxPAR)
.EQU  DMA_S1M0AR         , 0x34                              @ DMA stream 1 memory 0 address register (DMA_SxM0AR)
.EQU  DMA_S1M1AR         , 0x38                              @ DMA stream 1 memory 1 address register (DMA_SxM1AR)
.EQU  DMA_S1FCR          , 0x3C                              @ DMA stream 1 FIFO control register (DMA_SxFCR)
.EQU  DMA_S2CR           , 0x40                              @ DMA stream 2 configuration register (DMA_SxCR)
.EQU  DMA_S2NDTR         , 0x44                              @ DMA stream 2 number of data register (DMA_SxNDTR)
.EQU  DMA_S2PAR          , 0x48                              @ DMA stream 2 peripheral address register (DMA_SxPAR)
.EQU  DMA_S2M0AR         , 0x4C                              @ DMA stream 2 memory 0 address register (DMA_SxM0AR)
.EQU  DMA_S2M1AR         , 0x50                              @ DMA stream 2 memory 1 address register (DMA_SxM1AR)
.EQU  DMA_S2FCR          , 0x54                              @ DMA stream 2 FIFO control register (DMA_SxFCR)
.EQU  DMA_S3CR           , 0x58                              @ DMA stream 3 configuration register (DMA_SxCR)
.EQU  DMA_S3NDTR         , 0x5C                              @ DMA stream 3 number of data register (DMA_SxNDTR)
.EQU  DMA_S3PAR          , 0x60                              @ DMA stream 3 peripheral address register (DMA_SxPAR)
.EQU  DMA_S3M0AR         , 0x64                              @ DMA stream 3 memory 0 address register (DMA_SxM0AR)
.EQU  DMA_S3M1AR         , 0x68                              @ DMA stream 3 memory 1 address register (DMA_SxM1AR)
.EQU  DMA_S3FCR          , 0x6C                              @ DMA stream 3 FIFO control register (DMA_SxFCR)
.EQU  DMA_S4CR           , 0x70                              @ DMA stream 4 configuration register (DMA_SxCR)
.EQU  DMA_S4NDTR         , 0x74                              @ DMA stream 4 number of data register (DMA_SxNDTR)
.EQU  DMA_S4PAR          , 0x78                              @ DMA stream 4 peripheral address register (DMA_SxPAR)
.EQU  DMA_S4M0AR         , 0x7C                              @ DMA stream 4 memory 0 address register (DMA_SxM0AR)
.EQU  DMA_S4M1AR         , 0x80                              @ DMA stream 4 memory 1 address register (DMA_SxM1AR)
.EQU  DMA_S4FCR          , 0x84                              @ DMA stream 4 FIFO control register (DMA_SxFCR)
.EQU  DMA_S5CR           , 0x88                              @ DMA stream 5 configuration register (DMA_SxCR)
.EQU  DMA_S5NDTR         , 0x8C                              @ DMA stream 5 number of data register (DMA_SxNDTR)
.EQU  DMA_S5PAR          , 0x90                              @ DMA stream 5 peripheral address register (DMA_SxPAR)
.EQU  DMA_S5M0AR         , 0x94                              @ DMA stream 5 memory 0 address register (DMA_SxM0AR)
.EQU  DMA_S5M1AR         , 0x98                              @ DMA stream 5 memory 1 address register (DMA_SxM1AR)
.EQU  DMA_S5FCR          , 0x9C                              @ DMA stream 5 FIFO control register (DMA_SxFCR)
.EQU  DMA_S6CR           , 0xA0                              @ DMA stream 6 configuration register (DMA_SxCR)
.EQU  DMA_S6NDTR         , 0xA4                              @ DMA stream 6 number of data register (DMA_SxNDTR)
.EQU  DMA_S6PAR          , 0xA8                              @ DMA stream 6 peripheral address register (DMA_SxPAR)
.EQU  DMA_S6M0AR         , 0xAC                              @ DMA stream 6 memory 0 address register (DMA_SxM0AR)
.EQU  DMA_S6M1AR         , 0xB0                              @ DMA stream 6 memory 1 address register (DMA_SxM1AR)
.EQU  DMA_S6FCR          , 0xB4                              @ DMA stream 6 FIFO control register (DMA_SxFCR)
.EQU  DMA_S7CR           , 0xB8                              @ DMA stream 7 configuration register (DMA_SxCR)
.EQU  DMA_S7NDTR         , 0xBC                              @ DMA stream 7 number of data register (DMA_SxNDTR)
.EQU  DMA_S7PAR          , 0xC0                              @ DMA stream 7 peripheral address register (DMA_SxPAR)
.EQU  DMA_S7M0AR         , 0xC4                              @ DMA stream 7 memory 0 address register (DMA_SxM0AR)
.EQU  DMA_S7M1AR         , 0xC8                              @ DMA stream 7 memory 1 address register (DMA_SxM1AR)
.EQU  DMA_S7FCR          , 0xCC                              @ DMA stream 7 FIFO control register (DMA_SxFCR)

@.ITEM DMA_LISR
.EQU  DMA_LISR_TCIF3_N   , 27
.EQU  DMA_LISR_TCIF3     , 1 << 27
.EQU  DMA_LISR_HTIF3_N   , 26
.EQU  DMA_LISR_HTIF3     , 1 << 26
.EQU  DMA_LISR_TEIF3_N   , 25
.EQU  DMA_LISR_TEIF3     , 1 << 25
.EQU  DMA_LISR_DMEIF3_N  , 24
.EQU  DMA_LISR_DMEIF3    , 1 << 24
.EQU  DMA_LISR_FEIF3_N   , 22
.EQU  DMA_LISR_FEIF3     , 1 << 22
.EQU  DMA_LISR_TCIF2_N   , 21
.EQU  DMA_LISR_TCIF2     , 1 << 21
.EQU  DMA_LISR_HTIF2_N   , 20
.EQU  DMA_LISR_HTIF2     , 1 << 20
.EQU  DMA_LISR_TEIF2_N   , 19
.EQU  DMA_LISR_TEIF2     , 1 << 19
.EQU  DMA_LISR_DMEIF2_N  , 18
.EQU  DMA_LISR_DMEIF2    , 1 << 18
.EQU  DMA_LISR_FEIF2_N   , 16
.EQU  DMA_LISR_FEIF2     , 1 << 16
.EQU  DMA_LISR_TCIF1_N   , 11
.EQU  DMA_LISR_TCIF1     , 1 << 11
.EQU  DMA_LISR_HTIF1_N   , 10
.EQU  DMA_LISR_HTIF1     , 1 << 10
.EQU  DMA_LISR_TEIF1_N   , 9
.EQU  DMA_LISR_TEIF1     , 1 << 9
.EQU  DMA_LISR_DMEIF1_N  , 8
.EQU  DMA_LISR_DMEIF1    , 1 << 8
.EQU  DMA_LISR_FEIF1_N   , 6
.EQU  DMA_LISR_FEIF2     , 1 << 6
.EQU  DMA_LISR_TCIF0_N   , 5
.EQU  DMA_LISR_TCIF0     , 1 << 5
.EQU  DMA_LISR_HTIF0_N   , 4
.EQU  DMA_LISR_HTIF0     , 1 << 4
.EQU  DMA_LISR_TEIF0_N   , 3
.EQU  DMA_LISR_TEIF0     , 1 << 3
.EQU  DMA_LISR_DMEIF0_N  , 2
.EQU  DMA_LISR_DMEIF0    , 1 << 2
.EQU  DMA_LISR_FEIF0_N   , 0
.EQU  DMA_LISR_FEIF0     , 1

@.ITEM     DMA_HISR
.EQU  DMA_HISR_TCIF7_N   , 27
.EQU  DMA_HISR_TCIF7     , 1 << 27
.EQU  DMA_HISR_HTIF7_N   , 26
.EQU  DMA_HISR_HTIF7     , 1 << 26
.EQU  DMA_HISR_TEIF7_N   , 25
.EQU  DMA_HISR_TEIF3     , 1 << 25
.EQU  DMA_HISR_DMEIF7_N  , 24
.EQU  DMA_HISR_DMEIF7    , 1 << 24
.EQU  DMA_HISR_FEIF7_N   , 22
.EQU  DMA_HISR_FEIF7     , 1 << 22
.EQU  DMA_HISR_TCIF6_N   , 21
.EQU  DMA_HISR_TCIF6     , 1 << 21
.EQU  DMA_HISR_HTIF6_N   , 20
.EQU  DMA_HISR_HTIF6     , 1 << 20
.EQU  DMA_HISR_TEIF6_N   , 19
.EQU  DMA_HISR_TEIF6     , 1 << 19
.EQU  DMA_HISR_DMEIF6_N  , 18
.EQU  DMA_HISR_DMEIF6    , 1 << 18
.EQU  DMA_HISR_FEIF6_N   , 16
.EQU  DMA_HISR_FEIF6     , 1 << 16
.EQU  DMA_HISR_TCIF5_N   , 11
.EQU  DMA_HISR_TCIF5     , 1 << 11
.EQU  DMA_HISR_HTIF5_N   , 10
.EQU  DMA_HISR_HTIF5     , 1 << 10
.EQU  DMA_HISR_TEIF5_N   , 9
.EQU  DMA_HISR_TEIF5     , 1 << 9
.EQU  DMA_HISR_DMEIF5_N  , 8
.EQU  DMA_HISR_DMEIF5    , 1 << 8
.EQU  DMA_HISR_FEIF5_N   , 6
.EQU  DMA_HISR_FEIF5     , 1 << 6
.EQU  DMA_HISR_TCIF4_N   , 5
.EQU  DMA_HISR_TCIF4     , 1 << 5
.EQU  DMA_HISR_HTIF4_N   , 4
.EQU  DMA_HISR_HTIF4     , 1 << 4
.EQU  DMA_HISR_TEIF4_N   , 3
.EQU  DMA_HISR_TEIF4     , 1 << 3
.EQU  DMA_HISR_DMEIF4_N  , 2
.EQU  DMA_HISR_DMEIF4    , 1 << 2
.EQU  DMA_HISR_FEIF4_N   , 0
.EQU  DMA_HISR_FEIF4     , 1

@.ITEM     DMA_LIFCR
.EQU  DMA_LIFCR_ÑTCIF3_N , 27
.EQU  DMA_LIFCR_ÑTCIF3   , 1 << 27
.EQU  DMA_LIFCR_CHTIF3_N , 26
.EQU  DMA_LIFCR_CHTIF3   , 1 << 26
.EQU  DMA_LIFCR_CTEIF3_N , 25
.EQU  DMA_LIFCR_CTEIF3   , 1 << 25
.EQU  DMA_LIFCR_CDMEIF3_N, 24
.EQU  DMA_LIFCR_CDMEIF3  , 1 << 24
.EQU  DMA_LIFCR_CFEIF3_N , 22
.EQU  DMA_LIFCR_CFEIF3   , 1 << 22
.EQU  DMA_LIFCR_ÑTCIF2_N , 21
.EQU  DMA_LIFCR_ÑTCIF2   , 1 << 21
.EQU  DMA_LIFCR_CHTIF2_N , 20
.EQU  DMA_LIFCR_CHTIF2   , 1 << 20
.EQU  DMA_LIFCR_CTEIF2_N , 19
.EQU  DMA_LIFCR_CTEIF2   , 1 << 19
.EQU  DMA_LIFCR_CDMEIF2_N, 18
.EQU  DMA_LIFCR_CDMEIF2  , 1 << 18
.EQU  DMA_LIFCR_CFEIF2_N , 16
.EQU  DMA_LIFCR_CFEIF2   , 1 << 16
.EQU  DMA_LIFCR_ÑTCIF1_N , 11
.EQU  DMA_LIFCR_ÑTCIF1   , 1 << 11
.EQU  DMA_LIFCR_CHTIF1_N , 10
.EQU  DMA_LIFCR_CHTIF1   , 1 << 10
.EQU  DMA_LIFCR_CTEIF1_N , 9
.EQU  DMA_LIFCR_CTEIF1   , 1 << 9
.EQU  DMA_LIFCR_CDMEIF1_N, 8
.EQU  DMA_LIFCR_CDMEIF1  , 1 << 8
.EQU  DMA_LIFCR_CFEIF1_N , 6
.EQU  DMA_LIFCR_CFEIF1   , 1 << 6
.EQU  DMA_LIFCR_ÑTCIF0_N , 5
.EQU  DMA_LIFCR_ÑTCIF0   , 1 << 5
.EQU  DMA_LIFCR_CHTIF0_N , 4
.EQU  DMA_LIFCR_CHTIF0   , 1 << 4
.EQU  DMA_LIFCR_CTEIF0_N , 3
.EQU  DMA_LIFCR_CTEIF0   , 1 << 3
.EQU  DMA_LIFCR_CDMEIF0_N, 2
.EQU  DMA_LIFCR_CDMEIF0  , 1 << 2
.EQU  DMA_LIFCR_CFEIF0_N , 0
.EQU  DMA_LIFCR_CFEIF0   , 1

@.ITEM     DMA_HIFCR
.EQU  DMA_HIFCR_ÑTCIF7_N , 27
.EQU  DMA_HIFCR_ÑTCIF7   , 1 << 27
.EQU  DMA_HIFCR_CHTIF7_N , 26
.EQU  DMA_HIFCR_CHTIF7   , 1 << 26
.EQU  DMA_HIFCR_CTEIF7_N , 25
.EQU  DMA_HIFCR_CTEIF7   , 1 << 25
.EQU  DMA_HIFCR_CDMEIF7_N, 24
.EQU  DMA_HIFCR_CDMEIF7  , 1 << 24
.EQU  DMA_HIFCR_CFEIF7_N , 22
.EQU  DMA_HIFCR_CFEIF7   , 1 << 22
.EQU  DMA_HIFCR_ÑTCIF6_N , 21
.EQU  DMA_HIFCR_ÑTCIF6   , 1 << 21
.EQU  DMA_HIFCR_CHTIF6_N , 20
.EQU  DMA_HIFCR_CHTIF6   , 1 << 20
.EQU  DMA_HIFCR_CTEIF6_N , 19
.EQU  DMA_HIFCR_CTEIF6   , 1 << 19
.EQU  DMA_HIFCR_CDMEIF6_N, 18
.EQU  DMA_HIFCR_CDMEIF6  , 1 << 18
.EQU  DMA_HIFCR_CFEIF6_N , 16
.EQU  DMA_HIFCR_CFEIF6   , 1 << 16
.EQU  DMA_HIFCR_ÑTCIF5_N , 11
.EQU  DMA_HIFCR_ÑTCIF5   , 1 << 11
.EQU  DMA_HIFCR_CHTIF5_N , 10
.EQU  DMA_HIFCR_CHTIF5   , 1 << 10
.EQU  DMA_HIFCR_CTEIF5_N , 9
.EQU  DMA_HIFCR_CTEIF5   , 1 << 9
.EQU  DMA_HIFCR_CDMEIF5_N, 8
.EQU  DMA_HIFCR_CDMEIF5  , 1 << 8
.EQU  DMA_HIFCR_CFEIF5_N , 6
.EQU  DMA_HIFCR_CFEIF5   , 1 << 6
.EQU  DMA_HIFCR_ÑTCIF4_N , 5
.EQU  DMA_HIFCR_ÑTCIF4   , 1 << 5
.EQU  DMA_HIFCR_CHTIF4_N , 4
.EQU  DMA_HIFCR_CHTIF4   , 1 << 4
.EQU  DMA_HIFCR_CTEIF4_N , 3
.EQU  DMA_HIFCR_CTEIF4   , 1 << 3
.EQU  DMA_HIFCR_CDMEIF4_N, 2
.EQU  DMA_HIFCR_CDMEIF4  , 1 << 2
.EQU  DMA_HIFCR_CFEIF4_N , 0
.EQU  DMA_HIFCR_CFEIF4   , 1

@.ITEM     DMA_S0CR DMA_S1CR DMA_S2CR DMA_S3CR DMA_S4CR DMA_S5CR DMA_S6CR DMA_S7CR
.EQU  DMA_SxCR_CHSEL_N   , 25
.EQU  DMA_SxCR_MBURST_N  , 23
.EQU  DMA_SxCR_MBURST_SINGLE, 0
.EQU  DMA_SxCR_MBURST_INCR4, 1 << 23
.EQU  DMA_SxCR_MBURST_INCR8, 2 << 23
.EQU  DMA_SxCR_MBURST_INCR16, 3 << 23
.EQU  DMA_SxCR_PBURST_N  , 21
.EQU  DMA_SxCR_PBURST_SINGLE, 0
.EQU  DMA_SxCR_PBURST_INCR4, 1 << 21
.EQU  DMA_SxCR_PBURST_INCR8, 2 << 21
.EQU  DMA_SxCR_PBURST_INCR16, 3 << 21
.EQU  DMA_SxCR_CT        , 1 << 19
.EQU  DMA_SxCR_DBM       , 1 << 18
.EQU  DMA_SxCR_PL_N      , 16
.EQU  DMA_SxCR_PL_LOW    , 0
.EQU  DMA_SxCR_PL_MEDIUM , 1 << 16
.EQU  DMA_SxCR_PL_HIGH   , 2 << 16
.EQU  DMA_SxCR_PL_VHIGH  , 3 << 16
.EQU  DMA_SxCR_PINCOS    , 1 << 15
.EQU  DMA_SxCR_MSIZE_N   , 13
.EQU  DMA_SxCR_MSIZE_8B  , 0
.EQU  DMA_SxCR_MSIZE_16B , 1 << 13
.EQU  DMA_SxCR_MSIZE_32B , 2 << 13
.EQU  DMA_SxCR_PSIZE_N   , 11
.EQU  DMA_SxCR_PSIZE_8B  , 0
.EQU  DMA_SxCR_PSIZE_16B , 1 << 11
.EQU  DMA_SxCR_PSIZE_32B , 2 << 11
.EQU  DMA_SxCR_MSIZE_N   , 13
.EQU  DMA_SxCR_MSIZE_8B  , 0
.EQU  DMA_SxCR_MSIZE_16B , 1 << 13
.EQU  DMA_SxCR_MINC      , 1 << 10
.EQU  DMA_SxCR_PINC      , 1 << 9
.EQU  DMA_SxCR_CIRC      , 1 << 8
.EQU  DMA_SxCR_DIR_N     , 6
.EQU  DMA_SxCR_DIR_PTM   , 0
.EQU  DMA_SxCR_DIR_MTP   , 1 << 6
.EQU  DMA_SxCR_DIR_MTM   , 2 << 6
.EQU  DMA_SxCR_PFCTRL    , 1 << 5
.EQU  DMA_SxCR_TCIE      , 1 << 4
.EQU  DMA_SxCR_HTIE      , 1 << 3
.EQU  DMA_SxCR_TEIE      , 1 << 2
.EQU  DMA_SxCR_DMEIE     , 1 << 1
.EQU  DMA_SxCR_EN        , 1

@.ITEM     DMA_S0FCR DMA_S1FCR DMA_S2FCR DMA_S3FCR DMA_S4FCR DMA_S5FCR DMA_S6FCR DMA_S7FCR
.EQU  DMA_SxFCR_FEIE     , 1 << 7
.EQU  DMA_SxFCR_FS_N     , 3
.EQU  DMA_SxFCR_FS_1D4   , 0
.EQU  DMA_SxFCR_FS_1D2   , 1 << 3
.EQU  DMA_SxFCR_FS_3D4   , 2 << 3
.EQU  DMA_SxFCR_FS_FULL  , 3 << 3
.EQU  DMA_SxFCR_FS_FEMPTY, 4 << 3
.EQU  DMA_SxFCR_FS_FFULL , 5 << 3
.EQU  DMA_SxFCR_DMDIS    , 1 << 2
.EQU  DMA_SxFCR_FTH_N    , 0
.EQU  DMA_SxFCR_FTH_1D4  , 0
.EQU  DMA_SxFCR_FTH_1D2  , 1
.EQU  DMA_SxFCR_FTH_3D4  , 2
.EQU  DMA_SxFCR_FTH_FULL , 3














