From: Etienne Buira <etienne.buira.lists@free.fr>
Date: Tue, 28 Jun 2011 19:46:43 +0000
Subject: [lm-sensors] Using Asus P5Q-E sensors/pwm
Message-Id: <20110628194643.GM21173@epicure.lazyet.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi all. Hope I'm not hitting the wrong place. Searched a bit the
archives/google, but nothing that I could get working.

I run an Asus P5Q-E, and try to get PWM working.

Currently, I can read temperatures and fan speeds using asus_atk0110
modules. Unfortunately, all files in /sys/class/hwmon/hwmon0 (excepted
uevent) and /sys/class/hwmon/hwmon0/device are read-only, and there is
no pwm* files.

Kernel is Gentoo's xen-sources-2.6.34-r4, running as dom0.
lm-sensors version is 3.2.0
BIOS have been updated to its latest version (v2101). I tried to enable
and disable PnP and ACPIv2, but no difference in either case.

When loading asus_atk0110, those lines are thrown in system log:
Jun 28 16:06:40 localhost kernel: ATK0110 ATK0110:00: adding...
Jun 28 16:06:40 localhost kernel: ATK0110 ATK0110:00: board ID = P5Q-Deluxe
(funny, the mobo case really says p5q-e)
Jun 28 16:06:40 localhost kernel: ATK0110 ATK0110:00: Using old hwmon interface
Jun 28 16:06:40 localhost kernel: ATK0110 ATK0110:00: voltage: 0x6020000 Vcore Voltage [800-1600] enabled
Jun 28 16:06:40 localhost kernel: ATK0110 ATK0110:00: voltage: 0x6020001  +3.3 Voltage [2970-3630] enabled
Jun 28 16:06:40 localhost kernel: ATK0110 ATK0110:00: voltage: 0x6020002  +5 Voltage [4500-5500] enabled
Jun 28 16:06:40 localhost kernel: ATK0110 ATK0110:00: voltage: 0x6020003  +12 Voltage [10200-13800] enabled
Jun 28 16:06:40 localhost kernel: ATK0110 ATK0110:00: temperature: 0x6030000 CPU Temperature [600-950] enabled
Jun 28 16:06:40 localhost kernel: ATK0110 ATK0110:00: temperature: 0x6030001 MB Temperature [450-950] enabled
Jun 28 16:06:40 localhost kernel: ATK0110 ATK0110:00: fan: 0x6040000 CPU FAN Speed [600-7200] enabled
Jun 28 16:06:40 localhost kernel: ATK0110 ATK0110:00: fan: 0x6040001 CHASSIS1 FAN Speed [600-7200] enabled
Jun 28 16:06:40 localhost kernel: ATK0110 ATK0110:00: fan: 0x6040002 CHASSIS2 FAN Speed [600-7200] enabled
Jun 28 16:06:40 localhost kernel: ATK0110 ATK0110:00: fan: 0x6040003 CHASSIS3 FAN Speed [600-7200] enabled
Jun 28 16:06:40 localhost kernel: ATK0110 ATK0110:00: fan: 0x6040004 POWER FAN Speed [600-7200] enabled
Jun 28 16:06:40 localhost kernel: ATK0110 ATK0110:00: registering hwmon device
Jun 28 16:06:40 localhost kernel: ATK0110 ATK0110:00: populating sysfs directory
Jun 28 16:06:40 localhost kernel: i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Jun 28 16:06:40 localhost kernel: ACPI: resource 0000:00:1f.3 [io  0x0400-0x041f] conflicts with ACPI region SMRG [mem 0x00000400-0x0000040f window disabled]
Jun 28 16:06:40 localhost kernel: ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver


And leads to sensors' output:
atk0110-acpi-0
Adapter: ACPI interface
Vcore Voltage:      +1.18 V  (min =  +0.80 V, max =  +1.60 V)
 +3.3 Voltage:      +3.34 V  (min =  +2.97 V, max =  +3.63 V)
 +5 Voltage:        +4.99 V  (min =  +4.50 V, max =  +5.50 V)
 +12 Voltage:      +12.04 V  (min = +10.20 V, max = +13.80 V)
