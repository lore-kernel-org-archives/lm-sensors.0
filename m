From: "John @ BER Ltd" <john@ber.net.nz>
Date: Mon, 20 Apr 2009 08:06:13 +0000
Subject: [lm-sensors] incorrect CPU temp display
Message-Id: <00a201c9c18e$e055b580$0202fea9@dad>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6515993483308323574=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============6515993483308323574==
Content-Type: multipart/related;
	boundary="----=_NextPart_000_00A3_01C9C1F3.758A9580"

This is a multi-part message in MIME format.

------=_NextPart_000_00A3_01C9C1F3.758A9580
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_00A4_01C9C1F3.758CDF70"


------=_NextPart_001_00A4_01C9C1F3.758CDF70
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi I've got a Linux distro called Linux SME, have installed a system
monitoring software called sme7admin:
http://wiki.contribs.org/Sme7admin
=20
=20
I've been working on smeadmin to get the CPU, M/B and HDD temps =
displayed on
sme7admin. am able to get the network data details etc but sensor info =
has
been a struggle.
Got it sorted last week and correct CPU was being displayed- confirmed =
via
BIOS output.
For whatever reason the CPU temp is now being displayed as 70 degrees
Centigrade. Bios shows 45 degrees centigrade. this is displayed via
sme7admin and "sensors" display.
Unsure where to start. Any suggestions appreciated as my admin email box =
is
clogged with full of alerts.

login as: root
root@192.168.0.254's password:
Last login: Fri Apr 17 22:27:30 2009 from 192.168.0.153
[root@server ~]# ls /media/
cdrom  floppy  NO_NAME  usbdisk
[root@server ~]# ls /media/NO_NAME/
[root@server ~]# ls /media/usbdisk/
[root@server ~]# ls /media/NO_NAME/
[root@server ~]# ls /media/NO_NAME/
[root@server ~]# sen

-bash: sen: command not found
[root@server ~]# root
-bash: root: command not found
[root@server ~]# 1cheon
-bash: 1cheon: command not found
[root@server ~]#

[root@server ~]# sensors
w83697hf-isa-0290
Adapter: ISA adapter
VCore:     +1.58 V  (min =3D  +1.71 V, max =3D  +1.89 V)
+3.3V:     +3.26 V  (min =3D  +3.14 V, max =3D  +3.46 V)
+5V:       +4.95 V  (min =3D  +4.73 V, max =3D  +5.24 V)       ALARM
+12V:     +11.92 V  (min =3D +10.82 V, max =3D +13.19 V)
-12V:     -14.91 V  (min =3D -13.18 V, max =3D -10.88 V)
-5V:       -7.71 V  (min =3D  -5.25 V, max =3D  -4.75 V)
V5SB:      +5.24 V  (min =3D  +4.73 V, max =3D  +5.24 V)
VBat:      +0.00 V  (min =3D  +2.40 V, max =3D  +3.60 V)
fan1:     2721 RPM  (min =3D 337500 RPM, div =3D 2)
fan2:        0 RPM  (min =3D 3169 RPM, div =3D 2)
temp1:       +70=B0C  (high =3D   +64=B0C, hyst =3D    +4=B0C)   sensor =
=3D thermistor
temp2:     +36.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =
=3D thermistor
alarms:
beep_enable:
          Sound alarm disabled

eeprom-i2c-0-51
Adapter: SiS96x SMBus adapter at 0x0c00
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-50
Adapter: SiS96x SMBus adapter at 0x0c00
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

[root@server ~]# sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to =
all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): y
Probing for PCI bus adapters...
Use driver `i2c-sis96x' for device 00:02.1: Silicon Integrated Systems =
SMBus
Controller
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-sis96x' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): y
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang =
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you =
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SiS96x SMBus adapter at 0x0c00 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x08
Client found at address 0x10
Client found at address 0x31
Client at address 0x50 can not be probed - unload all client drivers =
first!
Client at address 0x51 can not be probed - unload all client drivers =
first!
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): ISA
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): y
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83697HF Super IO Sensors'
  Success... found at address 0x0295
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x60)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x60)

Do you want to scan for secondary Super I/O sensors? (YES/no): y
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `w83781d' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF' (confidence:  8)
<http://forums.contribs.org/Smileys/default/cool.gif>=20

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0295 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF Super IO Sensors' (confidence: 9)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver =
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? ISA

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe w83781d
modprobe w83627hf
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really =
should
try these commands right now to make sure everything is working =
properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): y
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
[root@server ~]#



Kind Regards=20
=20

-------------------------------------------------------------------------=
---
-------


