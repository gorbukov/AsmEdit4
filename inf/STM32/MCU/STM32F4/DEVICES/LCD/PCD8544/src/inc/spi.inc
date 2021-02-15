@.CharSet CP1251
@GNU AS

.include "/src/inc/base.inc"

@.item APB2PERIPH_BASE
.equ SPI                           , (APB2PERIPH_BASE + 0x3000)

@.item SPI
.equ SPI1_BASE                     , (APB2PERIPH_BASE + 0x3000)
.equ SPI2_BASE                     , (APB1PERIPH_BASE + 0x3800)
.equ SPI3_BASE                     , (APB1PERIPH_BASE + 0x3C00)
.equ SPI4_BASE                     , (APB2PERIPH_BASE + 0x3400)
.equ SPI5_BASE                     , (APB2PERIPH_BASE + 0x5000)
.equ SPI6_BASE                     , (APB2PERIPH_BASE + 0x5400)
.equ SPI1                          , PERIPH_BASE+SPI1_BASE
.equ SPI2                          , PERIPH_BASE+SPI2_BASE
.equ SPI3                          , PERIPH_BASE+SPI3_BASE
.equ SPI4                          , PERIPH_BASE+SPI4_BASE
.equ SPI5                          , PERIPH_BASE+SPI5_BASE
.equ SPI6                          , PERIPH_BASE+SPI6_BASE


@.item SPI1_BASE SPI2_BASE SPI3_BASE SPI4_BASE SPI5_BASE SPI6_BASE
.equ SPI_CR1                       , 0x00   @ SPI control register 1 (SPI_CR1)
.equ SPI_CR2                       , 0x04   @ SPI control register 2 (SPI_CR2)
.equ SPI_SR                        , 0x08   @ SPI status register (SPI_SR)
.equ SPI_DR                        , 0x0C   @ SPI data register (SPI_DR)
.equ SPI_CRCPR                     , 0x10   @ SPI CRC polynomial register (SPI_CRCPR)
.equ SPI_SPI_RXCRCR                , 0x14   @ SPI RX CRC register (SPI_RXCRCR)
.equ SPI_SPI_TXCRCR                , 0x18   @ SPI TX CRC register (SPI_TXCRCR)

@.item SPI_CR1
.equ SPI_CR1_CPHA                  , 0x0001
.equ SPI_CR1_CPOL                  , 0x0002
.equ SPI_CR1_MSTR                  , 0x0004
.equ SPI_CR1_BR_DIV_2              , 0x00<<3 @ Bits 5:3 BR[2:0]: Baud rate control
.equ SPI_CR1_BR_DIV_4              , 0x01<<3
.equ SPI_CR1_BR_DIV_8              , 0x02<<3
.equ SPI_CR1_BR_DIV_16             , 0x03<<3
.equ SPI_CR1_BR_DIV_32             , 0x04<<3
.equ SPI_CR1_BR_DIV_64             , 0x05<<3
.equ SPI_CR1_BR_DIV_128            , 0x06<<3
.equ SPI_CR1_BR_DIV_256            , 0x07<<3
.equ SPI_CR1_SPE                   , 0x0040
.equ SPI_CR1_LSBFIRST_LSB          , 0x0080
.equ SPI_CR1_SSI                   , 0x0100
.equ SPI_CR1_SSM                   , 0x0200
.equ SPI_CR1_RXONLY_OUT_DISABLED   , 0x0400
.equ SPI_CR1_DFF_16BIT             , 0x0800
.equ SPI_CR1_CRCNEXT_NEXT          , 0x1000
.equ SPI_CR1_CRCEN_ENABLED         , 0x2000
.equ SPI_CR1_BIDIOE                , 0x4000
.equ SPI_CR1_BIDIMODE              , 0x8000


@.item SPI_CR2
.equ  SPI_CR2_RXDMAEN              , 0x01 @ Bit 0 RXDMAEN: Rx buffer DMA enable
.equ  SPI_CR2_TXDMAEN              , 0x02 @ Bit 1 TXDMAEN: Tx buffer DMA enable
.equ  SPI_CR2_SSOE                 , 0x04 @ Bit 2 SSOE: SS output enable
.equ  SPI_CR2_FRF                  , 0x10 @ Bit 4 FRF: Frame format
.equ  SPI_CR2_ERRIE                , 0x20 @ Bit 5 ERRIE: Error interrupt enabled
.equ  SPI_CR2_RXNEIE               , 0x40 @ Bit 6 RXNEIE: RX buffer not empty interrupt enable
.equ  SPI_CR2_RXNEIE               , 0x40
.equ  SPI_CR2_TXEIE                , 0x80 @ Bit 7 TXEIE: Tx buffer empty interrupt enable
.equ  SPI_CR2_TXEIE                , 0x80


@.item SPI_SR
.equ  SPI_SR_RXNE_FULL             , 0x01
.equ  SPI_SR_TXE                   , 0x02
.equ  SPI_SR_CHSIDE_RIGHT          , 0x04
.equ  SPI_SR_UDR_OCCURED           , 0x08
.equ  SPI_SR_CRCERR_NOT_MATCH      , 0x10
.equ  SPI_SR_MODF_OCCURED          , 0x20
.equ  SPI_SR_OVR_OCCURED           , 0x40
.equ  SPI_SR_BSY                   , 0x80
.equ  SPI_SR_FRE_OCCURED           , 0x0100

@ маппинг SPI 1
@+------+--------+-------+-------+--------+--------+
@|          AF5  |  NSS  |  SCK  |  MISO  |  MOSI  |
@+---------------+-------+-------+--------+--------+
@| GPIOA         |  PA4  |  PA5  |  PA6   |  PA7   |
@|               |  PA15 |       |        |        |
@+---------------+-------+-------+--------+--------+
@| GPIOB         |       |  PB3  |  PB4   |  PB5   |
@+---------------+-------+-------+--------+--------+

@ маппинг SPI 2
@+------+--------+-------+-------+--------+--------+
@|          AF5  |  NSS  |  SCK  |  MISO  |  MOSI  |
@+---------------+-------+-------+--------+--------+
@| GPIOB         |  PB9  |  PB10 |  PB14  |  PB15  |
@|               |  PB12 |  PB13 |        |        |
@+---------------+-------+-------+--------+--------+
@| GPIOC         |       |       |  PC2   |  PC3   |
@+---------------+-------+-------+--------+--------+
@| GPIOI         |  PI0  |  PI1  |  PI2   |  PI3   |
@+---------------+-------+-------+--------+--------+


