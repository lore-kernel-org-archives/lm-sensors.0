From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sat, 31 May 2008 20:03:39 +0000
Subject: [lm-sensors] [Bug?] W83697: Broken readings for fan speed 10% of
Message-Id: <20080531220339.05dc83fd@neptune.home>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On a Commell LE-365 I get readings for fan speed that are broken about
10% of the time.
The board has a Winbond W83697 chip (I can't check the exact chip name
on the board as it's hidden by a heatsink, the photo from Commell, as
as well as the manual indicate a HG, the kenrel reports:
  [    3.572831] w83627hf: Found W83697HF chip at 0x290
  [    3.572831] WDT driver for the Winbond(TM) W83627HF/THF/HG Super I/O chip initialising.
  [    3.572831] w83627hf/thf/hg WDT: Watchdog already running. Resetting timeout to 60 sec
  [    3.572831] w83627hf/thf/hg WDT: initialized. timeout` sec (nowayout=0)
)

Below a sample (reformatted) output of
  while sleep 1; do
    date;
    cat /sys/class/hwmon/hwmon0/device/fan1_input;
  done
:
Sat May 31 21:11:23 CEST 2008    2070
Sat May 31 21:11:24 CEST 2008    2070
Sat May 31 21:11:25 CEST 2008    2070
Sat May 31 21:11:26 CEST 2008    2070
Sat May 31 21:11:27 CEST 2008    2070
Sat May 31 21:11:28 CEST 2008    2070
Sat May 31 21:11:29 CEST 2008    2057
Sat May 31 21:11:30 CEST 2008    2057
Sat May 31 21:11:31 CEST 2008    2070
Sat May 31 21:11:32 CEST 2008    2070
Sat May 31 21:11:33 CEST 2008      -1
Sat May 31 21:11:34 CEST 2008      -1
Sat May 31 21:11:35 CEST 2008      -1
Sat May 31 21:11:36 CEST 2008      -1
Sat May 31 21:11:37 CEST 2008    2057
Sat May 31 21:11:38 CEST 2008    2057
Sat May 31 21:11:39 CEST 2008    2057
Sat May 31 21:11:40 CEST 2008    2057
Sat May 31 21:11:41 CEST 2008    2070
Sat May 31 21:11:42 CEST 2008    2070
Sat May 31 21:11:43 CEST 2008    2070
Sat May 31 21:11:44 CEST 2008    2070
Sat May 31 21:11:45 CEST 2008    2057
Sat May 31 21:11:46 CEST 2008    2057
Sat May 31 21:11:47 CEST 2008      -1
Sat May 31 21:11:48 CEST 2008      -1
Sat May 31 21:11:49 CEST 2008    2070
Sat May 31 21:11:50 CEST 2008    2070
Sat May 31 21:11:51 CEST 2008    2057
Sat May 31 21:11:52 CEST 2008    2057
Sat May 31 21:11:53 CEST 2008    2057
Sat May 31 21:11:54 CEST 2008    2057
Sat May 31 21:11:55 CEST 2008    2057
Sat May 31 21:11:56 CEST 2008    2057
Sat May 31 21:11:58 CEST 2008    2057
Sat May 31 21:11:59 CEST 2008    2057
Sat May 31 21:12:00 CEST 2008    2070
Sat May 31 21:12:01 CEST 2008    2070
Sat May 31 21:12:02 CEST 2008    2057
Sat May 31 21:12:03 CEST 2008    2057
Sat May 31 21:12:04 CEST 2008    2083
Sat May 31 21:12:05 CEST 2008    2083
Sat May 31 21:12:06 CEST 2008    2057
Sat May 31 21:12:07 CEST 2008    2057
Sat May 31 21:12:08 CEST 2008    2070
Sat May 31 21:12:09 CEST 2008    2070
Sat May 31 21:12:10 CEST 2008    2070
Sat May 31 21:12:11 CEST 2008    2070
Sat May 31 21:12:12 CEST 2008  337500
Sat May 31 21:12:13 CEST 2008  337500
Sat May 31 21:12:14 CEST 2008  337500
Sat May 31 21:12:15 CEST 2008  337500
Sat May 31 21:12:16 CEST 2008  337500
Sat May 31 21:12:17 CEST 2008  337500
Sat May 31 21:12:18 CEST 2008    2070
Sat May 31 21:12:19 CEST 2008    2070
Sat May 31 21:12:20 CEST 2008    2070
Sat May 31 21:12:21 CEST 2008    2070
Sat May 31 21:12:22 CEST 2008    2070
Sat May 31 21:12:23 CEST 2008    2070
Sat May 31 21:12:24 CEST 2008    2070
Sat May 31 21:12:25 CEST 2008    2070
Sat May 31 21:12:26 CEST 2008    2057
Sat May 31 21:12:27 CEST 2008    2057
Sat May 31 21:12:28 CEST 2008    2070
Sat May 31 21:12:29 CEST 2008    2070
Sat May 31 21:12:30 CEST 2008    2070
Sat May 31 21:12:31 CEST 2008    2070
Sat May 31 21:12:32 CEST 2008      -1

The 337k RPM and -1 RPM do not make any sense.
I can't tell if this is a regression as I just started monitoring
a few sensor values (with older kernels I just did a few manual
checks but never noticed broken fan speeds)

In case there is more data I can provide, please ask.
As the board is not in production use I can easily try out patches.

Regards,
Bruno


I've configured the sensor chip with (lm_sensors-3.0.1)
  chip "w83697hf-*"
    label in0 "VCore"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"
    label in7 "V5SB"
    label in8 "VBat"

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
    compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

    set in0_min 0.844 * 0.95
    set in0_max 0.844 * 1.05

    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    set in8_min 3.0 * 0.80
    set in8_max 3.0 * 1.20

    set fan1_div 4
    set fan1_min 1000
    set fan2_min 0

Two sample outputs of sensors:
  w83697hf-isa-0290
  Adapter: ISA adapter
  VCore:       +0.83 V  (min =  +0.80 V, max =  +0.88 V)   
  +3.3V:       +3.28 V  (min =  +3.14 V, max =  +3.47 V)   
  +5V:         +5.00 V  (min =  +4.76 V, max =  +5.24 V)   
  +12V:        +7.90 V  (min = +10.82 V, max = +13.19 V)   ALARM
  -12V:        +1.95 V  (min =  -1.50 V, max = -11.13 V)   ALARM
  -5V:         +2.64 V  (min =  -4.65 V, max =  -5.95 V)   ALARM
  V5SB:        +5.48 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
  VBat:        +3.17 V  (min =  +2.40 V, max =  +3.60 V)   
  fan1:       337500 RPM  (min = 1328 RPM, div = 4)
  fan2:          0 RPM  (min =    0 RPM, div = 16)
  temp1:       +48.0 C  (high = +56.0 C, hyst = -77.0 C)  sensor   thermistor temp2:       +52.0 C  (high = +100.0 C, hyst = +95.0 C)
  sensor = thermistor beep_enable:enabled

  w83697hf-isa-0290
  Adapter: ISA adapter
  VCore:       +0.82 V  (min =  +0.80 V, max =  +0.88 V)   
  +3.3V:       +3.28 V  (min =  +3.14 V, max =  +3.47 V)   
  +5V:         +5.00 V  (min =  +4.76 V, max =  +5.24 V)   
  +12V:        +7.84 V  (min = +10.82 V, max = +13.19 V)   ALARM
  -12V:        +1.95 V  (min =  -1.50 V, max = -11.13 V)   ALARM
  -5V:         +2.64 V  (min =  -4.65 V, max =  -5.95 V)   ALARM
  V5SB:        +5.48 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
  VBat:        +3.17 V  (min =  +2.40 V, max =  +3.60 V)   
  fan1:       2083 RPM  (min = 1328 RPM, div = 4)
  fan2:          0 RPM  (min =    0 RPM, div = 16)
  temp1:       +47.0 C  (high = +56.0 C, hyst = -77.0 C)  sensor   thermistor temp2:       +52.0 C  (high = +100.0 C, hyst = +95.0 C)
  sensor = thermistor beep_enable:enabled

Note: I tried divisors 4, 16, 32, all with same final behavior.

Kernel config snipplet:
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_SENSORS_APPLESMC is not set

CONFIG_W83627HF_WDT=y
# CONFIG_W83697HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set

Kernel messages:
[    0.000000] Linux version 2.6.25.3 (bruno@venus) (gcc version 4.1.2 (Gentoo 4.1.2 p1.0.2)) #1 Mon May 12 19:57:16 CEST 2008
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003bee0000 (usable)
[    0.000000]  BIOS-e820: 000000003bee0000 - 000000003bee3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003bee3000 - 000000003bef0000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003bef0000 - 000000003bf00000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[    0.000000] 62MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
...
[    3.401878] i2c /dev entries driver
[    3.572831] w83627hf: Found W83697HF chip at 0x290
[    3.572831] WDT driver for the Winbond(TM) W83627HF/THF/HG Super I/O chip initialising.
[    3.572831] w83627hf/thf/hg WDT: Watchdog already running. Resetting timeout to 60 sec
[    3.572831] w83627hf/thf/hg WDT: initialized. timeout` sec (nowayout=0)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
