From: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Sat, 25 Dec 2010 13:15:46 +0000
Subject: [lm-sensors] f75375s detected but no temp output
Message-Id: <AANLkTimosNm7_k9scygyWZuWZPunJ=wteQ+UgFB2-Gn8@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5872470332275131397=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5872470332275131397==
Content-Type: multipart/alternative; boundary=90e6ba6e83f672f48104983be829

--90e6ba6e83f672f48104983be829
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I have graphics card Nvidia Geforce 6600Gt which has sensor chip f75375s.
I'm using binary nvidia driver on linux 2.6.35-24-generic

When I start sensors-detect, it write me:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
# Board: Gigabyte Technology Co., Ltd. GA-K8NF-9-RH

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   Success!
    (driver `k8temp')
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel Atom thermal sensor...                                No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      Yes
Found `ITE IT8712F Super IO Sensors'                        Success!
    (address 0x290, driver `it87')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
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
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO):

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-nforce2' for device 0000:00:01.1: nVidia Corporation
nForce4 SMBus (MCP)
Module i2c-dev loaded successfully.

Next adapter: SMBus nForce2 adapter at 1c00 (i2c-0)
Do you want to scan it? (yes/NO/selectively):

Next adapter: SMBus nForce2 adapter at 1c40 (i2c-1)
Do you want to scan it? (yes/NO/selectively):

Next adapter: NVIDIA i2c adapter  (i2c-2)
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter  (i2c-3)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x4a
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `National Semiconductor LM77'...                No
Probing for `Analog Devices ADT7411'...                     No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `National Semiconductor LM73'...                No
Probing for `National Semiconductor LM92'...                No
Probing for `National Semiconductor LM76'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x4b
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `National Semiconductor LM77'...                No
Probing for `Analog Devices ADT7411'...                     No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `Maxim MAX6650/MAX6651'...                      No
Probing for `National Semiconductor LM92'...                No
Probing for `National Semiconductor LM76'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...
No
Probing for `Analog Devices ADT7481'...                     No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)

Next adapter: NVIDIA i2c adapter  (i2c-4)
Do you want to scan it? (YES/no/selectively): Client found at address 0x2e
Probing for `Myson MTP008'...                               No
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `National Semiconductor LM85'...                No
Probing for `National Semiconductor LM96000 or PC8374L'...  No
Probing for `Analog Devices ADM1027'...                     No
Probing for `Analog Devices ADT7460 or ADT7463'...          No
Probing for `SMSC EMC6D100 or EMC6D101'...                  No
Probing for `SMSC EMC6D102'...                              No
Probing for `SMSC EMC6D103'...                              No
Probing for `Winbond WPCD377I'...                           No
Probing for `Analog Devices ADT7467 or ADT7468'...          No
Probing for `Analog Devices ADT7470'...                     No
Probing for `Analog Devices ADT7473'...                     No
Probing for `Analog Devices ADT7475'...                     No
Probing for `Analog Devices ADT7476'...                     No
Probing for `Analog Devices ADT7490'...                     No
Probing for `Andigilog aSC7611'...                          No
Probing for `Andigilog aSC7621'...                          No
Probing for `National Semiconductor LM87'...                No
Probing for `Analog Devices ADM1024'...                     No
Probing for `National Semiconductor LM93'...                No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83791D'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          No
Probing for `Nuvoton W83795G/ADG'...                        No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG/W83667HG/W83677HG'...        No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Winbond W83L786NR/NG/R/G'...                   No
Probing for `Winbond W83L785TS-S'...                        No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1026'...                     No
Probing for `Analog Devices ADM1025'...                     No
Probing for `Texas Instruments AMC6821'...                  No
Probing for `Analog Devices ADM1029'...                     No
Probing for `Analog Devices ADM1030'...                     No
Probing for `Analog Devices ADM1031'...                     No
Probing for `Analog Devices ADM1022'...                     No
Probing for `Texas Instruments THMC50'...                   No
Probing for `Analog Devices ADM1028'...                     No
Probing for `Texas Instruments THMC51'...                   No
Probing for `ITE IT8712F'...                                No
Probing for `SMSC DME1737'...                               No
Probing for `SMSC SCH5027D-NW'...                           No
Probing for `Fintek F75373S/SG'...                          No
*Probing for `Fintek F75375S/SP'...                          Success!*
*    (confidence 7, driver `f75375s')*
Probing for `Fintek F75387SG/RG'...                         No
Probing for `Winbond W83791SD'...                           No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `it87':
  * ISA bus, address 0x290
    Chip `ITE IT8712F Super IO Sensors' (confidence: 9)

*Driver `f75375s':*
*  * Bus `NVIDIA i2c adapter '*
*    Busdriver `nvidia', I2C address 0x2e*
*    Chip `Fintek F75375S/SP' (confidence: 7)*

Driver `k8temp' (autoloaded):
  * Chip `AMD K8 thermal sensors' (confidence: 9)

To load everything that is needed, add this to /etc/modules:
#----cut here----
# Chip drivers
*f75375s*
it87
#----cut here----
If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones!

Do you want to add these lines automatically to /etc/modules? (yes/NO)

Unloading i2c-dev... OK
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

After loading kernel module f75375s sensors does not show any f75375s info:

$ lsmod | grep f75375s
f75375s                11789  0

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +34.0=C2=B0C
Core1 Temp:  +33.0=C2=B0C

it8712-isa-0290
Adapter: ISA adapter
in0:         +1.14 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in1:         +2.56 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in2:         +3.30 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in3:         +2.03 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in4:         +3.06 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in5:         +2.38 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in6:         +2.46 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in7:         +2.48 V  (min =3D  +0.00 V, max =3D  +4.08 V)
Vbat:        +4.08 V
fan1:       3245 RPM  (min =3D  664 RPM, div =3D 8)
fan3:          0 RPM  (min =3D    0 RPM, div =3D 8)
temp1:       -55.0=C2=B0C  (low  =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C)=
  sensor =3D
thermistor
temp2:       +30.0=C2=B0C  (low  =3D +127.0=C2=B0C, high =3D +60.0=C2=B0C) =
 sensor =3D thermistor
temp3:       +70.0=C2=B0C  (low  =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C)=
  sensor =3D
thermistor
cpu0_vid:   +1.100 V
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Where is the problem? And why is no f75375s temp detected by lm sensors?

I tried program nvclock and it show me correct f75375s temp without problem=
:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
$ nvclock -i
...
-- Sensor info --
Sensor: Fintek F75375S
Board temperature: 46C
GPU temperature: 52C
Fanspeed: 4702 RPM
PWM duty cycle: 42.6%
...
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--90e6ba6e83f672f48104983be829
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,<div><br></div><div>I have graphics card Nvidia Geforce 6600Gt which =
has sensor chip=C2=A0f75375s. I&#39;m using binary nvidia driver on linux=
=C2=A02.6.35-24-generic</div><div><br></div><div>When I start sensors-detec=
t, it write me:</div>

<div><br></div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div><div># sensors-detect revision 581=
8 (2010-01-18 17:22:07 +0100)</div><div># Board: Gigabyte Technology Co., L=
td. GA-K8NF-9-RH</div><div>
<br>
</div><div>This program will help you determine which kernel modules you ne=
ed</div><div>to load to use lm_sensors most effectively. It is generally sa=
fe</div><div>and recommended to accept the default answers to all questions=
,</div>

<div>unless you know what you&#39;re doing.</div><div><br></div><div>Some s=
outh bridges, CPUs or memory controllers contain embedded sensors.</div><di=
v>Do you want to scan for them? This is totally safe. (YES/no):=C2=A0</div>
<div>
Silicon Integrated Systems SIS5595... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>VIA VT82C686 Integra=
ted Sensors... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>VIA VT8231 Integrated Sensors..=
. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>AMD K8 thermal sensors... =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Success!</div>

<div>=C2=A0=C2=A0 =C2=A0(driver `k8temp&#39;)</div><div>AMD Family 10h ther=
mal sensors... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>AMD Family 11h thermal sensors=
... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 No</div><div>Intel Core family thermal sensor... =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 No</div>

<div>Intel Atom thermal sensor... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</d=
iv><div>Intel AMB FB-DIMM thermal sensor... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>VIA C7 th=
ermal sensor... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><=
div>

VIA Nano thermal sensor... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</d=
iv><div><br></div><div>Some Super I/O chips contain embedded sensors. We ha=
ve to write to</div><div>standard I/O ports to probe them. This is usually =
safe.</div>

<div>Do you want to scan for Super I/O sensors? (YES/no):=C2=A0</div><div>P=
robing for Super-I/O at 0x2e/0x2f</div><div>Trying family `National Semicon=
ductor&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 No</div><div>Trying family `SMSC&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 No</div>

<div>Trying family `VIA/Winbond/Nuvoton/Fintek&#39;... =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Trying family `ITE&#39;... =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Yes</div><div>Found `IT=
E IT8712F Super IO Sensors&#39; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Success!</div>

<div>=C2=A0=C2=A0 =C2=A0(address 0x290, driver `it87&#39;)</div><div>Probin=
g for Super-I/O at 0x4e/0x4f</div><div>Trying family `National Semiconducto=
r&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No=
</div><div>Trying family `SMSC&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 No</div>

<div>Trying family `VIA/Winbond/Nuvoton/Fintek&#39;... =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Trying family `ITE&#39;... =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div><br></div>=
<div>Some systems (mainly servers) implement IPMI, a set of common interfac=
es</div>

<div>through which system health data may be retrieved, amongst other thing=
s.</div><div>We first try to get the information from SMBIOS. If we don&#39=
;t find it</div><div>there, we have to read from arbitrary I/O ports to pro=
be for such</div>

<div>interfaces. This is normally safe. Do you want to scan for IPMI</div><=
div>interfaces? (YES/no):=C2=A0</div><div>Probing for `IPMI BMC KCS&#39; at=
 0xca0... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0No</div><div>Probing for `IPMI BMC SMIC&#39; at 0xca8... =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div>

<div><br></div><div>Some hardware monitoring chips are accessible through t=
he ISA I/O ports.</div><div>We have to write to arbitrary I/O ports to prob=
e them. This is usually</div><div>safe though. Yes, you do have ISA I/O por=
ts even if you do not have any</div>

<div>ISA slots! Do you want to scan the ISA I/O ports? (yes/NO):=C2=A0</div=
><div><br></div><div>Lastly, we can probe the I2C/SMBus adapters for connec=
ted hardware</div><div>monitoring devices. This is the most risky part, and=
 while it works</div>

<div>reasonably well on most systems, it has been reported to cause trouble=
</div><div>on some systems.</div><div>Do you want to probe the I2C/SMBus ad=
apters now? (YES/no):=C2=A0</div><div>Using driver `i2c-nforce2&#39; for de=
vice 0000:00:01.1: nVidia Corporation nForce4 SMBus (MCP)</div>

<div>Module i2c-dev loaded successfully.</div><div><br></div><div>Next adap=
ter: SMBus nForce2 adapter at 1c00 (i2c-0)</div><div>Do you want to scan it=
? (yes/NO/selectively):=C2=A0</div><div><br></div><div>Next adapter: SMBus =
nForce2 adapter at 1c40 (i2c-1)</div>

<div>Do you want to scan it? (yes/NO/selectively):=C2=A0</div><div><br></di=
v><div>Next adapter: NVIDIA i2c adapter =C2=A0(i2c-2)</div><div>Do you want=
 to scan it? (YES/no/selectively):=C2=A0</div><div><br></div><div>Next adap=
ter: NVIDIA i2c adapter =C2=A0(i2c-3)</div>

<div>Do you want to scan it? (YES/no/selectively):=C2=A0</div><div>Client f=
ound at address 0x4a</div><div>Probing for `National Semiconductor LM75&#39=
;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>Pr=
obing for `Dallas Semiconductor DS75&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div>

<div>Probing for `National Semiconductor LM77&#39;... =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>Probing for `Analog Devices =
ADT7411&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 No</div><div>Probing for `Dallas Semiconductor DS1621/DS1631&#39=
;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div>

<div>Probing for `National Semiconductor LM73&#39;... =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>Probing for `National Semico=
nductor LM92&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0No</div><div>Probing for `National Semiconductor LM76&#39;... =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div>

<div>Probing for `Maxim MAX6633/MAX6634/MAX6635&#39;... =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>Client found at address 0x4b</d=
iv><div>Probing for `National Semiconductor LM75&#39;... =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>Probing for `Dallas Semi=
conductor DS75&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0No</div>

<div>Probing for `National Semiconductor LM77&#39;... =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>Probing for `Analog Devices =
ADT7411&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 No</div><div>Probing for `Dallas Semiconductor DS1621/DS1631&#39=
;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div>

<div>Probing for `Maxim MAX6650/MAX6651&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>Probing for `=
National Semiconductor LM92&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0No</div><div>Probing for `National Semiconductor LM76&#39;=
... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div>

<div>Probing for `Maxim MAX6633/MAX6634/MAX6635&#39;... =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</div><div>No</div><div>Probing for `Analog =
Devices ADT7481&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 No</div><div>Client found at address 0x50</div><div>Pr=
obing for `Analog Devices ADM1033&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div>

<div>Probing for `Analog Devices ADM1034&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Probing for `SPD=
 EEPROM&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Probing f=
or `EDID EEPROM&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Yes</div>

<div>=C2=A0=C2=A0 =C2=A0(confidence 8, not a hardware monitoring chip)</div=
><div><br></div><div>Next adapter: NVIDIA i2c adapter =C2=A0(i2c-4)</div><d=
iv>Do you want to scan it? (YES/no/selectively): Client found at address 0x=
2e</div><div>Probing for `Myson MTP008&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 No</div>

<div>Probing for `National Semiconductor LM78&#39;... =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>Probing for `National Semico=
nductor LM79&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0No</div><div>Probing for `National Semiconductor LM80&#39;... =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div>

<div>Probing for `National Semiconductor LM85&#39;... =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>Probing for `National Semico=
nductor LM96000 or PC8374L&#39;... =C2=A0No</div><div>Probing for `Analog D=
evices ADM1027&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 No</div>

<div>Probing for `Analog Devices ADT7460 or ADT7463&#39;... =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0No</div><div>Probing for `SMSC EMC6D100 or EMC6D101&#39=
;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div>=
<div>Probing for `SMSC EMC6D102&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</di=
v>

<div>Probing for `SMSC EMC6D103&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</di=
v><div>Probing for `Winbond WPCD377I&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div=
>Probing for `Analog Devices ADT7467 or ADT7468&#39;... =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0No</div>

<div>Probing for `Analog Devices ADT7470&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Probing for `Ana=
log Devices ADT7473&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Probing for `Analog Devices ADT7475&#=
39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 No</div>

<div>Probing for `Analog Devices ADT7476&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Probing for `Ana=
log Devices ADT7490&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Probing for `Andigilog aSC7611&#39;..=
. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0No</div>

<div>Probing for `Andigilog aSC7621&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>Pro=
bing for `National Semiconductor LM87&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>Probing for `Analog Devices ADM1024=
&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 No</div>

<div>Probing for `National Semiconductor LM93&#39;... =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>Probing for `Winbond W83781D=
&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>Probing for `Winbond W83782D&#3=
9;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div>

<div>Probing for `Winbond W83791D&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><=
div>Probing for `Winbond W83792D&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div=
>Probing for `Winbond W83793R/G&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div>

<div>Probing for `Nuvoton W83795G/ADG&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>Probing=
 for `Winbond W83627HF&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Probing for `=
Winbond W83627EHF&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div>

<div>Probing for `Winbond W83627DHG/W83667HG/W83677HG&#39;... =C2=A0 =C2=A0=
 =C2=A0 =C2=A0No</div><div>Probing for `Asus AS99127F (rev.1)&#39;... =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No=
</div><div>Probing for `Asus AS99127F (rev.2)&#39;... =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div>

<div>Probing for `Asus ASB100 Bach&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Pr=
obing for `Winbond W83L786NR/NG/R/G&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Probing for `Winbond W83L785TS=
-S&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0No</div>

<div>Probing for `Analog Devices ADM9240&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Probing for `Dal=
las Semiconductor DS1780&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0No</div><div>Probing for `National Semiconductor LM81&#39;... =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div>

<div>Probing for `Analog Devices ADM1026&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Probing for `Ana=
log Devices ADM1025&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Probing for `Texas Instruments AMC682=
1&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No<=
/div>

<div>Probing for `Analog Devices ADM1029&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Probing for `Ana=
log Devices ADM1030&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Probing for `Analog Devices ADM1031&#=
39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 No</div>

<div>Probing for `Analog Devices ADM1022&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Probing for `Tex=
as Instruments THMC50&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 No</div><div>Probing for `Analog Devices ADM1028&#39;... =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</d=
iv>

<div>Probing for `Texas Instruments THMC51&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Probing for `ITE IT8712=
F&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div>Probing for `S=
MSC DME1737&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div>

<div>Probing for `SMSC SCH5027D-NW&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Pr=
obing for `Fintek F75373S/SG&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No</div><div><b>Probing=
 for `Fintek F75375S/SP&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Success!</b></div>

<div><b>=C2=A0=C2=A0 =C2=A0(confidence 7, driver `f75375s&#39;)</b></div><d=
iv>Probing for `Fintek F75387SG/RG&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div>Probing f=
or `Winbond W83791SD&#39;... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 No</div><div><br>

</div><div>Now follows a summary of the probes I have just done.</div><div>=
Just press ENTER to continue:=C2=A0</div><div><br></div><div>Driver `it87&#=
39;:</div><div>=C2=A0=C2=A0* ISA bus, address 0x290</div><div>=C2=A0=C2=A0 =
=C2=A0Chip `ITE IT8712F Super IO Sensors&#39; (confidence: 9)</div>

<div><br></div><div><b>Driver `f75375s&#39;:</b></div><div><b>=C2=A0=C2=A0*=
 Bus `NVIDIA i2c adapter &#39;</b></div><div><b>=C2=A0=C2=A0 =C2=A0Busdrive=
r `nvidia&#39;, I2C address 0x2e</b></div><div><b>=C2=A0=C2=A0 =C2=A0Chip `=
Fintek F75375S/SP&#39; (confidence: 7)</b></div>

<div><br></div><div>Driver `k8temp&#39; (autoloaded):</div><div>=C2=A0=C2=
=A0* Chip `AMD K8 thermal sensors&#39; (confidence: 9)</div><div><br></div>=
<div>To load everything that is needed, add this to /etc/modules:</div><div=
>#----cut here----</div>

<div># Chip drivers</div><div><b>f75375s</b></div><div>it87</div><div>#----=
cut here----</div><div>If you have some drivers built into your kernel, the=
 list above will</div><div>contain too many modules. Skip the appropriate o=
nes!</div>

<div><br></div><div>Do you want to add these lines automatically to /etc/mo=
dules? (yes/NO)</div><div><br></div><div>Unloading i2c-dev... OK</div><div>=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</div><div><br></div>

<div>After loading kernel module=C2=A0f75375s sensors does not show any=C2=
=A0f75375s info:</div><div><br></div><div><div>$ lsmod | grep f75375s</div>=
<div>f75375s =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A011789 =
=C2=A00</div></div><div><br></div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>

<div><div>k8temp-pci-00c3</div><div>Adapter: PCI adapter</div><div>Core0 Te=
mp: =C2=A0+34.0=C2=B0C =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</=
div><div>Core1 Temp: =C2=A0+33.0=C2=B0C =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0</div><div><br></div><div>it8712-isa-0290</div>

<div>Adapter: ISA adapter</div><div>in0: =C2=A0 =C2=A0 =C2=A0 =C2=A0 +1.14 =
V =C2=A0(min =3D =C2=A0+0.00 V, max =3D =C2=A0+4.08 V) =C2=A0=C2=A0</div><d=
iv>in1: =C2=A0 =C2=A0 =C2=A0 =C2=A0 +2.56 V =C2=A0(min =3D =C2=A0+0.00 V, m=
ax =3D =C2=A0+4.08 V) =C2=A0=C2=A0</div><div>in2: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 +3.30 V =C2=A0(min =3D =C2=A0+0.00 V, max =3D =C2=A0+4.08 V) =C2=A0=C2=
=A0</div>

<div>in3: =C2=A0 =C2=A0 =C2=A0 =C2=A0 +2.03 V =C2=A0(min =3D =C2=A0+0.00 V,=
 max =3D =C2=A0+4.08 V) =C2=A0=C2=A0</div><div>in4: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 +3.06 V =C2=A0(min =3D =C2=A0+0.00 V, max =3D =C2=A0+4.08 V) =C2=A0=
=C2=A0</div><div>in5: =C2=A0 =C2=A0 =C2=A0 =C2=A0 +2.38 V =C2=A0(min =3D =
=C2=A0+0.00 V, max =3D =C2=A0+4.08 V) =C2=A0=C2=A0</div><div>in6: =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 +2.46 V =C2=A0(min =3D =C2=A0+0.00 V, max =3D =C2=A0+4=
.08 V) =C2=A0=C2=A0</div>

<div>in7: =C2=A0 =C2=A0 =C2=A0 =C2=A0 +2.48 V =C2=A0(min =3D =C2=A0+0.00 V,=
 max =3D =C2=A0+4.08 V) =C2=A0=C2=A0</div><div>Vbat: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0+4.08 V</div><div>fan1: =C2=A0 =C2=A0 =C2=A0 3245 RPM =C2=A0(min =3D =
=C2=A0664 RPM, div =3D 8)</div><div>fan3: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00 RPM =C2=A0(min =3D =C2=A0 =C2=A00 RPM, div =3D 8)</div><div>
temp1: =C2=A0 =C2=A0 =C2=A0 -55.0=C2=B0C =C2=A0(low =C2=A0=3D +127.0=C2=B0C=
, high =3D +127.0=C2=B0C) =C2=A0sensor =3D thermistor</div>
<div>temp2: =C2=A0 =C2=A0 =C2=A0 +30.0=C2=B0C =C2=A0(low =C2=A0=3D +127.0=
=C2=B0C, high =3D +60.0=C2=B0C) =C2=A0sensor =3D thermistor</div><div>temp3=
: =C2=A0 =C2=A0 =C2=A0 +70.0=C2=B0C =C2=A0(low =C2=A0=3D +127.0=C2=B0C, hig=
h =3D +127.0=C2=B0C) =C2=A0sensor =3D thermistor</div><div>cpu0_vid: =C2=A0=
 +1.100 V</div></div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>

<div><br></div><div>Where is the problem? And why is no f75375s temp detect=
ed by lm sensors?</div><div><br></div><div>I tried program nvclock and it s=
how me correct=C2=A0f75375s temp without problem:</div><div><br></div><div>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</div>
<div>$ nvclock -i</div><div>...</div><div><div>-- Sensor info --</div><div>=
Sensor: Fintek F75375S</div><div>Board temperature: 46C</div><div>GPU tempe=
rature: 52C</div><div>Fanspeed: 4702 RPM</div><div>PWM duty cycle: 42.6%</d=
iv>

</div><div>...</div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><br>-- <br>Pali Roh=C3=A1r<br><a =
href=3D"mailto:pali.rohar@gmail.com">pali.rohar@gmail.com</a><br><br><br>
</div>

--90e6ba6e83f672f48104983be829--


--===============5872470332275131397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5872470332275131397==--