Email: john@ber.net.nz

-------------------------------------------------------------------------=
---
--------

=20


Email disclaimer:


Emails from me, and any attached files are intended only for the person,
persons, entity, or entities to which they are addressed. It may contain
confidential and/or privileged materials, which should not be =
retransmitted
or otherwise disseminated. If you receive an email in error from me, =
please
let me know, and delete the material from your computer. Thank you.

-------------------------------------------------------------------------=
---
--------

=20

------=_NextPart_001_00A4_01C9C1F3.758CDF70
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16788" name=3DGENERATOR></HEAD>
<BODY>
<DIV>Hi I've<SPAN class=3D453520008-20042009> got a Linux distro called =
Linux SME,=20
have installed a system monitoring software called =
sme7admin:</SPAN></DIV>
<DIV><SPAN class=3D453520008-20042009><FONT face=3DArial size=3D2><A=20
href=3D"http://wiki.contribs.org/Sme7admin">http://wiki.contribs.org/Sme7=
admin</A></FONT></SPAN></DIV>
<DIV><SPAN class=3D453520008-20042009><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D453520008-20042009>I've</SPAN>&nbsp;been working on =
smeadmin to=20
get the CPU, M/B and HDD temps displayed on sme7admin.<SPAN=20
class=3D453520008-20042009> am able to get the network data details etc =
but sensor=20
info has been a struggle.</SPAN><BR>Got it sorted last week and correct =
CPU was=20
being displayed- confirmed via BIOS output.<BR>For whatever reason the =
CPU temp=20
is now being displayed as 70 degrees Centigrade. Bios shows 45 degrees=20
centigrade. this is displayed via sme7admin and "sensors" =
display.<BR>Unsure=20
where to start. Any suggestions appreciated as my admin email box is =
clogged=20
with full of alerts.<BR><BR>login as: root<BR><A class=3Dbbc_email=20
href=3D"mailto:root@192.168.0.254">root@192.168.0.254</A>'s =
password:<BR>Last=20
login: Fri Apr 17 22:27:30 2009 from 192.168.0.153<BR>[root@server ~]# =
ls=20
/media/<BR>cdrom&nbsp; floppy&nbsp; NO_NAME&nbsp; =
usbdisk<BR>[root@server ~]# ls=20
/media/NO_NAME/<BR>[root@server ~]# ls /media/usbdisk/<BR>[root@server =
~]# ls=20
/media/NO_NAME/<BR>[root@server ~]# ls /media/NO_NAME/<BR>[root@server =
~]#=20
sen<BR><BR>-bash: sen: command not found<BR>[root@server ~]# =
root<BR>-bash:=20
root: command not found<BR>[root@server ~]# 1cheon<BR>-bash: 1cheon: =
command not=20
found<BR>[root@server ~]#<BR><BR>[root@server ~]#=20
sensors<BR>w83697hf-isa-0290<BR>Adapter: ISA adapter<BR>VCore:&nbsp; =
&nbsp;=20
&nbsp;+1.58 V&nbsp; (min =3D&nbsp; +1.71 V, max =3D&nbsp; +1.89 =
V)<BR>+3.3V:&nbsp;=20
&nbsp; &nbsp;+3.26 V&nbsp; (min =3D&nbsp; +3.14 V, max =3D&nbsp; +3.46=20
V)<BR>+5V:&nbsp; &nbsp; &nbsp; &nbsp;+4.95 V&nbsp; (min =3D&nbsp; +4.73 =
V, max=20
=3D&nbsp; +5.24 V)&nbsp; &nbsp; &nbsp; &nbsp;ALARM<BR>+12V:&nbsp; &nbsp; =

