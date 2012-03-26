From: Scott Ondercin <sgo542@hotmail.com>
Date: Mon, 26 Mar 2012 19:59:56 +0000
Subject: Re: [lm-sensors] Incorrect Temperature Readings
Message-Id: <SNT120-W14AE6F1D312CD041BCB3E787450@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3085317740933432083=="
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT120-W272CB289017CB6E4F875EC87440@phx.gbl>,
	<20120325152311.GA6544@ericsson.com>
In-Reply-To: <20120325152311.GA6544@ericsson.com>
To: guenter.roeck@ericsson.com
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, lm-sensors@lm-sensors.org

--===============3085317740933432083==
Content-Type: multipart/alternative;
	boundary="_c3bd6aac-36e4-4dcc-95f4-fb7a540b6ad1_"

--_c3bd6aac-36e4-4dcc-95f4-fb7a540b6ad1_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


-I've been running the computer for over an hour currently and it feels per=
fectly fine.  Even the hard drive feels only mildly warm.  Nonetheless=2C I=
'm getting 96C readings for my PCI Adapter.

Is there a way to modify my /etc/sensors.conf file to change the input leve=
ls or high/crit temps for the adapter?  I may not be looking properly=2C bu=
t I can't find its chip name.

Also=2C is there a way to run "module-init-tools" without getting "stop/wai=
ting"?

> Date: Sun=2C 25 Mar 2012 08:23:12 -0700
> From: guenter.roeck@ericsson.com
> To: sgo542@hotmail.com
> CC: lm-sensors@lm-sensors.org=3B airlied@linux.ie=3B dri-devel@lists.free=
desktop.org
> Subject: Re: [lm-sensors] Incorrect Temperature Readings
>=20
> On Sun=2C Mar 25=2C 2012 at 07:49:46AM -0400=2C Scott Ondercin wrote:
> > So=2C once upon a time=2C my computer worked fine.  I have a Dell Inspi=
ron 1420=2C
> > which has a good ventilation system and usually runs quite cool.  A few=
 months
> > ago my fan broke and I had to have it replaced.  The new one=2C however=
=2C runs all
> > the time and is very loud.
> >=20
> > My lm-sensors is screwed up=2C and scanning various threads I can't see=
m to find
> > a problem like mine.  So=2C here is what running sensors gets me:
> >=20
> > sgo542@NostalgiaforInfinity:~$ sensors
> > acpitz-virtual-0
> > Adapter: Virtual device
> > temp1:        +32.5 C  (crit =3D +87.0 C)
> >=20
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Core 0:       +30.0 C  (high =3D +85.0 C=2C crit =3D +85.0 C)
> > Core 1:       +33.0 C  (high =3D +85.0 C=2C crit =3D +85.0 C)
> >=20
> > nouveau-pci-0100
> > Adapter: PCI adapter
> > temp1:        +97.0 C  (high =3D +100.0 C=2C crit =3D +110.0 C)
> >=20
> Scott=2C
>=20
> That temperature reading is from your graphics adapter. No idea how it co=
mes
> that it reports such a high temperature. Does it have a fan=2C and are yo=
u sure
> it is working ?
>=20
> Copying the driver maintainer and the drm mailing list. Maybe someone the=
re
> has an idea.
>=20
> Guenter
>=20
> > I've been casually browsing FireFox for a half hour and that is what it=
 gives
