@GNU AS
@.CharSet         CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                     Базовые константы RTC & BKP                  |
@ +------------------------------------------------------------------+
@.enddesc

.include   "/src/inc/base.inc"

@.item     APB2PERIPH_BASE
.equ  RTC_BASE           , APB1PERIPH_BASE + 0x2800
.equ  RTC                , PERIPH_BASE + RTC_BASE

@.item     RTC_BASE
.equ  RTC_TR             , 0x00    @ RTC time register
.equ  RTC_DR             , 0x04    @ RTC date register
.equ  RTC_CR             , 0x08    @ RTC control register
.equ  RTC_ISR            , 0x0C    @ RTC initialization and status register
.equ  RTC_PRER           , 0x10    @ RTC prescaler register
.equ  RTC_WUTR           , 0x14    @ RTC wakeup timer register
.equ  RTC_CALIBR         , 0x18    @ RTC calibration register
.equ  RTC_ALRMAR         , 0x1C    @ RTC alarm A register
.equ  RTC_ALRMBR         , 0x20    @ RTC alarm B register
.equ  RTC_WPR            , 0x24    @ RTC write protection register
.equ  RTC_SSR            , 0x28    @ RTC sub second register
.equ  RTC_SHIFTR         , 0x2C    @ RTC shift control register
.equ  RTC_TSTR           , 0x30    @ RTC time stamp time register
.equ  RTC_TSDR           , 0x34    @ RTC time stamp date register
.equ  RTC_TSSSR          , 0x38    @ RTC time-stamp sub second register
.equ  RTC_CALR           , 0x3C    @ RTC calibration register
.equ  RTC_TAFCR          , 0x40    @ RTC tamper and alternate function configuration register
.equ  RTC_ALRMASSR       , 0x44    @ RTC alarm A sub second register
.equ  RTC_ALRMBSSR       , 0x48    @ RTC alarm B sub second register
.equ  RTC_BKP0R          , 0x50    @ RTC backup register 1
.equ  RTC_BKP1R          , 0x54    @ RTC backup register 1
.equ  RTC_BKP2R          , 0x58    @ RTC backup register 2
.equ  RTC_BKP3R          , 0x5C    @ RTC backup register 3
.equ  RTC_BKP4R          , 0x60    @ RTC backup register 4
.equ  RTC_BKP5R          , 0x64    @ RTC backup register 5
.equ  RTC_BKP6R          , 0x68    @ RTC backup register 6
.equ  RTC_BKP7R          , 0x6C    @ RTC backup register 7
.equ  RTC_BKP8R          , 0x70    @ RTC backup register 8
.equ  RTC_BKP9R          , 0x74    @ RTC backup register 9
.equ  RTC_BKP10R         , 0x78    @ RTC backup register 10
.equ  RTC_BKP11R         , 0x7C    @ RTC backup register 11
.equ  RTC_BKP12R         , 0x80    @ RTC backup register 12
.equ  RTC_BKP13R         , 0x84    @ RTC backup register 13
.equ  RTC_BKP14R         , 0x88    @ RTC backup register 14
.equ  RTC_BKP15R         , 0x8C    @ RTC backup register 15
.equ  RTC_BKP16R         , 0x90    @ RTC backup register 16
.equ  RTC_BKP17R         , 0x94    @ RTC backup register 17
.equ  RTC_BKP18R         , 0x98    @ RTC backup register 18
.equ  RTC_BKP19R         , 0x9C    @ RTC backup register 19

