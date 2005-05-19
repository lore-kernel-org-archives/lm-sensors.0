From: christophe.dr@free.fr (christophe)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <200502141545.03330.christophe.dr@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I already tried to file this report on the 
http://www2.lm-sensors.nu/~lm78/support.html
page but for some unknown reasons it doesn't seem to register my ticket.
Here is the ticket i wanted to submit to the database :


I have googled a lot and searched the database and FAQ(section 5.3) but i
found no answer to my problem. The adt7463 on my asus w1n laptop / mandrake
10.1 Official Edition is not detected in spite of all my efforts.

I found nothing consistent in the logs.

Interesting part of sensors-detect :
- ----------------------------
...
  We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Sorry, no PCI bus adapters found.

We will now try to load each adapter module in turn.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): YES
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): YES
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x8705)
Probing for `ITE 8705F Super IO Sensors'
  Success... but not activated
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x8705)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors? (YES/no): YES
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)

 Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.
 See doc/FAQ, doc/lm_sensors-FAQ.html, or
 http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
 (FAQ #4.24.3) for further information.
 If you find out what chips are on your board, see
 http://secure.netroedge.com/~lm78/newdrivers.html for driver status.
...
- ----------------------------

Actually i ran speedfan on windows XP and it finds a ADT7463 (it says ID $27)
on an smbus ($2E address). It also says ISA bus at $0290 and SMBUS at$0540
(intel 82801DB).

lsmod gives :
- ----------------------------
i2c-dev                 7808  0
i2c-i801                7184  0
i2c-core               18836  2 i2c-dev,i2c-i801
usbmouse                4480  0
tsdev                   6080  0
joydev                  8128  0
usbhid                 40448  0
fglrx                 234816  7
md5                     3840  1
ipv6                  224132  12
snd-seq-oss            30848  0
snd-seq-midi-event      6272  1 snd-seq-oss
snd-seq                50576  4 snd-seq-oss,snd-seq-midi-event
snd-pcm-oss            54568  0
snd-mixer-oss          18432  1 snd-pcm-oss
snd-intel8x0           29900  1
snd-ac97-codec         68304  1 snd-intel8x0
snd-pcm                87304  2 snd-pcm-oss,snd-intel8x0
snd-timer              21252  2 snd-seq,snd-pcm
snd-page-alloc          7944  2 snd-intel8x0,snd-pcm
gameport                3584  1 snd-intel8x0
snd-mpu401-uart         6144  1 snd-intel8x0
snd-rawmidi            20004  1 snd-mpu401-uart
snd-seq-device          6536  3 snd-seq-oss,snd-seq,snd-rawmidi
snd                    51844  14
snd-seq-oss,snd-seq-midi-event,snd-seq,snd-pcm-oss,snd-mixer-oss,snd-intel8x0,snd-ac97-codec,snd-pcm,snd-timer,snd-mpu401-uart,snd-rawmidi,snd-seq-device
soundcore               7136  1 snd
ipt_TOS                 2176  12
ipt_REJECT              5888  4
ipt_pkttype             1536  4
ipt_LOG                 5760  8
ipt_state               1664  17
ipt_multiport           1920  0
ipt_conntrack           2304  0
iptable_mangle          2304  1
ip_nat_irc              3696  0
ip_nat_tftp             3184  0
ip_nat_ftp              4336  0
iptable_nat            20780  3 ip_nat_irc,ip_nat_tftp,ip_nat_ftp
ip_conntrack_irc       70576  1 ip_nat_irc
ip_conntrack_tftp       3248  0
ip_conntrack_ftp       71344  1 ip_nat_ftp
ip_conntrack           27944  9
ipt_state,ipt_conntrack,ip_nat_irc,ip_nat_tftp,ip_nat_ftp,iptable_nat,ip_conntrack_irc,ip_conntrack_tftp,ip_conntrack_ftp
iptable_filter          2304  1
ip_tables              14592  10
ipt_TOS,ipt_REJECT,ipt_pkttype,ipt_LOG,ipt_state,ipt_multiport,ipt_conntrack,iptable_mangle,iptable_nat,iptable_filter
af_packet              15880  6
ds                     17412  4
yenta_socket           18432  0
pcmcia_core            58564  2 ds,yenta_socket
eth1394                16904  0
sk98lin               159912  1
ide-cd                 36512  0
cdrom                  36764  1 ide-cd
ohci1394               30340  0
ieee1394              289464  2 eth1394,ohci1394
loop                   12424  0
ntfs                  145820  2
nls_utf8                1792  3
nls_cp437               5632  1
vfat                   11136  1
fat                    39360  1 vfat
intel-agp              19360  1
agpgart                27176  2 intel-agp
nvram                   6920  0
evdev                   7808  1
pcspkr                  3304  0
ehci-hcd               25604  0
uhci-hcd               27792  0
usbcore               100580  6 usbmouse,usbhid,ehci-hcd,uhci-hcd
thermal                15240  0
tc1100-wmi              6916  0
processor              21160  1 thermal
fan                     4100  0
button                  6416  0
battery                 9732  0
asus_acpi               9360  0
ac                      4740  0
ext3                  117352  1
jbd                    47512  1 ext3
- ----------------------------

lspci gives :
- ----------------------------
00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 21)
00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 21)
00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB
UHCI Controller #1 (rev 03)
00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB
UHCI Controller #2 (rev 03)
00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB
UHCI Controller #3 (rev 03)
00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI
Controller (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 83)
00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage
Controller (rev 03)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem
Controller (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility Radeon
9600 M10]
02:00.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit
Ethernet 10/100/1000Base-T Adapter (rev 13)
02:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
02:01.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
02:01.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev
04)
02:02.0 Multimedia controller: Philips Semiconductors SAA7133 Audio+video
broadcast decoder (rev f0)
02:03.0 Network controller: Intel Corp. PRO/Wireless 2200BG (rev 05)
- ----------------------------

lspci -n gives :
- ----------------------------
00:00.0 Class 0600: 8086:3340 (rev 21)
00:01.0 Class 0604: 8086:3341 (rev 21)
00:1d.0 Class 0c03: 8086:24c2 (rev 03)
00:1d.1 Class 0c03: 8086:24c4 (rev 03)
00:1d.2 Class 0c03: 8086:24c7 (rev 03)
00:1d.7 Class 0c03: 8086:24cd (rev 03)
00:1e.0 Class 0604: 8086:2448 (rev 83)
00:1f.0 Class 0601: 8086:24cc (rev 03)
00:1f.1 Class 0101: 8086:24ca (rev 03)
00:1f.5 Class 0401: 8086:24c5 (rev 03)
00:1f.6 Class 0703: 8086:24c6 (rev 03)
01:00.0 Class 0300: 1002:4e50
02:00.0 Class 0200: 11ab:4320 (rev 13)
02:01.0 Class 0607: 1180:0476 (rev ac)
02:01.1 Class 0607: 1180:0476 (rev ac)
02:01.2 Class 0c00: 1180:0552 (rev 04)
02:02.0 Class 0480: 1131:7133 (rev f0)
02:03.0 Class 0280: 8086:4220 (rev 05)
- ----------------------------

I tried to insert manually various modules like i2c-i801, i2c-i810,
i2c-sensor, i2c-piix4, i2c-isa....
I also tried to insert the lm85 module corresponding to the adt7463 sensor
chip. I tried many different parameters, but i don't know how to pass a
correct parameter described as :
"List of adapter,address pairs which are unquestionably assumed to contain a
`adt7463' chip"
in this document :
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/lm85

I suppose the problem is that there is no bus to reach the sensor. (SMBus ?
i2c ? Isa ???). But i have no clue on how to solve this.

i2cdetect gives nothing. i2cdump gives nothing.

isadump gives only zeros.

I can't read what's on the chip because it's a laptop and i would lose
warranty if i open it.

I don't know motherboard type but lspci above will tell you.

Sensor version is 2.8.7

Kernel version is 2.6.8.1

I need this lm_sensor to lower the fan speed in order to have more battery
time.

Thank you
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCELlnoBxdxgioZBIRAmdQAJwIfFHGG1YNcyIEIItbXzcKpmgNbwCgjQyp
fkMzt/BRxmgeCpWphRbLTHwFua
-----END PGP SIGNATURE-----
