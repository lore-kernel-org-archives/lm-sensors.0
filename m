From: Markus Rupprecht <rupprecht2@ullstein-realschule-fuerth.de>
Date: Wed, 26 Sep 2012 15:24:29 +0000
Subject: [lm-sensors] Problem with a Core2Quad on DG33FB
Message-Id: <50631E2D.3030001@ullstein-realschule-fuerth.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I'm the admin of a school. Our School-Server has a Intel DG33FB=20
Mainboard (Intel G33 Express) with a Intel Core2Quad processor.

We are running Debian Lenny 2.6.35.9

While doing a backup with clonezilla there was the message, that the cpu=20
is too hot and that the cpu will work slower.
After restarting the server I put the four cores in kde systemmonitor=20
(in german it's calles KDE Systemueberwachung).
It shows -0,77 =B0C -0,77 =B0C 100 =B0C 95 =B0C right now. I guess the deci=
mal=20
numbers are above 100=B0C.

Now I'm unshure, if this could be right.

So I did sensors-detect
12:26/0 server ~ # sensors-detect
# sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)

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
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 2000 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
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

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   Yes
Found `Nat. Semi. PC8374L Super IO Sensors'
     (but not activated)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         Success!
     (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp' (should be inserted):
   Detects correctly:
   * Chip `Intel Core family thermal sensor' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To load everything that is needed, add this to /etc/modules:

#----cut here----
# Chip drivers
# Warning: the required module coretemp is not currently installed
# on your system. For status of 2.6 kernel ports check
# http://www.lm-sensors.org/wiki/Devices. If driver is built
# into the kernel, or unavailable, comment out the following line.
coretemp
#----cut here----

Do you want to add these lines automatically? (yes/NO)

I checked: coretemp is build in the kernel.
I googled "PC8374L" and fount that i have to use lm85.

I loaded the lm85 module (it was not there before):

2:28/0 server ~ # lsmod |grep lm85
lm85                   16761  0
hwmon_vid               1798  1 lm85
i2c_core               17679  7=20
lm85,i2c_dev,i915,drm_kms_helper,drm,i2c_algo_bit,i2c_i801

Now I get:

12:28/1 server ~ # sensors
coretemp-isa-0000
Adapter: ISA adapter
ERROR: Can't get value of subfeature temp1_input: Can't read
Core 0:       +0.0 C  (high =3D +84.0 C, crit =3D +100.0 C)  ALARM

coretemp-isa-0001
Adapter: ISA adapter
Core 2:     +100.0 C  (high =3D +84.0 C, crit =3D +100.0 C)  ALARM

coretemp-isa-0002
Adapter: ISA adapter
ERROR: Can't get value of subfeature temp1_input: Can't read
Core 1:       +0.0 C  (high =3D +84.0 C, crit =3D +100.0 C)  ALARM

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +96.0 C  (high =3D +84.0 C, crit =3D +100.0 C)


Can this be true? On the cpu is a very huge cooler with heatpipes and a=20
large fan. When I touch it, it is not hot. It seams to be mounted ok.

Can anybody help?

Thank you,

Markus


P. S.
12:33/0 server /usr/src/linux-2.6.35.9 # lsmod |grep i2c
i2c_dev                 3677  0
i2c_algo_bit            4075  1 i915
i2c_i801                7081  0
i2c_core               17679  7=20
lm85,i2c_dev,i915,drm_kms_helper,drm,i2c_algo_bit,i2c_i801



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
