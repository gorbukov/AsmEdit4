                         @GNU AS
@.CHARSET =CP1251 ( Cyrillic )
@.DESC     type=module
@ +------------------------------------------------------------------+
@ |                        онстанты Flash control                    |
@ +------------------------------------------------------------------+
@.ENDDESC

.INCLUDE "/src/inc/base.inc"

                         @ базовые константы микроконтроллера

@.ITEM     AHB1PERIPH_BASE
.EQU  FLASH_R_BASE                  , ( AHB1PERIPH_BASE + 0x3C00 )

@.ITEM     FLASH_R_BASE
.EQU  FLASH_ACR                     , 0x00                   @ Flash access control register (FLASH_ACR)
.EQU  FLASH_KEYR                    , 0x04                   @ Flash key register (FLASH_KEYR)
.EQU  FLASH_OPTKEYR                 , 0x08                   @ Flash option key register (FLASH_OPTKEYR)
.EQU  FLASH_SR                      , 0x0C                   @ Flash st atus re gister (FLASH_SR)
.EQU  FLASH_CR                      , 0x10                   @ Flash control register (FLASH_CR)
.EQU  FLASH_OPTCR                   , 0x14                   @ Flash option control register (FLASH_OPTCR)

@.ITEM     FLASH_ACR
.EQU  FLASH_ACR_LATENCY_N           , 0                      @ Bits 2:0 LATENCY[2:0]: These bits represent the ratio of the CPU clock period to the Flash memory access time.
.EQU  FLASH_ACR_LATENCY_0           , 0
.EQU  FLASH_ACR_LATENCY_1           , 1
.EQU  FLASH_ACR_LATENCY_2           , 2
.EQU  FLASH_ACR_LATENCY_3           , 3
.EQU  FLASH_ACR_LATENCY_4           , 4
.EQU  FLASH_ACR_LATENCY_5           , 5
.EQU  FLASH_ACR_LATENCY_6           , 6
.EQU  FLASH_ACR_LATENCY_7           , 7
.EQU  FLASH_ACR_PRFTEN_N            , 8                      @ Bit 8 PRFTEN: Prefetch enable
.EQU  FLASH_ACR_PRFTEN              , 1 << 8
.EQU  FLASH_ACR_ICEN_N              , 9                      @ Bit 9 ICEN: Instruction cache enable
.EQU  FLASH_ACR_ICEN                , 1 << 9
.EQU  FLASH_ACR_DCEN_N              , 10                     @ Bit 10 DCEN: Data cache enable
.EQU  FLASH_ACR_DCEN                , 1 << 10
.EQU  FLASH_ACR_ICRST_N             , 11                     @ Bit 11 ICRST: Instruction cache reset
.EQU  FLASH_ACR_ICRST               , 1 << 11
.EQU  FLASH_ACR_DCRST_N             , 12                     @ Bit 12 DCRST: Data cache reset
.EQU  FLASH_ACR_DCRST               , 12

@.ITEM     FLASH_KEYR
.EQU  FLASH_KEYR_FKEYR_K1           , 0x45670123             @ Key1
.EQU  FLASH_KEYR_FKEYR_K2           , 0xCDEF89AB             @ Key2

@.ITEM     FLASH_OPTKEYR
.EQU  FLASH_OPTKEYR_OPTKEYR_K1      , 0x08192A3B             @ OPTKEY1
.EQU  FLASH_OPTKEYR_OPTKEYR_K2      , 0x4C5D6E7F             @ OPTKEY2

@.ITEM     FLASH_SR
.EQU  FLASH_SR_EOP_N                , 0                      @ Bit 0 EOP: End of operation
.EQU  FLASH_SR_EOP                  , 1                      @ Bit 0 EOP: End of operation
.EQU  FLASH_SR_OPERR_N              , 1                      @ Bit 1 OPERR: Operation error
.EQU  FLASH_SR_OPERR                , 1 << 1
.EQU  FLASH_SR_WRPERR_N             , 4                      @ Bit 4 WRPERR: Write protection error
.EQU  FLASH_SR_WRPERR               , 1 << 4
.EQU  FLASH_SR_PGAERR_N             , 5                      @ Bit 5 PGAERR: Programming alignment error
.EQU  FLASH_SR_PGAERR               , 1 << 5
.EQU  FLASH_SR_PGPERR_N             , 6                      @ Bit 6 PGPERR: Programming parallelism error
.EQU  FLASH_SR_PGPERR               , 1 << 6
.EQU  FLASH_SR_PGSERR_N             , 7                      @ Bit 7 PGSERR: Programming sequence error
.EQU  FLASH_SR_PGSERR               , 1 << 7
.EQU  FLASH_SR_BSY_N                , 16                     @ Bit 16 BSY: Busy
.EQU  FLASH_SR_BSY                  , 1 << 16

