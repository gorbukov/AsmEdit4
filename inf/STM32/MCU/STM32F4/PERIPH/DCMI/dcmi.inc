@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                     Базовые константы DCMI                       |
@ +------------------------------------------------------------------+
@.enddesc

.include "/src/inc/base.inc"

@.ITEM     AHB2PERIPH_BASE
.EQU  DCMI_BASE          , AHB2PERIPH_BASE + 0x50000
.EQU  DCMI               , PERIPH_BASE + DCMI_BASE

@.ITEM     DCMI_BASE DCMI
.EQU  DCMI_CR            , 0x00
.EQU  DCMI_SR            , 0x04
.EQU  DCMI_RIS           , 0x08
.EQU  DCMI_IER           , 0x0C
.EQU  DCMI_MIS           , 0x10
.EQU  DCMI_ICR           , 0x14
.EQU  DCMI_ESCR          , 0x18
.EQU  DCMI_ESUR          , 0x1C
.EQU  DCMI_CWSTR         , 0x20
.EQU  DCMI_CWSIZ         , 0x24
.EQU  DCMI_DR            , 0x28

@.ITEM     DCMI_CR
.EQU  DCMI_CR_ENABLE     , 1 << 14
.EQU  DCMI_CR_EDM_N      , 10
.EQU  DCMI_CR_EDM_8BIT   , 0
.EQU  DCMI_CR_EDM_10BIT  , 1 << 10
.EQU  DCMI_CR_EDM_12BIT  , 2 << 10
.EQU  DCMI_CR_EDM_14BIT  , 3 << 10
.EQU  DCMI_CR_FCRC_N     , 8
.EQU  DCMI_CR_FCRC_ALL   , 0
.EQU  DCMI_CR_FCRC_EVER  , 1 << 8
.EQU  DCMI_CR_FCRC_ONE   , 2 << 8
.EQU  DCMI_CR_VSPOL      , 1 << 7
.EQU  DCMI_CR_HSPOL      , 1 << 6
.EQU  DCMI_CR_PCKPOL     , 1 << 5
.EQU  DCMI_CR_ESS        , 1 << 4
.EQU  DCMI_CR_JPEG       , 1 << 3
.EQU  DCMI_CR_CROP       , 1 << 2
.EQU  DCMI_CR_CM         , 1 << 1
.EQU  DCMI_CR_CAPTURE    , 1

@.ITEM     DCMI_SR
.EQU  DCMI_SR_FNE        , 1 << 2
.EQU  DCMI_SR_VSYNC      , 1 << 1
.EQU  DCMI_SR_HSYNC      , 1

@.ITEM     DCMI_RIS
.EQU  DCMI_RIS_LINE_RIS  , 1 << 4
.EQU  DCMI_RIS_VSYNC_RIS , 1 << 3
.EQU  DCMI_RIS_ERR_RIS   , 1 << 2
.EQU  DCMI_RIS_OVR_RIS   , 1 << 1
.EQU  DCMI_RIS_FRAME_RIS , 1

@.ITEM     DCMI_IER
.EQU  DCMI_IER_LINE_IE   , 1 << 4
.EQU  DCMI_IER_VSYNC_IE  , 1 << 3
.EQU  DCMI_IER_ERR_IE    , 1 << 2
.EQU  DCMI_IER_OVR_IE    , 1 << 1
.EQU  DCMI_IER_FRAME_IE  , 1

@.ITEM     DCMI_MIS
.EQU  DCMI_MIS_LINE_MIS  , 1 << 4
.EQU  DCMI_MIS_VSYNC_MIS , 1 << 3
.EQU  DCMI_MIS_ERR_MIS   , 1 << 2
.EQU  DCMI_MIS_OVR_MIS   , 1 << 1
.EQU  DCMI_MIS_FRAME_MIS , 1

@.ITEM     DCMI_ICR
.EQU  DCMI_ICR_LINE_ISC  , 1 << 4
.EQU  DCMI_ICR_VSYNC_ISC , 1 << 3
.EQU  DCMI_ICR_ERR_ISC   , 1 << 2
.EQU  DCMI_ICR_OVR_ISC   , 1 << 1
.EQU  DCMI_ICR_FRAME_ISC , 1

@.ITEM     DCMI_ESCR
.EQU  DCMI_ESCR_FEC_N    , 24
.EQU  DCMI_ESCR_LEC_N    , 16
.EQU  DCMI_ESCR_LSC_N    , 8
.EQU  DCMI_ESCR_FSC_N    , 0

@.ITEM     DCMI_ESUR
.EQU  DCMI_ESUR_FEU_N    , 24
.EQU  DCMI_ESUR_LEU_N    , 16
.EQU  DCMI_ESUR_LSU_N    , 8
.EQU  DCMI_ESUR_FSU_N    , 0

@.ITEM     DCMI_CWSTRT
.EQU  DCMI_CWSTRT_VST_N  , 16
.EQU  DCMI_CWSTRT_HOFFCNT_N, 0

@.ITEM     DCMI_CWSIZE
.EQU  DCMI_CWSIZE_VLINE_N, 16
.EQU  DCMI_CWSIZE_CAPCNT_N, 0



