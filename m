From: kress@hal.saar.de (Michael Kress)
Date: Mon, 09 Oct 2006 18:03:58 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <452A8F0E.6080407@hal.saar.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
> Well hopefully this new version of the driver will just work. However,
> be aware that, contrary to the previous version, I couldn't give a try
> to this one, so you're the first tester. This means there could be a
> couple sharp edges left, please let me know if you notice anything
> wrong.
>
> The changes are essentially in the way the driver is registered, so
> basically, if you are able to load, unload and reload the driver, and
> everything still works, it's a good sign that the conversion is a
> success. You should also see the reserved I/O region in /proc/ioports
> as "pc87427 FMC".
>
> Please give it a try and report!
>  =20

I tried it - i.e. I replaced pc87427.c in a copy of the directory
containing the old pc87427.c
But I regret to report a failure. I try to document the relevant things...

(SENSORS-DETECT)
# sensors-detect revision 4196 (2006-10-06 11:27:56 +0200)
...
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801EB ICH5

We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
FATAL: Module i2c_i801 not found.
Loading failed... skipping.
...
Found `Nat. Semi. PC87427 Super IO Fan Sensors'             Success!
    (address 0x840, driver `pc87427')
Found `Nat. Semi. PC87427 Super IO Health Sensors'          Success!
    (address 0x880, driver `to-be-written')
...
Driver `pc87427' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0840 (Busdriver `i2c-isa')
    Chip `Nat. Semi. PC87427 Super IO Fan Sensors' (confidence: 9)

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0880 (Busdriver `i2c-isa')
    Chip `Nat. Semi. PC87427 Super IO Health Sensors' (confidence: 9)
...
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# Chip drivers
modprobe pc87427
# no driver for Nat. Semi. PC87427 Super IO Health Sensors yet
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----
...
(MK tries it)
[root at matrix PC87427-platform-driver]# modprobe i2c-isa
[root at matrix PC87427-platform-driver]# modprobe pc87427
[root at matrix PC87427-platform-driver]# /usr/local/bin/sensors -s #
recommended
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.
...
(MK)
Nothing happens yet in syslog or dmesg
As soon as I execute 'sensors' with the config below, I'll reveice these
lines in dmesg:
(DMESG)
pc87427: readall_fan: data=FFff88003d5e2a40, nr=3D0
pc87427: readall_fan: data=FFff88003d5e2a40, nr=3D1
pc87427: readall_fan: data=FFff88003d5e2a40, nr=3D2
pc87427: readall_fan: data=FFff88003d5e2a40, nr=3D3
pc87427: readall_fan: data=FFff88003d5e2a40, nr=3D4
pc87427: readall_fan: data=FFff88003d5e2a40, nr=3D5
pc87427: readall_fan: data=FFff88003d5e2a40, nr=3D6
pc87427: readall_fan: data=FFff88003d5e2a40, nr=3D7

(my /etc/sensors.conf:)
chip "pc87427-*"
   label fan1 "case-fan1"
   label fan2 "case-fan2"
   label fan3 "case-fan3"
   label fan4 "case-fan4"
   label fan5 "not-inst"
   label fan6 "CPU0-fan"
   label fan7 "not-inst"
   label fan8 "CPU1-fan"
   set fan1_min 2000
   set fan2_min 2000
   set fan3_min 2000
   set fan4_min 2000
   ignore fan5
   set fan6_min 2000
   ignore fan7
   set fan8_min 2000

(cat /proc/ioports)
[root at matrix PC87427-platform-driver]# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0840-085f : pc87427 FMC
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-107f : motherboard
    1000-1003 : PM1a_EVT_BLK
    1004-1005 : PM1a_CNT_BLK
    1008-100b : PM_TMR
    1020-1020 : PM2_CNT_BLK
    1028-102f : GPE0_BLK
1100-111f : 0000:00:1f.3
1180-11bf : 0000:00:1f.0
  1180-11bf : motherboard
1400-141f : 0000:00:1d.0
  1400-141f : uhci_hcd
1420-143f : 0000:00:1d.1
  1420-143f : uhci_hcd
1440-145f : 0000:00:1d.2
  1440-145f : uhci_hcd
1460-147f : 0000:00:1d.3
  1460-147f : uhci_hcd
14a0-14af : 0000:00:1f.1
  14a0-14a7 : ide0
  14a8-14af : ide1
2000-3fff : PCI Bus #02
  2000-2fff : PCI Bus #03
    2000-20ff : 0000:03:02.0
    2400-24ff : 0000:03:02.0
    2800-28ff : 0000:03:02.1
    2c00-2cff : 0000:03:02.1
  3000-3fff : PCI Bus #04
    3000-303f : 0000:04:01.0
      3000-303f : 3w-9xxx
    3040-307f : 0000:04:02.0
      3040-307f : e1000
    3080-30bf : 0000:04:02.1
      3080-30bf : e1000
4000-4fff : PCI Bus #07
  4000-40ff : 0000:07:01.0
fe00-fe00 : motherboard

(MK)
I hope, I didn't miss anything ...

By the way, I found that sensors-detect now detects a PC87360:
Found `Nat. Semi. PC87360 Super IO Fan Sensors'
    (but not activated)
If I try a 'modprobe pc87360' I get
FATAL: Error inserting pc87360
(/lib/modules/2.6.16-xen/kernel/drivers/hwmon/pc87360.ko): No such device
pc87360: Device 0x09 not activated
pc87360: No active logical device, module not inserted.

I don't know if it's somehow related. I think, it finds it at least
since the snapshot you published recently. It definitely didn't
recognize before.

Tell me if I can do / find out more for you...

Regards - Michael

--=20
Michael Kress, kress at hal.saar.de
http://www.michael-kress.de / http://kress.net
P E N G U I N S   A R E   C O O L


