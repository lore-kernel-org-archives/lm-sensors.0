From: jrickman@myamigos.us
Date: Fri, 27 Nov 2009 03:56:40 +0000
Subject: [lm-sensors] Troubleshooting SCH5127 / DME1737
Message-Id: <3647.66.169.133.216.1259294200.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am trying to troubleshoot why the SCH5127 sensor inside my Acer H340 NAS
system is not reporting via "lm_sensors". The chip shows to be on the
supported devices list. The "dme1737" module is on the system. I now know
about the "coretemp" support for Intel Atom CPU coming in the 2.6.32
kernel. When I try to run "sensors -f" it tells me to run
"sensors-detect". When I run "sensors-detect" it sees the need to load the
"coretemp" and "dme-1737" modules, but neither module seems to load.

In a different system using a different sensor but an Atom CPU, I see the
"coretemp" module fail to load but the sensor module loads and works: I
see output in "sensors -f".

I have "dmesg" output available, if needed. I do not lee any loading
errors in "/var/log/messages" other than for "coretemp".

Here is some relevant output from my system. Some output will "wrap":

[root@acer-nas-01 ~]# uname -a
Linux acer-nas-01.my.home 2.6.31.5-127.fc12.x86_64 #1 SMP Sat Nov 7
21:11:14 EST 2009 x86_64 x86_64 x86_64 GNU/Linux

[root@acer-nas-01 ~]# yum list installed | grep sensor
lm_sensors.x86_64              3.1.1-4.fc12                      @loc-updates
lm_sensors-libs.x86_64         3.1.1-4.fc12                      @loc-updates

[root@acer-nas-01 ~]# ls
/lib/modules/2.6.31.5-127.fc12.x86_64/kernel/drivers/hwmon
abituguru3.ko  adm9240.ko       atxp1.ko     fscpos.ko     ibmpex.ko    
lm83.ko     max1619.ko     thmc50.ko       w83791d.ko
abituguru.ko   ads7828.ko       coretemp.ko  g760a.ko      it87.ko      
lm85.ko     max6650.ko     tmp401.ko       w83792d.ko
ad7414.ko      adt7462.ko       dme1737.ko   gl518sm.ko    k8temp.ko    
lm87.ko     pc87360.ko     via686a.ko      w83793.ko
ad7418.ko      adt7470.ko       ds1621.ko    gl520sm.ko    lis3lv02d.ko 
lm90.ko     pc87427.ko     via-cputemp.ko  w83l785ts.ko
adm1021.ko     adt7473.ko       f71805f.ko   hdaps.ko      lm63.ko      
lm92.ko     pcf8591.ko     vt1211.ko       w83l786ng.ko
adm1025.ko     adt7475.ko       f71882fg.ko  hp_accel.ko   lm75.ko      
lm93.ko     sis5595.ko     vt8231.ko
adm1026.ko     applesmc.ko      f75375s.ko   hwmon-vid.ko  lm77.ko      
lm95241.ko  smsc47b397.ko  w83627ehf.ko
adm1029.ko     asb100.ko        fscher.ko    i5k_amb.ko    lm78.ko      
ltc4215.ko  smsc47m192.ko  w83627hf.ko
adm1031.ko     asus_atk0110.ko  fschmd.ko    ibmaem.ko     lm80.ko      
ltc4245.ko  smsc47m1.ko    w83781d.ko

[root@acer-nas-01 ~]# sensors-detect
# sensors-detect revision 1.1
# System: Acer Aspire easyStore H340
# Board: Acer WG945GCM

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal and voltage sensors...                       No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found `SMSC SCH5127 Super IO'                               Success!
    (address 0x800, driver `dme1737')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):  ^H
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO):

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
Module i2c-dev loaded successfully.

