From: "F. Fernandez" <ferdez@moredata.pt>
Date: Fri, 08 Jun 2007 10:53:47 +0000
Subject: [lm-sensors] Alerts after a power supply change
Message-Id: <4669353B.4040400@moredata.pt>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all!

I have a machine working for months now and sensors are being monitored=20
with nagios, with no complaints.

Two days ago the machine started to act weird and we decided to try to=20
change the power supply. The new one was somewhat less powerfull (300VA=20
instead of 400VA) but it worked.

Surprisingly, nagios informed us that there where ALARMs in the sensors.=20
We checked and it was true:

vulcan:~# sensors
w83627ehf-isa-0290
Adapter: ISA adapter
VCore:     +1.30 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:      +12.36 V  (min =3D  +9.98 V, max =3D +13.31 V)
AVCC:      +3.34 V  (min =3D  +1.04 V, max =3D  +3.74 V)
3VCC:      +3.31 V  (min =3D  +2.78 V, max =3D  +1.65 V) ALARM
in4:       +2.04 V  (min =3D  +0.28 V, max =3D  +1.98 V) ALARM
in5:       +1.62 V  (min =3D  +1.77 V, max =3D  +1.44 V) ALARM
in6:       +5.20 V  (min =3D  +6.25 V, max =3D  +4.02 V) ALARM
VSB:       +3.28 V  (min =3D  +2.40 V, max =3D  +0.93 V) ALARM
VBAT:      +2.66 V  (min =3D  +0.66 V, max =3D  +0.80 V) ALARM
in9:       +1.63 V  (min =3D  +1.07 V, max =3D  +0.63 V) ALARM
Case Fan:    0 RPM  (min =3D   84 RPM, div =3D 128) ALARM
CPU Fan:  2721 RPM  (min =3D 1004 RPM, div =3D 8)
Aux Fan:     0 RPM  (min =3D  115 RPM, div =3D 128) ALARM
fan4:        0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM
Sys Temp:    +35=B0C  (high =3D   +45=B0C, hyst =3D    +5=B0C)   ALARM
CPU Temp:  +38.5=B0C  (high =3D +50.0=B0C, hyst =3D  +5.0=B0C)
AUX Temp:  +44.5=B0C  (high =3D +55.0=B0C, hyst =3D  +5.0=B0C)

vulcan:~#


The machine is working all right since then, but the alarms continue. We=20
changed the power supply again, to a more powerful one, but the alarms=20
continue.

The label mismatch on the "sensors" command output is a bit strange. Is=20
seems like a problem in the conf file. But we didn't touch the conf=20
file! We just changed the power supply!

Any suggestions will very welcome. Thanks in advance!

Fernando

P.S.:

Here goes some more info on the system:

=3D=3D=3D=3D *KERNEL*
vulcan:~# uname -a
Linux vulcan 2.6.18-4-686 #1 SMP Wed May 9 23:03:12 UTC 2007 i686 GNU/Linux

=3D=3D=3D=3D *SENSORS VERSION*
vulcan:~# dpkg --list | grep sensors
ii  libsensors3                       2.10.1-3                            l=
ibrary to read temperature/voltage/fan sens
ii  lm-sensors                        2.10.1-3                            u=
tilities to read temperature/voltage/fan se

=3D=3D=3D=3D *ISADUMP*
vulcan:~# isadump 0x295 0x296
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 ff 04 ff 00 2b 32 13 b2 55 b2 01 3c 3c 02 02
10: 04 ff 30 00 00 01 01 3c 43 17 00 00 57 00 00 d3
20: a1 e9 cd ce ff ca cc 23 ff 3f ff da 00 fc bd ea
30: 41 67 ae f7 23 b4 dd 9d f4 2d 05 7d a8 5b 01 ff
40: 03 00 00 de ff ff 00 f4 2d ff 40 c4 90 95 00 a3
50: ff ff 80 ff ff ff 00 80 a1 63 ff ff 19 a4 ff 05
60: 04 ff 00 00 01 01 3c ff 11 ff 01 ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: 04 ff 04 ff 00 2b 32 13 b2 55 b2 01 3c 3c 02 02
90: 04 ff 30 00 00 01 01 3c 43 17 00 00 57 00 00 d3
a0: a1 e9 cd ce ff ca cc 23 ff 3f ff da 00 fc bd ea
b0: 41 67 ae f7 23 b4 dd 9d f4 2d 05 7d a8 5b 01 ff
c0: 03 00 00 de ff ff 00 f4 2d ff 40 c4 90 95 00 a3
d0: ff ff 80 ff ff ff 00 80 a1 63 ff ff 19 a4 ff 05
e0: 04 ff 00 00 01 01 3c ff 11 ff 01 ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
vulcan:~#

=3D=3D=3D=3D *SENSORS_DETECT*
vulcan:~# sensors-detect
# sensors-detect revision 4171 (2006-09-24 03:37:01 -0700)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel ICH7

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 0400
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x30
Client found at address 0x32
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x50
Handled by driver `eeprom' (already loaded), chip type `eeprom'
Client found at address 0x52
Handled by driver `eeprom' (already loaded), chip type `eeprom'
Client found at address 0x69

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Winbond W83627HF' at 0x290...                  No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `AMD K8 thermal sensors'...                     No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `Winbond W83627EHF/EHG Super IO Sensors'              Success!
    (address 0x290, driver `w83627ehf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0400'
    Busdriver `i2c-i801', I2C address 0x50
    Chip `eeprom' (confidence: 6)
  * Bus `SMBus I801 adapter at 0400'
    Busdriver `i2c-i801', I2C address 0x52
    Chip `eeprom' (confidence: 6)

  EEPROMs are *NOT* sensors! They are data storage chips commonly
  found on memory modules (SPD), in monitors (EDID), or in some
  laptops, for example.

Driver `w83627ehf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627EHF/EHG Super IO Sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-i801
# Chip drivers
eeprom
w83627ehf
#----cut here----


Do you want to add these lines to /etc/modules automatically? (yes/NO)



=3D=3D=3D=3D *I2CDETECT*

vulcan:~# i2cdetect 0

WARNING! This program can confuse your I2C bus, cause data loss and worse!

I will probe file /dev/i2c-0.

I will probe address range 0x03-0x77.

Continue? [Y/n]

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f

00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX

10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

30: 30 XX 32 XX XX XX XX XX XX XX XX XX XX XX XX XX

40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX

50: UU XX UU XX XX XX XX XX XX XX XX XX XX XX XX XX

60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX

70: XX XX XX XX XX XX XX XX

vulcan:~#


--=20
Fernando Fernandez
web:  http://www.moredata.pt



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
