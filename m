From: martin@berg.dk (Martin Berg)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Troubles making sensors work with ASUS motherboard
Message-Id: <3CB6C091.1040109@berg.dk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a problem making sensors to work with my Via chipset
When issuing 'modprobe via686a' after the rest of the relevant
modprobe's I get an error message indicating that I should use
the force_addr argument.
When "guessing" the correct address - this error message
disappears, but /proc/sys/dev/sensors/chips is empty resulting
in 'No sensors found!".
I have tried the addresses 0xd800, 0xd000 and 0xd400.
By an error I tried 0xd00 and now /proc/sys/dev/sensors/chips
did contain the via686a chip - but sensors came out with total
rubbish.

So in short my question is (assuming that it is not an other
error): how do I determine the correct address for modprobe
via686a ?

************
INFORMATION:
************
These modprobes work:
modprobe i2c-core
modprobe i2c-isa
modprobe i2c-dev
modprobe i2c-proc
modprobe i2c-viapro

But when issuing
modprobe via686a

I get following messages:
/lib/modules/2.4.16-4GB/kernel/drivers/sensors/via686a.o:
   init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters
/lib/modules/2.4.16-4GB/kernel/drivers/sensors/via686a.o:
  insmod /lib/modules/2.4.16-4GB/kernel/drivers/sensors/via686a.o failed
/lib/modules/2.4.16-4GB/misc/via686a.o:
   init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters
/lib/modules/2.4.16-4GB/misc/via686a.o:
  insmod /lib/modules/2.4.16-4GB/misc/via686a.o failed
/lib/modules/2.4.16-4GB/misc/via686a.o: insmod via686a failed


**************
dmesg content:
**************

i2c-core.o: i2c core module version 2.6.2 (20011118)
i2c-isa.o version 2.6.2 (20011118)
i2c-core.o: adapter ISA main adapter registered as adapter 0.
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-dev.o: i2c /dev entries driver module version 2.6.2 (20011118)
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-dev.o: Registered 'ISA main adapter' as minor 0
i2c-proc.o version 2.6.2 (20011118)
i2c-viapro.o version 2.6.2 (20011118)
i2c-viapro.o: Found Via VT82C686A/B device
i2c-dev.o: Registered 'SMBus Via Pro adapter at e800' as minor 1
i2c-core.o: adapter SMBus Via Pro adapter at e800 registered as adapter 1.
i2c-viapro.o: Via Pro SMBus detected and initialized
via686a.o version 2.6.2 (20011118)
via686a.o: base address not set - upgrade BIOS or use force_addr=0xaddr
via686a.o: No Via 686A sensors found.
via686a.o version 2.6.3 (20020322)
via686a.o: base address not set - upgrade BIOS or use force_addr=0xaddr
via686a.o: No Via 686A sensors found.

************
System info:
************

motherboard:
  ASUS CUV4X-E
chipset:
  VIA VT82C694X (North Bridge)
  VIA VT82C686B (South Bridge)
kernel:
  2.4.16 (kernel-source-2.4.16.SuSE-31)
sensors:
  2.6.3
Bios:
  1005 (newest release from ASUS)

***************
sensors-detect:
***************

Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:04.4: VIA Technologies VT82C686 
Apollo ACPI
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

Next adapter: SMBus Via Pro adapter at e800 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x00
.
Client found at address 0x2d
Probing for `Winbond W83782D'... Success!
    (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
Client found at address 0x2f
.
Client found at address 0x48
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x49
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')

 this.  Do you want to scan the ISA bus? (YES/no):
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Success!
    (confidence 9, driver `via686a')

Driver `w83781d' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x2d (and 0x48 0x49)
    Chip `Winbond W83782D' (confidence: 8)

Driver `pcf8591' (may not be inserted):
  Misdetects:
  * Bus `SMBus Via Pro adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x48
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus Via Pro adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x49
    Chip `Philips Semiconductors PCF8591' (confidence: 1)

Driver `lm75' (may not be inserted):
  Misdetects:
  * Bus `SMBus Via Pro adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x49
    Chip `National Semiconductor LM75' (confidence: 3)