@.ITEM     FLASH_CR
.EQU  FLASH_CR_Reset_Value          , 0x80000000             @ «начение регистра по умолчанию
.EQU  FLASH_CR_PG_N                 , 0                      @ Bit 0 PG: Programming
.EQU  FLASH_CR_PG                   , 1
.EQU  FLASH_CR_SER_N                , 1                      @ Bit 1 SER: Sector Erase
.EQU  FLASH_CR_SER                  , 1 << 1
.EQU  FLASH_CR_MER_N                , 2                      @ Bit 2 MER: Mass Erase
.EQU  FLASH_CR_MER                  , 1 << 2
.EQU  FLASH_CR_SNB_N                , 3                      @ Bits 6:3 SNB[3:0]: Sector number
.EQU  FLASH_CR_PSIZE_N              , 8                      @ Bits 9:8 PSIZE[1:0]: Program size
.EQU  FLASH_CR_PSIZE_0              , 0                      @ program x8
.EQU  FLASH_CR_PSIZE_1              , 1 << 8                 @ program x16
.EQU  FLASH_CR_PSIZE_2              , 2 << 8                 @ program x32
.EQU  FLASH_CR_PSIZE_3              , 3 << 8                 @ program x64
.EQU  FLASH_CR_STRT_N               , 16                     @ Bit 16 STRT: Start
.EQU  FLASH_CR_STRT                 , 1 << 16
.EQU  FLASH_CR_EOPIE_N              , 24                     @ Bit 24 EOPIE: End of operation interrupt enable
.EQU  FLASH_CR_EOPIE                , 1 << 24
.EQU  FLASH_CR_ERRIE_N              , 25                     @ Bit 25 ERRIE: Error interrupt enable
.EQU  FLASH_CR_ERRIE                , 1 << 25
.EQU  FLASH_CR_LOCK_N               , 31                     @ Bit 31 LOCK: Lock
.EQU  FLASH_CR_LOCK                 , 1 << 31

@.ITEM     FLASH_OPTCR
.EQU  FLASH_OPTCR_Reset_Value       , 0x0FFFAAED             @ «начение регистра по умолчанию
.EQU  FLASH_OPTCR_OPTLOCK_N         , 0                      @ Bit 0 OPTLOCK: Option lock
.EQU  FLASH_OPTCR_OPTLOCK           , 1
.EQU  FLASH_OPTCR_OPTSTRT_N         , 1                      @ Bit 1 OPTSTRT: Option start
.EQU  FLASH_OPTCR_OPTSTRT           , 1 << 1
.EQU  FLASH_OPTCR_BOR_LEV_N         , 2                      @ Bits 3:2 BOR_LEV[1:0]: BOR reset Level
.EQU  FLASH_OPTCR_BOR_LEV_0         , 0                      @ BOR Level 3 (VBOR3), brownout threshold level 3
.EQU  FLASH_OPTCR_BOR_LEV_1         , 1 << 2                 @ 01: BOR Level 2 (VBOR2), brownout threshold level 2
.EQU  FLASH_OPTCR_BOR_LEV_2         , 2 << 2                 @ 10: BOR Level 1 (VBOR1), brownout threshold level 1
.EQU  FLASH_OPTCR_BOR_LEV_3         , 3 << 2                 @ 11: BOR off, POR/PDR reset threshold level is applied
.EQU  FLASH_OPTCR_USER_N            , 5                      @ Bits 7:5 USER[2:0]: User option bytes
.EQU  FLASH_OPTCR_USER_STDBY        , 1 << 7                 @ Bit 7: nRST_STDBY
.EQU  FLASH_OPTCR_USER_STOP         , 1 << 6                 @ Bit 6: nRST_STOP
.EQU  FLASH_OPTCR_USER_SW           , 1 << 5                 @ Bit 5: WDG_SW
.EQU  FLASH_OPTCR_RDP_N             , 8                      @ Bits 15:8 RDP[7:0]: Read protect
.EQU  FLASH_OPTCR_nWRP_N            , 16                     @ Bits 27:16 nWRP[11:0]: Not write protect

