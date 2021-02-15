@.CharSet=CP1251 (Cyrillic)
@GNU AS


.include "/src/inc/base.inc"
@.item AHB1PERIPH_BASE
.equ CRC            , (AHB1PERIPH_BASE + 0x3000)

@.item CRC
.equ CRC_DR         , 0x00 		@ Data register (CRC_DR)
.equ CRC_IDR        , 0x04 		@ Independent data register (CRC_IDR)
.equ CRC_CR         , 0x08 		@ Control register (CRC_CR)

@.item CRC_IDR
.equ CRC_IDR_IDR_M  , 0x000000FF 	@ General-purpose 8-bit data register bits

@.item CRC_CR
.equ CRC_CR_RESET   , 0x01 		@ Resets the CRC calculation unit and sets the data register to 0xFFFF FFFF
