From: steve@hassard.net (Stephen Hassard)
Date: Mon, 19 Dec 2005 19:22:26 +0000
Subject: [lm-sensors] report: ATI IXP use via i2c-piix4
Message-Id: <43A70872.1040408@hassard.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <43A700F5.4020606@hassard.net>
In-Reply-To: <43A700F5.4020606@hassard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Stephen Hassard wrote:
>> I've got an MSI RS482M4-ILD motherboard that I've managed to get going 
>> with lm-sensors.
> Will the sensors command produce correct result?

Sorry, I forgot to attach the sensors output:

---

sensors
w83627thf-isa-0600
Adapter: ISA adapter
VCore:     +1.16 V  (min =  +1.94 V, max =  +1.94 V)       ALARM
+12V:     +12.89 V  (min = +10.82 V, max = +13.19 V)
+3.3V:     +3.20 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.04 V  (min =  +4.75 V, max =  +5.25 V)
-12V:     -12.28 V  (min = -10.80 V, max = -13.18 V)       ALARM
V5SB:      +5.08 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +3.36 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     3245 RPM  (min =  703 RPM, div = 8)                     (beep)
CPU Fan:     0 RPM  (min = 1318 RPM, div = 8)              ALARM
fan3:        0 RPM  (min = 2343 RPM, div = 8)              ALARM
M/B Temp:    +30?C  (high =   +70?C)                     sensor = 
thermistor
CPU Temp:  +25.0?C  (high =   +80?C, hyst =   +75?C)   sensor = 
thermistor
temp3:      -6.5?C  (high =   +80?C, hyst =   +75?C)   sensor = diode
vid:      +0.275 V  (VRM Version 9.0)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
           Sound alarm enabled

eeprom-i2c-0-51
Adapter: SMBus PIIX4 adapter at 0b00
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-50
Adapter: SMBus PIIX4 adapter at 0b00
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

---

Thanks,
Steve Hassard