@ Описание битов настройки регистра RTC_TR
@.item     RTC_TR
.EQU  RTC_TR_PM          , 1 << 22    @ Bit 22 PM: AM/PM@ PM
.EQU  DMA_SxFCR_FS_N     , 3
.EQU  DMA_SxFCR_FS_1D4   , 0
.EQU  DMA_SxFCR_FS_1D2   , 1 << 3
.EQU  DMA_SxFCR_FS_3D4   , 2 << 3
.equ  RTC_TR_HT_N        , 20    @  Bits 21:20 HT[1:0]: Hour tens in BCD format
.equ  RTC_TR_HT_0        , 1 << 20
.equ  RTC_TR_HT_1        , 1 << 20
.equ  RTC_TR_HU_N        , 16    @  Bits 19:16 HU[3:0]: Hour units in BCD format
.equ  RTC_TR_HU_0        , 1 << 16
.equ  RTC_TR_HU_1        , 2 << 16
.equ  RTC_TR_HU_2        , 4 << 16
.equ  RTC_TR_HU_3        , 8 << 16
.equ  RTC_TR_MNT_N       , 12    @ Bits 14:12 MNT[2:0]: Minute tens in BCD format
.equ  RTC_TR_MNT_0       , 1 << 12
.equ  RTC_TR_MNT_1       , 2 << 12
.equ  RTC_TR_MNT_2       , 4 << 12
.equ  RTC_TR_MNU_N       , 8    @ Bit 11:8 MNU[3:0]: Minute units in BCD format
.equ  RTC_TR_MNU_0       , 1 << 8
.equ  RTC_TR_MNU_1       , 2 << 8
.equ  RTC_TR_MNU_2       , 4 << 8
.equ  RTC_TR_MNU_3       , 8 << 8
.equ  RTC_TR_ST_N        , 4    @  Bits 6:4 ST[2:0]: Second tens in BCD format
.equ  RTC_TR_ST_0        , 1 << 4
.equ  RTC_TR_ST_1        , 2 << 4
.equ  RTC_TR_ST_2        , 4 << 4
.equ  RTC_TR_SU_N        , 0    @  Bits 3:0 SU[3:0]: Second units in BCD format
.equ  RTC_TR_SU_0        , 0x00000001
.equ  RTC_TR_SU_1        , 0x00000002
.equ  RTC_TR_SU_2        , 0x00000004
.equ  RTC_TR_SU_3        , 0x00000008

@ Описание битов настройки регистра  RTC_DR
@.item  RTC_DR
.equ  RTC_DR_YT_N        , 20    @ Bits 23:20 YT[3:0]: Year tens in BCD format
.equ  RTC_DR_YT_0        , 1 << 20
.equ  RTC_DR_YT_1        , 2 << 20
.equ  RTC_DR_YT_2        , 4 << 20
.equ  RTC_DR_YT_3        , 8 << 20
.equ  RTC_DR_YU_N        , 16    @ Bits 19:16 YU[3:0]: Year units in BCD format
.equ  RTC_DR_YU_0        , 1 << 16
.equ  RTC_DR_YU_1        , 2 << 16
.equ  RTC_DR_YU_2        , 4 << 16
.equ  RTC_DR_YU_3        , 8 << 16
.equ  RTC_DR_WDU_N       , 13    @ Bits 15:13 WDU[2:0]: Week day units
.equ  RTC_DR_WDU_0       , 1 << 13
.equ  RTC_DR_WDU_1       , 2 << 13
.equ  RTC_DR_WDU_2       , 4 << 13
.equ  RTC_DR_MT_N        , 12    @ Bit 12 MT: Month tens in BCD format
.equ  RTC_DR_MT          , 1 << 12
.equ  RTC_DR_MU_N        , 8    @ Bits 11:8 MU: Month units in BCD format
.equ  RTC_DR_MU_0        , 1 << 8
.equ  RTC_DR_MU_1        , 2 << 8
.equ  RTC_DR_MU_2        , 4 << 8
.equ  RTC_DR_MU_3        , 8 << 8
.equ  RTC_DR_DT_N        , 4    @ Bits 5:4 DT[1:0]: Date tens in BCD format
.equ  RTC_DR_DT_0        , 1 << 4
.equ  RTC_DR_DT_1        , 2 << 4
.equ  RTC_DR_DU_N        , 0    @  Bits 3:0 DU[3:0]: Date units in BCD format
.equ RTC_DR_DU_0, 0x00000001
.equ RTC_DR_DU_1, 0x00000002
.equ RTC_DR_DU_2, 0x00000004
.equ RTC_DR_DU_3, 0x00000008

