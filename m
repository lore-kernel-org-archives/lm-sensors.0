From: dsomers@trevezel.com (David Somers)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] bogus data from W83627HF on an ASRock K7S41 motherboard
Message-Id: <AMEFLIEAAGMCAAOCOFIPOELICAAA.dsomers@trevezel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

I've just started to play with lm-sensors, and have almost got it working...
however, I'm getting some bogus values, and some others are missing:
- -12V is bogus
- Vbat looks bogus
- fan1 and fan2 both zero (even though 1 fan is installed and turning)

 # sensors --version
sensors version 2.8.7 with libsensors version 2.8.7

My kernel is 2.6.11-gentoo-r8

My motherboard is an ASRock K7S41, and the sensor appears to be a S83627HF

The diagnostic stuff follows. Any help getting lm_sensors working with my
system would be very much appreciated (espeically as I'm a bit of a control
freak and want to monitor the health of my system).

TIA from Luxembourg,

David

 # i2cdetect
Error: No i2c-bus specified!
Syntax: i2cdetect [-f] [-q|-r] I2CBUS [FIRST LAST]
  I2CBUS is an integer
  With -f, scans all addresses (NOT RECOMMENDED)
  With -q, uses only quick write commands for probing (NOT RECOMMENDED)
  With -r, uses only read byte commands for probing (NOT RECOMMENDED)
  If provided, FIRST and LAST limit the probing range.
  i2cdetect -l lists installed busses only
  Installed I2C busses:
    i2c-1       unknown         SiS96x SMBus adapter at 0x0c00
Algorithm unavailable
    i2c-0       dummy           ISA main adapter                        ISA
bus algorithm

????? Why is the algorithm unavailable

# sensors
eeprom-i2c-1-51
Adapter: SiS96x SMBus adapter at 0x0c00
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-1-50
Adapter: SiS96x SMBus adapter at 0x0c00
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

w83697hf-isa-0290
Adapter: ISA adapter
VCore:     +1.58 V  (min =  +1.71 V, max =  +1.89 V)
+3.3V:     +3.26 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.00 V  (min =  +4.76 V, max =  +5.24 V)
+12V:     +11.61 V  (min = +10.82 V, max = +13.19 V)
-12V:      +1.04 V  (min = -13.18 V, max = -10.80 V)
-5V:       +2.14 V  (min =  -5.25 V, max =  -4.75 V)
V5SB:      +5.46 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +0.29 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min = 10074 RPM, div = 2)
fan2:        0 RPM  (min = 84375 RPM, div = 2)
temp1:       +32 C  (high =    +8 C, hyst =    +1 C)   sensor = PII/Celeron
diode
temp2:     +34.5 C  (high =  +120 C, hyst =  +120 C)   sensor = PII/Celeron
diode
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm enabled


# sensors-detect

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
Use driver `i2c-sis96x' for device 00:02.1: Silicon Integrated Systems SMBus
Controller
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-sis96x' (say NO if built into your kernel)? (YES/no): no
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

Next adapter: SiS96x SMBus adapter at 0x0c00 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x10
Client at address 0x50 can not be probed - unload all client drivers first!
Client at address 0x51 can not be probed - unload all client drivers first!
Client found at address 0x69

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
Probing for `Winbond W83697HF'
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
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

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83697HF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x60)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x60)

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `w83781d' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF Super IO Sensors' (confidence: 9)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?

If you want to load the modules at startup, generate a config file
below and make sure lm_sensors gets started; e.g
$ rc-update add lm_sensors default.

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----end cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.
To load everything that is needed, execute the commands above...

#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe w83627hf
# sleep 2 # optional
/usr/bin/sensors -s # recommended

Do you want to generate /etc/conf.d/lm_sensors? Enter s to specify other
file name?
  (YES/no/s):
Done.

# isadump 0x295 0x296
  WARNING! Running this program can cause system crashes, data loss and
worse!
  I will probe address register 0x0295 and data register 0x0296.
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 ff 01 ff 00 00 00 00 01 01 01 01 3c 3c 0a 0a
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 63 00 cc ba c0 c2 c3 20 ff ff ff 76 6b 4c 0c d9
30: c4 c3 b1 d9 b2 32 15 3b 31 08 01 43 08 04 00 00
40: 01 00 10 00 00 00 00 5f 1f 02 89 44 58 95 00 a3
50: ff ff 00 ff ff ff 00 80 60 70 ff ff 11 00 ff 05
60: 63 00 cc ba c0 c2 c3 20 ff ff ff 76 6b 4c 0c d9
70: c4 c3 b1 d9 b2 32 15 3b 31 08 01 43 08 04 00 00
80: 01 ff 01 ff 00 00 00 00 01 01 01 01 3c 3c 0a 0a
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 63 00 cc ba c0 c2 c3 20 ff ff ff 76 6b 4c 0c d9
b0: c4 c3 b1 d9 b2 32 15 3b 31 08 01 43 08 04 00 00
c0: 01 00 00 00 00 00 00 5f 1f 02 89 44 58 95 00 a3
d0: ff ff 00 ff ff ff 00 80 60 70 ff ff 11 00 ff 05
e0: 63 00 cc ba c0 c2 c3 20 ff ff ff 76 6b 4c 0c d9
f0: c4 c3 b1 d9 b2 32 15 3b 31 08 01 43 08 04 00 00


