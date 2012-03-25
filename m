From: Scott Ondercin <sgo542@hotmail.com>
Date: Sun, 25 Mar 2012 11:49:46 +0000
Subject: [lm-sensors] Incorrect Temperature Readings
Message-Id: <SNT120-W272CB289017CB6E4F875EC87440@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3832015006475440726=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3832015006475440726==
Content-Type: multipart/alternative;
	boundary="_7c9f73c9-f97a-4d70-9140-d484eccfabc9_"

--_7c9f73c9-f97a-4d70-9140-d484eccfabc9_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


So=2C once upon a time=2C my computer worked fine.  I have a Dell Inspiron =
1420=2C which has a good ventilation system and usually runs quite cool.  A=
 few months ago my fan broke and I had to have it replaced.  The new one=2C=
 however=2C runs all the time and is very loud.

My lm-sensors is screwed up=2C and scanning various threads I can't seem to=
 find a problem like mine.  So=2C here is what running sensors gets me:

sgo542@NostalgiaforInfinity:~$ sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:        +32.5=B0C  (crit =3D +87.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +30.0=B0C  (high =3D +85.0=B0C=2C crit =3D +85.0=B0C)
Core 1:       +33.0=B0C  (high =3D +85.0=B0C=2C crit =3D +85.0=B0C)

nouveau-pci-0100
Adapter: PCI adapter
temp1:        +97.0=B0C  (high =3D +100.0=B0C=2C crit =3D +110.0=B0C)

I've been casually browsing FireFox for a half hour and that is what it giv=
es me.  Now=2C I can sit this computer comfortably in my lap.  That 97C tem=
perature is clearly off=2C almost like it's reading in Farenheit but forget=
ting to convert it to Celsius.  Normally it just makes my fan run all the t=
ime=2C but now that spring has come=2C it gets hotter faster.  A few days a=
go I could only run it for 20-30 minutes before the reading hit 105C and th=
e automatic emergency shut-down kicked in.  Obviously=2C this needs to be f=
ixed before sumer strikes.

For reference=2C this is what I get from sensors-detect:

sgo542@NostalgiaforInfinity:~$ sudo sensors-detect
# sensors-detect revision 5946 (2011-03-23 11:54:44 +0100)
# System: Dell Inc. Inspiron 1420 (laptop)
# Board: Dell Inc. 0JX269

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions=2C
unless you know what you're doing.

Some south bridges=2C CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): y
Module cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
Intel digital thermal sensor...                             Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): y
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0x3201
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes=2C you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): y
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly=2C we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part=2C and while it works
reasonably well on most systems=2C it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): y
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801H ICH8
Module i2c-dev loaded successfully.

Next adapter: nouveau-0000:01:00.0-2 (i2c-0)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8=2C not a hardware monitoring chip)
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No

Next adapter: nouveau-0000:01:00.0-0 (i2c-1)
Do you want to scan it? (YES/no/selectively): y

Next adapter: SMBus I801 adapter at 10c0 (i2c-2)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8=2C not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8=2C not a hardware monitoring chip)

Now follows a summary of the probes I have just done.
Just press ENTER to continue:=20

Driver `coretemp':
  * Chip `Intel digital thermal sensor' (confidence: 9)

To load everything that is needed=2C add this to /etc/modules:
#----cut here----
# Chip drivers
coretemp
#----cut here----
If you have some drivers built into your kernel=2C the list above will
contain too many modules. Skip the appropriate ones!

Do you want to add these lines automatically to /etc/modules? (yes/NO)y
Successful!

Monitoring programs won't work until the needed modules are
loaded. You may want to run 'service module-init-tools start'
to load them.

Unloading i2c-dev... OK
Unloading cpuid... OK