@ Описание битов настройки регистра  RTC_CR
@.item  RTC_CR
.equ  RTC_CR_COE_1       , 1 << 23    @  1: Calibration output enabled
.equ  RTC_CR_OSEL_N      , 21    @  Bits 22:21 OSEL[1:0]: Output selection
.equ  RTC_CR_OSEL_0      , 1 << 21    @  01: Alarm A output enabled
.equ  RTC_CR_OSEL_1      , 2 << 21    @  10:Alarm B output enabled
.equ  RTC_CR_POL         , 1 << 20    @ Bit 20 POL: Output polarity of RTC_ALARM output
.equ  RTC_CR_COSEL       , 1 << 19    @ it 19 COSEL: Calibration output selection
.equ  RTC_CR_BKP         , 1 << 18    @ Bit 18 BKP: Backup
.equ  RTC_CR_SUB1H       , 1 << 17    @ Bit 17 SUB1H: Subtract 1 hour (winter time change)
.equ  RTC_CR_ADD1H       , 1 << 16    @  Bit 16 ADD1H: Add 1 hour (summer time change)
.equ  RTC_CR_TSIE        , 1 << 15    @ Bit 15 TSIE: Timestamp interrupt enable
.equ  RTC_CR_WUTIE       , 1 << 14    @ Bit 14 WUTIE: Wakeup timer interrupt enable
.equ  RTC_CR_ALRBIE      , 1 << 13    @ Bit 13 ALRBIE: Alarm B interrupt enable
.equ  RTC_CR_ALRAIE      , 1 << 12    @ Bit 12 ALRAIE: Alarm A interrupt enable
.equ  RTC_CR_TSE         , 1 << 11    @ Bit 11 TSE: Time stamp enable
.equ  RTC_CR_WUTE        , 1 << 10    @  Bit 10 WUTE: Wakeup timer enable
.equ  RTC_CR_ALRBE       , 1 << 9    @  Bit 9 ALRBE : Alarm B enable
.equ  RTC_CR_ALRAE       , 1 << 8    @  Bit 8 ALRAE: Alarm A enable
.equ  RTC_CR_DCE         , 1 << 7    @  Bit 7 DCE: Coarse digital calibration enable
.equ  RTC_CR_FMT         , 1 << 6    @  Bit 6 FMT: Hour format
.equ  RTC_CR_BYPSHAD     , 1 << 5    @  Bit 5 BYPSHAD: Bypass the shadow registers
.equ  RTC_CR_REFCKON     , 1 << 4    @  Bit 4 REFCKON: Reference clock detection enable (50 or 60 Hz)
.equ  RTC_CR_TSEDGE      , 1 << 3    @  Bit 3 TSEDGE: Timestamp event active edge
.equ  RTC_CR_WUCKSEL_N   , 0    @   Bits 2:0 WUCKSEL[2:0]: Wakeup clock selection
.equ  RTC_CR_WUCKSEL_0   , 0x00000001
.equ  RTC_CR_WUCKSEL_1   , 0x00000002
.equ  RTC_CR_WUCKSEL_2   , 0x00000004

@ Описание битов настройки регистра  RTC_ISR
@.item  RTC_ISR
.equ  RTC_ISR_RECALPF    , 1 << 16    @ Bit 16 RECALPF: Recalibration pending Flag
.equ  RTC_ISR_TAMP2F     , 1 << 14    @ Bit 14TAMP2F: Tamper detection flag
.equ  RTC_ISR_TAMP1F     , 1 << 13    @ Bit 13 TAMP1F: Tamper detection flag
.equ  RTC_ISR_TSOVF      , 1 << 12    @ Bit 12 TSOVF: Timestamp overflow flag
.equ  RTC_ISR_TSF        , 1 << 11    @ Bit 11 TSF: Timestamp flag
.equ  RTC_ISR_WUTF       , 1 << 10    @ Bit 10 WUTF: Wakeup timer flag
.equ  RTC_ISR_ALRBF      , 1 << 9    @ Bit 9 ALRBF: Alarm B flag
.equ  RTC_ISR_ALRAF      , 1 << 8    @ Bit 8 ALRAF: Alarm A flag
.equ  RTC_ISR_INIT       , 1 << 7    @ Bit 7 INIT: Initialization modei
.equ  RTC_ISR_INITF      , 1 << 6    @ Bit 6 INITF: Initialization flag
.equ  RTC_ISR_RSF        , 1 << 5    @ Bit 5 RSF: Registers synchronization flag
.equ  RTC_ISR_INITS      , 1 << 4    @ Bit 5 RSF: Registers synchronization flag
.equ  RTC_ISR_SHPF       , 1 << 3    @ Bit 3 SHPF: Shift operation pending
.equ  RTC_ISR_WUTWF      , 1 << 2    @ Bit 2 WUTWF: Wakeup timer write flag
.equ  RTC_ISR_ALRBWF     , 1 << 1    @ Bit 1 ALRBWF: Alarm B write flag
.equ  RTC_ISR_ALRAWF     , 1 << 0    @ Bit 0 ALRAWF: Alarm A write flag

