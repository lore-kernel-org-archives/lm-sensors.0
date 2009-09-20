From: "Sander" <san@fast-mail.nl>
Date: Sun, 20 Sep 2009 22:14:48 +0000
Subject: [lm-sensors] strange values when reading sensors
Message-Id: <0bf096687409de1be8dadc8082376124.squirrel@webmail.fast-mail.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I see some strange values when i read the mainboard sensors, some of theme
are in ALARM.
I have 4 questions about this, maybe someone can explain this?

1) Why does this happen and what values should i trust?
2) Why are there 2 sensors and what parts do they control?
3) Where can i find the reference from the output? like temp1=3D for example
cpu temp2=3D mainbord, etc...
4) My mainboard is a SuperMicro "X6DVL-EG2" with kernel
"2.6.30.5-43.fc11.i586" (FC11), do i need to set the
"acpi_enforce_resources=3Dlax" parameter at boot to ensure system stability?

I have included the output from both "sensors" and sensors-detect" for
reference.

Thanks in advance,

Sander.
-----------------
w83627hf-isa-0290
Adapter: ISA adapter
in0:         +1.52 V  (min =3D  +1.34 V, max =3D  +1.65 V)
in1:         +3.33 V  (min =3D  +2.96 V, max =3D  +3.62 V)
in2:         +3.38 V  (min =3D  +2.96 V, max =3D  +3.62 V)
in3:         +3.04 V  (min =3D  +2.67 V, max =3D  +3.26 V)
in4:         +3.25 V  (min =3D  +2.83 V, max =3D  +3.47 V)
in5:         +0.62 V  (min =3D  +0.42 V, max =3D  +0.86 V)
in6:         +2.61 V  (min =3D  +0.38 V, max =3D  +0.26 V)   ALARM
in7:         +3.33 V  (min =3D  +0.51 V, max =3D  +2.27 V)   ALARM
in8:         +3.25 V  (min =3D  +1.25 V, max =3D  +0.19 V)   ALARM
fan1:          0 RPM  (min =3D    0 RPM, div =3D 2)
fan2:          0 RPM  (min =3D 4591 RPM, div =3D 2)  ALARM
fan3:          0 RPM  (min =3D 3994 RPM, div =3D 2)  ALARM
temp1:       +33.0=A7=D2=A8cC  (high =3D +80.0=A7=D2=A8cC, hyst =3D  +0.0=
=A7=D2=A8cC)  sensor thermistor
temp2:       +31.0=A7=D2=A8cC  (high =3D +80.0=A7=D2=A8cC, hyst =3D +75.0=
=A7=D2=A8cC)  sensor thermistor
temp3:       +30.0=A7=D2=A8cC  (high =3D +80.0=A7=D2=A8cC, hyst =3D +75.0=
=A7=D2=A8cC)  sensor thermistor
cpu0_vid:   +0.000 V
beep_enable:enabled

w83792d-i2c-0-2f
Adapter: SMBus I801 adapter at 0540
VcoreA:      +1.32 V  (min =3D  +0.00 V, max =3D  +2.04 V)
VcoreB:      +1.34 V  (min =3D  +0.00 V, max =3D  +2.04 V)
in2:         +1.82 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in3:         +0.90 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in4:         +1.20 V  (min =3D  +1.07 V, max =3D  +1.31 V)
in5:         +1.82 V  (min =3D  +1.62 V, max =3D  +1.97 V)
+5V:         +5.09 V  (min =3D  +4.49 V, max =3D  +5.50 V)
5VSB:        +4.98 V  (min =3D  +4.49 V, max =3D  +5.50 V)
Vbat:        +0.00 V  (min =3D  +2.69 V, max =3D  +3.30 V)   ALARM
fan1:       4218 RPM  (min =3D  712 RPM, div =3D 8)
fan2:       4218 RPM  (min =3D  712 RPM, div =3D 8)
fan3:          0 RPM  (min =3D  712 RPM, div =3D 8)  ALARM
fan4:          0 RPM  (min =3D  712 RPM, div =3D 8)  ALARM
fan6:          0 RPM  (min =3D  712 RPM, div =3D 8)  ALARM
fan7:          0 RPM  (min =3D    0 RPM, div =3D 8)
temp1:       +46.0=A7=D2=A8cC  (high =3D +127.0=A7=D2=A8cC, hyst =3D  +0.0=
=A7=D2=A8cC)
temp2:       +33.0=A7=D2=A8cC  (high =3D +78.0=A7=D2=A8cC, hyst =3D +68.0=
=A7=D2=A8cC)
temp3:       +36.5=A7=D2=A8cC  (high =3D +78.0=A7=D2=A8cC, hyst =3D +68.0=
=A7=D2=A8cC)