Driver `via686a' (should be inserted):
  Detects correctly:
  * ISA bus, undetermined address (Busdriver `i2c-isa')
    Chip `VIA Technologies VT82C686 Integrated Sensors' (confidence: 9)

 I2C/SMBus (ISA/smbus)?
Use of uninitialized value in string eq at 
lm_sensors/lm_sensors-2.6.3/prog/detec
t/sensors-detect line 2519.
Use of uninitialized value in string eq at 
lm_sensors/lm_sensors-2.6.3/prog/detec
t/sensors-detect line 2531.

#----cut here----
# I2C adapter drivers
modprobe i2c-viapro
modprobe i2c-isa
# I2C chip drivers
modprobe w83781d
modprobe via686a
#----cut here----

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

Comment: modprobing w83781d results in sound being generated


******
lsmod:
******

i2c-viapro              3688   0  (unused)
i2c-proc                5888   0  (unused)
i2c-dev                 3520   0  (unused)
i2c-isa                 1220   0  (unused)
i2c-core               12352   0  [i2c-viapro i2c-proc i2c-dev i2c-isa]
snd-pcm-oss            18272   1  (autoclean)
snd-pcm-plugin         14480   0  (autoclean) [snd-pcm-oss]
snd-mixer-oss           4672   0  (autoclean) [snd-pcm-oss]
agpgart                29216   3  (autoclean)
NVdriver              946176  10  (autoclean)
.
.

*********
lspci -n:
*********

00:00.0 Class 0600: 1106:0691 (rev c4)
00:01.0 Class 0604: 1106:8598
00:04.0 Class 0601: 1106:0686 (rev 40)
00:04.1 Class 0101: 1106:0571 (rev 06)
00:04.2 Class 0c03: 1106:3038 (rev 16)
00:04.3 Class 0c03: 1106:3038 (rev 16)
00:04.4 Class 0600: 1106:3057 (rev 40)
00:05.0 Class 0401: 13f6:0111 (rev 10)
00:07.0 Class 0180: 105a:4d30 (rev 02)
00:09.0 Class 0200: 10ec:8139 (rev 10)
01:00.0 Class 0300: 10de:0201 (rev a3)

*********
lspci -v:
*********

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
        Subsystem: Asustek Computer, Inc.: Unknown device 80e7
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Flags: bus master, stepping, medium devsel, latency 32
        I/O ports at d800 [size]
        Capabilities: [c0] Power Management version 2

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d400 [size2]
        Capabilities: [80] Power Management version 2

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d000 [size2]
        Capabilities: [80] Power Management version 2

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev 40)
        Flags: medium devsel
        Capabilities: [68] Power Management version 2


************
i2cdetect 1:
************

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX 2f
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX 48 49 XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

***************
i2cdump 1 0x2d:
***************

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: bf c7 60 60 c7 d7 00 cd a7 f8 a5 ac 8c 68 54 f8    ??``??.??????hT?
10: a5 f8 a5 28 00 00 00 00 00 00 00 00 00 00 00 00    ???(............
20: 6c a1 de be c8 25 37 25 d7 ff ff 77 5d 77 5d e3    l????%7%?..w]w]?
30: b9 cd a7 ed 9d 40 05 49 22 00 00 00 81 00 00 00    ?????@?I"...?...
40: 01 92 00 ff 00 ff 00 57 2d 22 01 44 11 80 80 5c    ??.....W-"?D???\
50: ff ff 00 ff ff ff ff ff 31 8f 8f 0c e0 48 e2 3f    ........1????H??
60: 6d 9f e1 bd ca 24 37 25 d7 ff ff 77 5d 77 5d e3    m????$7%?..w]w]?
70: b9 cd a7 ed 9d 40 05 49 22 00 00 00 81 00 00 00    ?????@?I"...?...
80: be c7 5e 60 c7 d7 00 cd a7 f8 a5 ac 8c 68 54 f8    ??^`??.??????hT?
90: a5 f8 a5 28 00 00 00 00 00 00 00 00 00 00 00 00    ???(............
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................


***************
i2cdump 1 0x2f:
***************

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: 00 00 00 00 00 ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff    ................
f0: ff ff ff ff ff ff f8 10 ff ff ff ff ff ff ff ff    ......??........


***************
i2cdump 1 0x48:
***************

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff 00 79 7a ff ff ff ff ff ff ff ff ff ff ff ff    ..yz............
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 88 10 03 07 00 1f 2f 00 0a 0f ff ff ff ff ff ff    ????.?/.??......
90: 07 02 e2 e2 e2 ff ff ff ff ff ff ff ff ff ff e2    ?????..........?
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

***************
i2cdump 1 0x49:
***************

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 23 00 41 48 23 00 41 48 24 00 41 48 25 00 41 48    #.AH#.AH$.AH%.AH
10: 23 00 41 48 23 00 41 48 23 00 41 48 24 00 41 48    #.AH#.AH#.AH$.AH
20: 23 00 41 48 23 00 41 48 24 00 41 48 24 00 41 48    #.AH#.AH$.AH$.AH
30: 24 00 41 48 24 00 41 48 23 00 41 48 23 00 41 48    $.AH$.AH#.AH#.AH
40: 24 00 41 48 24 00 41 48 25 00 41 48 25 00 41 48    $.AH$.AH%.AH%.AH
50: 25 00 41 48 23 00 41 48 25 00 41 48 25 00 41 48    %.AH#.AH%.AH%.AH
60: 23 00 41 48 23 00 41 48 25 00 41 48 24 00 41 48    #.AH#.AH%.AH$.AH
70: 25 00 41 48 23 00 41 48 23 00 41 48 23 00 41 48    %.AH#.AH#.AH#.AH
80: 23 00 41 48 24 00 41 48 23 00 41 48 23 00 41 48    #.AH$.AH#.AH#.AH
90: 22 00 41 48 24 00 41 48 24 00 41 48 25 00 41 48    ".AH$.AH$.AH%.AH
a0: 24 00 41 48 23 00 41 48 25 00 41 48 24 00 41 48    $.AH#.AH%.AH$.AH
b0: 24 00 41 48 23 00 41 48 23 00 41 48 25 00 41 48    $.AH#.AH#.AH%.AH
c0: 24 00 41 48 23 00 41 48 25 00 41 48 25 00 41 48    $.AH#.AH%.AH%.AH
d0: 23 00 41 48 25 00 41 48 25 00 41 48 24 00 41 48    #.AH%.AH%.AH$.AH
e0: 23 00 41 48 23 00 41 48 25 00 41 48 23 00 41 48    #.AH#.AH%.AH#.AH
f0: 25 00 41 48 25 00 41 48 23 00 41 48 23 00 41 48    %.AH%.AH#.AH#.AH


Thanks for any help

Martin Berg
martin@berg.dk