sgo542@NostalgiaforInfinity:~$ sudo service module-init-tools start
module-init-tools stop/waiting
sgo542@NostalgiaforInfinity:~$ sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:        +32.5=B0C  (crit =3D +87.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +31.0=B0C  (high =3D +85.0=B0C=2C crit =3D +85.0=B0C)
Core 1:       +33.0=B0C  (high =3D +85.0=B0C=2C crit =3D +85.0=B0C)

nouveau-pci-0100
Adapter: PCI adapter
temp1:        +97.0=B0C  (high =3D +100.0=B0C=2C crit =3D +110.0=B0C)

sgo542@NostalgiaforInfinity:~$ sudo modprobe coretemp
sgo542@NostalgiaforInfinity:~$ sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:        +32.5=B0C  (crit =3D +87.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +30.0=B0C  (high =3D +85.0=B0C=2C crit =3D +85.0=B0C)
Core 1:       +33.0=B0C  (high =3D +85.0=B0C=2C crit =3D +85.0=B0C)

nouveau-pci-0100
Adapter: PCI adapter
temp1:        +97.0=B0C  (high =3D +100.0=B0C=2C crit =3D +110.0=B0C)

sgo542@NostalgiaforInfinity:~$ sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:        +33.5=B0C  (crit =3D +87.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +31.0=B0C  (high =3D +85.0=B0C=2C crit =3D +85.0=B0C)
Core 1:       +33.0=B0C  (high =3D +85.0=B0C=2C crit =3D +85.0=B0C)

nouveau-pci-0100
Adapter: PCI adapter
temp1:        +97.0=B0C  (high =3D +100.0=B0C=2C crit =3D +110.0=B0C)

sgo542@NostalgiaforInfinity:~$ sensors-detect
You need to be root to run this script.
sgo542@NostalgiaforInfinity:~$ sudo sensors-detect
# sensors-detect revision 5946 (2011-03-23 11:54:44 +0100)
# System: Dell Inc. Inspiron 1420 (laptop)
# Board: Dell Inc. 0JX269

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions=2C
unless you know what you're doing.

Some south bridges=2C CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): y
Module cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
Intel digital thermal sensor...                             Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): y
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0x3201
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes=2C you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): y
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly=2C we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part=2C and while it works
reasonably well on most systems=2C it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): y
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801H ICH8
Module i2c-dev loaded successfully.

Next adapter: nouveau-0000:01:00.0-2 (i2c-0)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8=2C not a hardware monitoring chip)
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No

Next adapter: nouveau-0000:01:00.0-0 (i2c-1)
Do you want to scan it? (YES/no/selectively): y

Next adapter: SMBus I801 adapter at 10c0 (i2c-2)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8=2C not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8=2C not a hardware monitoring chip)

Now follows a summary of the probes I have just done.
Just press ENTER to continue:=20

Driver `coretemp':
  * Chip `Intel digital thermal sensor' (confidence: 9)

To load everything that is needed=2C add this to /etc/modules:
#----cut here----
# Chip drivers
coretemp
#----cut here----
If you have some drivers built into your kernel=2C the list above will
contain too many modules. Skip the appropriate ones!

Do you want to add these lines automatically to /etc/modules? (yes/NO)y
Successful!

Monitoring programs won't work until the needed modules are
loaded. You may want to run 'service module-init-tools start'
to load them.

Unloading i2c-dev... OK
Unloading cpuid... OK

And when I try to run module-init-tools=2C I get:

sgo542@NostalgiaforInfinity:~$ sudo service module-init-tools start
module-init-tools stop/waiting

I've heard I might be able to fix this by tweaking the /etc/sensors.conf fi=
le=2C but I'm unsure how to even start with that.  I am moderately experien=
ces with Linux=2C but by no means an expert.  Any help would be appreciated=
=2C before it gets hot outside and my computer becomes completely unusable.
 		 	   		  =

--_7c9f73c9-f97a-4d70-9140-d484eccfabc9_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
So=2C once upon a time=2C my computer worked fine.&nbsp=3B I have a Dell In=
spiron 1420=2C which has a good ventilation system and usually runs quite c=
ool.&nbsp=3B A few months ago my fan broke and I had to have it replaced.&n=
bsp=3B The new one=2C however=2C runs all the time and is very loud.<br><br=
>My lm-sensors is screwed up=2C and scanning various threads I can't seem t=
o find a problem like mine.&nbsp=3B So=2C here is what running sensors gets=
 me:<br><br>sgo542@NostalgiaforInfinity:~$ sensors<br>acpitz-virtual-0<br>A=
