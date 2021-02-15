@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                       Константы FSMC                             |
@ +------------------------------------------------------------------+
@.enddesc

.include "/src/inc/base.inc"

@.ITEM     FSMC_BASE
.EQU  FSMC_BCR1          , 0
.EQU  FSMC_BCR2          , 8
.EQU  FSMC_BCR3          , 0x10
.EQU  FSMC_BCR4          , 0x18
.EQU  FSMC_BTR1          , 4
.EQU  FSMC_BTR2          , 0x0C
.EQU  FSMC_BTR3          , 0x14
.EQU  FSMC_BTR4          , 0x1C
.EQU  FSMC_BWTR1         , 0x104
.EQU  FSMC_BWTR2         , 0x10C
.EQU  FSMC_BWTR3         , 0x114
.EQU  FSMC_BWTR4         , 0x11C
.EQU  FSMC_PCR2          , 0x60
.EQU  FSMC_PCR3          , 0x80
.EQU  FSMC_PCR4          , 0xA0
.EQU  FSMC_SR2           , 0x64
.EQU  FSMC_SR3           , 0x84
.EQU  FSMC_SR4           , 0xA4
.EQU  FSMC_PMEM2         , 0x68
.EQU  FSMC_PMEM3         , 0x88
.EQU  FSMC_PMEM4         , 0xA8
.EQU  FSMC_PATT2         , 0x6C
.EQU  FSMC_PATT3         , 0x8C
.EQU  FSMC_PATT4         , 0xAC
.EQU  FSMC_PIO4          , 0xB0
.EQU  FSMC_ECCR2         , 0x74
.EQU  FSMC_ECCR3         , 0x94

@.ITEM     FSMC_BCR1 FSMC_BCR2 FSMC_BCR3 FSMC_BCR4
.EQU  FSMC_BCR1_RSTVALUE , 0x000030DB
.EQU  FSMC_BCR2_RSTVALUE , 0x000030D2
.EQU  FSMC_BCR3_RSTVALUE , 0x000030D2
.EQU  FSMC_BCR4_RSTVALUE , 0x000030D2
.EQU  FSMC_BCR_CBURSTRW  , 1 << 19
.EQU  FSMC_BCR_CPSIZE_N  , 16
.EQU  FSMC_BCR_CPSIZE_0  , 0
.EQU  FSMC_BCR_CPSIZE_128, 1 << FSMC_BCR_CPSIZE_N
.EQU  FSMC_BCR_CPSIZE_256, 2 << FSMC_BCR_CPSIZE_N
.EQU  FSMC_BCR_CPSIZE_512, 3 << FSMC_BCR_CPSIZE_N
.EQU  FSMC_BCR_CPSIZE_1K , 4 << FSMC_BCR_CPSIZE_N
.EQU  FSMC_BCR_ASYNCWAIT , 1 << 15
.EQU  FSMC_BCR_EXTMOD    , 1 << 14
.EQU  FSMC_BCR_WAITEN    , 1 << 13
.EQU  FSMC_BCR_WREN      , 1 << 12
.EQU  FSMC_BCR_WAITCFG   , 1 << 11
.EQU  FSMC_BCR_WRAPMOD   , 1 << 10
.EQU  FSMC_BCR_WAITPOL   , 1 << 9
.EQU  FSMC_BCR_BURSTEN   , 1 << 8
.EQU  FSMC_BCR_FACCEN    , 1 << 6
.EQU  FSMC_BCR_MWID_N    , 4
.EQU  FSMC_BCR_MWID_8    , 0
.EQU  FSMC_BCR_MWID_16   , 1 << FSMC_BCR_MWID_N
.EQU  FSMC_BCR_MTYP_N    , 2
.EQU  FSMC_BCR_MTYP_SRAM , 0
.EQU  FSMC_BCR_MTYP_PSWAM, 1 << FSMC_BCR_MTYP_N
.EQU  FSMC_BCR_MTYP_NOR  , 2 << FSMC_BCR_MTYP_N
.EQU  FSMC_BCR_MUXEN     , 1 << 1
.EQU  FSMC_BCR_MBKEN     , 1

