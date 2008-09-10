From: Dean Loros <autocrosser1@gmail.com>
Date: Wed, 10 Sep 2008 14:02:45 +0000
Subject: Re: [lm-sensors] Results of running your sensors-detect
Message-Id: <48C7D385.7090208@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48C719D9.90000@gmail.com>
In-Reply-To: <48C719D9.90000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

OK Jean---

ran check---results.

dean@linux:~/Desktop$ sudo rmmod lm78
[sudo] password for dean:
dean@linux:~/Desktop$ sudo rmmod w83627ehf
dean@linux:~/Desktop$ sudo rmmod i2c-nforce2
dean@linux:~/Desktop$ chmod 755 '/home/dean/Desktop/sensors-detect'
dean@linux:~/Desktop$ sudo '/home/dean/Desktop/sensors-detect'
# sensors-detect revision $Revision$

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): y
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 0000:00:0a.1: nVidia Corporation
nForce4 SMBus (MCP51)

We will now try to load each adapter module in turn.
Load `i2c-nforce2' (say NO if built into your kernel)? (YES/no): y
Module loaded successfully.
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no): y
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus nForce2 adapter at 1c00 (i2c-0)
Do you want to scan it? (YES/no/selectively): y
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
Probing for `EDID EEPROM'...                                No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Next adapter: SMBus nForce2 adapter at 1c80 (i2c-1)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x2d
Probing for `Myson MTP008'...                               No
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM78-J'...              No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `National Semiconductor LM85'...                No
Probing for `National Semiconductor LM96000'...             No
Probing for `Analog Devices ADM1027'...                     No
Probing for `Analog Devices ADT7460 or ADT7463'...          No
Probing for `SMSC EMC6D100 or EMC6D101'...                  No
Probing for `SMSC EMC6D102'...                              No
Probing for `SMSC EMC6D103'...                              No
Probing for `Analog Devices ADT7476'...                     No
Probing for `Andigilog aSC7611'...                          No
Probing for `Andigilog aSC7621'...                          No
Probing for `National Semiconductor LM87'...                No
Probing for `National Semiconductor LM93'...                No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83783S'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          No
Probing for `Winbond W83791SD'...                           No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG'...                          No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Winbond W83L784R/AR/G'...                      No
Probing for `Winbond W83L785R/G'...                         No
Probing for `Genesys Logic GL518SM Revision 0x00'...        No
Probing for `Genesys Logic GL518SM Revision 0x80'...        No
Probing for `Genesys Logic GL520SM'...                      No
Probing for `Genesys Logic GL525SM'...                      No
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
Probing for `VIA VT1211 (I2C)'...                           No
Probing for `ITE IT8712F'...                                No
Probing for `ALi M5879'...                                  No
Probing for `SMSC LPC47M15x/192/292/997'...                 No
Probing for `SMSC DME1737'...                               No
Probing for `SMSC SCH5027D-NW'...                           No
Probing for `Fintek F75373S/SG'...                          No
Probing for `Fintek F75375S/SP'...                          No
Probing for `Fintek F75387SG/RG'...                         No
Probing for `Analog Devices ADM1024'...                     No
Probing for `Winbond W83791D'...                            No
Client found at address 0x49
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `National Semiconductor LM77'...                No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `National Semiconductor LM92'...                No
Probing for `National Semiconductor LM76'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No

Next adapter: NVIDIA i2c adapter  (i2c-2)
Do you want to scan it? (YES/no/selectively): y

Next adapter: NVIDIA i2c adapter  (i2c-3)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x4a
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
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)

Next adapter: NVIDIA i2c adapter  (i2c-4)
Do you want to scan it? (YES/no/selectively): y

Next adapter: NVIDIA i2c adapter  (i2c-5)
Do you want to scan it? (YES/no/selectively): y

Next adapter: NVIDIA i2c adapter  (i2c-6)
Do you want to scan it? (YES/no/selectively): y

Next adapter: NVIDIA i2c adapter  (i2c-7)
Do you want to scan it? (YES/no/selectively): y

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): y
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): y
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `Winbond W83627DHG Super IO Sensors'                  Success!
    (address 0x290, driver `w83627ehf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no): y
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal and voltage sensors...                       No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `w83627ehf' (should be inserted):
  Detects correctly:
  * ISA bus, address 0x290
    Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)

Driver `coretemp' (should be inserted):
  Detects correctly:
  * Chip `Intel Core family thermal sensor' (confidence: 9)

Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO): n
To load everything that is needed, add this to one of the system
initialization scripts (e.g. /etc/rc.d/rc.local):

#----cut here----
# Chip drivers
modprobe w83627ehf
modprobe coretemp
/usr/bin/sensors -s
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.

Next i2c-dev run:

