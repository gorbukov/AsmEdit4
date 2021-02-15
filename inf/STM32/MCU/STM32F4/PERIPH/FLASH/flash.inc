@GNU AS
@.CharSet=CP1251 (Cyrillic)
@.desc type=module
@ +------------------------------------------------------------------+
@ |                        онстанты Flash control                    |
@ +------------------------------------------------------------------+
@.enddesc

.include "/src/inc/base.inc"

@ базовые константы микроконтроллера

@.item AHB1PERIPH_BASE
.equ FLASH_R_BASE               ,(AHB1PERIPH_BASE + 0x3C00)

@.item FLASH_R_BASE
.equ FLASH_ACR                  , 0x00 @ Flash access control register (FLASH_ACR)
.equ FLASH_KEYR                 , 0x04 @ Flash key register (FLASH_KEYR)
.equ FLASH_OPTKEYR              , 0x08 @ Flash option key register (FLASH_OPTKEYR)
.equ FLASH_SR                   , 0x0C @ Flash st atus re gister (FLASH_SR)
.equ FLASH_CR                   , 0x10 @ Flash control register (FLASH_CR)
.equ FLASH_OPTCR                , 0x14 @ Flash option control register (FLASH_OPTCR)

@.item FLASH_ACR
.equ FLASH_ACR_LATENCY_N        , 0 @ Bits 2:0 LATENCY[2:0]: These bits represent the ratio of the CPU clock period to the Flash memory access time.
.equ FLASH_ACR_LATENCY_0        , 0
.equ FLASH_ACR_LATENCY_1        , 1
.equ FLASH_ACR_LATENCY_2        , 2
.equ FLASH_ACR_LATENCY_3        , 3
.equ FLASH_ACR_LATENCY_4        , 4
.equ FLASH_ACR_LATENCY_5        , 5
.equ FLASH_ACR_LATENCY_6        , 6
.equ FLASH_ACR_LATENCY_7        , 7
.equ FLASH_ACR_PRFTEN_N         , 8 @ Bit 8 PRFTEN: Prefetch enable
.equ FLASH_ACR_PRFTEN           , 1<<8
.equ FLASH_ACR_ICEN_N           , 9 @ Bit 9 ICEN: Instruction cache enable
.equ FLASH_ACR_ICEN             , 1<<9
.equ FLASH_ACR_DCEN_N           , 10 @ Bit 10 DCEN: Data cache enable
.equ FLASH_ACR_DCEN             , 1<<10
.equ FLASH_ACR_ICRST_N          , 11 @ Bit 11 ICRST: Instruction cache reset
.equ FLASH_ACR_ICRST            , 1<<11
.equ FLASH_ACR_DCRST_N          , 12 @ Bit 12 DCRST: Data cache reset
.equ FLASH_ACR_DCRST            , 12

@.item FLASH_KEYR
.equ FLASH_KEYR_FKEYR_K1        ,  0x45670123 @ Key1
.equ FLASH_KEYR_FKEYR_K2        ,  0xCDEF89AB @ Key2

@.item FLASH_OPTKEYR
.equ FLASH_OPTKEYR_OPTKEYR_K1   ,  0x08192A3B @ OPTKEY1
.equ FLASH_OPTKEYR_OPTKEYR_K2   ,  0x4C5D6E7F @ OPTKEY2

@.item FLASH_SR
.equ FLASH_SR_EOP_N             , 0 @ Bit 0 EOP: End of operation
.equ FLASH_SR_EOP               , 1 @ Bit 0 EOP: End of operation
.equ FLASH_SR_OPERR_N           , 1 @ Bit 1 OPERR: Operation error
.equ FLASH_SR_OPERR             , 1<<1
.equ FLASH_SR_WRPERR_N          , 4 @ Bit 4 WRPERR: Write protection error
.equ FLASH_SR_WRPERR            , 1<<4
.equ FLASH_SR_PGAERR_N          , 5 @ Bit 5 PGAERR: Programming alignment error
.equ FLASH_SR_PGAERR            , 1<<5
.equ FLASH_SR_PGPERR_N          , 6 @ Bit 6 PGPERR: Programming parallelism error
.equ FLASH_SR_PGPERR            , 1<<6
.equ FLASH_SR_PGSERR_N          , 7 @ Bit 7 PGSERR: Programming sequence error
.equ FLASH_SR_PGSERR            , 1<<7
.equ FLASH_SR_BSY_N             , 16 @ Bit 16 BSY: Busy
.equ FLASH_SR_BSY               , 1<<16

