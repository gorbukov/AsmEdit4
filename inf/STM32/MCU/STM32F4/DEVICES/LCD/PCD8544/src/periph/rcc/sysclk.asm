@.CHARSET CP1251
@GNU AS
@.desc name=SYSCLK168_START type=proc
@ ***************************************************************************
@ *                МОДУЛЬ  НАСТРОЙКИ  ТАКТИРОВАНИЯ  STM32F4                 *
@ ***************************************************************************
@ * Модуль настраивает систему тактирования микроконтроллера на внешний     *
@ * кварцевый генератор, с использованием PLL и установкой необходимых де-  *
@ * лителей для шин и интерфейсов, ошибки при исполнении фиксируются        *
@ * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
@ * Модуль вызывать без параметров, регистры не сохраняются                 *
@ * команда вызова:                                                         *
@ *           BL SYSCLK168_START                             *
@ * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
@ * Используемые регистры: R0, R1, R2, R3, R4, R6, R7 (не сохраняются)      *
@ *      На входе: нет                                                       *
@ *     На выходе: R0 - статус результата настройки тактирования            *
@ * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
@ * Статус результата:                                                      *
@ *                    0: Частота установлена                               *
@ *                    1: Не удалось запустить HSE                          *
@ *                    2: Не удалось запустить PLL                          *
@ *                    3: Не удалось переключиться на PLL                   *
@ ***************************************************************************
@ *                            НАСТРОЙКИ  МОДУЛЯ                            *
@ * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
@ *                   значения делителей и множителей                       *
@ *                                                                         *
@ * Формула расчета частоты PLL                                             *
@ *                                                                         *
@ *          PLL_VCO = ([HSE_VALUE or HSI_VALUE] / PLL_M) * PLL_N           *
@ *                                                                         *
@ * Упрощенно: делитель PLL_M должен делить частоту кварца таким образом    *
@ * чтобы на выходе получить 2 МГц. Для кварца 8 МГц: PLL_M = 4, для кварца *
@ * 16 МГц: PLL_M=8, и так далее. (стр.227 RM0090 Reference manual)         *
@
.equ PLL_M , 4
.equ PLL_N , 168
@ * Формула расчета частоты тактирования процессора (стандарт: 168 мгц):    *
@ *                                                                         *
@ *                     SYSCLK = PLL_VCO / PLL_P                            *
@
.equ PLL_P , 2
@ * Формула расчета тактовой частоты для USB (стандарт: 48 мгц):            *
@ *                                                                         *
@ *           USB OTG FS, SDIO and RNG Clock =  PLL_VCO / PLLQ              *
@
.equ PLL_Q , 7
@ * -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  *
@ * значение таймаута при операциях ожидания готовности (степень двойки)    *
@ * Этот параметр менять не обязательно, в случае критической ошибки при    *
@ * запуске тактирования - ошибка будет сгенерирована и возвращена в R0     *
@ * по умолчанию стоит значение: 12                                         *
.equ timeout, 12
@ ***************************************************************************
@.enddesc

@ -----------------------   Дальше настроек нет !!  -------------------------

.syntax unified          @ синтаксис исходного кода
.thumb               @ тип используемых инструкций Thumb
.cpu cortex-m4          @ процессор
.fpu fpv4-sp-d16     @ сопроцессор

.include "/src/inc/flash.inc"
.include "/src/inc/pwr.inc"
.include "/src/inc/rcc.inc"

@ константы используемые модулем
.equ RCC_CFGR_SW           ,0x00000003

@ значение для загрузки в RCC_PLLCFGR
.equ RCC_PLLCFGR_val, PLL_M|(PLL_N<<6)+(((PLL_P>>1)-1)<<16)+RCC_PLLCFGR_PLLSRC_HSE+(PLL_Q<<24)

@ ---------------------- Текст программы модуля ------------------------
.section .asmcode

.global SYSCLK168_START

