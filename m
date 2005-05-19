From: zchen@avaya.com (Chen, Zhen Y (Zhen))
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: No subject
Message-Id: <FAAE770430B5A0408ADD9FFF96292E4C0153758D@cof110avexu2.global.avaya.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0111200151170.1364-100000@home.apu.edu>
In-Reply-To: <Pine.LNX.4.33.0111200151170.1364-100000@home.apu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi,
I ran the sensor package on my redhat 6.2, IBM xserver systems. 
It has a sensor chip somewhere. But the tool couldn't find a match.

Looks like: 0x30, 0x31, 0x64 are the chips that can't be determined by
the tool. 
0x50, 0x53. 0x57 are eeprom chips. 
 
I don't know for sure if the sensor is on the i2c bus, neither i could
identify the chip name and model.
I wonder if you can help  me out. 
thanks
zhen 

OUTPUT from SENSORS_DETECTY:

[root@definity1 detect]# ./sensors-detect
 This program will help you to determine which I2C/SMBus modules you
need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made
sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the /dev/i2c-*
files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev
files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things
may
 seem a bit confusing, but they will still work.
 
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): y
Probing for PCI bus adapters...
Sorry, no PCI bus adapters found.
 We will now try to load each adapter module in turn.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): y
Load `i2c-elektor' (say NO if built into your kernel)? (YES/no): y
Module loaded succesfully.
Load `i2c-elv' (say NO if built into your kernel)? (YES/no): y
/lib/modules/2.2.17-14.1s13smp/misc/i2c-elv.o: init_module: Device or
resource busy
/lib/modules/2.2.17-14.1s13smp/misc/i2c-elv.o: insmod
/lib/modules/2.2.17-14.1s13smp/
misc/i2c-elv.o failed
/lib/modules/2.2.17-14.1s13smp/misc/i2c-elv.o: insmod i2c-elv failed
Loading failed ()... skipping.
Load `i2c-philips-par' (say NO if built into your kernel)? (YES/no): y
Module loaded succesfully.
Load `i2c-velleman' (say NO if built into your kernel)? (YES/no): n
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.
 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. If you have a PIIX4, that
often
 includes addresses 0x69 and/or 0x6a.
 
Next adapter: SMBus OSB4 adapter at 0440 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x00
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Client found at address 0x30
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Client found at address 0x31
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Client found at address 0x50
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x53
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x57
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
 Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x64
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
 
Next adapter: PCF8584 ISA adapter (PCF8584 algorithm)
Do you want to scan it? (YES/no/selectively): y
Next adapter: Velleman K8000 (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively): y
 
Next adapter: PCF8584 ISA adapter (PCF8584 algorithm)
Do you want to scan it? (YES/no/selectively): y
 