&nbsp;+11.92 V&nbsp; (min =3D +10.82 V, max =3D +13.19 V)<BR>-12V:&nbsp; =
&nbsp;=20
&nbsp;-14.91 V&nbsp; (min =3D -13.18 V, max =3D -10.88 V)<BR>-5V:&nbsp; =
&nbsp;=20
&nbsp; &nbsp;-7.71 V&nbsp; (min =3D&nbsp; -5.25 V, max =3D&nbsp; -4.75=20
V)<BR>V5SB:&nbsp; &nbsp; &nbsp; +5.24 V&nbsp; (min =3D&nbsp; +4.73 V, =
max =3D&nbsp;=20
+5.24 V)<BR>VBat:&nbsp; &nbsp; &nbsp; +0.00 V&nbsp; (min =3D&nbsp; +2.40 =
V, max=20
=3D&nbsp; +3.60 V)<BR>fan1:&nbsp; &nbsp; &nbsp;2721 RPM&nbsp; (min =3D =
337500 RPM,=20
div =3D 2)<BR>fan2:&nbsp; &nbsp; &nbsp; &nbsp; 0 RPM&nbsp; (min =3D 3169 =
RPM, div =3D=20
2)<BR>temp1:&nbsp; &nbsp; &nbsp; &nbsp;+70=B0C&nbsp; (high =3D&nbsp; =
&nbsp;+64=B0C,=20
hyst =3D&nbsp; &nbsp; +4=B0C)&nbsp; &nbsp;sensor =3D =
thermistor<BR>temp2:&nbsp; &nbsp;=20
&nbsp;+36.0=B0C&nbsp; (high =3D&nbsp; &nbsp;+80=B0C, hyst =3D&nbsp; =
&nbsp;+75=B0C)&nbsp;=20
&nbsp;sensor =3D thermistor<BR>alarms:<BR>beep_enable:<BR>&nbsp; &nbsp; =
&nbsp;=20
&nbsp; &nbsp; Sound alarm disabled<BR><BR>eeprom-i2c-0-51<BR>Adapter: =
SiS96x=20
SMBus adapter at 0x0c00<BR>Memory type:&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;=20
DDR SDRAM DIMM<BR>Memory size (MB):&nbsp; &nbsp; &nbsp;=20
&nbsp;512<BR><BR>eeprom-i2c-0-50<BR>Adapter: SiS96x SMBus adapter at=20
0x0c00<BR>Memory type:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; DDR =
SDRAM=20
DIMM<BR>Memory size (MB):&nbsp; &nbsp; &nbsp; =
&nbsp;512<BR><BR>[root@server ~]#=20
sensors-detect<BR><BR>This program will help you determine which =
I2C/SMBus=20
modules you need to<BR>load to use lm_sensors most effectively. You need =
to have=20
i2c and<BR>lm_sensors installed before running this program.<BR>Also, =
you need=20
to be `root', or at least have access to the /dev/i2c-*<BR>files, for =
most=20
things.<BR>If you have patched your kernel and have some drivers built =
in, you=20
can<BR>safely answer NO if asked to load some modules. In this case, =
things=20
may<BR>seem a bit confusing, but they will still work.<BR><BR>It is =
generally=20
safe and recommended to accept the default answers to all<BR>questions, =
unless=20
you know what you're doing.<BR><BR>&nbsp;We can start with probing for =
(PCI) I2C=20
or SMBus adapters.<BR>&nbsp;You do not need any special privileges for=20
this.<BR>&nbsp;Do you want to probe now? (YES/no): y<BR>Probing for PCI =
bus=20
adapters...<BR>Use driver `i2c-sis96x' for device 00:02.1: Silicon =
Integrated=20
Systems SMBus Controller<BR>Probe succesfully concluded.<BR><BR>We will =
now try=20
to load each adapter module in turn.<BR>Module `i2c-sis96x' already=20
loaded.<BR>If you have undetectable or unsupported adapters, you can =
have=20
them<BR>scanned by manually loading the modules before running this=20
script.<BR><BR>&nbsp;To continue, we need module `i2c-dev' to be=20
loaded.<BR>&nbsp;If it is built-in into your kernel, you can safely skip =