@ Описание битов настройки регистра RTC_PRER
@.ITEM     RTC_PRER
.equ  RTC_PRER_PREDIV_A_M, 0x007F0000    @   Bits 22:16 PREDIV_A[6:0]: Asynchronous prescaler factor
.equ  RTC_PRER_PREDIV_A_N, 16
.equ  RTC_PRER_PREDIV_S_M, 0x00001FFF    @  Bits 14:0 PREDIV_S[14:0]: Synchronous prescaler factor
.equ  RTC_PRER_PREDIV_S_N, 0

@ Описание битов настройки регистра TC_WUTR
@.ITEM     RTC_WUTR
.equ  RTC_WUTR_WUT_M     , 0x0000FFFF    @  Bits 15:0 WUT[15:0]: Wakeup auto-reload value bits
.equ  RTC_WUTR_WUT_N     , 0
@ Описание битов настройки регистра RTC_CALIBR
@.item  RTC_CALIBR
.equ  RTC_CALIBR_DCS_N   , 7    @  Bit 7 DCS: Digital calibration sign
.equ  RTC_CALIBR_DCS     , 1 << 7    @  1: Negative calibration: calendar update frequency is decreased
.equ  RTC_CALIBR_DC_M    , 0x0000001F    @  Bits 4:0 DC[4:0]: Digital calibration
.equ  RTC_CALIBR_DC_N    , 0

@ Описание битов настройки регистра RTC_ALRMAR
@.item     RTC_ALRMAR
.equ  RTC_ALRMAR_MSK4    , 1 << 31    @ Bit 31 MSK4: Alarm A date mask
.equ  RTC_ALRMAR_WDSEL   , 1 << 30    @  Bit 30 WDSEL: Week day selection
.equ  RTC_ALRMAR_DT_N    , 28    @  Bits 29:28 DT[1:0]: Date tens in BCD format.
.equ  RTC_ALRMAR_DT_M    , 0x30000000
.equ  RTC_ALRMAR_DT_0    , 1 << 28    @ Bits 29:28 DT[1:0]: Date tens in BCD format.
.equ  RTC_ALRMAR_DT_1    , 1 << 29    @
.equ  RTC_ALRMAR_DU_M    , 0x0F000000    @  Bits 27:24 DU[3:0]: Date units or day in BCD format.
.equ  RTC_ALRMAR_DU_N    , 24
.equ  RTC_ALRMAR_DU_0    , 1 << 24
.equ  RTC_ALRMAR_DU_1    , 2 << 24
.equ  RTC_ALRMAR_DU_2    , 4 << 24
.equ  RTC_ALRMAR_DU_3    , 8 << 24
.equ  RTC_ALRMAR_MSK3    , 1 << 23    @  Bit 23 MSK3: Alarm A hours mask
.equ  RTC_ALRMAR_PM      , 1 << 22    @  Bit 22 PM: AM/PM notation
.equ  RTC_ALRMAR_HT      , 20    @ Bits 21:20 HT[1:0]: Hour tens in BCD format.
.equ  RTC_ALRMAR_HT_0    , 1 << 20
.equ  RTC_ALRMAR_HT_1    , 2 << 20
.equ  RTC_ALRMAR_HU_M    , 0x000F0000    @ Bits 19:16 HU[3:0]: Hour units in BCD format.
.equ  RTC_ALRMAR_HU_N    , 16
.equ  RTC_ALRMAR_HU_0    , 1 << 16
.equ  RTC_ALRMAR_HU_1    , 2 << 16
.equ  RTC_ALRMAR_HU_2    , 4 << 16
.equ  RTC_ALRMAR_HU_3    , 8 << 16
.equ  RTC_ALRMAR_MSK2    , 1 << 15    @  Bit 15 MSK2: Alarm A minutes mask
.equ  RTC_ALRMAR_MNT_M   , 0x00007000    @  Bits 14:12 MNT[2:0]: Minute tens in BCD format.
.equ  RTC_ALRMAR_MNT_N   , 12    @
.equ  RTC_ALRMAR_MNT_0   , 1 << 12
.equ  RTC_ALRMAR_MNT_1   , 2 << 12
.equ  RTC_ALRMAR_MNT_2   , 4 << 12
.equ  RTC_ALRMAR_MNU_M   , 0x00000F00    @  Bits 11:8 MNU[3:0]: Minute units in BCD format.
.equ  RTC_ALRMAR_MNU_N   , 8
.equ  RTC_ALRMAR_MNU_0   , 1 << 8
.equ  RTC_ALRMAR_MNU_1   , 2 << 8
.equ  RTC_ALRMAR_MNU_2   , 4 << 8
.equ  RTC_ALRMAR_MNU_3   , 8 << 8
.equ  RTC_ALRMAR_MSK1    , 1 << 7    @  Bit 7 MSK1: Alarm A seconds mask
.equ  RTC_ALRMAR_ST_M    , 0x00000070    @  Bits 6:4 ST[2:0]: Second tens in BCD format.
.equ  RTC_ALRMAR_ST_N    , 4    @
.equ  RTC_ALRMAR_ST_0    , 1 << 4
.equ  RTC_ALRMAR_ST_1    , 2 << 4
.equ  RTC_ALRMAR_ST_2    , 4 << 4
.equ  RTC_ALRMAR_SU_M    , 0x0000000F    @  Bits 3:0 SU[3:0]: Second units in BCD format.
.equ  RTC_ALRMAR_SU_N    , 0
.equ RTC_ALRMAR_SU_0, 0x00000001
.equ RTC_ALRMAR_SU_1, 0x00000002
.equ RTC_ALRMAR_SU_2, 0x00000004
.equ RTC_ALRMAR_SU_3, 0x00000008