@.ITEM     FSMC_BTR1 FSMC_BTR2 FSMC_BTR3 FSMC_BTR4
.EQU  FSMC_BTRx_RSTVALUE , 0x0FFFFFFF
.EQU  FSMC_BTR_ACCMOD_N  , 28
.EQU  FSMC_BTR_ACCMOD_A  , 0
.EQU  FSMC_BTR_ACCMOD_B  , 1 << FSMC_BTR_ACCMOD_N
.EQU  FSMC_BTR_ACCMOD_C  , 2 << FSMC_BTR_ACCMOD_N
.EQU  FSMC_BTR_ACCMOD_D  , 3 << FSMC_BTR_ACCMOD_N
.EQU  FSMC_BTR_DATLAT_N  , 24
.EQU  FSMC_BTR_DATLAT_2  , 0
.EQU  FSMC_BTR_DATLAT_3  , 1 << FSMC_BTR_DATLAT_N
.EQU  FSMC_BTR_DATLAT_4  , 2 << FSMC_BTR_DATLAT_N
.EQU  FSMC_BTR_DATLAT_5  , 3 << FSMC_BTR_DATLAT_N
.EQU  FSMC_BTR_DATLAT_6  , 4 << FSMC_BTR_DATLAT_N
.EQU  FSMC_BTR_DATLAT_7  , 5 << FSMC_BTR_DATLAT_N
.EQU  FSMC_BTR_DATLAT_8  , 6 << FSMC_BTR_DATLAT_N
.EQU  FSMC_BTR_DATLAT_9  , 7 << FSMC_BTR_DATLAT_N
.EQU  FSMC_BTR_DATLAT_10 , 8 << FSMC_BTR_DATLAT_N
.EQU  FSMC_BTR_DATLAT_11 , 9 << FSMC_BTR_DATLAT_N
.EQU  FSMC_BTR_DATLAT_12 , 10 << FSMC_BTR_DATLAT_N
.EQU  FSMC_BTR_DATLAT_13 , 11 << FSMC_BTR_DATLAT_N
.EQU  FSMC_BTR_DATLAT_14 , 12 << FSMC_BTR_DATLAT_N
.EQU  FSMC_BTR_DATLAT_15 , 13 << FSMC_BTR_DATLAT_N
.EQU  FSMC_BTR_DATLAT_16 , 14 << FSMC_BTR_DATLAT_N
.EQU  FSMC_BTR_DATLAT_17 , 15 << FSMC_BTR_DATLAT_N
.EQU  FSMC_BTR_CLKDIV_N  , 20
.EQU  FSMC_BTR_CLKDIV_2  , 1 << FSMC_BTR_CLKDIV_N
.EQU  FSMC_BTR_CLKDIV_3  , 2 << FSMC_BTR_CLKDIV_N
.EQU  FSMC_BTR_CLKDIV_4  , 3 << FSMC_BTR_CLKDIV_N
.EQU  FSMC_BTR_CLKDIV_5  , 4 << FSMC_BTR_CLKDIV_N
.EQU  FSMC_BTR_CLKDIV_6  , 5 << FSMC_BTR_CLKDIV_N
.EQU  FSMC_BTR_CLKDIV_7  , 6 << FSMC_BTR_CLKDIV_N
.EQU  FSMC_BTR_CLKDIV_8  , 7 << FSMC_BTR_CLKDIV_N
.EQU  FSMC_BTR_CLKDIV_9  , 8 << FSMC_BTR_CLKDIV_N
.EQU  FSMC_BTR_CLKDIV_10 , 9 << FSMC_BTR_CLKDIV_N
.EQU  FSMC_BTR_CLKDIV_11 , 10 << FSMC_BTR_CLKDIV_N
.EQU  FSMC_BTR_CLKDIV_12 , 11 << FSMC_BTR_CLKDIV_N
.EQU  FSMC_BTR_CLKDIV_13 , 12 << FSMC_BTR_CLKDIV_N
.EQU  FSMC_BTR_CLKDIV_14 , 13 << FSMC_BTR_CLKDIV_N
.EQU  FSMC_BTR_CLKDIV_15 , 14 << FSMC_BTR_CLKDIV_N
.EQU  FSMC_BTR_CLKDIV_16 , 15 << FSMC_BTR_CLKDIV_N
.EQU  FSMC_BTR_BUSTURN_N , 16
.EQU  FSMC_BTR_BUSTURN_0 , 0
.EQU  FSMC_BTR_BUSTURN_1 , 1 << FSMC_BTR_BUSTURN_N
.EQU  FSMC_BTR_BUSTURN_2 , 2 << FSMC_BTR_BUSTURN_N
.EQU  FSMC_BTR_BUSTURN_3 , 3 << FSMC_BTR_BUSTURN_N
.EQU  FSMC_BTR_BUSTURN_4 , 4 << FSMC_BTR_BUSTURN_N
.EQU  FSMC_BTR_BUSTURN_5 , 5 << FSMC_BTR_BUSTURN_N
.EQU  FSMC_BTR_BUSTURN_6 , 6 << FSMC_BTR_BUSTURN_N
.EQU  FSMC_BTR_BUSTURN_7 , 7 << FSMC_BTR_BUSTURN_N
.EQU  FSMC_BTR_BUSTURN_8 , 8 << FSMC_BTR_BUSTURN_N
.EQU  FSMC_BTR_BUSTURN_9 , 9 << FSMC_BTR_BUSTURN_N
.EQU  FSMC_BTR_BUSTURN_10, 10 << FSMC_BTR_BUSTURN_N
.EQU  FSMC_BTR_BUSTURN_11, 11 << FSMC_BTR_BUSTURN_N
.EQU  FSMC_BTR_BUSTURN_12, 12 << FSMC_BTR_BUSTURN_N
.EQU  FSMC_BTR_BUSTURN_13, 13 << FSMC_BTR_BUSTURN_N
.EQU  FSMC_BTR_BUSTURN_14, 14 << FSMC_BTR_BUSTURN_N
.EQU  FSMC_BTR_BUSTURN_15, 15 << FSMC_BTR_BUSTURN_N
.EQU  FSMC_BTR_DATAST_N  , 8
.EQU  FSMC_BTR_ADDHLD_N  , 4
.EQU  FSMC_BTR_ADDSET_N  , 0