this.<BR>&nbsp;i2c-dev is not loaded. Do you want to load it now? =
(YES/no):=20
y<BR>&nbsp;Module loaded succesfully.<BR><BR>&nbsp;We are now going to =
do the=20
adapter probings. Some adapters may hang halfway<BR>&nbsp;through; we =
can't=20
really help that. Also, some chips will be double detected;<BR>&nbsp;we =
choose=20
the one with the highest confidence value in that case.<BR>&nbsp;If you =
found=20
that the adapter hung after probing a certain address, you =
can<BR>&nbsp;specify=20
that address to remain unprobed. That often<BR>&nbsp;includes address =
0x69=20
(clock chip).<BR><BR>Next adapter: SiS96x SMBus adapter at 0x0c00 =
(Algorithm=20
unavailable)<BR>Do you want to scan it? (YES/no/selectively): =
y<BR>Client found=20
at address 0x08<BR>Client found at address 0x10<BR>Client found at =
address=20
0x31<BR>Client at address 0x50 can not be probed - unload all client =
drivers=20
first!<BR>Client at address 0x51 can not be probed - unload all client =
drivers=20
first!<BR>Client found at address 0x69<BR><BR>Some chips are also =
accessible=20
through the ISA bus. ISA probes are<BR>typically a bit more dangerous, =
as we=20
have to write to I/O ports to do<BR>this. This is usually safe =
though.<BR><BR>Do=20
you want to scan the ISA bus? (YES/no): ISA<BR>Probing for `National=20
Semiconductor LM78'<BR>&nbsp; Trying address 0x0290... =
Failed!<BR>Probing for=20
`National Semiconductor LM78-J'<BR>&nbsp; Trying address 0x0290...=20
Failed!<BR>Probing for `National Semiconductor LM79'<BR>&nbsp; Trying =
address=20
0x0290... Failed!<BR>Probing for `Winbond W83781D'<BR>&nbsp; Trying =
address=20
0x0290... Failed!<BR>Probing for `Winbond W83782D'<BR>&nbsp; Trying =
address=20
0x0290... Failed!<BR>Probing for `Winbond W83627HF'<BR>&nbsp; Trying =
address=20
0x0290... Failed!<BR>Probing for `Winbond W83697HF'<BR>&nbsp; Trying =
address=20
0x0290... Success!<BR>&nbsp; &nbsp; (confidence 8, driver =
`w83781d')<BR>Probing=20
for `Silicon Integrated Systems SIS5595'<BR>&nbsp; Trying general =
detect...=20
Failed!<BR>Probing for `VIA Technologies VT82C686 Integrated =
Sensors'<BR>&nbsp;=20
Trying general detect... Failed!<BR>Probing for `VIA Technologies VT8231 =

Integrated Sensors'<BR>&nbsp; Trying general detect... =
Failed!<BR>Probing for=20
`ITE IT8705F / IT8712F / SiS 950'<BR>&nbsp; Trying address 0x0290...=20
Failed!<BR>Probing for `IPMI BMC KCS'<BR>&nbsp; Trying address 0x0ca0... =

Failed!<BR>Probing for `IPMI BMC SMIC'<BR>&nbsp; Trying address =
0x0ca8...=20
Failed!<BR><BR>Some Super I/O chips may also contain sensors. Super I/O =
probes=20
are<BR>typically a bit more dangerous, as we have to write to I/O ports =
to=20
do<BR>this. This is usually safe though.<BR><BR>Do you want to scan for =
Super=20
I/O sensors? (YES/no): y<BR>Probing for `ITE 8702F Super IO =
Sensors'<BR>&nbsp;=20
Failed! (skipping family)<BR>Probing for `Nat. Semi. PC87351 Super IO =
Fan=20
Sensors'<BR>&nbsp; Failed! (skipping family)<BR>Probing for `SMSC 47B27x =
Super=20
IO Fan Sensors'<BR>&nbsp; Failed! (skipping family)<BR>Probing for =
`VT1211 Super=20
IO Sensors'<BR>&nbsp; Failed! (0x60)<BR>Probing for `Winbond W83627HF =
Super IO=20
Sensors'<BR>&nbsp; Failed! (0x60)<BR>Probing for `Winbond W83627THF =
Super IO=20
Sensors'<BR>&nbsp; Failed! (0x60)<BR>Probing for `Winbond W83637HF Super =
IO=20
Sensors'<BR>&nbsp; Failed! (0x60)<BR>Probing for `Winbond W83697HF Super =
IO=20
Sensors'<BR>&nbsp; Success... found at address 0x0295<BR>Probing for =
`Winbond=20
W83697SF/UF Super IO PWM'<BR>&nbsp; Failed! (0x60)<BR>Probing for =
`Winbond=20
W83L517D Super IO'<BR>&nbsp; Failed! (0x60)<BR><BR>Do you want to scan =
for=20
secondary Super I/O sensors? (YES/no): y<BR>Probing for `ITE 8702F Super =
IO=20
Sensors'<BR>&nbsp; Failed! (skipping family)<BR>Probing for `Nat. Semi. =
PC87351=20
Super IO Fan Sensors'<BR>&nbsp; Failed! (skipping family)<BR>Probing for =
`SMSC=20
47B27x Super IO Fan Sensors'<BR>&nbsp; Failed! (skipping =
family)<BR>Probing for=20
`VT1211 Super IO Sensors'<BR>&nbsp; Failed! (skipping =
family)<BR><BR>&nbsp;Now=20
follows a summary of the probes I have just done.<BR>&nbsp;Just press =
ENTER to=20
continue:<BR><BR>Driver `w83781d' (should be inserted):<BR>&nbsp; =
Detects=20
correctly:<BR>&nbsp; * ISA bus address 0x0290 (Busdriver =
`i2c-isa')<BR>&nbsp;=20
&nbsp; Chip `Winbond W83697HF' (confidence: <IMG class=3Dsmiley =
title=3DCool alt=3D8)=20
src=3D"http://forums.contribs.org/Smileys/default/cool.gif"=20
border=3D0><BR><BR>Driver `w83627hf' (should be inserted):<BR>&nbsp; =
Detects=20
correctly:<BR>&nbsp; * ISA bus address 0x0295 (Busdriver =
`i2c-isa')<BR>&nbsp;=20
&nbsp; Chip `Winbond W83697HF Super IO Sensors' (confidence:=20
9)<BR><BR><BR>&nbsp;I will now generate the commands needed to load the =
I2C=20
modules.<BR>&nbsp;Sometimes, a chip is available both through the ISA =
bus and an=20
I2C bus.<BR>&nbsp;ISA bus access is faster, but you need to load an =
additional=20
driver module<BR>&nbsp;for it. If you have the choice, do you want to =
use the=20
ISA bus or the<BR>&nbsp;I2C/SMBus (ISA/smbus)? ISA<BR><BR>To make the =
sensors=20
modules behave correctly, add these lines=20
to<BR>/etc/modules.conf:<BR><BR>#----cut here----<BR># I2C module=20
options<BR>alias char-major-89 i2c-dev<BR>#----cut here----<BR><BR>To =
load=20
everything that is needed, add this to some /etc/rc* =
file:<BR><BR>#----cut=20
here----<BR># I2C adapter drivers<BR>modprobe i2c-isa<BR># I2C chip=20
drivers<BR>modprobe w83781d<BR>modprobe w83627hf<BR># sleep 2 #=20
optional<BR>/usr/bin/sensors -s # recommended<BR>#----cut=20
here----<BR><BR>WARNING! If you have some things built into your kernel, =
the=20
list above<BR>will contain too many modules. Skip the appropriate ones! =
You=20
really should<BR>try these commands right now to make sure everything is =
working=20
properly.<BR>Monitoring programs won't work until it's done.<BR><BR>Do =
you want=20
to generate /etc/sysconfig/lm_sensors? (YES/no): y<BR>Copy=20
prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors<BR>for =
initialization=20
at boot time.<BR>[root@server ~]#<BR><BR><BR><BR>Kind Regards </DIV>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft>
<P class=3DMsoNormal style=3D"mso-margin-top-alt: auto; =
mso-margin-bottom-alt: auto"=20
align=3Dleft><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">------------------------------------------------------------------=
-----------------</SPAN></P>
<P class=3DMsoNormal=20
style=3D"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto">
<P class=3DMsoNormal=20
style=3D"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN></P><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Email: <A=20
href=3D"mailto:john@ber.net.nz">john@ber.net.nz</A></SPAN></P>
<P class=3DMsoNormal=20
style=3D"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">------------------------------------------------------------------=
------------------</SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><?xml:namespace prefix =3D =
o ns =3D=20
"urn:schemas-microsoft-com:office:office" /><o:p>&nbsp;</o:p></SPAN></P>
<H3><SPAN style=3D"FONT-FAMILY: Arial">Email =
disclaimer:<o:p></o:p></SPAN></H3>
<P><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Emails from me, =
and any=20
attached files are intended only for the person, persons, entity, or =
entities to=20
which they are addressed. It may contain confidential and/or privileged=20
materials, which should not be retransmitted or otherwise disseminated. =
If you=20
receive an email in error from me, please let me know, and delete the =
material=20
from your computer. Thank you.<o:p></o:p></SPAN></P>
<P><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">------------------------------------------------------------------=
------------------<o:p></o:p></SPAN></P></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_001_00A4_01C9C1F3.758CDF70--

------=_NextPart_000_00A3_01C9C1F3.758A9580
Content-Type: image/gif;
	name="cool.gif"
Content-Transfer-Encoding: base64
Content-Location: http://forums.contribs.org/Smileys/default/cool.gif

R0lGODlhDwAPALMNAP/qAEVFRQAAAP/OAP/JAP6dAP+0AP/+k//9E///x//////lAP//6wAAAAAA
AAAAACH5BAEAAA0ALAAAAAAPAA8AAARZsEkZap24VZbOGRcWcAgCnEMRTEFnnnC6ascLx2sr7DvA
76rAgacQ+HZFQ+VwNJ54BGXAdoNFK4PqbUFQabJOmIAAogwGi99YxjoT3m+2KGCoG4IZlmU2iQAA
Ow==

------=_NextPart_000_00A3_01C9C1F3.758A9580--



--===============6515993483308323574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6515993483308323574==--


