From: yml@yml.com (Yermo M. Lamers)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Unresolved Symbols question lm_sensors 2.8.0/i2c 2.8.0/linux
Message-Id: <3F7E4191.9070700@yml.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F7B83FF.2060409@yml.com>
In-Reply-To: <3F7B83FF.2060409@yml.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[root@nbi_master root]# lsmod
Module                  Size  Used by    Not tainted
eeprom                  4688   0  (unused)
lm87                    7776   0  (unused)
i2c-proc                8084   0  [eeprom lm87]
i2c-piix4               4424   0  (unused)
dmi_scan                2148   0  [i2c-piix4]
i2c-core               20196   0  [eeprom lm87 i2c-proc i2c-piix4]
autofs                 13684   0  (autoclean) (unused)
e100                   62340   1
ipt_REJECT              3928   6  (autoclean)
iptable_filter          2412   1  (autoclean)
ip_tables              15864   2  [ipt_REJECT iptable_filter]
keybdev                 2976   0  (unused)
mousedev                5656   0  (unused)
hid                    22308   0  (unused)
input                   6208   0  [keybdev mousedev hid]
usb-ohci               22216   0  (unused)
usbcore                82592   1  [hid usb-ohci]
ext3                   73376   1
jbd                    56336   1  [ext3]
raid1                  16044   2
aic79xx               142084   4
sd_mod                 13452   8
scsi_mod              110488   2  [aic79xx sd_mod]

Another question.

this is a Dual PIII SuperMicro board. The P3TDLE.

lm_sensors (and i2c) 2.8.0. under Redhat 9.

[root@nbi_master root]# cat /proc/version
Linux version 2.4.20-8smp (bhcompile@porky.devel.redhat.com) (gcc 
version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 SMP Thu Mar 13 
17:45:54 EST 2003

Here is the output I'm getting from sensors:

[root@nbi_master root]# sensors
lm87-i2c-0-2e
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
2.5V:      +0.00 V  (min =  +2.36 V, max =  +2.63 V)   ALARM
Vccp1:     +1.43 V  (min =  +1.36 V, max =  +1.51 V)
3.3V:      +3.31 V  (min =  +3.12 V, max =  +3.47 V)
5V:        +5.13 V  (min =  +4.73 V, max =  +5.26 V)
12V:      +12.25 V  (min = +11.37 V, max = +12.62 V)
Vccp2:     +0.00 V  (min =  +1.36 V, max =  +1.51 V)   ALARM
fan1:     3308 RPM  (min = 3000 RPM, div = 2)
fan2:     3308 RPM  (min = 3000 RPM, div = 2)
temp1:       +34?C  (min =  +10?C, max =  +60?C)
CPU_Temp:    +36?C  (min =  +10?C, max =  +60?C)
vid:       +1.45 V

lm87-i2c-0-2e
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
2.5V:      +0.00 V  (min =  +2.36 V, max =  +2.63 V)   ALARM
Vccp1:     +1.43 V  (min =  +1.36 V, max =  +1.51 V)
3.3V:      +3.31 V  (min =  +3.12 V, max =  +3.47 V)
5V:        +5.13 V  (min =  +4.73 V, max =  +5.26 V)
12V:      +12.25 V  (min = +11.37 V, max = +12.62 V)
Vccp2:     +0.00 V  (min =  +1.36 V, max =  +1.51 V)   ALARM
fan1:     3308 RPM  (min = 3000 RPM, div = 2)
fan2:     3308 RPM  (min = 3000 RPM, div = 2)
temp1:       +34?C  (min =  +10?C, max =  +60?C)
CPU_Temp:    +36?C  (min =  +10?C, max =  +60?C)
vid:       +1.45 V

eeprom-i2c-0-50
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
Memory size (MB):       512

eeprom-i2c-0-51
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
Memory size (MB):       512

I'm assuming the duplicate entries at the top are what's mentioned in 
the FAQ, right?

My issue is that the second CPU Temparature is not showing up. From what 
I can tell temp1 is the case ambient temperature. Did I miss something 
in the configuration?

I'm assuming the voltage alarms are for things that are not hooked up, no?

The sensor itself seems to be working as evidenced by BIOS setup.

thanks,

-- Yermo


Other info:

[root@nbi_master root]# lsmod
Module                  Size  Used by    Not tainted
eeprom                  4688   0  (unused)
lm87                    7776   0  (unused)
i2c-proc                8084   0  [eeprom lm87]
i2c-piix4               4424   0  (unused)
dmi_scan                2148   0  [i2c-piix4]
i2c-core               20196   0  [eeprom lm87 i2c-proc i2c-piix4]
autofs                 13684   0  (autoclean) (unused)
e100                   62340   1
ipt_REJECT              3928   6  (autoclean)
iptable_filter          2412   1  (autoclean)
ip_tables              15864   2  [ipt_REJECT iptable_filter]
keybdev                 2976   0  (unused)
mousedev                5656   0  (unused)
hid                    22308   0  (unused)
input                   6208   0  [keybdev mousedev hid]
usb-ohci               22216   0  (unused)
usbcore                82592   1  [hid usb-ohci]
ext3                   73376   1
jbd                    56336   1  [ext3]
raid1                  16044   2
aic79xx               142084   4
sd_mod                 13452   8
scsi_mod              110488   2  [aic79xx sd_mod]

Mark M. Hoffman wrote:
> * Yermo M. Lamers <yml@yml.com> [2003-10-03 15:46:52 -0400]:
> 
> <snip>
> 
>>Here's what I get:
>>
>>[root@nbi_master lm_sensors-2.8.0]# make kernel/busses/dmi_scan.o
>>grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
> 
> 
> <snip>
> 
> This is the (RedHat specific) problem.  You need to copy the matching
> config from /usr/src/linux-2.4/configs/<blah> to /usr/src/linux-2.4/.config
> The missing file above is actually a link to...  ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Then start over.  Be sure to "make clean" in i2c and lm_sensors2 first.
> 
> Everyone else: why don't we simply fail compilation without this file?
> 
> Regards,
> 

-- 
---------------------------------------------------------------------
DTLink Software                                 http://www.dtlink.com
---------------------------------------------------------------------