@.ITEM     FSMC_BWTR1 FSMC_BWTR2 FSMC_BWTR3 FSMC_BWTR4
.EQU  FSMC_BWTRx_RSTVALUE, 0x0FFFFFFF
.EQU  FSMC_BWTR_ACCMOD_N , 28
.EQU  FSMC_BWTR_ACCMOD_A , 0
.EQU  FSMC_BWTR_ACCMOD_B , 1 << FSMC_BWTR_ACCMOD_N
.EQU  FSMC_BWTR_ACCMOD_C , 2 << FSMC_BWTR_ACCMOD_N
.EQU  FSMC_BWTR_ACCMOD_D , 3 << FSMC_BWTR_ACCMOD_N
.EQU  FSMC_BWTR_BUSTURN_N, 16
.EQU  FSMC_BWTR_DATAST_N , 8
.EQU  FSMC_BWTR_ADDHLD_N , 4
.EQU  FSMC_BWTR_ADDSET_N , 0

@.ITEM     FSMC_PCR2 FSMC_PCR3 FSMC_PCR4
.EQU  FSMC_PCRx_RSTVALUE , 0x00000018
.EQU  FSMC_PCR_ECCPS_N   , 17
.EQU  FSMC_PCR_ECCPS_256 , 0
.EQU  FSMC_PCR_ECCPS_512 , 1 << FSMC_PCR_ECCPS_N
.EQU  FSMC_PCR_ECCPS_1K  , 2 << FSMC_PCR_ECCPS_N
.EQU  FSMC_PCR_ECCPS_2K  , 3 << FSMC_PCR_ECCPS_N
.EQU  FSMC_PCR_ECCPS_4K  , 4 << FSMC_PCR_ECCPS_N
.EQU  FSMC_PCR_ECCPS_8K  , 5 << FSMC_PCR_ECCPS_N
.EQU  FSMC_PCR_TAR_N     , 13
.EQU  FSMC_PCR_TAR_1     , 0
.EQU  FSMC_PCR_TAR_2     , 1 << FSMC_PCR_TAR_N
.EQU  FSMC_PCR_TAR_3     , 2 << FSMC_PCR_TAR_N
.EQU  FSMC_PCR_TAR_4     , 3 << FSMC_PCR_TAR_N
.EQU  FSMC_PCR_TAR_5     , 4 << FSMC_PCR_TAR_N
.EQU  FSMC_PCR_TAR_6     , 5 << FSMC_PCR_TAR_N
.EQU  FSMC_PCR_TAR_7     , 6 << FSMC_PCR_TAR_N
.EQU  FSMC_PCR_TAR_8     , 7 << FSMC_PCR_TAR_N
.EQU  FSMC_PCR_TAR_9     , 8 << FSMC_PCR_TAR_N
.EQU  FSMC_PCR_TAR_10    , 9 << FSMC_PCR_TAR_N
.EQU  FSMC_PCR_TAR_11    , 10 << FSMC_PCR_TAR_N
.EQU  FSMC_PCR_TAR_12    , 11 << FSMC_PCR_TAR_N
.EQU  FSMC_PCR_TAR_13    , 12 << FSMC_PCR_TAR_N
.EQU  FSMC_PCR_TAR_14    , 13 << FSMC_PCR_TAR_N
.EQU  FSMC_PCR_TAR_15    , 14 << FSMC_PCR_TAR_N
.EQU  FSMC_PCR_TAR_16    , 15 << FSMC_PCR_TAR_N
.EQU  FSMC_PCR_TCLR_N    , 9
.EQU  FSMC_PCR_TCLR_1    , 0
.EQU  FSMC_PCR_TCLR_2    , 1 << FSMC_PCR_TCLR_N
.EQU  FSMC_PCR_TCLR_3    , 2 << FSMC_PCR_TCLR_N
.EQU  FSMC_PCR_TCLR_4    , 3 << FSMC_PCR_TCLR_N
.EQU  FSMC_PCR_TCLR_5    , 4 << FSMC_PCR_TCLR_N
.EQU  FSMC_PCR_TCLR_6    , 5 << FSMC_PCR_TCLR_N
.EQU  FSMC_PCR_TCLR_7    , 6 << FSMC_PCR_TCLR_N
.EQU  FSMC_PCR_TCLR_8    , 7 << FSMC_PCR_TCLR_N
.EQU  FSMC_PCR_TCLR_9    , 8 << FSMC_PCR_TCLR_N
.EQU  FSMC_PCR_TCLR_10   , 9 << FSMC_PCR_TCLR_N
.EQU  FSMC_PCR_TCLR_11   , 10 << FSMC_PCR_TCLR_N
.EQU  FSMC_PCR_TCLR_12   , 11 << FSMC_PCR_TCLR_N
.EQU  FSMC_PCR_TCLR_13   , 12 << FSMC_PCR_TCLR_N
.EQU  FSMC_PCR_TCLR_14   , 13 << FSMC_PCR_TCLR_N
.EQU  FSMC_PCR_TCLR_15   , 14 << FSMC_PCR_TCLR_N
.EQU  FSMC_PCR_TCLR_16   , 15 << FSMC_PCR_TCLR_N
.EQU  FSMC_PCR_ECCEN     , 1 << 6
.EQU  FSMC_PCR_PWID_N    , 4
.EQU  FSMC_PCR_PWID_8    , 0
.EQU  FSMC_PCR_PWID_16   , 1 << FSMC_PCR_PWID_N
.EQU  FSMC_PCR_PTYP      , 1 << 3
.EQU  FSMC_PCR_PBKEN     , 1 << 2
.EQU  FSMC_PCR_PWAITEN   , 1 << 1

