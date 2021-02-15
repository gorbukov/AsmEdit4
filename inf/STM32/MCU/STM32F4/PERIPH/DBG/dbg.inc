@GNU AS
@.CharSet =CP1251 ( Cyrillic )
@.desc     type=module
@ +------------------------------------------------------------------+
@ |                     Ѕазовые константы DBG                    |
@ +------------------------------------------------------------------+
@.enddesc

.include   "/src/inc/base.inc"

@.item     CORE
.equ  DBG_BASE           , CORE + 0x42000
.equ  DBG                , CORE_BASE + DBG_BASE    @Address: 0xE004 2000
@ Debug MCU registers base address

@.item     DBG_BASE DBG
.equ  DBGMCU_IDCODE      , 0x00    @ MCU device ID code
.equ  DBGMCU_CR          , 0x04    @ Debug MCU configuration register
.equ  DBGMCU_APB1_FZ     , 0x08    @ Debug MCU APB1 freeze regist
.equ  DBGMCU_APB2_FZ     , 0x0C    @ Debug MCU APB2 Freeze register
.equ  DBGMCU_ITM_LA      , 0xE0000FB0    @ITM lock access    Table 308. Main ITM registers
.equ  DBGMCU_ITM_TC      , 0xE0000E80    @ITM trace control
.equ  DBGMCU_ITM_TP      , 0xE0000E40    @ITM trace privilege
.equ  DBGMCU_ITM_TE      , 0xE0000E00    @ITM trace enable
.equ  DBGMCU_ITM_SP      , 0xE0000000    @Stimulus port registers 0-31
.equ  DBGMCU_ETM_LA      , 0xE0041FB0    @ ETM Lock Access 38.15.4 ETM configuration example
.equ  DBGMCU_ETM_C       , 0xE0041000    @ ETM Control
.equ  DBGMCU_ETM_S       , 0xE0041010    @ ETM Status
.equ  DBGMCU_ETM_TE      , 0xE0041008    @ ETM Trigger Event
.equ  DBGMCU_ETM_TEC     , 0xE004101C    @ETM Trace Enable Control
.equ  DBGMCU_ETM_TEE     , 0xE0041020    @ETM Trace Enable Event
.equ  DBGMCU_ETM_TSS     , 0xE0041024    @ETM Trace Start/Stop
.equ  DBGMCU_TPIU_CPS    , 0xE0040004    @ Current port size
.equ  DBGMCU_TPIU_SPP    , 0xE00400F0    @ Selected pin protocol
.equ  DBGMCU_TPIU_FFC    , 0xE0040304    @ Formatter and flush control,The resulting default value is 0x102
.equ  DBGMCU_TPIU_FFS    , 0xE0040300    @ Not used in CortexЃ-M4 with FPU, always read as 0x00000008


@.item     DBGMCU_IDCODE
.equ  DBGMCU_IDCODE_DEV_ID, 0x00000FFF    @ Bits 11:0 DEV_ID[11:0]: Device identifier (STM32F405xx/07xx and STM32F415xx/17xx)
.equ  DBGMCU_IDCODE_REV_ID, 0xFFFF0000    @Bits 31:16 REV_ID[15:0] Revision identifier                                          @This field indicates the revision of the device.                                          @STM32F405xx/07xx and STM32F415xx/17xx devices:

@.item     DBGMCU_CR
.equ  DBGMCU_CR_TRACE_MODE, 0x000000C0    @Bits 7:5 TRACE_MODE[1:0]
.equ  DBGMCU_CR_TRACE_MODE_N, 5
.equ  DBGMCU_CR_TRACE_MODE_1, 4 << 5    @TRACE_MODE=xx: TRACE pins not assigned (default state)
.equ  DBGMCU_CR_TRACE_MODE_0, 2 << 5    @ TRACE_MODE=00: TRACE_MODE=01: TRACE_MODE=10:  TRACE_MODE=11:
.equ  DBGMCU_CR_TRACE_IOEN, 1 << 5    @Bits 5 TRACE_IOEN: Trace pin assigment control
.equ  DBGMCU_CR_DBG_STANDBY, 0x00000004    @ Bit 2 DBG_STANDBY: Debug Standby mode
.equ  DBGMCU_CR_DBG_STOP , 0x00000002    @Bit 1 DBG_STOP: Debug Stop mode
.equ  DBGMCU_CR_DBG_SLEEP, 0x00000001    @Bit 0 DBG_SLEEP: Debug Sleep mode

