From: Carl Seutter <cseutter@sbcglobal.net>
Date: Wed, 23 Jan 2013 02:58:10 +0000
Subject: [lm-sensors] Issue on ASUS Sabertooth 990FX
Message-Id: <50FF51C2.4000507@sbcglobal.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all,
I have an ASUS Sabertooth 990FX motherboard with bios version 1604.

I'm running OpenSuSe 12.1 with the 3.1.10 kernel, sensors 3.3, and I=20
downloaded the standalone driver from=20
http://khali.linux-fr.org/devel/misc/it87/ as it indicated it supported=20
5 fans.
I'm seeing some incorrect results when running sensors for the number of=20
fans and temperatures:

# ./sensors
k10temp-pci-00c3
Adapter: PCI adapter
temp1:         +8.5=B0C  (high =3D +70.0=B0C)
                        (crit =3D +90.0=B0C, hyst =3D +87.0=B0C)

fam15h_power-pci-00c4
Adapter: PCI adapter
power1:       32.24 W  (crit =3D 124.77 W)

it8721-isa-0290
Adapter: ISA adapter
in0:          +2.82 V  (min =3D  +2.32 V, max =3D  +1.51 V)  ALARM
in1:          +2.80 V  (min =3D  +1.68 V, max =3D  +0.24 V)  ALARM
in2:          +0.88 V  (min =3D  +0.42 V, max =3D  +1.85 V)
+3.3V:        +3.31 V  (min =3D  +2.38 V, max =3D  +1.82 V)  ALARM
in4:          +1.16 V  (min =3D  +0.89 V, max =3D  +0.36 V)  ALARM
in5:          +2.51 V  (min =3D  +1.72 V, max =3D  +2.08 V)  ALARM
in6:          +1.73 V  (min =3D  +1.64 V, max =3D  +0.44 V)  ALARM
3VSB:         +0.29 V  (min =3D  +2.02 V, max =3D  +4.90 V)  ALARM
Vbat:         +3.34 V
fan1:        2156 RPM  (min =3D   17 RPM)
fan2:           0 RPM  (min =3D  327 RPM)  ALARM
fan3:         722 RPM  (min =3D   13 RPM)
temp1:        +31.0=B0C  (low  =3D +43.0=B0C, high =3D +44.0=B0C)  sensor =
=3D thermistor
temp2:        +29.0=B0C  (low  =3D +10.0=B0C, high =3D -66.0=B0C)  sensor =
=3D thermistor
temp3:       -128.0=B0C  (low  =3D -117.0=B0C, high =3D +71.0=B0C)  sensor =
=3D disabled
intrusion0:  OK


My motherboard has a total of 6 fan connections, 4 of which actually=20
have fans attached.  The BIOS shows all 6 connections but as you can=20
see, only 3 are being reported.  Additionally, my motherboard is=20
supposed to have 10 sensors for monitoring temperatures.  I know the=20
it87 driver only measures 3, and temp3 doesn't look right.  Maybe it's=20
showing -128 because it's disabled?

While trying to figure out why I was only seeing 3 fans I discovered this:

#rmmod it87
# ./isadump 0x295 0x296
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 11 02 fb 00 00 00 00 00 00 80 58 0f 07 44 ff a3
10: 0b 0a 61 77 c7 80 00 00 01 ff 03 99 08 c0 c0 c0
20: eb e9 60 8a 61 d1 90 0c 8b 1f 1e 80 80 30 3d 3d
30: 7e c1 14 8c 9a 23 4c 63 1e 4a ad 8f 25 89 cc 54
40: 2c 2b be 0a 47 8b 5f 40 ad 6a d4 00 ff ff ff ff
50: 2f 18 7f 7f 7f 40 00 00 90 00 37 12 60 00 00 00
60: 80 14 46 0c a0 41 00 ff 7f 7f 7f 80 00 00 00 ff
70: 80 00 7f ff 00 41 00 ff ff ff ff ff ff ff ff ff
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 0d 02 51
90: ff 00 00 00 ff 00 00 00 ff ff ff ff ff ff ff ff
a0: 11 87 87 87 87 87 87 ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

In looking at 80-87 are all showing 00, maybe that explains why sensors=20
is only showing fans1-3.


When I insert module it87:

# modprobe it87
it87: Found IT8721F chip at 0x290, revision 1

Maybe the revision makes a difference?


Here is the output from sensors-detect:
# ./sensors-detect
# sensors-detect revision 6085 (2012-10-30 18:18:45 +0100)
# Board: ASUSTeK COMPUTER INC. SABERTOOTH 990FX

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Module cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           Success!
     (driver `k10temp')
AMD Family 15h power sensors...                             Success!
     (driver `fam15h_power')
Intel digital thermal sensor...                             No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      Yes
Found `ITE IT8721F/IT8758E Super IO Sensors'                Success!
     (address 0x290, driver `it87')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): yes
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc=20
SB600/SB700/SB800 SMBus
Module i2c-dev loaded successfully.

Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
     (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
     (confidence 8, not a hardware monitoring chip)
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
     (confidence 8, not a hardware monitoring chip)
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
     (confidence 8, not a hardware monitoring chip)

Next adapter: NVIDIA i2c adapter 0 at 1:00.0 (i2c-1)
Do you want to scan it? (yes/NO/selectively): yes

Next adapter: NVIDIA i2c adapter 1 at 1:00.0 (i2c-2)
Do you want to scan it? (yes/NO/selectively): yes

Next adapter: NVIDIA i2c adapter 2 at 1:00.0 (i2c-3)
Do you want to scan it? (yes/NO/selectively): yes

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `it87':
   * ISA bus, address 0x290
     Chip `ITE IT8721F/IT8758E Super IO Sensors' (confidence: 9)

Driver `fam15h_power' (autoloaded):
   * Chip `AMD Family 15h power sensors' (confidence: 9)

Driver `k10temp' (autoloaded):
   * Chip `AMD Family 15h thermal sensors' (confidence: 9)

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.service to /lib/systemd/system
and run 'systemctl enable lm_sensors.service'
for initialization at boot time.
Unloading i2c-dev... OK
Unloading cpuid... OK

Is there a test program/script/module that can be used to determine what=20
is attached?  Or is it just trial and error?  I was thinking about=20
trying to resolve the issues with the fans initially, but wasn't sure=20
where to start with trying to identify the addresses.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