@ Описание битов настройки регистра RTC_ALRMBR
@.item     RTC_ALRMBR
.equ  RTC_ALRMBR_MSK4    ,  1 << 31   @  Bit 31 MSK4: Alarm B date mask
.equ  RTC_ALRMBR_WDSEL   , 1 << 30    @  Bit 30 WDSEL: Week day selection
.equ  RTC_ALRMBR_DT_N    , 28    @  Bits 29:28 DT[1:0]: Date tens in BCD format.
.equ  RTC_ALRMBR_DT_M    , 0x30000000
.equ  RTC_ALRMBR_DT_0    , 1 << 28    @ Bits 29:28 DT[1:0]: Date tens in BCD format.
.equ  RTC_ALRMBR_DT_1    , 1 << 29    @
.equ  RTC_ALRMBR_DU_M    , 0x0F000000    @  Bits 27:24 DU[3:0]: Date units or day in BCD format.
.equ  RTC_ALRMBR_DU_N    , 24
.equ  RTC_ALRMBR_DU_0    , 1 << 24
.equ  RTC_ALRMBR_DU_1    , 2 << 24
.equ  RTC_ALRMBR_DU_2    , 4 << 24
.equ  RTC_ALRMBR_DU_3    , 8 << 24
.equ  RTC_ALRMBR_MSK3    , 1 << 23    @  Bit 23 MSK3: Alarm A hours mask
.equ  RTC_ALRMBR_PM      , 1 << 22    @  Bit 22 PM: AM/PM notation
.equ  RTC_ALRMBR_HT      , 20    @ Bits 21:20 HT[1:0]: Hour tens in BCD format.
.equ  RTC_ALRMBR_HT_0    , 1 << 20
.equ  RTC_ALRMBR_HT_1    , 2 << 20
.equ  RTC_ALRMBR_HU_M    , 0x000F0000    @ Bits 19:16 HU[3:0]: Hour units in BCD format.
.equ  RTC_ALRMBR_HU_N    , 16
.equ  RTC_ALRMBR_HU_0    , 1 << 16
.equ  RTC_ALRMBR_HU_1    , 2 << 16
.equ  RTC_ALRMBR_HU_2    , 4 << 16
.equ  RTC_ALRMBR_HU_3    , 8 << 16
.equ  RTC_ALRMBR_MSK2    , 1 << 15    @  Bit 15 MSK2: Alarm A minutes mask
.equ  RTC_ALRMBR_MNT_M   , 0x00007000    @  Bits 14:12 MNT[2:0]: Minute tens in BCD format.
.equ  RTC_ALRMBR_MNT_N   , 12    @
.equ  RTC_ALRMBR_MNT_0   , 1 << 12
.equ  RTC_ALRMBR_MNT_1   , 2 << 12
.equ  RTC_ALRMBR_MNT_2   , 4 << 12
.equ  RTC_ALRMBR_MNU_M   , 0x00000F00    @  Bits 11:8 MNU[3:0]: Minute units in BCD format.
.equ  RTC_ALRMBR_MNU_N   , 8
.equ  RTC_ALRMBR_MNU_0   , 1 << 8
.equ  RTC_ALRMBR_MNU_1   , 2 << 8
.equ  RTC_ALRMBR_MNU_2   , 4 << 8
.equ  RTC_ALRMBR_MNU_3   , 8 << 8
.equ  RTC_ALRMBR_MSK1    , 1 << 7    @  Bit 7 MSK1: Alarm A seconds mask
.equ  RTC_ALRMBR_ST_M    , 0x00000070    @  Bits 6:4 ST[2:0]: Second tens in BCD format.
.equ  RTC_ALRMBR_ST_N    , 4    @
.equ  RTC_ALRMBR_ST_0    , 1 << 4
.equ  RTC_ALRMBR_ST_1    , 2 << 4
.equ  RTC_ALRMBR_ST_2    , 4 << 4
.equ  RTC_ALRMBR_SU_M    , 0x0000000F    @  Bits 3:0 SU[3:0]: Second units in BCD format.
.equ  RTC_ALRMBR_SU_N    , 0
.equ  RTC_ALRMBR_SU_0    , 0x00000001
.equ  RTC_ALRMBR_SU_1    , 0x00000002
.equ  RTC_ALRMBR_SU_2    , 0x00000004
.equ  RTC_ALRMBR_SU_3    , 0x00000008