> > me.  Now=2C I can sit this computer comfortably in my lap.  That 97C te=
mperature
> > is clearly off=2C almost like it's reading in Farenheit but forgetting =
to convert
> > it to Celsius.  Normally it just makes my fan run all the time=2C but n=
ow that
> > spring has come=2C it gets hotter faster.  A few days ago I could only =
run it for
> > 20-30 minutes before the reading hit 105C and the automatic emergency s=
hut-down
> > kicked in.  Obviously=2C this needs to be fixed before sumer strikes.
> >=20
> > For reference=2C this is what I get from sensors-detect:
> >=20
> > sgo542@NostalgiaforInfinity:~$ sudo sensors-detect
> > # sensors-detect revision 5946 (2011-03-23 11:54:44 +0100)
> > # System: Dell Inc. Inspiron 1420 (laptop)
> > # Board: Dell Inc. 0JX269
> >=20
> > This program will help you determine which kernel modules you need
> > to load to use lm_sensors most effectively. It is generally safe
> > and recommended to accept the default answers to all questions=2C
> > unless you know what you're doing.
> >=20
> > Some south bridges=2C CPUs or memory controllers contain embedded senso=
rs.
> > Do you want to scan for them? This is totally safe. (YES/no): y
> > Module cpuid loaded successfully.
> > Silicon Integrated Systems SIS5595...                       No
> > VIA VT82C686 Integrated Sensors...                          No
> > VIA VT8231 Integrated Sensors...                            No
> > AMD K8 thermal sensors...                                   No
> > AMD Family 10h thermal sensors...                           No
> > AMD Family 11h thermal sensors...                           No
> > AMD Family 12h and 14h thermal sensors...                   No
> > Intel digital thermal sensor...                             Success!
> >     (driver `coretemp')
> > Intel AMB FB-DIMM thermal sensor...                         No
> > VIA C7 thermal sensor...                                    No
> > VIA Nano thermal sensor...                                  No
> >=20
> > Some Super I/O chips contain embedded sensors. We have to write to
> > standard I/O ports to probe them. This is usually safe.
> > Do you want to scan for Super I/O sensors? (YES/no): y
> > Probing for Super-I/O at 0x2e/0x2f
> > Trying family `National Semiconductor'...                   No
> > Trying family `SMSC'...                                     Yes
> > Found unknown chip with ID 0x3201
> > Probing for Super-I/O at 0x4e/0x4f
> > Trying family `National Semiconductor'...                   No
> > Trying family `SMSC'...                                     No
> > Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> > Trying family `ITE'...                                      No
> >=20
> > Some hardware monitoring chips are accessible through the ISA I/O ports=
.
> > We have to write to arbitrary I/O ports to probe them. This is usually
> > safe though. Yes=2C you do have ISA I/O ports even if you do not have a=
ny
> > ISA slots! Do you want to scan the ISA I/O ports? (YES/no): y
> > Probing for `National Semiconductor LM78' at 0x290...       No
> > Probing for `National Semiconductor LM79' at 0x290...       No
> > Probing for `Winbond W83781D' at 0x290...                   No
> > Probing for `Winbond W83782D' at 0x290...                   No
> >=20
> > Lastly=2C we can probe the I2C/SMBus adapters for connected hardware
> > monitoring devices. This is the most risky part=2C and while it works
> > reasonably well on most systems=2C it has been reported to cause troubl=
e
> > on some systems.
> > Do you want to probe the I2C/SMBus adapters now? (YES/no): y
> > Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801H ICH8
> > Module i2c-dev loaded successfully.
> >=20
> > Next adapter: nouveau-0000:01:00.0-2 (i2c-0)
> > Do you want to scan it? (YES/no/selectively): y
> > Client found at address 0x50
> > Probing for `Analog Devices ADM1033'...                     No
> > Probing for `Analog Devices ADM1034'...                     No
> > Probing for `SPD EEPROM'...                                 No
> > Probing for `EDID EEPROM'...                                Yes
> >     (confidence 8=2C not a hardware monitoring chip)
> > Client found at address 0x51
> > Probing for `Analog Devices ADM1033'...                     No
> > Probing for `Analog Devices ADM1034'...                     No
> > Probing for `SPD EEPROM'...                                 No
> > Client found at address 0x52
> > Probing for `Analog Devices ADM1033'...                     No
> > Probing for `Analog Devices ADM1034'...                     No
> > Probing for `SPD EEPROM'...                                 No
> > Client found at address 0x53
> > Probing for `Analog Devices ADM1033'...                     No
> > Probing for `Analog Devices ADM1034'...                     No
> > Probing for `SPD EEPROM'...                                 No
> >=20
> > Next adapter: nouveau-0000:01:00.0-0 (i2c-1)
> > Do you want to scan it? (YES/no/selectively): y
> >=20
> > Next adapter: SMBus I801 adapter at 10c0 (i2c-2)
> > Do you want to scan it? (YES/no/selectively): y
> > Client found at address 0x50
> > Probing for `Analog Devices ADM1033'...                     No
> > Probing for `Analog Devices ADM1034'...                     No
> > Probing for `SPD EEPROM'...                                 Yes
> >     (confidence 8=2C not a hardware monitoring chip)
> > Probing for `EDID EEPROM'...                                No
> > Client found at address 0x52
> > Probing for `Analog Devices ADM1033'...                     No
> > Probing for `Analog Devices ADM1034'...                     No
> > Probing for `SPD EEPROM'...                                 Yes
> >     (confidence 8=2C not a hardware monitoring chip)
> >=20
> > Now follows a summary of the probes I have just done.
> > Just press ENTER to continue:
> >=20
> > Driver `coretemp':
> >   * Chip `Intel digital thermal sensor' (confidence: 9)
> >=20
> > To load everything that is needed=2C add this to /etc/modules:
> > #----cut here----
> > # Chip drivers
> > coretemp
> > #----cut here----
> > If you have some drivers built into your kernel=2C the list above will
> > contain too many modules. Skip the appropriate ones!
> >=20
> > Do you want to add these lines automatically to /etc/modules? (yes/NO)y
> > Successful!
> >=20
> > Monitoring programs won't work until the needed modules are
> > loaded. You may want to run 'service module-init-tools start'
> > to load them.
> >=20
> > Unloading i2c-dev... OK
> > Unloading cpuid... OK
> >=20
> > sgo542@NostalgiaforInfinity:~$ sudo service module-init-tools start
> > module-init-tools stop/waiting
> > sgo542@NostalgiaforInfinity:~$ sensors
> > acpitz-virtual-0
> > Adapter: Virtual device
> > temp1:        +32.5 C  (crit =3D +87.0 C)
> >=20
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Core 0:       +31.0 C  (high =3D +85.0 C=2C crit =3D +85.0 C)
> > Core 1:       +33.0 C  (high =3D +85.0 C=2C crit =3D +85.0 C)
> >=20
> > nouveau-pci-0100
> > Adapter: PCI adapter
> > temp1:        +97.0 C  (high =3D +100.0 C=2C crit =3D +110.0 C)
> >=20
> > sgo542@NostalgiaforInfinity:~$ sudo modprobe coretemp
> > sgo542@NostalgiaforInfinity:~$ sensors
> > acpitz-virtual-0
> > Adapter: Virtual device
> > temp1:        +32.5 C  (crit =3D +87.0 C)
> >=20
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Core 0:       +30.0 C  (high =3D +85.0 C=2C crit =3D +85.0 C)
> > Core 1:       +33.0 C  (high =3D +85.0 C=2C crit =3D +85.0 C)
> >=20
> > nouveau-pci-0100
> > Adapter: PCI adapter
> > temp1:        +97.0 C  (high =3D +100.0 C=2C crit =3D +110.0 C)
> >=20
> > sgo542@NostalgiaforInfinity:~$ sensors
> > acpitz-virtual-0
> > Adapter: Virtual device
> > temp1:        +33.5 C  (crit =3D +87.0 C)
> >=20
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Core 0:       +31.0 C  (high =3D +85.0 C=2C crit =3D +85.0 C)
> > Core 1:       +33.0 C  (high =3D +85.0 C=2C crit =3D +85.0 C)
> >=20
> > nouveau-pci-0100
> > Adapter: PCI adapter
> > temp1:        +97.0 C  (high =3D +100.0 C=2C crit =3D +110.0 C)
> >=20
> > sgo542@NostalgiaforInfinity:~$ sensors-detect
> > You need to be root to run this script.
> > sgo542@NostalgiaforInfinity:~$ sudo sensors-detect
> > # sensors-detect revision 5946 (2011-03-23 11:54:44 +0100)
> > # System: Dell Inc. Inspiron 1420 (laptop)
> > # Board: Dell Inc. 0JX269
> >=20
> > This program will help you determine which kernel modules you need
> > to load to use lm_sensors most effectively. It is generally safe
> > and recommended to accept the default answers to all questions=2C
> > unless you know what you're doing.
> >=20
> > Some south bridges=2C CPUs or memory controllers contain embedded senso=
rs.
> > Do you want to scan for them? This is totally safe. (YES/no): y
> > Module cpuid loaded successfully.
> > Silicon Integrated Systems SIS5595...                       No
> > VIA VT82C686 Integrated Sensors...                          No
> > VIA VT8231 Integrated Sensors...                            No
> > AMD K8 thermal sensors...                                   No
> > AMD Family 10h thermal sensors...                           No
> > AMD Family 11h thermal sensors...                           No
> > AMD Family 12h and 14h thermal sensors...                   No
> > Intel digital thermal sensor...                             Success!
> >     (driver `coretemp')
> > Intel AMB FB-DIMM thermal sensor...                         No
> > VIA C7 thermal sensor...                                    No
> > VIA Nano thermal sensor...                                  No
> >=20
> > Some Super I/O chips contain embedded sensors. We have to write to
> > standard I/O ports to probe them. This is usually safe.
> > Do you want to scan for Super I/O sensors? (YES/no): y
> > Probing for Super-I/O at 0x2e/0x2f
> > Trying family `National Semiconductor'...                   No
> > Trying family `SMSC'...                                     Yes
> > Found unknown chip with ID 0x3201
> > Probing for Super-I/O at 0x4e/0x4f
> > Trying family `National Semiconductor'...                   No
> > Trying family `SMSC'...                                     No
> > Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> > Trying family `ITE'...                                      No
> >=20
> > Some hardware monitoring chips are accessible through the ISA I/O ports=
.
> > We have to write to arbitrary I/O ports to probe them. This is usually
> > safe though. Yes=2C you do have ISA I/O ports even if you do not have a=
ny
> > ISA slots! Do you want to scan the ISA I/O ports? (YES/no): y
> > Probing for `National Semiconductor LM78' at 0x290...       No
> > Probing for `National Semiconductor LM79' at 0x290...       No
> > Probing for `Winbond W83781D' at 0x290...                   No
> > Probing for `Winbond W83782D' at 0x290...                   No
> >=20
> > Lastly=2C we can probe the I2C/SMBus adapters for connected hardware
> > monitoring devices. This is the most risky part=2C and while it works
> > reasonably well on most systems=2C it has been reported to cause troubl=
e
> > on some systems.
> > Do you want to probe the I2C/SMBus adapters now? (YES/no): y
> > Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801H ICH8
> > Module i2c-dev loaded successfully.
> >=20
> > Next adapter: nouveau-0000:01:00.0-2 (i2c-0)
> > Do you want to scan it? (YES/no/selectively): y
> > Client found at address 0x50
> > Probing for `Analog Devices ADM1033'...                     No
> > Probing for `Analog Devices ADM1034'...                     No
> > Probing for `SPD EEPROM'...                                 No
> > Probing for `EDID EEPROM'...                                Yes
> >     (confidence 8=2C not a hardware monitoring chip)
> > Client found at address 0x51
> > Probing for `Analog Devices ADM1033'...                     No
> > Probing for `Analog Devices ADM1034'...                     No
> > Probing for `SPD EEPROM'...                                 No
> > Client found at address 0x52
> > Probing for `Analog Devices ADM1033'...                     No
> > Probing for `Analog Devices ADM1034'...                     No
> > Probing for `SPD EEPROM'...                                 No
> > Client found at address 0x53
> > Probing for `Analog Devices ADM1033'...                     No
> > Probing for `Analog Devices ADM1034'...                     No
> > Probing for `SPD EEPROM'...                                 No
> >=20
> > Next adapter: nouveau-0000:01:00.0-0 (i2c-1)
> > Do you want to scan it? (YES/no/selectively): y
> >=20
> > Next adapter: SMBus I801 adapter at 10c0 (i2c-2)
> > Do you want to scan it? (YES/no/selectively): y
> > Client found at address 0x50
> > Probing for `Analog Devices ADM1033'...                     No
> > Probing for `Analog Devices ADM1034'...                     No
> > Probing for `SPD EEPROM'...                                 Yes
> >     (confidence 8=2C not a hardware monitoring chip)
> > Probing for `EDID EEPROM'...                                No
> > Client found at address 0x52
> > Probing for `Analog Devices ADM1033'...                     No
> > Probing for `Analog Devices ADM1034'...                     No
> > Probing for `SPD EEPROM'...                                 Yes
> >     (confidence 8=2C not a hardware monitoring chip)
> >=20
> > Now follows a summary of the probes I have just done.
> > Just press ENTER to continue:
> >=20
> > Driver `coretemp':
> >   * Chip `Intel digital thermal sensor' (confidence: 9)
> >=20
> > To load everything that is needed=2C add this to /etc/modules:
> > #----cut here----
> > # Chip drivers
> > coretemp
> > #----cut here----
> > If you have some drivers built into your kernel=2C the list above will
> > contain too many modules. Skip the appropriate ones!
> >=20
> > Do you want to add these lines automatically to /etc/modules? (yes/NO)y
> > Successful!
> >=20
> > Monitoring programs won't work until the needed modules are
> > loaded. You may want to run 'service module-init-tools start'
> > to load them.
> >=20
> > Unloading i2c-dev... OK
> > Unloading cpuid... OK
> >=20
> > And when I try to run module-init-tools=2C I get:
> >=20
> > sgo542@NostalgiaforInfinity:~$ sudo service module-init-tools start
> > module-init-tools stop/waiting
> >=20
> > I've heard I might be able to fix this by tweaking the /etc/sensors.con=
f file=2C
> > but I'm unsure how to even start with that.  I am moderately experience=
s with
> > Linux=2C but by no means an expert.  Any help would be appreciated=2C b=
efore it
> > gets hot outside and my computer becomes completely unusable.
>=20
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>=20
 		 	   		  =

--_c3bd6aac-36e4-4dcc-95f4-fb7a540b6ad1_
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
-I've been running the computer for over an hour currently and it feels per=
fectly fine.&nbsp=3B Even the hard drive feels only mildly warm.&nbsp=3B No=
netheless=2C I'm getting 96C readings for my PCI Adapter.<br><br>Is there a=
 way to modify my /etc/sensors.conf file to change the input levels or high=
/crit temps for the adapter?&nbsp=3B I may not be looking properly=2C but I=
 can't find its chip name.<br><br>Also=2C is there a way to run "module-ini=
t-tools" without getting "stop/waiting"?<br><br><div><div id=3D"SkyDrivePla=
ceholder"></div>&gt=3B Date: Sun=2C 25 Mar 2012 08:23:12 -0700<br>&gt=3B Fr=
om: guenter.roeck@ericsson.com<br>&gt=3B To: sgo542@hotmail.com<br>&gt=3B C=
C: lm-sensors@lm-sensors.org=3B airlied@linux.ie=3B dri-devel@lists.freedes=
ktop.org<br>&gt=3B Subject: Re: [lm-sensors] Incorrect Temperature Readings=
<br>&gt=3B <br>&gt=3B On Sun=2C Mar 25=2C 2012 at 07:49:46AM -0400=2C Scott=
 Ondercin wrote:<br>&gt=3B &gt=3B So=2C once upon a time=2C my computer wor=
ked fine.  I have a Dell Inspiron 1420=2C<br>&gt=3B &gt=3B which has a good=
 ventilation system and usually runs quite cool.  A few months<br>&gt=3B &g=
t=3B ago my fan broke and I had to have it replaced.  The new one=2C howeve=
r=2C runs all<br>&gt=3B &gt=3B the time and is very loud.<br>&gt=3B &gt=3B =
<br>&gt=3B &gt=3B My lm-sensors is screwed up=2C and scanning various threa=
ds I can't seem to find<br>&gt=3B &gt=3B a problem like mine.  So=2C here i=
s what running sensors gets me:<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B sgo542@N=
ostalgiaforInfinity:~$ sensors<br>&gt=3B &gt=3B acpitz-virtual-0<br>&gt=3B =
&gt=3B Adapter: Virtual device<br>&gt=3B &gt=3B temp1:        +32.5 C  (cri=
t =3D +87.0 C)<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B coretemp-isa-0000<br>&gt=
=3B &gt=3B Adapter: ISA adapter<br>&gt=3B &gt=3B Core 0:       +30.0 C  (hi=
gh =3D +85.0 C=2C crit =3D +85.0 C)<br>&gt=3B &gt=3B Core 1:       +33.0 C =
 (high =3D +85.0 C=2C crit =3D +85.0 C)<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B =
nouveau-pci-0100<br>&gt=3B &gt=3B Adapter: PCI adapter<br>&gt=3B &gt=3B tem=
p1:        +97.0 C  (high =3D +100.0 C=2C crit =3D +110.0 C)<br>&gt=3B &gt=
=3B <br>&gt=3B Scott=2C<br>&gt=3B <br>&gt=3B That temperature reading is fr=
om your graphics adapter. No idea how it comes<br>&gt=3B that it reports su=
ch a high temperature. Does it have a fan=2C and are you sure<br>&gt=3B it =
is working ?<br>&gt=3B <br>&gt=3B Copying the driver maintainer and the drm=
 mailing list. Maybe someone there<br>&gt=3B has an idea.<br>&gt=3B <br>&gt=
=3B Guenter<br>&gt=3B <br>&gt=3B &gt=3B I've been casually browsing FireFox=
 for a half hour and that is what it gives<br>&gt=3B &gt=3B me.  Now=2C I c=
an sit this computer comfortably in my lap.  That 97C temperature<br>&gt=3B=
 &gt=3B is clearly off=2C almost like it's reading in Farenheit but forgett=
ing to convert<br>&gt=3B &gt=3B it to Celsius.  Normally it just makes my f=
an run all the time=2C but now that<br>&gt=3B &gt=3B spring has come=2C it =
gets hotter faster.  A few days ago I could only run it for<br>&gt=3B &gt=
=3B 20-30 minutes before the reading hit 105C and the automatic emergency s=
hut-down<br>&gt=3B &gt=3B kicked in.  Obviously=2C this needs to be fixed b=
efore sumer strikes.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B For reference=2C th=
is is what I get from sensors-detect:<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B sg=
o542@NostalgiaforInfinity:~$ sudo sensors-detect<br>&gt=3B &gt=3B # sensors=
-detect revision 5946 (2011-03-23 11:54:44 +0100)<br>&gt=3B &gt=3B # System=
: Dell Inc. Inspiron 1420 (laptop)<br>&gt=3B &gt=3B # Board: Dell Inc. 0JX2=
69<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B This program will help you determine =
which kernel modules you need<br>&gt=3B &gt=3B to load to use lm_sensors mo=
st effectively. It is generally safe<br>&gt=3B &gt=3B and recommended to ac=
cept the default answers to all questions=2C<br>&gt=3B &gt=3B unless you kn=
ow what you're doing.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Some south bridges=
=2C CPUs or memory controllers contain embedded sensors.<br>&gt=3B &gt=3B D=
o you want to scan for them? This is totally safe. (YES/no): y<br>&gt=3B &g=
t=3B Module cpuid loaded successfully.<br>&gt=3B &gt=3B Silicon Integrated =
Systems SIS5595...                       No<br>&gt=3B &gt=3B VIA VT82C686 I=
ntegrated Sensors...                          No<br>&gt=3B &gt=3B VIA VT823=
1 Integrated Sensors...                            No<br>&gt=3B &gt=3B AMD =
K8 thermal sensors...                                   No<br>&gt=3B &gt=3B=
 AMD Family 10h thermal sensors...                           No<br>&gt=3B &=
gt=3B AMD Family 11h thermal sensors...                           No<br>&gt=
=3B &gt=3B AMD Family 12h and 14h thermal sensors...                   No<b=
r>&gt=3B &gt=3B Intel digital thermal sensor...                            =
 Success!<br>&gt=3B &gt=3B     (driver `coretemp')<br>&gt=3B &gt=3B Intel A=
MB FB-DIMM thermal sensor...                         No<br>&gt=3B &gt=3B VI=
A C7 thermal sensor...                                    No<br>&gt=3B &gt=
=3B VIA Nano thermal sensor...                                  No<br>&gt=
=3B &gt=3B <br>&gt=3B &gt=3B Some Super I/O chips contain embedded sensors.=
 We have to write to<br>&gt=3B &gt=3B standard I/O ports to probe them. Thi=
s is usually safe.<br>&gt=3B &gt=3B Do you want to scan for Super I/O senso=
rs? (YES/no): y<br>&gt=3B &gt=3B Probing for Super-I/O at 0x2e/0x2f<br>&gt=
=3B &gt=3B Trying family `National Semiconductor'...                   No<b=
r>&gt=3B &gt=3B Trying family `SMSC'...                                    =
 Yes<br>&gt=3B &gt=3B Found unknown chip with ID 0x3201<br>&gt=3B &gt=3B Pr=
obing for Super-I/O at 0x4e/0x4f<br>&gt=3B &gt=3B Trying family `National S=
emiconductor'...                   No<br>&gt=3B &gt=3B Trying family `SMSC'=
...                                     No<br>&gt=3B &gt=3B Trying family `=
VIA/Winbond/Nuvoton/Fintek'...               No<br>&gt=3B &gt=3B Trying fam=
ily `ITE'...                                      No<br>&gt=3B &gt=3B <br>&=
gt=3B &gt=3B Some hardware monitoring chips are accessible through the ISA =
I/O ports.<br>&gt=3B &gt=3B We have to write to arbitrary I/O ports to prob=
e them. This is usually<br>&gt=3B &gt=3B safe though. Yes=2C you do have IS=
A I/O ports even if you do not have any<br>&gt=3B &gt=3B ISA slots! Do you =
want to scan the ISA I/O ports? (YES/no): y<br>&gt=3B &gt=3B Probing for `N=
ational Semiconductor LM78' at 0x290...       No<br>&gt=3B &gt=3B Probing f=
or `National Semiconductor LM79' at 0x290...       No<br>&gt=3B &gt=3B Prob=
ing for `Winbond W83781D' at 0x290...                   No<br>&gt=3B &gt=3B=
 Probing for `Winbond W83782D' at 0x290...                   No<br>&gt=3B &=
gt=3B <br>&gt=3B &gt=3B Lastly=2C we can probe the I2C/SMBus adapters for c=
onnected hardware<br>&gt=3B &gt=3B monitoring devices. This is the most ris=
ky part=2C and while it works<br>&gt=3B &gt=3B reasonably well on most syst=
ems=2C it has been reported to cause trouble<br>&gt=3B &gt=3B on some syste=
ms.<br>&gt=3B &gt=3B Do you want to probe the I2C/SMBus adapters now? (YES/=
no): y<br>&gt=3B &gt=3B Using driver `i2c-i801' for device 0000:00:1f.3: In=
tel 82801H ICH8<br>&gt=3B &gt=3B Module i2c-dev loaded successfully.<br>&gt=
=3B &gt=3B <br>&gt=3B &gt=3B Next adapter: nouveau-0000:01:00.0-2 (i2c-0)<b=
r>&gt=3B &gt=3B Do you want to scan it? (YES/no/selectively): y<br>&gt=3B &=
gt=3B Client found at address 0x50<br>&gt=3B &gt=3B Probing for `Analog Dev=
ices ADM1033'...                     No<br>&gt=3B &gt=3B Probing for `Analo=
g Devices ADM1034'...                     No<br>&gt=3B &gt=3B Probing for `=
SPD EEPROM'...                                 No<br>&gt=3B &gt=3B Probing =
for `EDID EEPROM'...                                Yes<br>&gt=3B &gt=3B   =
  (confidence 8=2C not a hardware monitoring chip)<br>&gt=3B &gt=3B Client =
found at address 0x51<br>&gt=3B &gt=3B Probing for `Analog Devices ADM1033'=
...                     No<br>&gt=3B &gt=3B Probing for `Analog Devices ADM=
1034'...                     No<br>&gt=3B &gt=3B Probing for `SPD EEPROM'..=
.                                 No<br>&gt=3B &gt=3B Client found at addre=
ss 0x52<br>&gt=3B &gt=3B Probing for `Analog Devices ADM1033'...           =
          No<br>&gt=3B &gt=3B Probing for `Analog Devices ADM1034'...      =
               No<br>&gt=3B &gt=3B Probing for `SPD EEPROM'...             =
                    No<br>&gt=3B &gt=3B Client found at address 0x53<br>&gt=
=3B &gt=3B Probing for `Analog Devices ADM1033'...                     No<b=
r>&gt=3B &gt=3B Probing for `Analog Devices ADM1034'...                    =
 No<br>&gt=3B &gt=3B Probing for `SPD EEPROM'...                           =
      No<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Next adapter: nouveau-0000:01:0=
0.0-0 (i2c-1)<br>&gt=3B &gt=3B Do you want to scan it? (YES/no/selectively)=
: y<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Next adapter: SMBus I801 adapter at =
10c0 (i2c-2)<br>&gt=3B &gt=3B Do you want to scan it? (YES/no/selectively):=
 y<br>&gt=3B &gt=3B Client found at address 0x50<br>&gt=3B &gt=3B Probing f=
or `Analog Devices ADM1033'...                     No<br>&gt=3B &gt=3B Prob=
ing for `Analog Devices ADM1034'...                     No<br>&gt=3B &gt=3B=
 Probing for `SPD EEPROM'...                                 Yes<br>&gt=3B =
&gt=3B     (confidence 8=2C not a hardware monitoring chip)<br>&gt=3B &gt=
=3B Probing for `EDID EEPROM'...                                No<br>&gt=
=3B &gt=3B Client found at address 0x52<br>&gt=3B &gt=3B Probing for `Analo=
g Devices ADM1033'...                     No<br>&gt=3B &gt=3B Probing for `=
Analog Devices ADM1034'...                     No<br>&gt=3B &gt=3B Probing =
for `SPD EEPROM'...                                 Yes<br>&gt=3B &gt=3B   =
  (confidence 8=2C not a hardware monitoring chip)<br>&gt=3B &gt=3B <br>&gt=
=3B &gt=3B Now follows a summary of the probes I have just done.<br>&gt=3B =
&gt=3B Just press ENTER to continue:<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Dri=
ver `coretemp':<br>&gt=3B &gt=3B   * Chip `Intel digital thermal sensor' (c=
onfidence: 9)<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B To load everything that is=
 needed=2C add this to /etc/modules:<br>&gt=3B &gt=3B #----cut here----<br>=
&gt=3B &gt=3B # Chip drivers<br>&gt=3B &gt=3B coretemp<br>&gt=3B &gt=3B #--=
--cut here----<br>&gt=3B &gt=3B If you have some drivers built into your ke=
rnel=2C the list above will<br>&gt=3B &gt=3B contain too many modules. Skip=
 the appropriate ones!<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Do you want to ad=
d these lines automatically to /etc/modules? (yes/NO)y<br>&gt=3B &gt=3B Suc=
cessful!<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Monitoring programs won't work =
until the needed modules are<br>&gt=3B &gt=3B loaded. You may want to run '=
service module-init-tools start'<br>&gt=3B &gt=3B to load them.<br>&gt=3B &=
gt=3B <br>&gt=3B &gt=3B Unloading i2c-dev... OK<br>&gt=3B &gt=3B Unloading =
cpuid... OK<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B sgo542@NostalgiaforInfinity:=
~$ sudo service module-init-tools start<br>&gt=3B &gt=3B module-init-tools =
stop/waiting<br>&gt=3B &gt=3B sgo542@NostalgiaforInfinity:~$ sensors<br>&gt=
=3B &gt=3B acpitz-virtual-0<br>&gt=3B &gt=3B Adapter: Virtual device<br>&gt=
=3B &gt=3B temp1:        +32.5 C  (crit =3D +87.0 C)<br>&gt=3B &gt=3B <br>&=
gt=3B &gt=3B coretemp-isa-0000<br>&gt=3B &gt=3B Adapter: ISA adapter<br>&gt=
=3B &gt=3B Core 0:       +31.0 C  (high =3D +85.0 C=2C crit =3D +85.0 C)<br=
>&gt=3B &gt=3B Core 1:       +33.0 C  (high =3D +85.0 C=2C crit =3D +85.0 C=
)<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B nouveau-pci-0100<br>&gt=3B &gt=3B Adap=
ter: PCI adapter<br>&gt=3B &gt=3B temp1:        +97.0 C  (high =3D +100.0 C=
=2C crit =3D +110.0 C)<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B sgo542@Nostalgiaf=
orInfinity:~$ sudo modprobe coretemp<br>&gt=3B &gt=3B sgo542@NostalgiaforIn=
finity:~$ sensors<br>&gt=3B &gt=3B acpitz-virtual-0<br>&gt=3B &gt=3B Adapte=
r: Virtual device<br>&gt=3B &gt=3B temp1:        +32.5 C  (crit =3D +87.0 C=
)<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B coretemp-isa-0000<br>&gt=3B &gt=3B Ada=
pter: ISA adapter<br>&gt=3B &gt=3B Core 0:       +30.0 C  (high =3D +85.0 C=
=2C crit =3D +85.0 C)<br>&gt=3B &gt=3B Core 1:       +33.0 C  (high =3D +85=
.0 C=2C crit =3D +85.0 C)<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B nouveau-pci-01=
00<br>&gt=3B &gt=3B Adapter: PCI adapter<br>&gt=3B &gt=3B temp1:        +97=
.0 C  (high =3D +100.0 C=2C crit =3D +110.0 C)<br>&gt=3B &gt=3B <br>&gt=3B =
&gt=3B sgo542@NostalgiaforInfinity:~$ sensors<br>&gt=3B &gt=3B acpitz-virtu=
al-0<br>&gt=3B &gt=3B Adapter: Virtual device<br>&gt=3B &gt=3B temp1:      =
  +33.5 C  (crit =3D +87.0 C)<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B coretemp-i=
sa-0000<br>&gt=3B &gt=3B Adapter: ISA adapter<br>&gt=3B &gt=3B Core 0:     =
  +31.0 C  (high =3D +85.0 C=2C crit =3D +85.0 C)<br>&gt=3B &gt=3B Core 1: =
      +33.0 C  (high =3D +85.0 C=2C crit =3D +85.0 C)<br>&gt=3B &gt=3B <br>=
&gt=3B &gt=3B nouveau-pci-0100<br>&gt=3B &gt=3B Adapter: PCI adapter<br>&gt=
=3B &gt=3B temp1:        +97.0 C  (high =3D +100.0 C=2C crit =3D +110.0 C)<=
br>&gt=3B &gt=3B <br>&gt=3B &gt=3B sgo542@NostalgiaforInfinity:~$ sensors-d=
etect<br>&gt=3B &gt=3B You need to be root to run this script.<br>&gt=3B &g=
t=3B sgo542@NostalgiaforInfinity:~$ sudo sensors-detect<br>&gt=3B &gt=3B # =
sensors-detect revision 5946 (2011-03-23 11:54:44 +0100)<br>&gt=3B &gt=3B #=
 System: Dell Inc. Inspiron 1420 (laptop)<br>&gt=3B &gt=3B # Board: Dell In=
c. 0JX269<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B This program will help you det=
ermine which kernel modules you need<br>&gt=3B &gt=3B to load to use lm_sen=
sors most effectively. It is generally safe<br>&gt=3B &gt=3B and recommende=
d to accept the default answers to all questions=2C<br>&gt=3B &gt=3B unless=
 you know what you're doing.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Some south =
bridges=2C CPUs or memory controllers contain embedded sensors.<br>&gt=3B &=
gt=3B Do you want to scan for them? This is totally safe. (YES/no): y<br>&g=
t=3B &gt=3B Module cpuid loaded successfully.<br>&gt=3B &gt=3B Silicon Inte=
grated Systems SIS5595...                       No<br>&gt=3B &gt=3B VIA VT8=
2C686 Integrated Sensors...                          No<br>&gt=3B &gt=3B VI=
A VT8231 Integrated Sensors...                            No<br>&gt=3B &gt=
=3B AMD K8 thermal sensors...                                   No<br>&gt=
=3B &gt=3B AMD Family 10h thermal sensors...                           No<b=
r>&gt=3B &gt=3B AMD Family 11h thermal sensors...                          =
 No<br>&gt=3B &gt=3B AMD Family 12h and 14h thermal sensors...             =
      No<br>&gt=3B &gt=3B Intel digital thermal sensor...                  =
           Success!<br>&gt=3B &gt=3B     (driver `coretemp')<br>&gt=3B &gt=
=3B Intel AMB FB-DIMM thermal sensor...                         No<br>&gt=
=3B &gt=3B VIA C7 thermal sensor...                                    No<b=
r>&gt=3B &gt=3B VIA Nano thermal sensor...                                 =
 No<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Some Super I/O chips contain embedde=
d sensors. We have to write to<br>&gt=3B &gt=3B standard I/O ports to probe=
 them. This is usually safe.<br>&gt=3B &gt=3B Do you want to scan for Super=
 I/O sensors? (YES/no): y<br>&gt=3B &gt=3B Probing for Super-I/O at 0x2e/0x=
2f<br>&gt=3B &gt=3B Trying family `National Semiconductor'...              =
     No<br>&gt=3B &gt=3B Trying family `SMSC'...                           =
          Yes<br>&gt=3B &gt=3B Found unknown chip with ID 0x3201<br>&gt=3B =
&gt=3B Probing for Super-I/O at 0x4e/0x4f<br>&gt=3B &gt=3B Trying family `N=
ational Semiconductor'...                   No<br>&gt=3B &gt=3B Trying fami=
ly `SMSC'...                                     No<br>&gt=3B &gt=3B Trying=
 family `VIA/Winbond/Nuvoton/Fintek'...               No<br>&gt=3B &gt=3B T=
rying family `ITE'...                                      No<br>&gt=3B &gt=
=3B <br>&gt=3B &gt=3B Some hardware monitoring chips are accessible through=
 the ISA I/O ports.<br>&gt=3B &gt=3B We have to write to arbitrary I/O port=
s to probe them. This is usually<br>&gt=3B &gt=3B safe though. Yes=2C you d=
o have ISA I/O ports even if you do not have any<br>&gt=3B &gt=3B ISA slots=
! Do you want to scan the ISA I/O ports? (YES/no): y<br>&gt=3B &gt=3B Probi=
ng for `National Semiconductor LM78' at 0x290...       No<br>&gt=3B &gt=3B =
Probing for `National Semiconductor LM79' at 0x290...       No<br>&gt=3B &g=
t=3B Probing for `Winbond W83781D' at 0x290...                   No<br>&gt=
=3B &gt=3B Probing for `Winbond W83782D' at 0x290...                   No<b=
r>&gt=3B &gt=3B <br>&gt=3B &gt=3B Lastly=2C we can probe the I2C/SMBus adap=
ters for connected hardware<br>&gt=3B &gt=3B monitoring devices. This is th=
e most risky part=2C and while it works<br>&gt=3B &gt=3B reasonably well on=
 most systems=2C it has been reported to cause trouble<br>&gt=3B &gt=3B on =
some systems.<br>&gt=3B &gt=3B Do you want to probe the I2C/SMBus adapters =
now? (YES/no): y<br>&gt=3B &gt=3B Using driver `i2c-i801' for device 0000:0=
0:1f.3: Intel 82801H ICH8<br>&gt=3B &gt=3B Module i2c-dev loaded successful=
ly.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Next adapter: nouveau-0000:01:00.0-2=
 (i2c-0)<br>&gt=3B &gt=3B Do you want to scan it? (YES/no/selectively): y<b=
r>&gt=3B &gt=3B Client found at address 0x50<br>&gt=3B &gt=3B Probing for `=
Analog Devices ADM1033'...                     No<br>&gt=3B &gt=3B Probing =
for `Analog Devices ADM1034'...                     No<br>&gt=3B &gt=3B Pro=
bing for `SPD EEPROM'...                                 No<br>&gt=3B &gt=
=3B Probing for `EDID EEPROM'...                                Yes<br>&gt=
=3B &gt=3B     (confidence 8=2C not a hardware monitoring chip)<br>&gt=3B &=
gt=3B Client found at address 0x51<br>&gt=3B &gt=3B Probing for `Analog Dev=
ices ADM1033'...                     No<br>&gt=3B &gt=3B Probing for `Analo=
g Devices ADM1034'...                     No<br>&gt=3B &gt=3B Probing for `=
SPD EEPROM'...                                 No<br>&gt=3B &gt=3B Client f=
ound at address 0x52<br>&gt=3B &gt=3B Probing for `Analog Devices ADM1033'.=
..                     No<br>&gt=3B &gt=3B Probing for `Analog Devices ADM1=
034'...                     No<br>&gt=3B &gt=3B Probing for `SPD EEPROM'...=
                                 No<br>&gt=3B &gt=3B Client found at addres=
s 0x53<br>&gt=3B &gt=3B Probing for `Analog Devices ADM1033'...            =
         No<br>&gt=3B &gt=3B Probing for `Analog Devices ADM1034'...       =
              No<br>&gt=3B &gt=3B Probing for `SPD EEPROM'...              =
                   No<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Next adapter: nouv=
eau-0000:01:00.0-0 (i2c-1)<br>&gt=3B &gt=3B Do you want to scan it? (YES/no=
/selectively): y<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Next adapter: SMBus I80=
1 adapter at 10c0 (i2c-2)<br>&gt=3B &gt=3B Do you want to scan it? (YES/no/=
selectively): y<br>&gt=3B &gt=3B Client found at address 0x50<br>&gt=3B &gt=
=3B Probing for `Analog Devices ADM1033'...                     No<br>&gt=
=3B &gt=3B Probing for `Analog Devices ADM1034'...                     No<b=
r>&gt=3B &gt=3B Probing for `SPD EEPROM'...                                =
 Yes<br>&gt=3B &gt=3B     (confidence 8=2C not a hardware monitoring chip)<=
br>&gt=3B &gt=3B Probing for `EDID EEPROM'...                              =
  No<br>&gt=3B &gt=3B Client found at address 0x52<br>&gt=3B &gt=3B Probing=
 for `Analog Devices ADM1033'...                     No<br>&gt=3B &gt=3B Pr=
obing for `Analog Devices ADM1034'...                     No<br>&gt=3B &gt=
=3B Probing for `SPD EEPROM'...                                 Yes<br>&gt=
=3B &gt=3B     (confidence 8=2C not a hardware monitoring chip)<br>&gt=3B &=
gt=3B <br>&gt=3B &gt=3B Now follows a summary of the probes I have just don=
e.<br>&gt=3B &gt=3B Just press ENTER to continue:<br>&gt=3B &gt=3B <br>&gt=
=3B &gt=3B Driver `coretemp':<br>&gt=3B &gt=3B   * Chip `Intel digital ther=
mal sensor' (confidence: 9)<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B To load ever=
ything that is needed=2C add this to /etc/modules:<br>&gt=3B &gt=3B #----cu=
t here----<br>&gt=3B &gt=3B # Chip drivers<br>&gt=3B &gt=3B coretemp<br>&gt=
=3B &gt=3B #----cut here----<br>&gt=3B &gt=3B If you have some drivers buil=
t into your kernel=2C the list above will<br>&gt=3B &gt=3B contain too many=
 modules. Skip the appropriate ones!<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Do =
you want to add these lines automatically to /etc/modules? (yes/NO)y<br>&gt=
=3B &gt=3B Successful!<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Monitoring progra=
ms won't work until the needed modules are<br>&gt=3B &gt=3B loaded. You may=
 want to run 'service module-init-tools start'<br>&gt=3B &gt=3B to load the=
m.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Unloading i2c-dev... OK<br>&gt=3B &gt=
=3B Unloading cpuid... OK<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B And when I try=
 to run module-init-tools=2C I get:<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B sgo5=
42@NostalgiaforInfinity:~$ sudo service module-init-tools start<br>&gt=3B &=
gt=3B module-init-tools stop/waiting<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B I'v=
e heard I might be able to fix this by tweaking the /etc/sensors.conf file=
=2C<br>&gt=3B &gt=3B but I'm unsure how to even start with that.  I am mode=
rately experiences with<br>&gt=3B &gt=3B Linux=2C but by no means an expert=
.  Any help would be appreciated=2C before it<br>&gt=3B &gt=3B gets hot out=
side and my computer becomes completely unusable.<br>&gt=3B <br>&gt=3B &gt=
=3B _______________________________________________<br>&gt=3B &gt=3B lm-sen=
sors mailing list<br>&gt=3B &gt=3B lm-sensors@lm-sensors.org<br>&gt=3B &gt=
=3B http://lists.lm-sensors.org/mailman/listinfo/lm-sensors<br>&gt=3B <br><=
/div> 		 	   		  </div></body>
</html>=

--_c3bd6aac-36e4-4dcc-95f4-fb7a540b6ad1_--


--===============3085317740933432083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3085317740933432083==--
