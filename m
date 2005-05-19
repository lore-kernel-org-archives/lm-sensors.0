From: bweller1@earthlink.net (Brian Weller)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: unsupported chip winbond W83637HF
Message-Id: <2F1B90A1-6003-11D7-9070-0050E4595D2C@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Per your instructions I've included the output of sensors-detect, 
i2cdetect and i2cdump below.

-------------- next part --------------
 This program will help you to determine which I2C/SMBus modules you need to
 load to use lm_sensors most effectively.
 You need to have installed lm-sensors modules before you can use
 some functions of this utility.
 Also, you need to be `root', or at least have access to
 the /dev/i2c[-/]* files for some things.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things may
 seem a bit confusing, but they will still work.

 Could not find dmidecode, which should have been installed with lm_sensors.
 Runing dmidecode would help us determining your system vendor, which allows
 safer operations. Please provide one of the following:
  /usr/local/sbin/dmidecode
  /usr/sbin/dmidecode
You can still go on, but you are encouraged to fix the problem first.
 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation, just scanning
 the bus will break your Thinkpad forever!
 If this is a non-Thinkpad IBM, we still suggest you press CTRL+C. We have
 had users reporting system breakage on other IBM systems as well.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801DB ICH4
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no): YES
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): 
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

Next adapter: SMBus I801 adapter at 0500 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): YES
Client found at address 0x00
Client found at address 0x08
Client found at address 0x44
Client found at address 0x4e
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x50
Probing for `Serial EEPROM (SDRAM DIMM)'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x69

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): YES
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

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 

Driver `lm75' (may not be inserted):
  Misdetects:
  * Bus `SMBus I801 adapter at 0500' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x4e
    Chip `National Semiconductor LM75' (confidence: 3)

Driver `adm1021' (should be inserted but causes problems):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0500' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x4e
    Chip `National Semiconductor LM84' (confidence: 6)
  Misdetects:
  * Bus `SMBus I801 adapter at 0500' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x4e
    Chip `Maxim MAX1617' (confidence: 3)

Driver `pcf8591' (may not be inserted):
  Misdetects:
  * Bus `SMBus I801 adapter at 0500' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x4e
    Chip `Philips Semiconductors PCF8591' (confidence: 1)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0500' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `Serial EEPROM (SDRAM DIMM)' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? 

WARNING! If you have some things built into your kernel, the 
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, edit /etc/modules and add the modules
 listed here to it:

#----cut here----
# I2C adapter drivers
i2c-i801
# I2C chip drivers
adm1021
eeprom
#----cut here----

Then, run /etc/init.d/modutils


To make the sensors modules behave correctly, add these lines to 
/etc/modutils/local and run update-modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
options adm1021 ignore=0,0x4e
#----cut here----
-------------- next part --------------

-------------- next part --------------
prog/detect/i2cdetect 0
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX 
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX 4e XX 
50: 50 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX 
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
-------------- next part --------------

-------------- next part --------------
prog/dump/i2cdump 0 0x08
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x8, mode byte
  You have five seconds to reconsider and press CTRL-C!

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
-------------- next part --------------

-------------- next part --------------
prog/dump/i2cdump 0 0x4e
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x4e, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
-------------- next part --------------

-------------- next part --------------
prog/dump/i2cdump 0 0x44
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x44, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 03 26 00 00 00 00 00 00 00 00 00 00 00 00    ..?&............
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
-------------- next part --------------

-------------- next part --------------
prog/dump/i2cdump 0 0x50
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x50, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 02 40 00 04 75 75 00 82 08 00 01    ??????@.?uu.??.?
10: 0e 04 0c 01 02 20 c0 a0 75 00 00 50 3c 50 2d 40    ????? ??u..P<P-@
20: 90 90 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ??PP.....AK02u..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 e3    ...............?
40: c1 49 4e 46 49 4e 45 4f 57 48 59 53 36 34 44 36    ?INFINEOWHYS64D6
50: 34 30 32 30 47 55 2d 37 00 00 00 02 25 03 09 00    4020GU-7...?%??.
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
-------------- next part --------------

-------------- next part --------------
prog/dump/i2cdump 0 0x69
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x69, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12    ????????????????
10: 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12    ????????????????
20: 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12    ????????????????
30: 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12    ????????????????
40: 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12    ????????????????
50: 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12    ????????????????
60: 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12    ????????????????
70: 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12    ????????????????
80: 19 ff 7f eb 00 ec 08 00 1c 00 00 00 00 00 00 03    ?.??.??.?......?
90: 00 be 19 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3    .???????????????
a0: 19 ff 7f eb 00 ec 08 00 1c 00 00 00 00 00 00 03    ?.??.??.?......?
b0: 00 be 19 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3    .???????????????
c0: 19 ff 7f eb 00 ec 08 00 1c 00 00 00 00 00 00 03    ?.??.??.?......?
d0: 00 be 19 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3    .???????????????
e0: 19 ff 7f eb 00 ec 08 00 1c 00 00 00 00 00 00 03    ?.??.??.?......?
f0: 00 be 19 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3    .???????????????
-------------- next part --------------


The only chip on the board that I think is a sensor is the winbond 
W83637HF