@ Описание битов настройки регистра RTC_WPR
@.item     RTC_WPR
.equ RTC_WPR_KEY, 0x000000FF

@ Описание битов настройки регистра RTC_SSR
@.item     RTC_SSR
.equ RTC_SSR_SS, 0x0000FFFF


@ Описание битов настройки регистра RTC_SHIFTR
@.item     RTC_SHIFTR
.equ RTC_SHIFTR_SUBFS, 0x00007FFF
.equ RTC_SHIFTR_ADD1S, 0x80000000


@ Описание битов настройки регистра RTC_TSTR
@.item     RTC_TSTR
.equ  RTC_TSTR_PM        , 1 << 22    @ it 22 PM: AM/PM notation
.equ  RTC_TSTR_HT_M      , 0x00300000    @  Bits 21:20 HT[1:0]: Hour tens in BCD format.
.equ  RTC_TSTR_HT_N      , 20    @
.equ  RTC_TSTR_HT_0      , 1 << 20
.equ  RTC_TSTR_HT_1      , 2 << 20
.equ  RTC_TSTR_HU_M      , 0x000F0000    @  Bits 19:16 HU[3:0]: Hour units in BCD format.
.equ  RTC_TSTR_HU_N      , 16    @
.equ  RTC_TSTR_HU_0      , 1 << 16
.equ  RTC_TSTR_HU_1      , 2 << 16
.equ  RTC_TSTR_HU_2      , 4 << 16
.equ  RTC_TSTR_HU_3      , 8 << 16
.equ  RTC_TSTR_MNT       , 0x00007000    @  Bits 14:12 MNT[2:0]: Minute tens in BCD format.
.equ  RTC_TSTR_MNT       , 12    @
.equ  RTC_TSTR_MNT_0     , 1 << 12
.equ  RTC_TSTR_MNT_1     , 2 << 12
.equ  RTC_TSTR_MNT_2     , 4 << 12
.equ  RTC_TSTR_MNU_M     , 0x00000F00    @   Bits 11:8 MNU[3:0]: Minute units in BCD format.
.equ  RTC_TSTR_MNU_N     , 8    @
.equ  RTC_TSTR_MNU_0     , 1 << 8
.equ  RTC_TSTR_MNU_1     , 2 << 8
.equ  RTC_TSTR_MNU_2     , 4 << 8
.equ  RTC_TSTR_MNU_3     , 8 << 8
.equ  RTC_TSTR_ST_M      , 0x00000070    @  Bits 6:4 ST[2:0]: Second tens in BCD format.
.equ  RTC_TSTR_ST_N      , 4    @
.equ  RTC_TSTR_ST_0      , 1 << 4
.equ  RTC_TSTR_ST_1      , 2 << 4
.equ  RTC_TSTR_ST_2      , 4 << 4
.equ  RTC_TSTR_SU_M      , 0x0000000F    @  Bits 3:0 SU[3:0]: Second units in BCD format.
.equ  RTC_TSTR_SU_N      , 0    @
.equ RTC_TSTR_SU_0, 0x00000001
.equ RTC_TSTR_SU_1, 0x00000002
.equ RTC_TSTR_SU_2, 0x00000004
.equ RTC_TSTR_SU_3, 0x00000008

