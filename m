From: douglassac@earthlink.net (Chris Douglass)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: sensors-output.
Message-Id: <1080645241.2518.37.camel@ronin.inmyhouse.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK- Here it is.
Although I didn't include it, sensors-detect still reccommends loading
the adm1021 module. 
I use an ABIT NF7-S v2.0. I also have an NV7-133R (NForce 1 ABIT board),
and a whole slew of MSI NForce2 boards (forgot the model #) at the
office. Would it be worthwhile to try this on one of those machines? I
still haven't quite figured out if the particular sensors used on any
particular MB are dependant on manufacturers choice or dictated by the
bus and chipset being used.
-Chris



Here is output for sensors-detect. I didn't include failed sensors. :

Next adapter: SMBus nForce2 adapter at 5000 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x30
Client found at address 0x32
Client found at address 0x4e
..
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
..
Client found at address 0x52
Probing for `SPD EEPROM'... Success!

..
Do you want to scan the ISA bus? (YES/no):
..
Probing for `Winbond W83627HF'
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')


Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `adm1021' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 5000' (Algorithm unavailable)
    Busdriver `i2c-nforce2', I2C address 0x4e
    Chip `National Semiconductor LM84' (confidence: 5)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 5000' (Algorithm unavailable)
    Busdriver `i2c-nforce2', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 5000' (Algorithm unavailable)
    Busdriver `i2c-nforce2', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)

Driver `w83781d' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)

--
Here is the output of:
/usr/local/sbin/i2cdump 0 0x4e (if this isn't what you wanted, let me
know)


     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 28 08 00 00 00 80 08 00 00 00 eb 00 00 00 00 00    (?...??...?.....
10: 28 28 28 28 28 28 28 28 08 08 08 00 00 00 00 00    ((((((((???.....
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



> sensors-detect tells me I have and adm1021 sensor. When I try to load
> this module, my monitor turns off, and the hard drive light stays on
> until I shut down and unplug the machine from the wall for several
> seconds.

I have updated sensors-detect in CVS, could you please give it a try and
confirm that it will *not* pretend you have an adm1021-compatible chip
anymore?

Also, I'd be very interested by the output of i2cdump for this
mysterious chip.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

