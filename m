From: emmanuel.fleury@labri.fr (Emmanuel Fleury)
Date: Sun, 15 Jan 2006 09:27:36 +0000
Subject: [lm-sensors] [Asus A8NE-FM/S] Unknown Chip
Message-Id: <43CA1588.8060906@labri.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I've an Asus A8NE-FM/S mother-board running a kernel 2.6.15. I have some
trouble to find the right hardware monitor chip in the list (the i2c-isa
bus is recognized fine). Here are some informations:

I've build-in the i2c-dev, i2c-isa and i2c-nforce2 drivers in the
kernel. I get two i2c busses (/dev/i2c-0 and /dev/i2c-1).

### Sensors-detect results ###

# sensors-detect revision 1.393 (2005/08/30 18:51:18)

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce4
SMBus (MCP)
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-nforce2' (say NO if built into your kernel)? (YES/no): no
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): no
 Well, you will know best. We will just hope you edited `/etc/modules.conf'
 for automatic loading of this module. If not,
 you won't be able to open any /dev/i2c-* file (unless youhave it built-in
 into your kernel)

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus nForce2 adapter at 4c40
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08

Next adapter: SMBus nForce2 adapter at 4c00
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x2e
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85 or LM96000'... Failed!
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... Failed!
Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'... Failed!
Probing for `Analog Devices ADT7467'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `National Semiconductor LM93'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Failed!
Probing for `Winbond W83791SD'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Winbond W83627EHF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Winbond W83L785TS-S'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `Analog Devices ADM1030'... Failed!
Probing for `Analog Devices ADM1031'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `Analog Devices ADM1028'... Failed!
Probing for `ITE IT8712F'... Failed!
Client found at address 0x30
Client found at address 0x31
Client at address 0x50 can not be probed - unload all client drivers first!
Client at address 0x51 can not be probed - unload all client drivers first!

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no):
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
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8712F'
  Trying address 0x0290... Failed!
Probing for `ITE IT8705F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x7701)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x7701)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x7701)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x77)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x77)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x77)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x77)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0x77)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0x77)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0x77)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0x77)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0x77)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0x77)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x77)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0x77)
Probing for `Nat. Semi. PC87591 Super IO'
  Failed! (0x77)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0x77)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0x77)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0x77)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0x77)
Probing for `Nat. Semi. PCPC87427 Super IO'
  Failed! (0x77)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x77)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x77)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x77)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0x77)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0x77)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0x77)
Probing for `SMSC 47M172 Super IO'
  Failed! (0x77)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0x77)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

 Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.
 See doc/FAQ, doc/lm_sensors-FAQ.html, or
 http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
 (FAQ #4.24.3) for further information.
 If you find out what chips are on your board, see
 http://secure.netroedge.com/~lm78/newdrivers.html for driver status.

### i2cdetect ###

odin:~# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX 2e XX
30: 30 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: UU UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX
odin:~# i2cdetect 1
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-1.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

### i2cdump ###

# i2cdump for (0,0x08), (0,0x30), (0,0x31), (1,0x08)

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

-----------------------------------------------------------------------
i2cdump for (0,0x2e)

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: c1 60 c5 c4 c3 80 1f 29 76 10 ff ff ff ff ff ff    ?`?????)v?......
30: 39 ff ff 00 00 00 00 00 00 00 00 00 00 00 5c 89    9.............\?
40: 05 90 40 00 00 ff 00 ff 00 ff 00 ff 00 ff 80 7f    ??@...........??
50: 81 7f 81 7f ff ff ff ff ff ff ff ff 42 42 62 0b    ????........BBb?
60: cb 0b 60 b0 39 ff 80 5a 46 46 64 64 64 44 40 00    ??`?9.?ZFFdddD at .
70: 39 ff ff 09 09 09 09 09 09 00 00 00 40 00 ec 18    9..??????... at .??
80: 7e a4 0e 00 30 60 dd d3 20 00 4d 4d 0b 0b 0c 00    ~??.0`?? .MM???.
90: 04 04 04 04 0c 0c 0c 5a f1 c8 00 00 ff 00 ff 00    ???????Z??......
a0: 00 00 0c 00 02 00 00 0b 0b fe ff fe ff ff ff ff    ..?.?..???.?....
b0: ff 00 00 00 00 00 28 28 0e 0e 2b 2b 00 00 00 00    ......((??++....
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

-----------------------------------------------------------------------
i2cdump for (0,0x50)

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0b 01 40 00 04 50 70 00 82 08 00 01    ??????@.?Pp.??.?
10: 0e 04 1c 01 02 20 c1 60 70 75 70 3c 28 3c 28 80    ????? ?`pup<(<(?
20: 60 60 40 40 00 00 00 00 00 37 41 28 28 50 00 01    ``@@.....7A((P.?
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10 af    ..............??
40: c1 00 00 00 00 00 00 00 45 36 34 44 36 34 33 30    ?.......E64D6430
50: 30 48 55 35 43 20 20 20 20 20 20 03 04 05 29 02    0HU5C      ???)?
60: 0b d1 13 00 00 00 00 00 00 00 00 00 00 00 00 00    ???.............
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

-----------------------------------------------------------------------
i2cdump for (0,0x51)

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0b 01 40 00 04 50 70 00 82 08 00 01    ??????@.?Pp.??.?
10: 0e 04 1c 01 02 20 c1 60 70 75 70 3c 28 3c 28 80    ????? ?`pup<(<(?
20: 60 60 40 40 00 00 00 00 00 37 41 28 28 50 00 01    ``@@.....7A((P.?
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10 af    ..............??
40: c1 00 00 00 00 00 00 00 45 36 34 44 36 34 33 30    ?.......E64D6430
50: 30 48 55 35 43 20 20 20 20 20 20 03 04 05 29 02    0HU5C      ???)?
60: 0b d1 15 00 00 00 00 00 00 00 00 00 00 00 00 00    ???.............
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

Regards
-- 
Emmanuel Fleury

Out the 10Base-T, through the router, down the T1, over the leased
line, off the bridge, past the firewall...nothing but Net.
  -- Tony Miller