@ Описание битов настройки регистра RTC_TSDR
@.item     RTC_TSDR
.equ  RTC_TSDR_WDU       , 0x0000E000    @  Bits 15:13 WDU[1:0]: Week day units
.equ  RTC_TSDR_WDU_N     , 13    @
.equ  RTC_TSDR_WDU_0     , 2 << 13
.equ  RTC_TSDR_WDU_1     , 4 << 13
.equ  RTC_TSDR_WDU_2     , 8 << 13
.equ  RTC_TSDR_MT        , 1 << 12    @  Bit 12 MT: Month tens in BCD format
.equ  RTC_TSDR_MU_M      , 0x00000F00    @  Bits 11:8 MU[3:0]: Month units in BCD format
.equ  RTC_TSDR_MU_N      , 8    @
.equ  RTC_TSDR_MU_0      , 1 << 8
.equ  RTC_TSDR_MU_1      , 2 << 8
.equ  RTC_TSDR_MU_2      , 4 << 8
.equ  RTC_TSDR_MU_3      , 8 << 8
.equ  RTC_TSDR_DT_M      , 0x00000030    @  Bits 5:4 DT[1:0]: Date tens in BCD format
.equ  RTC_TSDR_DT_N      , 4    @
.equ  RTC_TSDR_DT_0      , 1 << 4
.equ  RTC_TSDR_DT_1      , 2 << 4
.equ  RTC_TSDR_DU_M      , 0x0000000F    @  Bit 3:0 DU[3:0]: Date units in BCD format
.equ  RTC_TSDR_DU_N      , 0    @
.equ RTC_TSDR_DU_0, 0x00000001
.equ RTC_TSDR_DU_1, 0x00000002
.equ RTC_TSDR_DU_2, 0x00000004
.equ RTC_TSDR_DU_3, 0x00000008

@ Описание битов настройки регистра RTC_TSSSR
@.item     RTC_TSSSR
.equ RTC_TSSSR_SS, 0x0000FFFF

@ Описание битов настройки регистра RTC_CALR
@.item     RTC_CALR
.equ  RTC_CALR_CALP      , 1 << 15    @ Bit 15 CALP: Increase frequency of RTC by 488.5 ppm
.equ  RTC_CALR_CALW8     , 1 << 14    @ Bit 14 CALW8: Use an 8-second calibration cycle period
.equ  RTC_CALR_CALW16    , 1 << 13    @ Bit 13 CALW16: Use a 16-second calibration cycle period
.equ  RTC_CALR_CALM_M    , 0x000001FF    @  Bits 8:0 CALM[8:0]: Calibration minus
.equ  RTC_CALR_CALM_0    , 0x00000001
.equ  RTC_CALR_CALM_1    , 0x00000002
.equ  RTC_CALR_CALM_2    , 0x00000004
.equ  RTC_CALR_CALM_3    , 0x00000008
.equ  RTC_CALR_CALM_4    , 0x00000010
.equ  RTC_CALR_CALM_5    , 0x00000020
.equ  RTC_CALR_CALM_6    , 0x00000040
.equ  RTC_CALR_CALM_7    , 0x00000080
.equ  RTC_CALR_CALM_8    , 0x00000100