@.item     DBGMCU_APB1_FZ
.equ  DBGMCU_APB1_FZ_DBG_CAN2_STOP, 1 << 26    @Bit 26 DBG_CAN2_STOP: Debug CAN2 stopped when Core is halted
.equ  DBGMCU_APB1_FZ_DBG_CAN1_STOP, 1 << 25    @Bit 25 DBG_CAN1_STOP: Debug CAN2 stopped when Core is halted
.equ  DBGMCU_APB1_FZ_DBG_I2C3_SMBUS_TIMEOUT, 1 << 23    @Bit 23 DBG_I2C3_SMBUS_TIMEOUT: SMBUS timeout mode stopped when Core is halted
.equ  DBGMCU_APB1_FZ_DBG_I2C2_SMBUS_TIMEOUT, 1 << 22    @ Bit 22 DBG_I2C2_SMBUS_TIMEOUT: SMBUS timeout mode stopped when Core is halted
.equ  DBGMCU_APB1_FZ_DBG_I2C1_SMBUS_TIMEOUT, 1 << 21    @ Bit 21 DBG_I2C1_SMBUS_TIMEOUT: SMBUS timeout mode stopped when Core is halted
.equ  DBGMCU_APB1_FZ_DBG_IWDG_STOP, 1 << 12    @Bit 12 DBG_IWDG_STOP: Debug independent watchdog stopped when core is halted
.equ  DBGMCU_APB1_FZ_DBG_WWDG_STOP, 1 << 11    @Bit 11 DBG_WWDG_STOP: Debug Window Watchdog stopped when Core is halted
.equ  DBGMCU_APB1_FZ_DBG_RTC_STOP, 1 << 10    @Bit 10 DBG_RTC_STOP: RTC stopped when Core is halted
.equ  DBGMCU_APB1_FZ_DBG_TIM14_STOP, 1 << 8    @Bits 8:0 DBG_TIMx_STOP: TIMx counter stopped when core is halted (x=2..7, 12..14)
.equ  DBGMCU_APB1_FZ_DBG_TIM13_STOP, 1 << 7
.equ  DBGMCU_APB1_FZ_DBG_TIM12_STOP, 1 << 6
.equ  DBGMCU_APB1_FZ_DBG_TIM7_STOP, 1 << 5
.equ  DBGMCU_APB1_FZ_DBG_TIM6_STOP, 1 << 4
.equ  DBGMCU_APB1_FZ_DBG_TIM5_STOP, 1 << 3
.equ  DBGMCU_APB1_FZ_DBG_TIM4_STOP, 1 << 2
.equ  DBGMCU_APB1_FZ_DBG_TIM3_STOP, 1 << 1
.equ  DBGMCU_APB1_FZ_DBG_TIM2_STOP, 1 << 0

@.item     DBGMCU_APB2_FZ
.equ  DBGMCU_APB2_FZ_DBG_TIM11_STOP, 1 << 18    @Bits 18:16 DBG_TIMx_STOP: TIMx counter stopped when core is halted (x=9..11)
.equ  DBGMCU_APB2_FZ_DBG_TIM10_STOP, 1 << 17
.equ  DBGMCU_APB2_FZ_DBG_TIM9_STOP, 1 << 16
.equ  DBGMCU_APB2_FZ_DBG_TIM8_STOP, 1 << 1    @Bit 1 DBG_TIM8_STOP: TIM8 counter stopped when core is halted
.equ  DBGMCU_APB2_FZ_DBG_TIM1_STOP, 1 << 0    @Bit 0 DBG_TIM1_STOP: TIM1 counter stopped when core is halted

@.item     DBGMCU_TPIU_CPS
.equ  DBGMCU_TPIU_CPS_M     ,0x0000000f   @Allows the trace port size to be selected:
.equ  DBGMCU_TPIU_CPS_0 , 1 << 0    @ Bit 0: Port size = 1,only 1 bit must be set. By default, the port size is one bit. (0x00000001)
.equ  DBGMCU_TPIU_CPS_1 , 1 << 1    @ Bit 1: Port size = 2
.equ  DBGMCU_TPIU_CPS_2 , 1 << 2    @ Bit 2: Port size = 3, not supportedBit 2: Port size = 3
.equ  DBGMCU_TPIU_CPS_3 , 1 << 3    @ Bit 3: Port size = 4

@.item     DBGMCU_TPIU_SPP
.equ  DBGMCU_TPIU_SPP_M  , 0x00000003    @Allows the Trace Port Protocol to be selected: Bit1:0=
.equ  DBGMCU_TPIU_SPP_N  , 0    @
.equ  DBGMCU_TPIU_SPP_00 , 0x00000000    @ 00: Sync Trace Port Mode
.equ  DBGMCU_TPIU_SPP_01 , 1 << 0    @ 01: Serial Wire Output - manchester (default value)
.equ  DBGMCU_TPIU_SPP_10 , 1 << 1    @ 10: Serial Wire Output - NRZ

@.item     DBGMCU_TPIU_FFC
.equ  DBGMCU_TPIU_FFC    , 0x00000102    @Write TPIU Formatter and Flush Control Register to 0x102 (default value)

.equ  DBGMCU_TPIU_FFC_8  , 1 << 8    @Bit 8 = TrigIn = always С1 to indicate that triggers are indicated
.equ  DBGMCU_TPIU_FFC_1  , 1 << 1    @Bit 1 = EnFCont. In Sync Trace mode (Select_Pin_Protocol register bit1:0=00)

