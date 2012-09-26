From: "rupprecht-admin2, Markus" <rupprecht2@ullstein-realschule-fuerth.de>
Date: Wed, 26 Sep 2012 10:41:52 +0000
Subject: [lm-sensors] Core2Quad and very hight temperature
Message-Id: <92013948.11222.1348656112623.JavaMail.open-xchange@atlas>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8687249147920129619=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8687249147920129619==
Content-Type: multipart/alternative; 
	boundary="----=_Part_11221_1123631865.1348656112568"

------=_Part_11221_1123631865.1348656112568
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm the admin of a school. Our Server ist a Server has a Intel DG33FB Mainb=
oard
(it's Intel G33) with a Intel Core2Quad processor.

We are running Debian Lenny 2.6.35.9

While doing a backup with clonezilla there was the message, that the cpu
temperature is too hot and that the cpu will work slower.
After restarting the server I draw the four cores in kde systemmonitor (in
german it's calles KDE Systemueberwachung).
It shows -0,77 and -0,77 and=C2=A0 100 and 95 =C2=B0C. I guess the decimal =
number is above
100=C2=B0C.

Now I'm unsure, if this could be right.

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
Probing for `Analog Devices ADM1033'...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 No
Probing for `Analog Devices ADM1034'...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 No
Probing for `SPD EEPROM'...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Yes
=C2=A0=C2=A0=C2=A0 (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 No
Probing for `Analog Devices ADM1034'...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 No
Probing for `SPD EEPROM'...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Yes
=C2=A0=C2=A0=C2=A0 (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 No
Probing for `National Semiconductor LM78-J' at 0x290...=C2=A0=C2=A0=C2=A0=
=C2=A0 No
Probing for `National Semiconductor LM79' at 0x290...=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 No
Probing for `Winbond W83781D' at 0x290...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 No
Probing for `Winbond W83782D' at 0x290...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 No
Probing for `IPMI BMC KCS' at 0xca0...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 No
Probing for `IPMI BMC SMIC' at 0xca8...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Yes
Found `Nat. Semi. PC8374L Super IO Sensors'
=C2=A0=C2=A0=C2=A0 (but not activated)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 No
Trying family `SMSC'...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 No
Trying family `VIA/Winbond/Fintek'...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 No
Trying family `ITE'...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no):
Silicon Integrated Systems SIS5595...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 No
VIA VT82C686 Integrated Sensors...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 No
VIA VT8231 Integrated Sensors...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 No
AMD K8 thermal sensors...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 No
AMD K10 thermal sensors...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 No
Intel Core family thermal sensor...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Success!
=C2=A0=C2=A0=C2=A0 (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp' (should be inserted):
=C2=A0 Detects correctly:
=C2=A0 * Chip `Intel Core family thermal sensor' (confidence: 9)

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

I checked: coretemp is build in.
I googled "PC8374L" and fount that i have to use lm85.

I loaded the lm85 module:

2:28/0 server ~ # lsmod |grep lm85
lm85=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16761=C2=A0 0
hwmon_vid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 1798=C2=A0 1 lm85
i2c_core=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 17679=C2=A0 7
lm85,i2c_dev,i915,drm_kms_helper,drm,i2c_algo_bit,i2c_i801

Now I get:

12:28/1 server ~ # sensors
coretemp-isa-0000
Adapter: ISA adapter
ERROR: Can't get value of subfeature temp1_input: Can't read
Core 0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +0.0 C=C2=A0 (high =3D +84.0 C,=
 crit =3D +100.0 C)=C2=A0 ALARM

coretemp-isa-0001
Adapter: ISA adapter
Core 2:=C2=A0=C2=A0=C2=A0=C2=A0 +100.0 C=C2=A0 (high =3D +84.0 C, crit =3D =
+100.0 C)=C2=A0 ALARM

coretemp-isa-0002
Adapter: ISA adapter
ERROR: Can't get value of subfeature temp1_input: Can't read
Core 1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +0.0 C=C2=A0 (high =3D +84.0 C,=
 crit =3D +100.0 C)=C2=A0 ALARM

coretemp-isa-0003
Adapter: ISA adapter
Core 3:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +96.0 C=C2=A0 (high =3D +84.0 C, crit=
 =3D +100.0 C)


Can this be true? On the cpu is a very huge cooler with heatpipes and a lar=
ge
fan. When I touch it, it is not hot. It seams to be mounted ok.

Can anybody help?

Thank you,

Markus


P. S.
12:33/0 server /usr/src/linux-2.6.35.9 # lsmod |grep i2c
i2c_dev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3677=C2=A0 0
i2c_algo_bit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 4075=C2=A0 1 i915
i2c_i801=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 7081=C2=A0 0
i2c_core=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 17679=C2=A0 7
lm85,i2c_dev,i915,drm_kms_helper,drm,i2c_algo_bit,i2c_i801
------=_Part_11221_1123631865.1348656112568
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title></title>
  </head>

  <body>
    <p style="margin: 0px;">Hi,<br/>
    <br/>
    I&#39;m the admin of a school. Our Server ist a Server has a Intel DG33FB Mainboard (it&#39;s Intel G33) with a Intel Core2Quad processor.<br/>
    <br/>
    We are running Debian Lenny 2.6.35.9<br/>
    <br/>
    While doing a backup with clonezilla there was the message, that the cpu temperature is too hot and that the cpu will work slower.<br/>
    After restarting the server I draw the four cores in kde systemmonitor (in german it&#39;s calles KDE Systemueberwachung).<br/>
    It shows -0,77 and -0,77 and&#160; 100 and 95 &#176;C. I guess the decimal number is above 100&#176;C.<br/>
    <br/>
    Now I&#39;m unsure, if this could be right.<br/>
    <br/>
    So I did sensors-detect<br/>
    12:26/0 server ~ # sensors-detect<br/>
    # sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)<br/>
    <br/>
    This program will help you determine which kernel modules you need<br/>
    to load to use lm_sensors most effectively. It is generally safe<br/>
    and recommended to accept the default answers to all questions,<br/>
    unless you know what you&#39;re doing.<br/>
    <br/>
    We can start with probing for (PCI) I2C or SMBus adapters.<br/>
    Do you want to probe now? (YES/no):<br/>
    Probing for PCI bus adapters...<br/>
    Use driver `i2c-i801&#39; for device 0000:00:1f.3: Intel ICH9<br/>
    <br/>
    We will now try to load each adapter module in turn.<br/>
    Module `i2c-i801&#39; already loaded.<br/>
    If you have undetectable or unsupported I2C/SMBus adapters, you can have<br/>
    them scanned by manually loading the modules before running this script.<br/>
    <br/>
    We are now going to do the I2C/SMBus adapter probings. Some chips may<br/>
    be double detected; we choose the one with the highest confidence<br/>
    value in that case.<br/>
    If you found that the adapter hung after probing a certain address,<br/>
    you can specify that address to remain unprobed.<br/>
    <br/>
    Next adapter: SMBus I801 adapter at 2000 (i2c-0)<br/>
    Do you want to scan it? (YES/no/selectively):<br/>
    Client found at address 0x50<br/>
    Probing for `Analog Devices ADM1033&#39;...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    Probing for `Analog Devices ADM1034&#39;...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    Probing for `SPD EEPROM&#39;...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; Yes<br/>
    &#160;&#160;&#160; (confidence 8, not a hardware monitoring chip)<br/>
    Probing for `EDID EEPROM&#39;...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    Client found at address 0x52<br/>
    Probing for `Analog Devices ADM1033&#39;...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    Probing for `Analog Devices ADM1034&#39;...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    Probing for `SPD EEPROM&#39;...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; Yes<br/>
    &#160;&#160;&#160; (confidence 8, not a hardware monitoring chip)<br/>
    Probing for `EDID EEPROM&#39;...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    <br/>
    Some chips are also accessible through the ISA I/O ports. We have to<br/>
    write to arbitrary I/O ports to probe them. This is usually safe though.<br/>
    Yes, you do have ISA I/O ports even if you do not have any ISA slots!<br/>
    Do you want to scan the ISA I/O ports? (YES/no):<br/>
    Probing for `National Semiconductor LM78&#39; at 0x290...&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    Probing for `National Semiconductor LM78-J&#39; at 0x290...&#160;&#160;&#160;&#160; No<br/>
    Probing for `National Semiconductor LM79&#39; at 0x290...&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    Probing for `Winbond W83781D&#39; at 0x290...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    Probing for `Winbond W83782D&#39; at 0x290...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    Probing for `IPMI BMC KCS&#39; at 0xca0...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    Probing for `IPMI BMC SMIC&#39; at 0xca8...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    <br/>
    Some Super I/O chips may also contain sensors. We have to write to<br/>
    standard I/O ports to probe them. This is usually safe.<br/>
    Do you want to scan for Super I/O sensors? (YES/no):<br/>
    Probing for Super-I/O at 0x2e/0x2f<br/>
    Trying family `National Semiconductor&#39;...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; Yes<br/>
    Found `Nat. Semi. PC8374L Super IO Sensors&#39;<br/>
    &#160;&#160;&#160; (but not activated)<br/>
    Probing for Super-I/O at 0x4e/0x4f<br/>
    Trying family `National Semiconductor&#39;...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    Trying family `SMSC&#39;...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    Trying family `VIA/Winbond/Fintek&#39;...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    Trying family `ITE&#39;...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    <br/>
    Some south bridges, CPUs or memory controllers may also contain<br/>
    embedded sensors. Do you want to scan for them? (YES/no):<br/>
    Silicon Integrated Systems SIS5595...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    VIA VT82C686 Integrated Sensors...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    VIA VT8231 Integrated Sensors...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    AMD K8 thermal sensors...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    AMD K10 thermal sensors...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    Intel Core family thermal sensor...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; Success!<br/>
    &#160;&#160;&#160; (driver `coretemp&#39;)<br/>
    Intel AMB FB-DIMM thermal sensor...&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; No<br/>
    <br/>
    Now follows a summary of the probes I have just done.<br/>
    Just press ENTER to continue:<br/>
    <br/>
    Driver `coretemp&#39; (should be inserted):<br/>
    &#160; Detects correctly:<br/>
    &#160; * Chip `Intel Core family thermal sensor&#39; (confidence: 9)<br/>
    <br/>
    I will now generate the commands needed to load the required modules.<br/>
    Just press ENTER to continue:<br/>
    <br/>
    To load everything that is needed, add this to /etc/modules:<br/>
    <br/>
    #----cut here----<br/>
    # Chip drivers<br/>
    # Warning: the required module coretemp is not currently installed<br/>
    # on your system. For status of 2.6 kernel ports check<br/>
    # http://www.lm-sensors.org/wiki/Devices. If driver is built<br/>
    # into the kernel, or unavailable, comment out the following line.<br/>
    coretemp<br/>
    #----cut here----<br/>
    <br/>
    Do you want to add these lines automatically? (yes/NO)<br/>
    <br/>
    I checked: coretemp is build in.<br/>
    I googled &quot;PC8374L&quot; and fount that i have to use lm85.<br/>
    <br/>
    I loaded the lm85 module:<br/>
    <br/>
    2:28/0 server ~ # lsmod |grep lm85<br/>
    lm85&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 16761&#160; 0<br/>
    hwmon_vid&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 1798&#160; 1 lm85<br/>
    i2c_core&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 17679&#160; 7 lm85,i2c_dev,i915,drm_kms_helper,drm,i2c_algo_bit,i2c_i801<br/>
    <br/>
    Now I get:<br/>
    <br/>
    12:28/1 server ~ # sensors<br/>
    coretemp-isa-0000<br/>
    Adapter: ISA adapter<br/>
    ERROR: Can&#39;t get value of subfeature temp1_input: Can&#39;t read<br/>
    Core 0:&#160;&#160;&#160;&#160;&#160;&#160; +0.0 C&#160; (high = +84.0 C, crit = +100.0 C)&#160; ALARM<br/>
    <br/>
    coretemp-isa-0001<br/>
    Adapter: ISA adapter<br/>
    Core 2:&#160;&#160;&#160;&#160; +100.0 C&#160; (high = +84.0 C, crit = +100.0 C)&#160; ALARM<br/>
    <br/>
    coretemp-isa-0002<br/>
    Adapter: ISA adapter<br/>
    ERROR: Can&#39;t get value of subfeature temp1_input: Can&#39;t read<br/>
    Core 1:&#160;&#160;&#160;&#160;&#160;&#160; +0.0 C&#160; (high = +84.0 C, crit = +100.0 C)&#160; ALARM<br/>
    <br/>
    coretemp-isa-0003<br/>
    Adapter: ISA adapter<br/>
    Core 3:&#160;&#160;&#160;&#160;&#160; +96.0 C&#160; (high = +84.0 C, crit = +100.0 C)<br/>
    <br/>
    <br/>
    Can this be true? On the cpu is a very huge cooler with heatpipes and a large fan. When I touch it, it is not hot. It seams to be mounted ok.<br/>
    <br/>
    Can anybody help?<br/>
    <br/>
    Thank you,<br/>
    <br/>
    Markus<br/>
    <br/>
    <br/>
    P. S.<br/>
    12:33/0 server /usr/src/linux-2.6.35.9 # lsmod |grep i2c<br/>
    i2c_dev&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 3677&#160; 0<br/>
    i2c_algo_bit&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 4075&#160; 1 i915<br/>
    i2c_i801&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 7081&#160; 0<br/>
    i2c_core&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 17679&#160; 7 lm85,i2c_dev,i915,drm_kms_helper,drm,i2c_algo_bit,i2c_i801<br/>
    <br/>
    </p>
  </body>
</html>
------=_Part_11221_1123631865.1348656112568--


--===============8687249147920129619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8687249147920129619==--