@ Описание битов настройки регистра RTC_TAFCR
@.item     RTC_TAFCR
.equ  RTC_TAFCR_ALARMOUTTYPE, 1 << 18    @  Bit 18 ALARMOUTTYPE: RTC_ALARM output type
.equ  RTC_TAFCR_TSINSEL  , 1 << 17    @  Bit 17 TSINSEL: TIMESTAMP mapping
.equ  RTC_TAFCR_TAMPINSEL, 1 << 16    @  Bit 16 TAMP1INSEL: TAMPER1 mapping
.equ  RTC_TAFCR_TAMPPUDIS, 1 << 15    @  Bit 15 TAMPPUDIS: TAMPER pull-up disable
.equ  RTC_TAFCR_TAMPPRCH_M, 0x00006000    @ Bits 14:13 TAMPPRCH[1:0]: Tamper precharge duration
.equ  RTC_TAFCR_TAMPPRCH_N, 13    @
.equ  RTC_TAFCR_TAMPPRCH_0, 2 << 13
.equ  RTC_TAFCR_TAMPPRCH_1, 4 << 13
.equ  RTC_TAFCR_TAMPFLT_M, 0x00001800    @ Bits 12:11 TAMPFLT[1:0]: Tamper filter count
.equ  RTC_TAFCR_TAMPFLT_N, 0x00001800    @
.equ  RTC_TAFCR_TAMPFLT_0, 8 << 11
.equ  RTC_TAFCR_TAMPFLT_1, 16 << 11
.equ  RTC_TAFCR_TAMPFREQ_M, 0x00000700    @ Bits 10:8 TAMPFREQ[2:0]: Tamper sampling frequency
.equ  RTC_TAFCR_TAMPFREQ_N, 8    @
.equ  RTC_TAFCR_TAMPFREQ_0, 1 << 8
.equ  RTC_TAFCR_TAMPFREQ_1, 2 << 8
.equ  RTC_TAFCR_TAMPFREQ_2, 4 << 8
.equ  RTC_TAFCR_TAMPTS   , 0x00000008    @  Bit 7 TAMPTS: Activate timestamp on tamper detection event
.equ  TAMP2TRG           , 1 << 4    @  Bit 4 TAMP2TRG: Active level for tamper 2
.equ  RTC_TAFCR_TAMP2E   , 0x00000008    @  Bit 3 TAMP2E: Tamper 2 detection enable                                       @  Bit 3 TAMP2E: Tamper 2 detection enable
.equ  RTC_TAFCR_TAMPIE   , 0x00000004    @ Bit 2 TAMPIE: Tamper interrupt enable
.equ  RTC_TAFCR_TAMP1TRG , 0x00000002    @  Bit 1 TAMP1TRG: Active level for tamper 1
.equ  RTC_TAFCR_TAMP1E   , 0x00000001    @  Bit 0 TAMP1E: Tamper 1 detection enable

@ Описание битов настройки регистра RTC_ALRMASSR
@.item     RTC_ALRMASSR
.equ  RTC_ALRMASSR_MASKSS_M, x0F000000    @  Bits 27:24 MASKSS[3:0]: Mask the most-significant bits starting at this bit
.equ  RTC_ALRMASSR_MASKSS_N, 24    @
.equ  RTC_ALRMASSR_MASKSS_0, 1 << 24
.equ  RTC_ALRMASSR_MASKSS_1, 2 << 24
.equ  RTC_ALRMASSR_MASKSS_2, 4 << 24
.equ  RTC_ALRMASSR_MASKSS_3, 8 << 24
.equ  RTC_ALRMASSR_SS    , 0x00007FFF    @  Bits 14:0 SS[14:0]: Sub seconds value

@ Описание битов настройки регистра RTC_ALRMBSSR
@.item     RTC_ALRMBSSR
.equ  RTC_ALRMBSSR_MASKSS_M, x0F000000    @  Bits 27:24 MASKSS[3:0]: Mask the most-significant bits starting at this bit
.equ  RTC_ALRMBSSR_MASKSS_N, 24    @
.equ  RTC_ALRMBSSR_MASKSS_0, 1 << 24
.equ  RTC_ALRMBSSR_MASKSS_1, 2 << 24
.equ  RTC_ALRMBSSR_MASKSS_2, 4 << 24
.equ  RTC_ALRMBSSR_MASKSS_3, 8 << 24
.equ  RTC_ALRMBSSR_SS    , 0x00007FFF    @  Bits 14:0 SS[14:0]: Sub seconds value