@.ITEM     FSMC_SR2 FSMC_SR3 FSMC_SR4
.EQU  FSMC_SRx_RSTVALUE  , 0x00000040
.EQU  FSMC_SR_FEMPT      , 1 << 6
.EQU  FSMC_SR_IFEN       , 1 << 5
.EQU  FSMC_SR_ILEN       , 1 << 4
.EQU  FSMC_SR_IREN       , 1 << 3
.EQU  FSMC_SR_IFS        , 1 << 2
.EQU  FSMC_SR_ILS        , 1 << 1
.EQU  FSMC_SR_IRS        , 1

@.ITEM     FSMC_PMEM2 FSMC_PMEM3 FSMC_PMEM4
.EQU  FSMC_PMEMx_RSTVALUE, 0xFCFCFCFC
.EQU  FSMC_PMEM_MEMHIZ_N , 24
.EQU  FSMC_PMEM_MEMHOLD_N, 16
.EQU  FSMC_PMEM_MEMWAIT_N, 8
.EQU  FSMC_PMEM_MEMSET_N , 0

@.ITEM     FSMC_PATT2 FSMC_PATT3 FSMC_PATT4
.EQU  FSMC_PATTx_RSTVALUE, 0xFCFCFCFC
.EQU  FSMC_PATT_ATTHIZ_N , 24
.EQU  FSMC_PATT_ATTHOLD_N, 16
.EQU  FSMC_PATT_ATTWAIT_N, 8
.EQU  FSMC_PATT_ATTSET_N , 0

