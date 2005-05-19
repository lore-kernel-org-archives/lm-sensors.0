From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: problem with tyan s2720 board
Message-Id: <3E1B7D7A.6000403@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030107215456.B2BEC121124@global.com>
In-Reply-To: <20030107215456.B2BEC121124@global.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

try CVS which has super I/O detection and a new 83627hf isa driver.

Ramesh Ramakrishnan wrote:
> hi
> 
> i am having trouble in getting lm_sensor 2.7.0 working on tyan s2720 board with 
> linux kernel 2.4.19.
> 
> The s2720 onboard hardware monitoring devices include Winbond W83627HF,
> Winbond W83782d and two 'on Chip Xeon Thermal Sensor' at address 0x18 and 0x19.
> 
> the i2c-detect script suggest to load the following modules i2c-isa, i2c-i801, w83781d
> and eeprom. After loading the suggested modules on running the i2cdetect gives the 
> following output
> 
>   Installed I2C busses:
>     i2c-0       smbus           SMBus I801 adapter at ec80              Non-I2C SMBus adapter
>     i2c-1       dummy           ISA main adapter                        ISA bus algorithm
> 
> in the lm_sensor mailing list, found an advice to load the adm1021 module to get the 
> temperature from xeon processor. loaded the adm1021 module on bus 0,0x18.
> 
> running the sensors gives wrong temperature(-1) for adm1021. tried loading the module
> in both address 0x18 and 0x19.
> 
> one think i noticed is when i load the i2c-velleman (this module is loaded when during
> the sensors-detect script, though the script doesnt suggest to load this module) the i2cdetect
> shows up the following result. 
> 
> again loading the adm1021 on the i2c bus 2 results the same output(-1).
> 
>   Installed I2C busses:
>     i2c-0       smbus           SMBus I801 adapter at ec80              Non-I2C SMBus adapter
>     i2c-1       dummy           ISA main adapter                        ISA bus algorithm
>     i2c-2       i2c             Velleman K8000                          Bit-shift algorithm
> 
> any information is appreciated.
> 
> regards
> ramesh
> 
> 
> the output from i2cdetect
> -------------------------
> 
> w83782d-i2c-0-29
> Adapter: SMBus I801 adapter at ec80
> Algorithm: Non-I2C SMBus adapter
> VCore:     +1.47 V  (min =  +1.21 V, max =  +1.48 V)
> VCC_1.2:   +1.13 V  (min =  +1.21 V, max =  +1.48 V)       ALARM
> 3.3V:      +3.42 V  (min =  +2.97 V, max =  +3.63 V)
> +5V:       +5.07 V  (min =  +4.50 V, max =  +5.48 V)
> 12V:      +12.16 V  (min = +10.79 V, max = +13.11 V)
> VCC_2.5:   +2.54 V  (min =  +0.33 V, max =  +0.78 V)
> VCC_1.8:   +1.76 V  (min =  +0.70 V, max =  +1.02 V)
> V5SB:      +5.11 V  (min =  +4.50 V, max =  +5.48 V)
> VBat:      +3.24 V  (min =  +2.70 V, max =  +3.29 V)
> P1Fan:       0 RPM  (min =  895 RPM, div = 2)
> P2Fan:       0 RPM  (min =  895 RPM, div = 2)
> Fan3:        0 RPM  (min =  895 RPM, div = 2)
> VRM:         +74?C  (limit =  +60?C)                       sensor = thermistor   ALARM
> vid:      +1.350 V
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm disabled
> 
> w83627hf-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> Fan4:        0 RPM  (min = 1500 RPM, div = 2)
> Fan5:        0 RPM  (min = 1500 RPM, div = 2)
> Fan6:        0 RPM  (min = 1500 RPM, div = 2)
> vid:      +1.350 V
> alarms:
> beep_enable:
>           Sound alarm disabled
> 
> adm1021-i2c-0-18
> Adapter: SMBus I801 adapter at ec80
> Algorithm: Non-I2C SMBus adapter
> CPU0_Sub:     -1?C  (min =   -1?C, max =   -1?C)ALARM (LOW,HIGH)
> CPU0:         -1?C  (min =   -1?C, max =   -1?C)ALARM (N/A,LOW)
> die_code:  255
> 
> 