# sensors-detect revision 5666 (2009-02-26 17:15:04 +0100)
# System: Supermicro X6DVL-EG2

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal and voltage sensors...                       No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `Winbond W83627HF/F/HG/G Super IO Sensors'            Success!
    (address 0x290, driver `w83627hf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We have to read from arbitrary I/O ports to probe for such interfaces.
This is normally safe. Do you want to scan for IPMI interfaces?
(YES/no):
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
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 6300ESB
Module i2c-dev loaded successfully.

Next adapter: SMBus I801 adapter at 0540 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x2c
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
Probing for `Analog Devices ADT7470'...                     No
Probing for `Analog Devices ADT7476'...                     No
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
Probing for `Winbond W83627HF'...                           Success!
    (confidence 7, driver `use-isa-instead', other addresses: 0x48 0x49)
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG'...                          No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Genesys Logic GL518SM'...                      No
Probing for `Genesys Logic GL520SM'...                      No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1026'...                     No
Probing for `Analog Devices ADM1025'...                     No
Probing for `Philips NE1619'...                             No
Probing for `Analog Devices ADM1029'...                     No
Probing for `Analog Devices ADM1030'...                     No
Probing for `Analog Devices ADM1031'...                     No
Probing for `Analog Devices ADM1022'...                     No
Probing for `Texas Instruments THMC50'...                   No
Probing for `ITE IT8712F'...                                No
Probing for `ALi M5879'...                                  No
Probing for `SMSC LPC47M15x/192/292/997'...                 No
Probing for `SMSC DME1737'...                               No
Probing for `SMSC SCH5027D-NW'...                           No
Probing for `Winbond W83791SD'...                           No
Client found at address 0x2f
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `Analog Devices ADT7470'...                     No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83791D'...                            No
Probing for `Winbond W83792D'...                            Success!
    (confidence 7, driver `w83792d', other addresses: 0x4b 0x4f)
Probing for `Winbond W83793R/G'...                          No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG'...                          No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Winbond W83L786NR/NG/R/G'...                   No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1029'...                     No
Probing for `ITE IT8712F'...                                No
Probing for `Fintek custom power control IC'...             No
Probing for `Winbond W83791SD'...                           No
Client found at address 0x48
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `National Semiconductor LM77'...                No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `Maxim MAX6650/MAX6651'...                      No
Probing for `National Semiconductor LM92'...                No
Probing for `National Semiconductor LM76'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x49
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `National Semiconductor LM77'...                No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `National Semiconductor LM92'...                No
Probing for `National Semiconductor LM76'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x4b
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `National Semiconductor LM77'...                No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `Maxim MAX6650/MAX6651'...                      No
Probing for `National Semiconductor LM92'...                No
Probing for `National Semiconductor LM76'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `Analog Devices ADT7481'...                     No
Client found at address 0x4f
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `w83792d':
  * Bus `SMBus I801 adapter at 0540'
    Busdriver `i2c_i801', I2C address 0x2f (and 0x4b 0x4f)
    Chip `Winbond W83792D' (confidence: 7)

Driver `w83627hf':
  * ISA bus, address 0x290
    Chip `Winbond W83627HF/F/HG/G Super IO Sensors' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
Starting lm_sensors: loading module w83627hf w83792d       [  OK  ]
Unloading i2c-dev... OK


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