dapter: Virtual device<br>temp1:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B +32.5=B0C&nbsp=3B (crit =3D +87.0=B0C)<br><br>coretemp-isa-00=
00<br>Adapter: ISA adapter<br>Core 0:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B +30.0=B0C&nbsp=3B (high =3D +85.0=B0C=2C crit =3D +85.0=B0C)<br=
>Core 1:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +33.0=B0C&nbsp=3B =
(high =3D +85.0=B0C=2C crit =3D +85.0=B0C)<br><br>nouveau-pci-0100<br>Adapt=
er: PCI adapter<br>temp1:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B +97.0=B0C&nbsp=3B (high =3D +100.0=B0C=2C crit =3D +110.0=B0C)<br><b=
r>I've been casually browsing FireFox for a half hour and that is what it g=
ives me.&nbsp=3B Now=2C I can sit this computer comfortably in my lap.&nbsp=
=3B That 97C temperature is clearly off=2C almost like it's reading in Fare=
nheit but forgetting to convert it to Celsius.&nbsp=3B Normally it just mak=
es my fan run all the time=2C but now that spring has come=2C it gets hotte=
r faster.&nbsp=3B A few days ago I could only run it for 20-30 minutes befo=
re the reading hit 105C and the automatic emergency shut-down kicked in.&nb=
sp=3B Obviously=2C this needs to be fixed before sumer strikes.<br><br>For =
reference=2C this is what I get from sensors-detect:<br><br>sgo542@Nostalgi=
aforInfinity:~$ sudo sensors-detect<br># sensors-detect revision 5946 (2011=
-03-23 11:54:44 +0100)<br># System: Dell Inc. Inspiron 1420 (laptop)<br># B=
oard: Dell Inc. 0JX269<br><br>This program will help you determine which ke=
rnel modules you need<br>to load to use lm_sensors most effectively. It is =
generally safe<br>and recommended to accept the default answers to all ques=
tions=2C<br>unless you know what you're doing.<br><br>Some south bridges=2C=
 CPUs or memory controllers contain embedded sensors.<br>Do you want to sca=
n for them? This is totally safe. (YES/no): y<br>Module cpuid loaded succes=
sfully.<br>Silicon Integrated Systems SIS5595...&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
 No<br>VIA VT82C686 Integrated Sensors...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B No<br>VIA VT8231 Integrated Sensors...&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>AMD K8 thermal senso=