Next adapter: Velleman K8000 (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively): n
 
 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): y
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
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
 
 Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus OSB4 adapter at 0440' (Non-I2C SMBus adapter)
    Busdriver `?????', I2C address 0x50
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
  * Bus `SMBus OSB4 adapter at 0440' (Non-I2C SMBus adapter)
    Busdriver `?????', I2C address 0x53
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
  * Bus `SMBus OSB4 adapter at 0440' (Non-I2C SMBus adapter)
    Busdriver `?????', I2C address 0x57
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 1)
 



out put from i2c_detect. i2c dump:

 Error: No i2c-bus specified!
Syntax: i2cdetect I2CBUS
  I2CBUS is an integer
  Installed I2C busses:
    i2c-0       smbus           SMBus OSB4 adapter at 0440
Non-I2C SMBus
 adapter
    i2c-1       i2c             PCF8584 ISA adapter
PCF8584 algor
ithm
    i2c-2       i2c             Velleman K8000
Bit-shift alg
orithm
 
[root@definity1 detect]# ./i2cdetect 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: 30 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: 50 XX XX 53 XX XX XX 57 XX XX XX XX XX XX XX XX
60: XX XX XX XX 64 XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
 
[root@definity1 dump]# ./i2cdump 0 0x30
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-0, address 0x30, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: ff ff ff ff ff XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX XX XX ff XX ff ff XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
90: XX XX XX XX XX XX XX XX XX XX XX XX ff XX XX XX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
f0: XX XX XX XX XX XX ff XX XX XX XX XX XX XX XX XX
 

[root@definity1 dump]# ./i2cdump 0 0x31
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-0, address 0x31, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 02 00 01 07 03 00 00 02 00 01 00 01
10: 03 00 02 00 01 00 03 03 00 02 00 01 07 03 03 00
20: 00 00 05 00 05 04 00 05 04 05 00 06 04 00 00 00
30: 01 07 03 00 00 08 08 00 0a 06 00 00 09 09 00 0a
40: 06 00 00 00 00 00 00 06 00 00 06 06 06 06 06 06
50: 00 07 00 01 01 07 00 05 02 00 06 00 06 02 05 02
60: 00 01 00 07 00 05 07 00 01 01 07 00 05 00 00 03
70: 00 03 00 05 03 04 03 00 00 00 05 00 05 01 01 07
80: 05 05 08 08 00 0a 00 00 05 09 09 00 0b 00 00 05
90: 00 00 00 00 00 00 05 05 05 05 05 05 05 05 32 55
a0: 25 55 6a 45 04 d0 23 5c 3f 44 5a 07 80 e0 13 a0
b0: 04 d8 fb 5c 01 ff 01 51 00 f9 00 b3 00 b5 00 03
c0: 00 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
d0: 55 55 55 55 55 55 55 55 55 55 18 02 03 01 0d 80
e0: 00 00 00 00 00 00 00 55 55 55 55 55 55 55 55 55
f0: 55 55 55 55 01 01 00 00 00 00 01 00 55 55 30 55
[root@definity1 dump]#
 
 
[root@definity1 dump]# ./i2cdump 0 0x50
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-0, address 0x50, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 80 08 04 0c 0a 01 48 00 01 75 54 02 80 08 08 01
10: 8f 04 06 01 01 1f 0e a0 60 00 00 14 0f 14 2c 20
20: 15 08 15 08 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 12 df
40: 2c ff ff ff ff ff ff ff 08 39 4c 53 44 54 31 36
50: 37 32 47 2d 31 33 33 45 31 20 20 01 00 01 2c 5b
60: 18 66 ee 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 64 8f
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[root@definity1 dump]# ./i2cdump 0 0x53
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-0, address 0x53, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 80 08 04 0c 0a 01 48 00 01 75 54 02 80 08 08 01
10: 8f 04 06 01 01 1f 0e a0 60 00 00 14 0f 14 2c 20
20: 15 08 15 08 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 12 df
40: 2c ff ff ff ff ff ff ff 08 39 4c 53 44 54 31 36
50: 37 32 47 2d 31 33 33 45 31 20 20 01 00 01 2c 5b
60: 18 66 e9 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 64 8f
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[root@definity1 dump]# ./i2cdump 0 0x57
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-0, address 0x57, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 6e d7 00 00 00 00 00 00 00 00 00 00 00 00 34 fa
10: 31 42 36 31 54 37 20 4b 31 30 47 54 53 4c 52 4d
20: 00 00 00 00 32 35 50 33 33 34 37 20 20 20 20 20
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 7f 7f 7f 7f 7f 7f 7f 7f
50: 00 00 42 4f 58 20 53 45 52 49 41 4c 4e 55 4d 42
60: 45 52 00 00 32 35 50 32 31 32 37 20 20 20 20 20
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

 
[root@definity1 dump]# ./i2cdump 0 0x64
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-0, address 0x64, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: e0 00 00 00 00 0f 00 00 02 fe 02 01 00 00 00 00
10: 00 00 40 20 00 02 00 00 00 00 ff ff ff ff 00 00
20: e0 00 00 00 00 0f 00 00 02 fe 02 01 00 00 00 00
30: 00 00 40 20 00 02 00 00 00 00 ff ff ff ff 00 00
40: e0 00 00 00 00 0f 00 00 02 fe 02 01 00 00 00 00
50: 00 00 40 20 00 02 00 00 00 00 ff ff ff ff 00 00
60: e0 00 00 00 00 0f 00 00 02 fe 02 01 00 00 00 00
70: 00 00 40 20 00 02 00 00 00 00 ff ff ff ff 00 00
80: e0 00 00 00 00 0f 00 00 02 fe 02 01 00 00 00 00
90: 00 00 40 20 00 02 00 00 00 00 ff ff ff ff 00 00
a0: e0 00 00 00 00 0f 00 00 02 fe 02 01 00 00 00 00
b0: 00 00 40 20 00 02 00 00 00 00 ff ff ff ff 00 00
c0: e0 00 00 00 00 0f 00 00 02 fe 02 01 00 00 00 00
d0: 00 00 40 20 00 02 00 00 00 00 ff ff ff ff 00 00
e0: e0 00 00 00 00 0f 00 00 02 fe 02 01 00 00 00 00
f0: 00 00 40 20 00 02 00 00 00 00 ff ff ff ff 00 00
 
 






 











-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020219/5d6f8b47/attachment.html