Next adapter: SMBus I801 adapter at 18a0 (i2c-0)
Do you want to scan it? (yes/NO/selectively):

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp':
  * Chip `Intel Core family thermal sensor' (confidence: 9)

Driver `dme1737':
  * ISA bus, address 0x800
    Chip `SMSC SCH5127 Super IO' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
Starting lm_sensors: loading module coretemp dme1737 No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.
[FAILED]
Unloading i2c-dev... OK

[root@acer-nas-01 etc]# cat sysconfig/lm_sensors
# Generated by sensors-detect on Thu Nov 26 21:34:56 2009
# This file is sourced by /etc/init.d/lm_sensors and defines the modules to
# be loaded/unloaded.
#
# The format of this file is a shell script that simply defines variables:
# HWMON_MODULES for hardware monitoring driver modules, and optionally
# BUS_MODULES for any required bus driver module (for example for I2C or
SPI).

HWMON_MODULES="coretemp dme1737"

# For compatibility reasons, modules are also listed individually as
variables
#    MODULE_0, MODULE_1, MODULE_2, etc.
# You should use BUS_MODULES and HWMON_MODULES instead if possible.

MODULE_0=coretemp
MODULE_1=dme1737

[root@acer-nas-01 ~]# lsmod
Module                  Size  Used by
dme1737                40856  0
hwmon_vid               2896  1 dme1737
ipv6                  298864  18
p4_clockmod             6148  1
freq_table              4864  1 p4_clockmod
speedstep_lib           5712  1 p4_clockmod
dm_multipath           17304  0
rfkill                 20488  0
iTCO_wdt               13008  0
iTCO_vendor_support     3588  1 iTCO_wdt
wmi                     7280  0
i2c_i801               12800  0
sky2                   49172  0
serio_raw               6644  0
pata_acpi               5152  0
ata_generic             5924  0
usb_storage            60288  0
pata_marvell            4656  0
i915                  219952  0
drm_kms_helper         25360  1 i915
drm                   171168  2 i915,drm_kms_helper
i2c_algo_bit            6020  1 i915
i2c_core               28608  5 dme1737,i2c_i801,i915,drm,i2c_algo_bit
video                  23476  1 i915
output                  3360  1 video
[root@acer-nas-01 ~]#

[root@acer-nas-01 ~]# lspci
00:00.0 Host bridge: Intel Corporation 82945G/GZ/P/PL Memory Controller
Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82945G/GZ Integrated
Graphics Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 01)
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 2 (rev 01)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 3 (rev 01)
00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 4 (rev 01)
00:1c.4 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI
Express Port 5 (rev 01)
00:1c.5 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI
Express Port 6 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
Controller #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
Controller #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
Controller #3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
Controller #4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC
Interface Bridge (rev 01)
00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family) SATA
AHCI Controller (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
(rev 01)
09:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8071 PCI-E
Gigabit Ethernet Controller (rev 16)
0a:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6121 SATA II
Controller (rev b2)

[root@acer-nas-01 ~]# lspci -xx -s 00:1c
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 01)
00: 86 80 d0 27 04 04 10 00 01 00 04 06 08 00 81 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 f0 00 00 20
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 00 00

00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 2 (rev 01)
00: 86 80 d2 27 04 04 10 00 01 00 04 06 08 00 81 00
10: 00 00 00 00 00 00 00 00 00 04 04 00 f0 00 00 20
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 07 02 00 00

00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 3 (rev 01)
00: 86 80 d4 27 04 04 10 00 01 00 04 06 08 00 81 00
10: 00 00 00 00 00 00 00 00 00 06 06 00 f0 00 00 20
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 03 00 00

00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 4 (rev 01)
00: 86 80 d6 27 04 04 10 00 01 00 04 06 08 00 81 00
10: 00 00 00 00 00 00 00 00 00 08 08 00 f0 00 00 20
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 00 00

00:1c.4 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI
Express Port 5 (rev 01)
00: 86 80 e0 27 07 04 10 00 01 00 04 06 08 00 81 00
10: 00 00 00 00 00 00 00 00 00 09 09 00 20 20 00 00
20: 30 f0 30 f0 01 80 01 80 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 04 00

00:1c.5 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI
Express Port 6 (rev 01)
00: 86 80 e2 27 07 04 10 00 01 00 04 06 08 00 81 00
10: 00 00 00 00 00 00 00 00 00 0a 0a 00 30 30 00 00
20: 40 f0 40 f0 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 07 02 04 00

[root@acer-nas-01 ~]# lspci -xx -s 00:1f
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC
Interface Bridge (rev 01)
00: 86 80 b8 27 07 00 10 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 83 01
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00

00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family) SATA
AHCI Controller (rev 01)
00: 86 80 c1 27 07 04 b0 02 01 01 06 01 00 00 00 00
10: e9 18 00 00 dd 18 00 00 e1 18 00 00 d9 18 00 00
20: c1 18 00 00 00 04 2c f0 00 00 00 00 25 10 83 01
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 02 00 00

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
(rev 01)
00: 86 80 da 27 01 01 80 02 01 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 18 00 00 00 00 00 00 00 00 00 00 25 10 83 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00

[root@acer-nas-01 ~]# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-0060 : keyboard
0064-0064 : keyboard
0070-0071 : rtc0
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
03c0-03df : vga+
03f8-03ff : serial
04d0-04d1 : pnp 00:01
0800-087f : pnp 00:01
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-107f : pnp 00:01
    1000-1003 : ACPI PM1a_EVT_BLK
    1004-1005 : ACPI PM1a_CNT_BLK
    1008-100b : ACPI PM_TMR
    1010-1015 : ACPI CPU throttle
    1020-1020 : ACPI PM2_CNT_BLK
    1028-102f : ACPI GPE0_BLK
    1030-1033 : iTCO_wdt
    1060-107f : iTCO_wdt
1180-11bf : 0000:00:1f.0
  1180-11bf : pnp 00:01
1820-183f : 0000:00:1d.0
  1820-183f : uhci_hcd
1840-185f : 0000:00:1d.1
  1840-185f : uhci_hcd
1860-187f : 0000:00:1d.2
  1860-187f : uhci_hcd
1880-189f : 0000:00:1d.3
  1880-189f : uhci_hcd
18a0-18bf : 0000:00:1f.3
  18a0-18bf : i801_smbus
18c0-18cf : 0000:00:1f.2
  18c0-18cf : ahci
18d0-18d7 : 0000:00:02.0
18d8-18db : 0000:00:1f.2
  18d8-18db : ahci
18dc-18df : 0000:00:1f.2
  18dc-18df : ahci
18e0-18e7 : 0000:00:1f.2
  18e0-18e7 : ahci
18e8-18ef : 0000:00:1f.2
  18e8-18ef : ahci
2000-2fff : PCI Bus 0000:09
  2000-20ff : 0000:09:00.0
    2000-20ff : sky2
3000-3fff : PCI Bus 0000:0a
  3000-300f : 0000:0a:00.0
    3000-300f : pata_marvell
  3010-3013 : 0000:0a:00.0
    3010-3013 : pata_marvell
  3014-3017 : 0000:0a:00.0
    3014-3017 : pata_marvell
  3018-301f : 0000:0a:00.0
    3018-301f : pata_marvell
  3020-3027 : 0000:0a:00.0
    3020-3027 : pata_marvell
fe00-fe00 : pnp 00:01
[root@acer-nas-01 ~]#




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
