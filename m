From: Gabriel C <crazy@frugalware.org>
Date: Thu, 17 Apr 2008 16:04:20 +0000
Subject: [lm-sensors] ASUS P5E-VM DO and unknown chip with ID 0x0b00
Message-Id: <48077504.4000905@frugalware.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all,

I got an new ASUS P5E-VM DO motherboard and I'm somewhat confused about wha=
t lmsensors detects.

Also I run linux 2.6.25-rc9-git* at the moment with lm-sensors 3.0.1.

I know the motherboard has an W83627DHG-A Super I/O chip which is detected =
correctly but doesn't seems to get
the CPU fan speed at all and almost everything was on ALARM by default =3D).
I've change the config a bit and the most things seems to work now.
I'll work on a config for that motherboard over the weekend most probably.

( from BIOS HW Monitoring section I can see the fan speed correctly )

Also sensors-detect found an SMSC chip ( no idea where this one is locate o=
n motherboard =3D) ) but with and unknow chip ID. It is possible to figure =
what chip that is and the correct ID ?

Output of sensors :

w83627dhg-isa-0290
Adapter: ISA adapter
VCore:       +1.12 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:        +11.25 V  (min =3D +10.82 V, max =3D +13.20 V)
AVCC:        +3.28 V  (min =3D  +3.14 V, max =3D  +3.47 V)
3VCC:        +3.26 V  (min =3D  +3.14 V, max =3D  +3.47 V)
in4:         +1.66 V  (min =3D  +0.72 V, max =3D  +0.48 V)   ALARM
in5:         +1.66 V  (min =3D  +0.91 V, max =3D  +0.37 V)   ALARM
in6:         +5.25 V  (min =3D  +4.76 V, max =3D  +5.25 V)
VSB:         +3.28 V  (min =3D  +3.14 V, max =3D  +3.47 V)
VBAT:        +3.20 V  (min =3D  +3.14 V, max =3D  +3.47 V)
Case Fan:      0 RPM  (min =3D 1318 RPM, div =3D 128)  ALARM
CPU Fan:       0 RPM  (min =3D 1757 RPM, div =3D 128)  ALARM
Aux Fan:       0 RPM  (min =3D  100 RPM, div =3D 128)  ALARM
fan4:          0 RPM  (min =3D 7031 RPM, div =3D 32)  ALARM
fan5:          0 RPM  (min =3D 14062 RPM, div =3D 32)  ALARM
Sys Temp:    +31.0=B0C  (high =3D +45.0=B0C, hyst =3D +40.0=B0C)  sensor =
=3D thermistor
CPU Temp:    +25.0=B0C  (high =3D +45.0=B0C, hyst =3D +40.0=B0C)  sensor =
=3D diode
AUX Temp:     +2.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
cpu0_vid:   +1.550 V

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +44.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +48.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +46.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +46.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

Output of sensors-detect:

sensors-detect
# sensors-detect revision 5108 (2008-01-22 13:22:47 +0100)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel ICH9

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 0400 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x50
Handled by driver `eeprom' (already loaded), chip type `eeprom'
    (note: this is probably NOT a sensor chip!)
Client found at address 0x52
Handled by driver `eeprom' (already loaded), chip type `eeprom'
    (note: this is probably NOT a sensor chip!)

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `Winbond W83627DHG Super IO Sensors'                  Success!
    (address 0x290, driver `w83627ehf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0x0b00

Some CPUs or memory controllers may also contain embedded sensors.
Do you want to scan for them? (YES/no):
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.


Please let me know if you guys need more infos.

Probably OT here but I've tested linux-next from yesterday and I got the fo=
llowing ACPI warning for w83627ehf :

...

[   19.960897] w83627ehf: Found W83627DHG chip at 0x290
[   19.961068] ACPI: I/O resource w83627ehf [0x295-0x296] conflicts with AC=
PI region HWRE [0x290-0x299]
[   19.961145] ACPI: Device needs an ACPI driver

...


Best Regards,

Gabriel C


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
