@ GNU AS
@.CHARSET CP1251

.include "/src/inc/base.inc"

@.item MPU_BASE
.equ MPU_TYPER                , 0x00 @ MPU type register
.equ MPU_CTRL                 , 0x04 @ MPU control register
.equ MPU_RNR                  , 0x08 @ MPU region number register
.equ MPU_RBAR                 , 0x0C @ MPU region base adress register
.equ MPU_RASR                 , 0x10 @ MPU region attribute and size register

@.item MPU_TYPER
.equ MPU_TYPER_SEPARATE       , 1    @ Separate
.equ MPU_TYPER_SEPARATE_N     , 0    @ Separate flag number
.equ MPU_TYPER_DREGION_N      , 9    @ Number of MPU data regions
.equ MPU_TYPER_DREGION_MASK   , 0x7F<<9  @ Number of MPU data regions
.equ MPU_TYPER_DREGION_8MPU   , 0x08<<9  @ Eight MPU regions
.equ MPU_TYPER_DREGION_NOMPU  , 0x00 @ MPU not present
.equ MPU_TYPER_IREGION_N      , 16   @ Number of MPU instruction regions
.equ MPU_TYPER_IREGION_MASK   , 0xFF<16  @ Number of MPU instruction regions

@.item MPU_CTRL
.equ MPU_CTRL_ENABLE          , 1    @ Enables the MPU
.equ MPU_CTRL_ENABLE_N        , 0    @ Enables the MPU
.equ MPU_CTRL_HFNMIENA        , 2    @ MPU is enabled during hard fault, NMI and FAULTMASK handlers
.equ MPU_CTRL_HFNMIENA_N      , 1    @ MPU is enabled during hard fault, NMI and FAULTMASK handlers
.equ MPU_CTRL_PRIVDEFENA      , 4    @ if the MPU is enabled, enables use of the default memory map as background region for privileged software accesses
.equ MPU_CTRL_PRIVDEFENA_N    , 2    @ if the MPU is enabled, enables use of the default memory map as background region for privileged software accesses

@.item MPU_RNR
.equ MPU_RNR_REGION           , 0    @ MPU Region
.equ MPU_RNR_REGION_N         , 0    @ MPU Region
.equ MPU_RNR_REGION_MASK      , 0xFF    @ MPU Region mask

@.item MPU_RBAR
.equ MPU_RBAR_REGION_N        , 0    @ MPU region field
.equ MPU_RBAR_VALID_N         , 4    @ MPU region number valid
.equ MPU_RBAR_VALID           , 0x10    @ MPU region number valid
.equ MPU_RBAR_ADDR_N          , 5    @ Region base address field

@.item MPU_RASR
.equ MPU_RASR_ENABLE          , 1    @ Region enable bit
.equ MPU_RASR_ENABLE_N        , 0    @ num Region enable bit
.equ MPU_RASR_SIZE_N          , 1    @ Size of the MPU protection region
.equ MPU_RASR_SIZE_MASK       , 0x3E    @ Size of the MPU protection region
.equ MPU_RASR_SRD_N           , 8    @ Subregion disable bits
.equ MPU_RASR_SRD_MASK        , 0xFF00  @ Subregion disable bits
.equ MPU_RASR_B_N             , 16   @ Memory attribute
.equ MPU_RASR_C_N             , 17   @ Memory attribute
.equ MPU_RASR_S_N             , 18   @ Shareable memory attribute
.equ MPU_RASR_TEX_N           , 19   @ Memory attribute
.equ MPU_RASR_TEX_MASK        , 0x380000  @ mask Memory attribute
.equ MPU_RASR_AP_N            , 24   @ Access permission
.equ MPU_RASR_AP_MASK         , 0x07000000  @ Access permission mask
.equ MPU_RASR_XN              , 0x10000000  @ Instruction access disable bit
.equ MPU_RASR_XN_N            , 28   @ Instruction access disable bit

