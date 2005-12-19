From: steve@hassard.net (Stephen Hassard)
Date: Mon, 19 Dec 2005 18:50:29 +0000
Subject: [lm-sensors] report: ATI IXP use via i2c-piix4
Message-Id: <43A700F5.4020606@hassard.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've got an MSI RS482M4-ILD motherboard that I've managed to get going 
with lm-sensors.

Hardware info page:
http://www.msicomputer.com/product/p_spec.asp?model=RS482M4-ILD&class=mb

I'm using kernel 2.6.15-rc6-ck1 w/ the patch from 
http://assembler.cz/download/ati2_patch

---

Dec 19 10:38:38 localhost sensord: sensord started
Dec 19 10:38:38 localhost sensord: Sensor alarm: Chip 
w83627thf-isa-0600: VCore: +1.15 V (min = +1.94 V, max = +1.94 V) [ALARM]
Dec 19 10:38:38 localhost sensord: Sensor alarm: Chip 
w83627thf-isa-0600: -12V: -12.28 V (min = -10.80 V, max = -13.18 V) [ALARM]
Dec 19 10:38:38 localhost sensord: Sensor alarm: Chip 
w83627thf-isa-0600: CPU Fan: 0 RPM (min = 1318 RPM, div = 8) [ALARM]
Dec 19 10:38:38 localhost sensord: Sensor alarm: Chip 
w83627thf-isa-0600: fan3: 0 RPM (min = 2343 RPM, div = 8) [ALARM]
Dec 19 10:38:38 localhost sensord: Sensor alarm: Chip 
w83627thf-isa-0600: alarms: Chassis intrusion detection [ALARM]
Dec 19 10:38:38 localhost sensord: Chip: w83627thf-isa-0600
Dec 19 10:38:38 localhost sensord: Adapter: ISA adapter
Dec 19 10:38:38 localhost sensord: Algorithm: ISA algorithm
Dec 19 10:38:38 localhost sensord:   VCore: +1.15 V (min = +1.94 V, max 
= +1.94 V) [ALARM]
Dec 19 10:38:38 localhost sensord:   +12V: +12.89 V (min = +10.82 V, max 
= +13.19 V)
Dec 19 10:38:38 localhost sensord:   +3.3V: +3.20 V (min = +3.14 V, max 
= +3.47 V)
Dec 19 10:38:38 localhost sensord:   +5V: +5.04 V (min = +4.75 V, max = 
+5.25 V)
Dec 19 10:38:38 localhost sensord:   -12V: -12.28 V (min = -10.80 V, max 
= -13.18 V) [ALARM]
Dec 19 10:38:38 localhost sensord:   V5SB: +5.08 V (min = +4.76 V, max = 
+5.24 V)
Dec 19 10:38:38 localhost sensord:   VBat: +3.36 V (min = +2.40 V, max = 
+3.60 V)
Dec 19 10:38:38 localhost sensord:   fan1: 3245 RPM (min = 703 RPM, div 
= 8) (beep)
Dec 19 10:38:38 localhost sensord:   CPU Fan: 0 RPM (min = 1318 RPM, div 
= 8) [ALARM]
Dec 19 10:38:38 localhost sensord:   fan3: 0 RPM (min = 2343 RPM, div = 
8) [ALARM]
Dec 19 10:38:38 localhost sensord:   M/B Temp: 30 C (limit = 70 C, 
sensors = thermistor)
Dec 19 10:38:38 localhost sensord:   CPU Temp: 25.0 C (limit = 80 C, 
hysteresis = 75 C, sensor = thermistor)
Dec 19 10:38:38 localhost sensord:   temp3: -5.5 C (limit = 80 C, 
hysteresis = 75 C, sensor = PII/Celeron diode)
Dec 19 10:38:38 localhost sensord:   vid: +0.275 V
Dec 19 10:38:38 localhost sensord:   alarms: Chassis intrusion detection 
[ALARM]
Dec 19 10:38:38 localhost sensord:   beep_enable: Sound alarm enabled
Dec 19 10:38:38 localhost sensord: Chip: eeprom-i2c-0-51
Dec 19 10:38:38 localhost sensord: Adapter: SMBus PIIX4 adapter at 0b00
Dec 19 10:38:38 localhost sensord: Algorithm: Unavailable from sysfs
Dec 19 10:38:38 localhost sensord:   Memory type: DDR SDRAM DIMM SPD
Dec 19 10:38:38 localhost sensord:   Memory size (MB): Invalid 13 10 2 4
Dec 19 10:38:38 localhost sensord: Chip: eeprom-i2c-0-50
Dec 19 10:38:38 localhost sensord: Adapter: SMBus PIIX4 adapter at 0b00
Dec 19 10:38:38 localhost sensord: Algorithm: Unavailable from sysfs
Dec 19 10:38:38 localhost sensord:   Memory type: DDR SDRAM DIMM SPD
Dec 19 10:38:38 localhost sensord:   Memory size (MB): Invalid 13 10 2 4