@.item FLASH_CR
.equ FLASH_CR_Reset_Value       , 0x80000000 @ «начение регистра по умолчанию
.equ FLASH_CR_PG_N              , 0 @ Bit 0 PG: Programming
.equ FLASH_CR_PG                , 1
.equ FLASH_CR_SER_N             , 1 @ Bit 1 SER: Sector Erase
.equ FLASH_CR_SER               , 1<<1
.equ FLASH_CR_MER_N             , 2 @ Bit 2 MER: Mass Erase
.equ FLASH_CR_MER               , 1<<2
.equ FLASH_CR_SNB_N             , 3 @ Bits 6:3 SNB[3:0]: Sector number
.equ FLASH_CR_PSIZE_N           , 8 @ Bits 9:8 PSIZE[1:0]: Program size
.equ FLASH_CR_PSIZE_0           , 0 @ program x8
.equ FLASH_CR_PSIZE_1           , 1<<8 @ program x16
.equ FLASH_CR_PSIZE_2           , 2<<8 @ program x32
.equ FLASH_CR_PSIZE_3           , 3<<8 @ program x64
.equ FLASH_CR_STRT_N            , 16 @ Bit 16 STRT: Start
.equ FLASH_CR_STRT              , 1<<16
.equ FLASH_CR_EOPIE_N           , 24 @ Bit 24 EOPIE: End of operation interrupt enable
.equ FLASH_CR_EOPIE             , 1<<24
.equ FLASH_CR_ERRIE_N           , 25 @ Bit 25 ERRIE: Error interrupt enable
.equ FLASH_CR_ERRIE             , 1<<25
.equ FLASH_CR_LOCK_N            , 31 @ Bit 31 LOCK: Lock
.equ FLASH_CR_LOCK              , 1<<31

@.item FLASH_OPTCR
.equ FLASH_OPTCR_Reset_Value    , 0x0FFFAAED @ «начение регистра по умолчанию
.equ FLASH_OPTCR_OPTLOCK_N      , 0 @ Bit 0 OPTLOCK: Option lock
.equ FLASH_OPTCR_OPTLOCK        , 1
.equ FLASH_OPTCR_OPTSTRT_N      , 1 @ Bit 1 OPTSTRT: Option start
.equ FLASH_OPTCR_OPTSTRT        , 1<<1
.equ FLASH_OPTCR_BOR_LEV_N      , 2 @ Bits 3:2 BOR_LEV[1:0]: BOR reset Level
.equ FLASH_OPTCR_BOR_LEV_0      , 0    @ BOR Level 3 (VBOR3), brownout threshold level 3
.equ FLASH_OPTCR_BOR_LEV_1      , 1<<2 @ 01: BOR Level 2 (VBOR2), brownout threshold level 2
.equ FLASH_OPTCR_BOR_LEV_2      , 2<<2 @ 10: BOR Level 1 (VBOR1), brownout threshold level 1
.equ FLASH_OPTCR_BOR_LEV_3      , 3<<2 @ 11: BOR off, POR/PDR reset threshold level is applied
.equ FLASH_OPTCR_USER_N         , 5 @ Bits 7:5 USER[2:0]: User option bytes
.equ FLASH_OPTCR_USER_STDBY     , 1<<7 @ Bit 7: nRST_STDBY
.equ FLASH_OPTCR_USER_STOP      , 1<<6 @ Bit 6: nRST_STOP
.equ FLASH_OPTCR_USER_SW        , 1<<5 @ Bit 5: WDG_SW
.equ FLASH_OPTCR_RDP_N          , 8 @ Bits 15:8 RDP[7:0]: Read protect
.equ FLASH_OPTCR_nWRP_N         , 16 @ Bits 27:16 nWRP[11:0]: Not write protect