SYSCLK168_START:
                PUSH    { LR }
                LDR     R7, =(PERIPH_BASE + RCC_BASE)

        @ Включаем HSE
                LDR     R1, [R7, RCC_CR]
                ORR     R1,  R1, RCC_CR_HSEON
                STR     R1, [R7, RCC_CR]

        @ Ожидаем стабилизации частоты кварца
                MOV     R0, 1                @ код ошибки при выходе по timeout
                ADD     R6,  R7, RCC_CR      @ регистр для проверки
                LDR     R2, =RCC_CR_HSERDY   @ бит для проверки
                BL      TST_BIT

        @ Включаем POWER control
                LDR     R1, [R7, RCC_APB1ENR]
                ORR     R1,  R1, RCC_APB1ENR_PWREN
                STR     R1, [R7, RCC_APB1ENR]

        @ Вн. регулятор в режим "нагрузкa" (выходим из энергосбережения)
                LDR     R1, =(PERIPH_BASE + PWR_BASE + PWR_CR)
                LDR     R2, [R1]
                ORR     R2,  R2, PWR_CR_VOS
                STR     R2, [R1]

     @ Установим делители шин
                LDR     R1, [R7, RCC_CFGR]             @ делитель шины AHB
                ORR     R1,  R1, RCC_CFGR_HPRE_DIV1    @ HCLK=SYSCLK
                STR     R1, [R7, RCC_CFGR]

                LDR     R1, [R7, RCC_CFGR]             @ делитель шины APB2
                ORR     R1,  R1, RCC_CFGR_PPRE2_DIV2   @ PCLK2=HCLK / 2
                STR     R1, [R7, RCC_CFGR]

                LDR     R1, [R7, RCC_CFGR]             @ делитель шины APB1
                ORR     R1,  R1, RCC_CFGR_PPRE1_DIV4   @ PCLK1=HCLK / 4
                STR     R1, [R7, RCC_CFGR]

        @ Настройка PLL коэффициентами PLL_M, PLL_N, PLL_Q, PLL_P
                LDR     R1, =RCC_PLLCFGR_val           @ расчитанное значение
                STR     R1, [R7, RCC_PLLCFGR]

        @ Включаем питание PLL
                LDR     R1, [R7, RCC_CR]
                ORR     R1,  R1, RCC_CR_PLLON
                STR     R1, [R7, RCC_CR]

        @ Ожидаем готовности PLL
                ADD     R0, R0, 1
                LDR     R2, =RCC_CR_PLLRDY
                BL      TST_BIT

        @ Настройка Flash prefetch, instruction cache, data cache и wait state
                LDR     R2, =(PERIPH_BASE + FLASH_R_BASE + FLASH_ACR)
                LDR     R1, [R2]
                LDR     R1, =(FLASH_ACR_ICEN + FLASH_ACR_DCEN + FLASH_ACR_LATENCY_5 + FLASH_ACR_PRFTEN)
                STR     R1, [R2]

        @ Выбираем PLL источником такта
                LDR     R1, [R7, RCC_CFGR]
                BIC     R1,  R1, RCC_CFGR_SW
                ORR     R1,  R1, RCC_CFGR_SW_PLL
                STR     R1, [R7, RCC_CFGR]

        @ Ожидаем переключения на PLL
                ADD     R0, R0, 1
                ADD     R6, R7, RCC_CFGR
                LDR     R2, =RCC_CFGR_SWS_PLL
          BL      TST_BIT

                MOV     R0, 0              @ признак успешности выполнения
                B       exit

@ Подпрограмма проверки готовности: ------------------------------------------
@     R0 - статус на выход
@     R1 - адрес для чтения
@     R2 - бит-карта для сравнения
@     R3 портиться !
@     R4 портиться !
TST_BIT:
                ADD     R3, R0, R0, lsl  timeout     @ значение timeout
TST_ready:
        @ проверка на таймаут
                SUBS    R3, R3, 1
                BEQ     exit                         @ timeout истек, выходим !

        @ проверка готовности HSE
                LDR     R4, [R6, 0]
                TST     R4,  R2
                BEQ     TST_ready
                BX      LR

        @ выход из процедуры
 exit:
                POP     { PC }
