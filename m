From: ingo.gb@gmail.com
Date: Mon, 18 Jan 2010 11:19:16 +0000
Subject: [lm-sensors] strange lm_sensors readings
Message-Id: <201001181219.16657.ingo.gb@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I get readings which are some 20 degrees Centigrade off the BIOS readings. =

Below a sensors-detect (I went along with the defaults) followed by a senso=
rs=20
command.=20

I have a P45TurboTwins2000 mobo from ASRock. Please let me know if there is=
=20
any other information you require...

toad@deskarch 983\5 ~ > sudo sensors-detect=20
Password:                                  =20
# sensors-detect revision 5729 (2009-06-02 15:51:29 +0200)
# System: To Be Filled By O.E.M. To Be Filled By O.E.M.  =20

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe =20
and recommended to accept the default answers to all questions,  =20
unless you know what you're doing.                               =20

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):          =20
Silicon Integrated Systems SIS5595...                       No         =20
VIA VT82C686 Integrated Sensors...                          No         =20
VIA VT8231 Integrated Sensors...                            No         =20
AMD K8 thermal sensors...                                   No         =20
AMD K10 thermal sensors...                                  No         =20
Intel Core family thermal sensor...                         Success!   =20
    (driver `coretemp')                                                =20
Intel AMB FB-DIMM thermal sensor...                         No         =20
VIA C7 thermal and voltage sensors...                       No         =20

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.          =20
Do you want to scan for Super I/O sensors? (YES/no):             =20
Probing for Super-I/O at 0x2e/0x2f                               =20
Trying family `National Semiconductor'...                   No   =20
Trying family `SMSC'...                                     No   =20
Trying family `VIA/Winbond/Fintek'...                       Yes  =20
Found `Winbond W83627DHG Super IO Sensors'                  Success!
    (address 0x290, driver `w83627ehf')                            =20
Probing for Super-I/O at 0x4e/0x4f                                 =20
Trying family `National Semiconductor'...                   No     =20
Trying family `SMSC'...                                     No     =20
Trying family `VIA/Winbond/Fintek'...                       No     =20
Trying family `ITE'...                                      No     =20

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it   =20
there, we have to read from arbitrary I/O ports to probe for such      =20
interfaces. This is normally safe. Do you want to scan for IPMI        =20
interfaces? (YES/no):                                                  =20
Probing for `IPMI BMC KCS' at 0xca0...                      No         =20
Probing for `IPMI BMC SMIC' at 0xca8...                     No         =20

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually =20
safe though. Yes, you do have ISA I/O ports even if you do not have any=20
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO):            =20

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.                                                     =20
Do you want to probe the I2C/SMBus adapters now? (YES/no):           =20
Using driver `i2c-i801' for device 0000:00:1f.3: Intel ICH10         =20
WARNING: All config files need .conf: /etc/modprobe.d/uvesafb.conf.pacsave,=
 it=20
will be ignored in a future release.
Module i2c-dev loaded successfully.                                        =
                                       =20

Next adapter: SMBus I801 adapter at 0400 (i2c-0)
Do you want to scan it? (yes/NO/selectively):  =20

Next adapter: NVIDIA i2c adapter  (i2c-1)
Do you want to scan it? (YES/no/selectively):=20
Client found at address 0x4a                 =20
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `National Semiconductor LM77'...                No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `National Semiconductor LM92'...                No
Probing for `National Semiconductor LM76'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x4b                                 =20
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `National Semiconductor LM77'...                No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `Maxim MAX6650/MAX6651'...                      No
Probing for `National Semiconductor LM92'...                No
Probing for `National Semiconductor LM76'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `Analog Devices ADT7481'...                     No
Client found at address 0x50                                 =20
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)            =20
Client found at address 0x51                                  =20
Probing for `Analog Devices ADM1033'...                     No=20
Probing for `Analog Devices ADM1034'...                     No=20
Probing for `SPD EEPROM'...                                 No=20

Next adapter: NVIDIA i2c adapter  (i2c-2)
Do you want to scan it? (YES/no/selectively):=20

Next adapter: NVIDIA i2c adapter  (i2c-3)
Do you want to scan it? (YES/no/selectively):=20

Now follows a summary of the probes I have just done.
Just press ENTER to continue:                       =20

Driver `w83627ehf':
  * ISA bus, address 0x290
    Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)

Driver `coretemp':
  * Chip `Intel Core family thermal sensor' (confidence: 9)

Do you want to overwrite /etc/conf.d/lm_sensors? (YES/no):=20
Copy prog/init/lm_sensors.init to /etc/rc.d/lm_sensors    =20
for initialization at boot time.                          =20
You should now start the lm_sensors service to load the required
kernel modules.                                                =20

Unloading i2c-dev... OK


toad@deskarch 983\6 ~ > sensors
coretemp-isa-0000             =20
Adapter: ISA adapter          =20
Core 0:      +50.0=B0C  (high =3D +78.0=B0C, crit =3D +100.0=B0C) =20

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +44.0=B0C  (high =3D +78.0=B0C, crit =3D +100.0=B0C)

w83627dhg-isa-0290
Adapter: ISA adapter
Vcore:       +1.21 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:         +1.83 V  (min =3D  +1.98 V, max =3D  +1.80 V)   ALARM
AVCC:        +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
VCC:         +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:         +1.12 V  (min =3D  +1.40 V, max =3D  +0.44 V)   ALARM
in5:         +1.66 V  (min =3D  +1.59 V, max =3D  +0.73 V)   ALARM
in6:         +1.70 V  (min =3D  +1.95 V, max =3D  +0.61 V)   ALARM
3VSB:        +3.31 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:        +3.15 V  (min =3D  +2.70 V, max =3D  +3.30 V)
fan1:          0 RPM  (min =3D 5273 RPM, div =3D 128)  ALARM
fan2:       1757 RPM  (min =3D 2376 RPM, div =3D 8)  ALARM
fan3:          0 RPM  (min =3D  753 RPM, div =3D 128)  ALARM
fan5:          0 RPM  (min =3D 3515 RPM, div =3D 128)  ALARM
temp1:       +35.0=B0C  (high =3D +58.0=B0C, hyst =3D +91.0=B0C)  sensor =
=3D thermistor
temp2:       +58.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
temp3:       +19.5=B0C  (high =3D +20.0=B0C, hyst =3D +20.0=B0C)  sensor =
=3D thermistor
cpu0_vid:   +2.050 V


toad@deskarch 977\7 ~ >

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