CPU FAN Speed:     2909 RPM  (min =  600 RPM)
CHASSIS1 FAN Speed:1010 RPM  (min =  600 RPM)
CHASSIS2 FAN Speed:   0 RPM  (min =  600 RPM)
CHASSIS3 FAN Speed:   0 RPM  (min =  600 RPM)
POWER FAN Speed:      0 RPM  (min =  600 RPM)
CPU Temperature:    +37.5°C  (high = +60.0°C, crit = +95.0°C)  
MB Temperature:     +46.0°C  (high = +45.0°C, crit = +95.0°C)  

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +60.0°C  (high = +80.0°C, crit = +100.0°C)  

coretemp-isa-0001
Adapter: ISA adapter
Core 0:      +56.0°C  (high = +80.0°C, crit = +100.0°C)  

coretemp-isa-0002
Adapter: ISA adapter
Core 0:      +61.0°C  (high = +80.0°C, crit = +100.0°C)  

coretemp-isa-0003
Adapter: ISA adapter
Core 0:      +61.0°C  (high = +80.0°C, crit = +100.0°C)


Most intersting things in sensors-detect:
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found `Winbond W83667HG Super IO Sensors'                   Success!
    (address 0x290, driver `w83627ehf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
...
Driver `w83627ehf':
  * ISA bus, address 0x290
    Chip `Winbond W83667HG Super IO Sensors' (confidence: 9)
Driver `coretemp':
  * Chip `Intel Core family thermal sensor' (confidence: 9)

When I try to insmod w83627ehf (after rmmoding asus_atk0110):
Jun 28 16:23:33 localhost kernel: w83627ehf: Found W83667HG chip at 0x290
Jun 28 16:23:33 localhost kernel: ACPI: resource w83627ehf [io  0x0295-0x0296] conflicts with ACPI region HWRE [io  0x0290-0x0299 pref window disabled]
Jun 28 16:23:33 localhost kernel: ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
(didn't try the acpi_enforce_resources=lax, don't know the probability
of bad things to happen, but felt cold about it)

# lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation 4 Series Chipset DRAM Controller [8086:2e20] (rev 02)
00:01.0 PCI bridge [0604]: Intel Corporation 4 Series Chipset PCI Express Root Port [8086:2e21] (rev 02)
00:1a.0 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #4 [8086:3a37]
00:1a.1 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #5 [8086:3a38]
00:1a.2 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #6 [8086:3a39]
00:1a.7 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #2 [8086:3a3c]
00:1b.0 Audio device [0403]: Intel Corporation 82801JI (ICH10 Family) HD Audio Controller [8086:3a3e]
00:1c.0 PCI bridge [0604]: Intel Corporation 82801JI (ICH10 Family) PCI Express Root Port 1 [8086:3a40]
00:1c.4 PCI bridge [0604]: Intel Corporation 82801JI (ICH10 Family) PCI Express Root Port 5 [8086:3a48]
00:1c.5 PCI bridge [0604]: Intel Corporation 82801JI (ICH10 Family) PCI Express Root Port 6 [8086:3a4a]
00:1d.0 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #1 [8086:3a34]
00:1d.1 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #2 [8086:3a35]
00:1d.2 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #3 [8086:3a36]
00:1d.7 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #1 [8086:3a3a]
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge [8086:244e] (rev 90)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801JIR (ICH10R) LPC Interface Controller [8086:3a16]
00:1f.2 SATA controller [0106]: Intel Corporation 82801JI (ICH10 Family) SATA AHCI Controller [8086:3a22]
00:1f.3 SMBus [0c05]: Intel Corporation 82801JI (ICH10 Family) SMBus Controller [8086:3a30]
01:00.0 VGA compatible controller [0300]: nVidia Corporation G98 [GeForce 8400 GS] [10de:06e4] (rev a1)
02:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd. 88E8056 PCI-E Gigabit Ethernet Controller [11ab:4364] (rev 12)
03:00.0 IDE interface [0101]: Marvell Technology Group Ltd. 88SE6121 SATA II Controller [11ab:6121] (rev b1)
05:02.0 Ethernet controller [0200]: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller [11ab:4320] (rev 14)
05:03.0 FireWire (IEEE 1394) [0c00]: Agere Systems FW322/323 [11c1:5811] (rev 70)

Is that possible to tweak fan speed by software?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
