From: jnareb@fuw.edu.pl (Jakub Narebski)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Ticket #: 758, ITE IT8712F-A not detected, and not properly
Message-Id: <Pine.LNX.4.33.0112191715470.14694-100000@flow.fuw.edu.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> If you come up with better formulas let us know.

I will try, but most probably I will use only the temp and fan readings
(and ignore voltage readings). I don't think that there might be any
problem with voltage; the motherboard is not overclocked.

BTW. the Windows 98 driver for IT8712F sensor from ITE site shows that two
of voltages are incorrect, although the BIOS shows that voltages are O.K.
Maybe it depends on motherboard? I didn't found any information about
sensors wiring on the ECS site...

> Unfortunately the driver does not yet distinguish between
> a 8705 and a 8712 so there can?t be separate sections in sensors.conf
> until that is fixed.

I wanted only the example settings for it8712f, commented out, so one can
choose which settings to use.


Here comes the output of sensors-detect, sensors, i2cdetect and i2cdump. I
don't have isadump output (the computer I write mail from is not the
computer I have installed lm_sensors on).

[root@localhost root] sensors-detect
 This program will help you to determine which I2C/SMBus modules you need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the /dev/i2c[-/]* files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things may
 seem a bit confusing, but they will still work.

 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation,  just scanning
 the bus will break your thinkpad forever!

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies VT8233 VLink South Bridge
Use driver `i2c-riva' for device 01:00.0: RIVA UVTNT2
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-viapro' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
Load `i2c-riva' (say NO if built into your kernel)? (YES/no):
modprobe: Can't locate module i2c-riva
Loading failed ()... skipping.
** Note: i2c-riva module is available at
** http://drama.obuda.kando.hu/~fero/cgi-bin/rivatv.shtml
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus Via Pro adapter at 5000 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Genesys Logic GL525SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
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
Client found at address 0x69

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):
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
Probing for `VIA Technologies VT 82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?

WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-viapro
# I2C chip drivers
modprobe eeprom
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----


[root@localhost root]# i2cdetect
Error: No i2c-bus specified!
Syntax: i2cdetect I2CBUS
  I2CBUS is an integer
  Installed I2C busses:
    i2c-0       smbus           SMBus Via Pro adapter at 5000           Non-I2C SMBus adapter
[root@localhost root]# i2cdetect 0
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: 50 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX


[root@localhost root]# i2cdump 0 0x2d
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x2d, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 11 32 6f 02 00 00 00 00 00 00 03 09 00 72 ff fb
10: df fa db 30 00 00 00 00 00 00 00 00 00 00 00 00
20: 6d 9a cb b9 ce 39 42 54 c2 22 2a 2f 00 00 00 00
30: 4f 1e bb ba 67 dc 73 49 df 73 37 df 4b 4e de 16
40: f7 f6 be 7e c9 f9 00 00 2d 00 00 00 00 00 00 00
50: ff 38 7f 7f 7f 00 00 00 90 5d 02 00 80 00 00 00
60: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
70: 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00 00
80: 11 32 6f 02 00 00 00 00 00 00 03 09 00 71 ff fb
90: df fa db 30 00 00 00 00 00 00 00 00 00 00 00 00
a0: 6d 9a cb b9 ce 39 42 54 c2 22 2a 2f 00 00 00 00
b0: 4f 1e bb ba 67 dc 73 49 df 73 37 df 4b 4e de 16
c0: f7 f6 be 7e c9 f9 00 00 2d 00 00 00 00 00 00 00
d0: ff 38 7f 7f 7f 00 00 00 90 5d 02 00 80 00 00 00
e0: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
f0: 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00 00
[root@localhost root]# i2cdump 0 0x50
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x50, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 80 08 07 0c 0a 02 40 00 04 70 75 00 80 08 00 01
10: 0e 04 0c 01 02 20 00 75 75 00 00 50 3c 50 2d 20
20: 90 90 50 50 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 6d
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[root@localhost root]# i2cdump 0 0x69
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x69, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
10: 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
20: 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
30: 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
40: 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
50: 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
60: 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
70: 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
80: 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
90: 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
a0: 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
b0: 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
c0: 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
d0: 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
e0: 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
f0: 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10

-- 
Jakub Nar?bski
    Poland