rs...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>AMD Family 10h =
thermal sensors...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B No<br>AMD Family 11h thermal sensors...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>AMD Family 12h and 14h thermal sensors...=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br=
>Intel digital thermal sensor...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B Success!<br>&nbsp=3B&nbsp=3B&nbsp=3B (driv=
er `coretemp')<br>Intel AMB FB-DIMM thermal sensor...&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B No<br>VIA C7 thermal sensor...&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>VIA Nano thermal sensor...&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br><br>Some Super I/O chips contain =
embedded sensors. We have to write to<br>standard I/O ports to probe them. =
This is usually safe.<br>Do you want to scan for Super I/O sensors? (YES/no=
): y<br>Probing for Super-I/O at 0x2e/0x2f<br>Trying family `National Semic=
onductor'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B No<br>Trying family `SMSC'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B Yes<br>Found unknown chip with ID 0x3201<br>Pro=
bing for Super-I/O at 0x4e/0x4f<br>Trying family `National Semiconductor'..=
.&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<b=
r>Trying family `SMSC'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B No<br>Trying family `VIA/Winbond/Nuvoton/Fintek'...&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Trying family `ITE'...&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br><br>Some hardwa=
re monitoring chips are accessible through the ISA I/O ports.<br>We have to=
 write to arbitrary I/O ports to probe them. This is usually<br>safe though=
. Yes=2C you do have ISA I/O ports even if you do not have any<br>ISA slots=
! Do you want to scan the ISA I/O ports? (YES/no): y<br>Probing for `Nation=
al Semiconductor LM78' at 0x290...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B No<br>Probing for `National Semiconductor LM79' at 0x290...&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing for `Winbond W83781D=
' at 0x290...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B No<br>Probing for `Winbond W83782D' at 0x290...&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br><br>Lastly=2C we =
can probe the I2C/SMBus adapters for connected hardware<br>monitoring devic=
es. This is the most risky part=2C and while it works<br>reasonably well on=
 most systems=2C it has been reported to cause trouble<br>on some systems.<=
br>Do you want to probe the I2C/SMBus adapters now? (YES/no): y<br>Using dr=
iver `i2c-i801' for device 0000:00:1f.3: Intel 82801H ICH8<br>Module i2c-de=
v loaded successfully.<br><br>Next adapter: nouveau-0000:01:00.0-2 (i2c-0)<=
br>Do you want to scan it? (YES/no/selectively): y<br>Client found at addre=
ss 0x50<br>Probing for `Analog Devices ADM1033'...&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing =
for `Analog Devices ADM1034'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing for `SPD EEPROM'.=
..&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing for `EDID EEPROM'...&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B Yes<br>&nbsp=3B&nbsp=3B&nbsp=3B (confidence 8=2C not a =
hardware monitoring chip)<br>Client found at address 0x51<br>Probing for `A=
nalog Devices ADM1033'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing for `Analog Devices ADM10=
34'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B No<br>Probing for `SPD EEPROM'...&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B No<br>Client found at address 0x52<br>Probing for `Analog Devices =
ADM1033'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B No<br>Probing for `Analog Devices ADM1034'...&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B No<br>Probing for `SPD EEPROM'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br=
>Client found at address 0x53<br>Probing for `Analog Devices ADM1033'...&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B No<br>Probing for `Analog Devices ADM1034'...&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Prob=
ing for `SPD EEPROM'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br><br>Next ada=
pter: nouveau-0000:01:00.0-0 (i2c-1)<br>Do you want to scan it? (YES/no/sel=
ectively): y<br><br>Next adapter: SMBus I801 adapter at 10c0 (i2c-2)<br>Do =
you want to scan it? (YES/no/selectively): y<br>Client found at address 0x5=
0<br>Probing for `Analog Devices ADM1033'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing for =
`Analog Devices ADM1034'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing for `SPD EEPROM'...&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B Yes<br>&nbsp=3B&nbsp=3B&nbsp=3B (confidence 8=
=2C not a hardware monitoring chip)<br>Probing for `EDID EEPROM'...&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B No<br>Client found at address 0x52<br>Probing for `Analog =
Devices ADM1033'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing for `Analog Devices ADM1034'...=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B No<br>Probing for `SPD EEPROM'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B Yes<br>&nbsp=3B&nbsp=3B&nbsp=3B (confidence 8=2C not a hardware monitor=
ing chip)<br><br>Now follows a summary of the probes I have just done.<br>J=
ust press ENTER to continue: <br><br>Driver `coretemp':<br>&nbsp=3B * Chip =
`Intel digital thermal sensor' (confidence: 9)<br><br>To load everything th=
at is needed=2C add this to /etc/modules:<br>#----cut here----<br># Chip dr=
ivers<br>coretemp<br>#----cut here----<br>If you have some drivers built in=
to your kernel=2C the list above will<br>contain too many modules. Skip the=
 appropriate ones!<br><br>Do you want to add these lines automatically to /=
etc/modules? (yes/NO)y<br>Successful!<br><br>Monitoring programs won't work=
 until the needed modules are<br>loaded. You may want to run 'service modul=
e-init-tools start'<br>to load them.<br><br>Unloading i2c-dev... OK<br>Unlo=
ading cpuid... OK<br><br>sgo542@NostalgiaforInfinity:~$ sudo service module=
-init-tools start<br>module-init-tools stop/waiting<br>sgo542@NostalgiaforI=
nfinity:~$ sensors<br>acpitz-virtual-0<br>Adapter: Virtual device<br>temp1:=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +32.5=B0C&nbsp=3B =
(crit =3D +87.0=B0C)<br><br>coretemp-isa-0000<br>Adapter: ISA adapter<br>Co=
re 0:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +31.0=B0C&nbsp=3B (hi=
gh =3D +85.0=B0C=2C crit =3D +85.0=B0C)<br>Core 1:&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B +33.0=B0C&nbsp=3B (high =3D +85.0=B0C=2C crit =3D +=
85.0=B0C)<br><br>nouveau-pci-0100<br>Adapter: PCI adapter<br>temp1:&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +97.0=B0C&nbsp=3B (high =
=3D +100.0=B0C=2C crit =3D +110.0=B0C)<br><br>sgo542@NostalgiaforInfinity:~=
$ sudo modprobe coretemp<br>sgo542@NostalgiaforInfinity:~$ sensors<br>acpit=
z-virtual-0<br>Adapter: Virtual device<br>temp1:&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B +32.5=B0C&nbsp=3B (crit =3D +87.0=B0C)<br><br=
>coretemp-isa-0000<br>Adapter: ISA adapter<br>Core 0:&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B +30.0=B0C&nbsp=3B (high =3D +85.0=B0C=2C crit =
=3D +85.0=B0C)<br>Core 1:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +=
33.0=B0C&nbsp=3B (high =3D +85.0=B0C=2C crit =3D +85.0=B0C)<br><br>nouveau-=
pci-0100<br>Adapter: PCI adapter<br>temp1:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B +97.0=B0C&nbsp=3B (high =3D +100.0=B0C=2C crit =3D =
+110.0=B0C)<br><br>sgo542@NostalgiaforInfinity:~$ sensors<br>acpitz-virtual=
-0<br>Adapter: Virtual device<br>temp1:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B +33.5=B0C&nbsp=3B (crit =3D +87.0=B0C)<br><br>coretemp=
-isa-0000<br>Adapter: ISA adapter<br>Core 0:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B +31.0=B0C&nbsp=3B (high =3D +85.0=B0C=2C crit =3D +85.0=
=B0C)<br>Core 1:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +33.0=B0C&=
nbsp=3B (high =3D +85.0=B0C=2C crit =3D +85.0=B0C)<br><br>nouveau-pci-0100<=
br>Adapter: PCI adapter<br>temp1:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B +97.0=B0C&nbsp=3B (high =3D +100.0=B0C=2C crit =3D +110.0=B0=
C)<br><br>sgo542@NostalgiaforInfinity:~$ sensors-detect<br>You need to be r=
oot to run this script.<br>sgo542@NostalgiaforInfinity:~$ sudo sensors-dete=
ct<br># sensors-detect revision 5946 (2011-03-23 11:54:44 +0100)<br># Syste=
m: Dell Inc. Inspiron 1420 (laptop)<br># Board: Dell Inc. 0JX269<br><br>Thi=
s program will help you determine which kernel modules you need<br>to load =
to use lm_sensors most effectively. It is generally safe<br>and recommended=
 to accept the default answers to all questions=2C<br>unless you know what =
you're doing.<br><br>Some south bridges=2C CPUs or memory controllers conta=
in embedded sensors.<br>Do you want to scan for them? This is totally safe.=
 (YES/no): y<br>Module cpuid loaded successfully.<br>Silicon Integrated Sys=
tems SIS5595...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>VIA VT82C686 Integrated S=
ensors...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>VIA VT823=
1 Integrated Sensors...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B No<br>AMD K8 thermal sensors...&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B No<br>AMD Family 10h thermal sensors...&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>AMD Family 11h thermal =
sensors...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>=
AMD Family 12h and 14h thermal sensors...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Intel digital thermal sensor...&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B Su=
ccess!<br>&nbsp=3B&nbsp=3B&nbsp=3B (driver `coretemp')<br>Intel AMB FB-DIMM=
 thermal sensor...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>VIA C7 t=