dean@linux:~/Desktop$ modprobe i2c-dev
dean@linux:~/Desktop$ i2cdump 1 0x49
No size specified (using byte-data access)
Error: Could not open file `/dev/i2c-1': Permission denied
Run as root?
dean@linux:~/Desktop$ sudo i2cdump 1 0x49
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-1, address 0x49, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff 00 8d 00 00 ff ff ff ff    .........?......

Left lm78 unloaded--what next?

Cheers!!
Dean


Jean Delvare wrote:
> Hi Dean,
>=20
> On Tue, 09 Sep 2008 17:50:33 -0700, Dean Loros wrote:
>> Hi Jean--
>>
>> I'm baffled--I ran the copy of sensors-detect you wanted me
>> to....Results are:
>>
>> dean@linux:~/Desktop$ sudo '/home/dean/Desktop/sensors-detect'
>> (...)
>> Next adapter: SMBus nForce2 adapter at 1c80 (i2c-1)
>> Do you want to scan it? (YES/no/selectively): y
>> Client found at address 0x2d
>> (...)
>> Probing for `National Semiconductor LM78'...                Success!
>>     (confidence 6, driver `lm78')
>=20
> The code preventing the misdetection was only for ISA access to the
> device, not I2C access. I've just fixed that.
>=20
>> (...)
>> Probing for `Winbond W83627DHG'...                          No
>=20
> This fails because the chip is not in bank 0 (and we can't reliably
> detect it in that case.) No big deal anyway, the w83627ehf driver
> doesn't make use of the I2C interface, so this detection doesn't need
> to succeed for things to work.
>=20
>> (...)
>> Client found at address 0x49
>> Probing for `National Semiconductor LM75'...                No
>> Probing for `Dallas Semiconductor DS75'...                  No
>> Probing for `National Semiconductor LM77'...                No
>> Probing for `Dallas Semiconductor DS1621/DS1631'...         No
>> Probing for `National Semiconductor LM92'...                No
>> Probing for `National Semiconductor LM76'...                No
>> Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
>=20
> Mysterious one. Please provide the output of:
>=20
> modprobe i2c-dev
> i2cdump 1 0x49
>=20
> Maybe that's a new chip we don't know about.
>=20
> The rest is as expected.
>=20
>> Values afterwards:
>>
>>
>> dean@linux:~/Desktop$ sensors
>> acpitz-virtual-0
>> Adapter: Virtual device
>> temp1:       +40.0=B0C  (crit =3D +60.0=B0C)
>>
>> w83627dhg-isa-0290
>> Adapter: ISA adapter
>> VCore:       +1.28 V  (min =3D  +1.05 V, max =3D  +1.58 V)
>> in1:         +6.92 V  (min =3D  +5.91 V, max =3D +10.40 V)
>> AVCC:        +3.33 V  (min =3D  +2.30 V, max =3D  +3.47 V)
>> 3VCC:        +3.33 V  (min =3D  +3.50 V, max =3D  +4.08 V)   ALARM
>> in4:         +1.28 V  (min =3D  +2.04 V, max =3D  +2.04 V)   ALARM
>> in5:         +1.55 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
>> in6:         +5.86 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
>> VSB:         +3.33 V  (min =3D  +3.14 V, max =3D  +3.47 V)
>> VBAT:        +3.04 V  (min =3D  +2.64 V, max =3D  +3.47 V)
>> Case Fan:   3125 RPM  (min =3D  332 RPM, div =3D 16)
>> CPU Fan:    2556 RPM  (min =3D  332 RPM, div =3D 16)
>> Aux Fan:       0 RPM  (min =3D  340 RPM, div =3D 128)  ALARM
>> fan4:       1654 RPM  (min =3D  803 RPM, div =3D 16)
>> fan5:          0 RPM  (min =3D    0 RPM, div =3D 128)
>> CPU Temp:    +34.0=B0C  (high =3D +127.0=B0C, hyst =3D  +0.0=B0C)  senso=
r =3D transistor
>> M/B Temp:    +36.5=B0C  (high =3D  +1.0=B0C, hyst =3D  +0.0=B0C)  ALARM =
 sensor >> thermistor
>>
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Core 0:      +38.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>>
>> coretemp-isa-0001
>> Adapter: ISA adapter
>> Core 1:      +45.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>>
>> coretemp-isa-0002
>> Adapter: ISA adapter
>> Core 2:      +45.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>>
>> coretemp-isa-0003
>> Adapter: ISA adapter
>> Core 3:      +47.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>>
>> lm78-i2c-1-2d
>> Adapter: SMBus nForce2 adapter at 1c80
>> VCore 1:     +2.56 V  (min =3D  +2.10 V, max =3D  +3.15 V)
>> VCore 2:     +2.10 V  (min =3D  +1.79 V, max =3D  +3.15 V)
>> +3.3V:       +3.33 V  (min =3D  +2.30 V, max =3D  +3.47 V)
>> +5V:         +3.33 V  (min =3D  +3.50 V, max =3D  +4.08 V)   ALARM
>> +12V:        +2.56 V  (min =3D  +4.08 V, max =3D  +4.08 V)   ALARM
>> -12V:        +3.10 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
>> -5V:         +3.66 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
>> fan1:       50000 RPM  (min =3D 5314 RPM, div =3D 1)  ALARM
>> fan2:       40909 RPM  (min =3D 5314 RPM, div =3D 1)  ALARM
>> fan3:          0 RPM  (min =3D 21774 RPM, div =3D 2)  ALARM
>> temp1:       +88.0=B0C  (high =3D +100.0=B0C, hyst =3D +120.0=B0C)  ALARM
>> cpu0_vid:   +3.000 V
>>
>>
>> I would say that SMBus nForce2 has my two "missing" fan speeds, but
>> looks like the multiplier is a bit off......
>=20
> No, no. Again, the LM78 is a misdetection. Do not load the lm78 driver.
> I don't know what chip handles your extra fans, but that's definitely
> not the chip at I2C address 1-2d.
>=20
>> What do you think?
>=20
> Please download the latest version of sensors-detect again:
> http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-3.0.0/pr=
og/detect/sensors-detect?format=3Dtxt
> I've fixed the misdetection, it will no longer suggest the lm78 driver.
>=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