@.ITEM     FSMC_PIO4
.EQU  FSMC_PIO4x_RSTVALUE, 0xFCFCFCFC
.EQU  FSMC_PATT_PIOHIZ_N , 24
.EQU  FSMC_PATT_PIOHOLD_N, 16
.EQU  FSMC_PATT_PIOWAIT_N, 8
.EQU  FSMC_PATT_PIOSET_N , 0


@             Table  8. FSMC pin definition
@
@ Pins(1)               FSMC                   LQFP100(2)  WLCSP90(2)
@          CF   NOR/PSRAM/  NOR/PSRAM   NAND
@                 SRAM         Mux     16 bit
@
@ PE2       -      A23         A23       -        Yes         -
@ PE3       -      A19         A19       -        Yes         -
@ PE4       -      A20         A20       -        Yes         -
@ PE5       -      A21         A21       -        Yes         -
@ PE6       -      A22         A22       -        Yes         -
@ PF0       A0      A0          -        -         -          -
@ PF1       A1      A1          -        -         -          -
@ PF2       A2      A2          -        -         -          -
@ PF3       A3      A3          -        -         -          -
@ PF4       A4      A4          -        -         -          -
@ PF5       A5      A5          -        -         -          -
@ PF6      NIORD     -          -        -         -          -
@ PF7      NREG      -          -        -         -          -
@ PF8      NIOWR     -          -        -         -          -
@ PF9       CD       -          -        -         -          -
@ PF10     INTR      -          -        -         -          -
@ PF12      A6      A6          -        -         -          -
@ PF13      A7      A7          -        -         -          -
@ PF14      A8      A8          -        -         -          -
@ PF15      A9      A9          -        -         -          -
@ PG0      A10     A10          -        -         -          -
@ PG1              A11          -        -         -          -
@ PE7       D4      D4         DA4      D4        Yes        Yes
@ PE8       D5      D5         DA5      D5        Yes        Yes
@ PE9       D6      D6         DA6      D6        Yes        Yes
@ PE10      D7      D7         DA7      D7        Yes        Yes
@ PE11      D8      D8         DA8      D8        Yes        Yes
@ PE12      D9      D9         DA9      D9        Yes        Yes
@ PE13     D10     D10        DA10     D10        Yes        Yes
@ PE14     D11     D11        DA11     D11        Yes        Yes
@ PE15     D12     D12        DA12     D12        Yes        Yes
@ PD8      D13     D13        DA13     D13        Yes        Yes
@ PD9      D14     D14        DA14     D14        Yes        Yes
@ PD10     D15     D15        DA15     D15        Yes        Yes
@ PD11      -      A16         A16     CLE        Yes        Yes
@ PD12      -      A17         A17     ALE        Yes        Yes
@ PD13      -      A18         A18       -        Yes         -
@ PD14      D0      D0         DA0      D0        Yes        Yes
@ PD15      D1      D1         DA1      D1        Yes        Yes
@ PG2       -      A12          -        -         -          -
@ PG3       -      A13          -        -         -          -
@ PG4       -      A14          -        -         -          -
@ PG5       -      A15          -        -         -          -
@ PG6       -       -           -      INT2        -          -
@ PG7       -       -           -      INT3        -          -
@ PD0      D2       D2         DA2       D2       Yes        Yes
@ PD1      D3       D3         DA3       D3       Yes        Yes
@ PD3       -      CLK         CLK       -        Yes         -
@ PD4      NOE     NOE         NOE      NOE       Yes        Yes
@ PD5      NWE     NWE         NWE      NWE       Yes        Yes
@ PD6     NWAIT   NWAIT       NWAIT    NWAIT      Yes        Yes
@ PD7       -      NE1         NE1      NCE2      Yes        Yes
@ PG9       -      NE2         NE2      NCE3       -          -
@ PG10    NCE4_1   NE3         NE3       -         -          -
@ PG11    NCE4_2    -           -        -         -          -
@ PG12      -      NE4         NE4       -         -          -
@ PG13      -      A24         A24       -         -          -
@ PG14      -      A25         A25       -         -          -
@ PB7       -     NADV         NADV      -        Yes        Yes
@ PE0       -     NBL0         NBL0      -        Yes         -
@ PE1       -     NBL1         NBL1      -        Yes         -
@
@ 1. Full FSMC features are available on LQFP144, LQFP176, and UFBGA176.
@    The features available on smaller packages are given in the dedicated
@    package column.
@ 2. Ports F and G are not available in devices delivered in 100-pin packages.