hermal sensor...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No=
<br>VIA Nano thermal sensor...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br=
><br>Some Super I/O chips contain embedded sensors. We have to write to<br>=
standard I/O ports to probe them. This is usually safe.<br>Do you want to s=
can for Super I/O sensors? (YES/no): y<br>Probing for Super-I/O at 0x2e/0x2=
f<br>Trying family `National Semiconductor'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Trying family `SMSC'...&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B Yes<br>Found un=
known chip with ID 0x3201<br>Probing for Super-I/O at 0x4e/0x4f<br>Trying f=
amily `National Semiconductor'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Trying family `SMSC'...&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Trying family `VIA/Winb=
ond/Nuvoton/Fintek'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Trying fa=
mily `ITE'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B No<br><br>Some hardware monitoring chips are accessible through=
 the ISA I/O ports.<br>We have to write to arbitrary I/O ports to probe the=
m. This is usually<br>safe though. Yes=2C you do have ISA I/O ports even if=
 you do not have any<br>ISA slots! Do you want to scan the ISA I/O ports? (=
YES/no): y<br>Probing for `National Semiconductor LM78' at 0x290...&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing for `National Semico=
nductor LM79' at 0x290...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B N=
o<br>Probing for `Winbond W83781D' at 0x290...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing for `Winbond W83782D=
' at 0x290...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B No<br><br>Lastly=2C we can probe the I2C/SMBus adapters for connec=
ted hardware<br>monitoring devices. This is the most risky part=2C and whil=
e it works<br>reasonably well on most systems=2C it has been reported to ca=
use trouble<br>on some systems.<br>Do you want to probe the I2C/SMBus adapt=
ers now? (YES/no): y<br>Using driver `i2c-i801' for device 0000:00:1f.3: In=
tel 82801H ICH8<br>Module i2c-dev loaded successfully.<br><br>Next adapter:=
 nouveau-0000:01:00.0-2 (i2c-0)<br>Do you want to scan it? (YES/no/selectiv=
ely): y<br>Client found at address 0x50<br>Probing for `Analog Devices ADM1=
033'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B No<br>Probing for `Analog Devices ADM1034'...&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
 No<br>Probing for `SPD EEPROM'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>P=
robing for `EDID EEPROM'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B Yes<br>&nbsp=3B&nbsp=3B=
&nbsp=3B (confidence 8=2C not a hardware monitoring chip)<br>Client found a=
t address 0x51<br>Probing for `Analog Devices ADM1033'...&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>P=
robing for `Analog Devices ADM1034'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing for `SPD EEP=
ROM'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Client found at address 0x52=
<br>Probing for `Analog Devices ADM1033'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing for `An=
alog Devices ADM1034'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing for `SPD EEPROM'...&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Client found at address 0x53<br>Probing f=
or `Analog Devices ADM1033'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing for `Analog Devices =
ADM1034'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B No<br>Probing for `SPD EEPROM'...&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B No<br><br>Next adapter: nouveau-0000:01:00.0-0 (i2c-1)<br>Do =
you want to scan it? (YES/no/selectively): y<br><br>Next adapter: SMBus I80=
1 adapter at 10c0 (i2c-2)<br>Do you want to scan it? (YES/no/selectively): =
y<br>Client found at address 0x50<br>Probing for `Analog Devices ADM1033'..=
.&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B No<br>Probing for `Analog Devices ADM1034'...&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>P=
robing for `SPD EEPROM'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B Yes<br>&nbsp=3B=
&nbsp=3B&nbsp=3B (confidence 8=2C not a hardware monitoring chip)<br>Probin=
g for `EDID EEPROM'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Client found at address=
 0x52<br>Probing for `Analog Devices ADM1033'...&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing f=
or `Analog Devices ADM1034'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing for `SPD EEPROM'...&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B Yes<br>&nbsp=3B&nbsp=3B&nbsp=3B (confidenc=
e 8=2C not a hardware monitoring chip)<br><br>Now follows a summary of the =
probes I have just done.<br>Just press ENTER to continue: <br><br>Driver `c=
oretemp':<br>&nbsp=3B * Chip `Intel digital thermal sensor' (confidence: 9)=
<br><br>To load everything that is needed=2C add this to /etc/modules:<br>#=
----cut here----<br># Chip drivers<br>coretemp<br>#----cut here----<br>If y=
ou have some drivers built into your kernel=2C the list above will<br>conta=
in too many modules. Skip the appropriate ones!<br><br>Do you want to add t=
hese lines automatically to /etc/modules? (yes/NO)y<br>Successful!<br><br>M=
onitoring programs won't work until the needed modules are<br>loaded. You m=
ay want to run 'service module-init-tools start'<br>to load them.<br><br>Un=
loading i2c-dev... OK<br>Unloading cpuid... OK<br><br>And when I try to run=
 module-init-tools=2C I get:<br><br>sgo542@NostalgiaforInfinity:~$ sudo ser=
vice module-init-tools start<br>module-init-tools stop/waiting<br><br>I've =
heard I might be able to fix this by tweaking the /etc/sensors.conf file=2C=
 but I'm unsure how to even start with that.&nbsp=3B I am moderately experi=
ences with Linux=2C but by no means an expert.&nbsp=3B Any help would be ap=
preciated=2C before it gets hot outside and my computer becomes completely =
unusable.<br> 		 	   		  </div></body>
</html>=

--_7c9f73c9-f97a-4d70-9140-d484eccfabc9_--


--===============3832015006475440726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3832015006475440726==--
