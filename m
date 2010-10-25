From: Mahmood Naderan <nt_mahmood@yahoo.com>
Date: Mon, 25 Oct 2010 08:14:18 +0000
Subject: [lm-sensors] k10temp is detected but not shown
Message-Id: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7457800540023948897=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============7457800540023948897==
Content-Type: multipart/alternative; boundary="0-1237385525-1287994458=:74607"

--0-1237385525-1287994458=:74607
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,=0AI want to=A0see AMD sensors with lm-sensors. Here is what I did:=0A=
=0Amahmood@localhost:~$ sudo sensors-detect=0A# sensors-detect revision 581=
8 (2010-01-18 17:22:07 +0100)=0A# System: empty empty=0A# Board: TYAN S8230=
=0AThis program will help you determine which kernel modules you need=0Ato =
load to use lm_sensors most effectively. It is generally safe=0Aand recomme=
nded to accept the default answers to all questions,=0Aunless you know what=
 you're doing.=0ASome south bridges, CPUs or memory controllers contain emb=
edded sensors.=0ADo you want to scan for them? This is totally safe. (YES/n=
o): yes=0ASilicon Integrated Systems SIS5595...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AVIA VT82C686 Integrated Sensor=
s...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 No=0AVIA VT8231 Integrated Sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AAMD K8 thermal sen=
sors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AAMD Family 10h thermal sensors...=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 Success!=0A=A0=A0=A0 (driver `k10temp')=0AAMD Family 11h thermal sensor=
s...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 No=0AIntel Core family thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AIntel Atom thermal se=
nsor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AIntel AMB FB-DIMM thermal sensor...=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AVIA=
 C7 thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AVIA Nano thermal s=
ensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0ASome Super I/O chips contain embedde=
d sensors. We have to write to=0Astandard I/O ports to probe them. This is =
usually safe.=0ADo you want to scan for Super I/O sensors? (YES/no): yes=0A=
Probing for Super-I/O at 0x2e/0x2f=0ATrying family `National Semiconductor'=
...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0ATrying famil=
y `SMSC'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0ATrying family `VIA/Winbo=
nd/Nuvoton/Fintek'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Yes=0AFound=
 `Winbond W83627DHG-P Super IO Sensors'=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Success!=0A=A0=A0=A0 (address 0xa10, driver `w83627ehf')=0AProbin=
g for Super-I/O at 0x4e/0x4f=0ATrying family `National Semiconductor'...=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0ATrying family `SMS=
C'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Yes=0AFound unknown chip with ID 0x=
0b00=0ASome systems (mainly servers) implement IPMI, a set of common interf=
aces=0Athrough which system health data may be retrieved, amongst other thi=
ngs.=0AWe first try to get the information from SMBIOS. If we don't find it=
=0Athere, we have to read from arbitrary I/O ports to probe for such=0Ainte=
rfaces. This is normally safe. Do you want to scan for IPMI=0Ainterfaces? (=
YES/no): yes=0AFound `IPMI BMC KCS' at 0xca2...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Success!=0A=A0=A0=A0=
 (confidence 8, driver `ipmisensors')=0ASome hardware monitoring chips are =
accessible through the ISA I/O ports.=0AWe have to write to arbitrary I/O p=
orts to probe them. This is usually=0Asafe though. Yes, you do have ISA I/O=
 ports even if you do not have any=0AISA slots! Do you want to scan the ISA=
 I/O ports? (yes/NO): yes=0AProbing for `National Semiconductor LM78' at 0x=
290...=A0=A0=A0=A0=A0=A0 No=0AProbing for `National Semiconductor LM79' at =
0x290...=A0=A0=A0=A0=A0=A0 No=0AProbing for `Winbond W83781D' at 0x290...=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `Wi=
nbond W83782D' at 0x290...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 No=0ALastly, we can probe the I2C/SMBus adapters for connected hardw=
are=0Amonitoring devices. This is the most risky part, and while it works=
=0Areasonably well on most systems, it has been reported to cause trouble=
=0Aon some systems.=0ADo you want to probe the I2C/SMBus adapters now? (YES=
/no): yes=0AUsing driver `i2c-piix4' for device 0000:00:14.0: ATI Technolog=
ies Inc =0ASB600/SB700/SB800 SMBus=0AModule i2c-dev loaded successfully.=0A=
Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)=0ADo you want to scan it?=
 (YES/no/selectively): yes=0ANow follows a summary of the probes I have jus=
t done.=0AJust press ENTER to continue:=0ADriver `w83627ehf':=0A=A0 * ISA b=
us, address 0xa10=0A=A0=A0=A0 Chip `Winbond W83627DHG-P Super IO Sensors' (=
confidence: 9)=0ADriver `ipmisensors':=0A=A0 * ISA bus, address 0xca2=0A=A0=
=A0=A0 Chip `IPMI BMC KCS' (confidence: 8)=0ADriver `k10temp':=0A=A0 * Chip=
 `AMD Family 10h thermal sensors' (confidence: 9)=0AWarning: the required m=
odule ipmisensors is not currently installed=0Aon your system. If it is bui=
lt into the kernel then it's OK.=0AOtherwise, check http://www.lm-sensors.o=
rg/wiki/Devicesfor=0Adriver availability.=0AWarning: the required module k1=
0temp is not currently installed=0Aon your system. If it is built into the =
kernel then it's OK.=0AOtherwise, check http://www.lm-sensors.org/wiki/Devi=
cesfor=0Adriver availability.=0ATo load everything that is needed, add this=
 to /etc/modules:=0A#----cut here----=0A# Adapter drivers=0Aipmi-si=0A# Chi=
p drivers=0Aw83627ehf=0A#----cut here----=0AIf you have some drivers built =
into your kernel, the list above will=0Acontain too many modules. Skip the =
appropriate ones!=0ADo you want to add these lines automatically to /etc/mo=
dules? (yes/NO)yes=0ASuccessful!=0AMonitoring programs won't work until the=
 needed modules are=0Aloaded. You may want to run '/etc/init.d/module-init-=
tools start'=0Ato load them.=0AUnloading i2c-dev... OK=0A=0AI then start th=
e service:=0Amahmood@localhost:~$ sudo /etc/init.d/module-init-tools start=
=0ARather than invoking init scripts through /etc/init.d, use the service(8=
)=0Autility, e.g. service module-init-tools start=0ASince the script you ar=
e attempting to invoke has been converted to an=0AUpstart job, you may also=
 use the start(8) utility, e.g. start module-init-tools=0Amodule-init-tools=
 stop/waiting=0A=0ASeems that all things are fine, however when I run "sens=
ors" there is no cpu =0Atemps:mahmood@localhost:~$ sensors=0Aw83627dhg-isa-=
0a10=0AAdapter: ISA adapter=0AVcore:=A0=A0=A0=A0=A0=A0 +1.11 V=A0 (min =3D=
=A0 +0.00 V, max =3D=A0 +1.74 V)=0Ain1:=A0=A0=A0=A0=A0=A0=A0=A0 +1.11 V=A0 =
(min =3D=A0 +1.91 V, max =3D=A0 +1.63 V)=A0=A0 ALARM=0AAVCC:=A0=A0=A0=A0=A0=
=A0=A0 +3.33 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3.63 V)=0AVCC:=A0=A0=A0=
=A0=A0=A0=A0=A0 +3.33 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3.63 V)=0Ain4:=
=A0=A0=A0=A0=A0=A0=A0=A0 +2.03 V=A0 (min =3D=A0 +0.80 V, max =3D=A0 +1.18 V=
)=A0=A0 ALARM=0Ain5:=A0=A0=A0=A0=A0=A0=A0=A0 +1.66 V=A0 (min =3D=A0 +1.52 V=
, max =3D=A0 +1.02 V)=A0=A0 ALARM=0Ain6:=A0=A0=A0=A0=A0=A0=A0=A0 +1.12 V=A0=
 (min =3D=A0 +1.12 V, max =3D=A0 +1.71 V)=0A3VSB:=A0=A0=A0=A0=A0=A0=A0 +3.2=
8 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3.63 V)=0AVbat:=A0=A0=A0=A0=A0=A0=
=A0 +3.25 V=A0 (min =3D=A0 +2.70 V, max =3D=A0 +3.30 V)=0Afan1:=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D 2109 RPM, div =3D 128)=A0 ALARM=0Afan2:=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D 1757 RPM, div =3D 128)=A0 ALA=
RM=0Afan3:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D 10546 RPM, div =3D =
128)=A0 ALARM=0Afan4:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0 878 R=
PM, div =3D 128)=A0 ALARM=0Afan5:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =
=3D 10546 RPM, div =3D 128)=A0 ALARM=0Atemp1:=A0=A0=A0=A0=A0=A0 +42.0=C2=B0=
C=A0 (high =3D -58.0=C2=B0C, hyst =3D +99.0=C2=B0C)=A0 sensor =3D thermisto=
r=0Atemp2:=A0=A0=A0=A0=A0=A0 +41.0=C2=B0C=A0 (high =3D +80.0=C2=B0C, hyst =
=3D +75.0=C2=B0C)=A0 sensor =3D thermistor=0Atemp3:=A0=A0=A0=A0=A0=A0 -60.0=
=C2=B0C=A0 (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)=A0 sensor =3D tra=
nsistor=0Acpu0_vid:=A0=A0 +0.375 V=0A=0A=A0=0AI use Ubuntu 10.04 on AMD64. =
Also I used the lm-sensors package from synaptick.=0AAny idea? k10temp is d=
etected but not shown. Thanks=0A=A0=0A// Naderan *Mahmood;=0A=0A=0A      
--0-1237385525-1287994458=:74607
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:tahoma, new york, times, serif;font-size=
:12pt;color:#000000;"><DIV></DIV>=0A<DIV>Hi,</DIV>=0A<DIV>I want to&nbsp;se=
e AMD sensors with lm-sensors. Here is what I did:</DIV>=0A<DIV>&nbsp;</DIV=
>=0A<DIV><FONT size=3D2 face=3D"Courier New, courier, monaco, monospace, sa=
ns-serif">mahmood@localhost:~$ sudo sensors-detect<BR># sensors-detect revi=
sion 5818 (2010-01-18 17:22:07 +0100)<BR># System: empty empty<BR># Board: =
TYAN S8230</FONT></DIV>=0A<DIV><FONT size=3D2 face=3D"Courier New, courier,=
 monaco, monospace, sans-serif">This program will help you determine which =
kernel modules you need<BR>to load to use lm_sensors most effectively. It i=
s generally safe<BR>and recommended to accept the default answers to all qu=
estions,<BR>unless you know what you're doing.</FONT></DIV>=0A<DIV><FONT si=
ze=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif">Some so=
uth bridges, CPUs or memory controllers contain embedded sensors.<BR>Do you=
 want to scan for them? This is totally safe. (YES/no): yes<BR>Silicon Inte=
grated Systems SIS5595...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; No<BR>VIA VT82C686 Integrated Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>VIA VT8231 Integrate=
d Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; No<BR>AMD K8 thermal
 sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>AMD=
 Family 10h thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!<BR>&nbsp;&nbsp;&nbsp; (driver=
 `k10temp')<BR>AMD Family 11h thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Intel Core fam=
ily thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; No<BR>Intel Atom thermal
 sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Intel AMB FB-DIMM ther=
mal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; No<BR>VIA C7 thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; No<BR>VIA Nano thermal sensor...&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No</FONT></DIV>=0A<DIV><FONT size=3D2 face=3D=
"Courier New, courier, monaco, monospace, sans-serif">Some Super I/O chips =
contain embedded sensors. We have to write to<BR>standard I/O ports to prob=
e them. This is usually safe.<BR>Do you want to scan for Super I/O sensors?=
 (YES/no): yes<BR>Probing for Super-I/O at 0x2e/0x2f<BR>Trying family `Nati=
onal Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Trying family=
 `SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; No<BR>Trying family `VIA/Winbond/Nuvoton/Fintek'...&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<BR>Found=
 `Winbond W83627DHG-P Super IO
 Sensors'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; Success!<BR>&nbsp;&nbsp;&nbsp; (address 0xa10, dri=
ver `w83627ehf')<BR>Probing for Super-I/O at 0x4e/0x4f<BR>Trying family `Na=
tional Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Trying fami=
ly `SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; Yes<BR>Found unknown chip with ID 0x0b00</FONT></DIV>=0A<DIV><FONT size=
=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif">Some syst=
ems (mainly servers) implement IPMI, a set of common interfaces<BR>through =
which system health data may be retrieved, amongst other things.<BR>We firs=
t try to get the information from SMBIOS. If we don't find it<BR>there, we =
have to read from arbitrary I/O ports to probe for such<BR>interfaces. This=
 is normally safe. Do you want to scan for IPMI<BR>interfaces? (YES/no): ye=
s<BR>Found `IPMI BMC KCS' at 0xca2...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!<BR>&nbsp;&nbsp;&=
nbsp; (confidence 8, driver `ipmisensors')</FONT></DIV>=0A<DIV><FONT size=
=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif">Some hard=
ware monitoring chips are accessible through the ISA I/O ports.<BR>We have =
to write to arbitrary I/O ports to probe them. This is usually<BR>safe thou=
gh. Yes, you do have ISA I/O ports even if you do not have any<BR>ISA slots=
! Do you want to scan the ISA I/O ports? (yes/NO): yes<BR>Probing for `Nati=
onal Semiconductor LM78' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No=
<BR>Probing for `National Semiconductor LM79' at 0x290...&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; No<BR>Probing for `Winbond W83781D' at 0x290...&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Winbond W83782D' at 0x290...&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No</FONT></DIV>=0A<DIV><FONT size=3D2 face=
=3D"Courier New, courier, monaco, monospace, sans-serif">Lastly, we can pro=
be the I2C/SMBus adapters for connected hardware<BR>monitoring devices. Thi=
s is the most risky part, and while it works<BR>reasonably well on most sys=
tems, it has been reported to cause trouble<BR>on some systems.<BR>Do you w=
ant to probe the I2C/SMBus adapters now? (YES/no): yes<BR>Using driver `i2c=
-piix4' for device 0000:00:14.0: ATI Technologies Inc SB600/SB700/SB800 SMB=
us<BR>Module i2c-dev loaded successfully.</FONT></DIV>=0A<DIV><FONT size=3D=
2 face=3D"Courier New, courier, monaco, monospace, sans-serif">Next adapter=
: SMBus PIIX4 adapter at 0b00 (i2c-0)<BR>Do you want to scan it? (YES/no/se=
lectively): yes</FONT></DIV>=0A<DIV><FONT size=3D2 face=3D"Courier New, cou=
rier, monaco, monospace, sans-serif">Now follows a summary of the probes I =
have just done.<BR>Just press ENTER to continue:</FONT></DIV>=0A<DIV><FONT =
size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif">Drive=
r `w83627ehf':<BR>&nbsp; * ISA bus, address 0xa10<BR>&nbsp;&nbsp;&nbsp; Chi=
p `Winbond W83627DHG-P Super IO Sensors' (confidence: 9)</FONT></DIV>=0A<DI=
V><FONT size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-seri=
f">Driver `ipmisensors':<BR>&nbsp; * ISA bus, address 0xca2<BR>&nbsp;&nbsp;=
&nbsp; Chip `IPMI BMC KCS' (confidence: 8)</FONT></DIV>=0A<DIV><FONT size=
=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif">Driver `k=
10temp':<BR>&nbsp; * Chip `AMD Family 10h thermal sensors' (confidence: 9)<=
/FONT></DIV>=0A<DIV><FONT size=3D2 face=3D"Courier New, courier, monaco, mo=
nospace, sans-serif">Warning: the required module ipmisensors is not curren=
tly installed<BR>on your system. If it is built into the kernel then it's O=
K.<BR>Otherwise, check </FONT><A href=3D"http://www.lm-sensors.org/wiki/Dev=
ices"><FONT size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-=
serif">http://www.lm-sensors.org/wiki/Devices</FONT></A><FONT size=3D2 face=
=3D"Courier New, courier, monaco, monospace, sans-serif"> for<BR>driver ava=
ilability.</FONT></DIV>=0A<DIV><FONT size=3D2 face=3D"Courier New, courier,=
 monaco, monospace, sans-serif">Warning: the required module k10temp is not=
 currently installed<BR>on your system. If it is built into the kernel then=
 it's OK.<BR>Otherwise, check </FONT><A href=3D"http://www.lm-sensors.org/w=
iki/Devices"><FONT size=3D2 face=3D"Courier New, courier, monaco, monospace=
, sans-serif">http://www.lm-sensors.org/wiki/Devices</FONT></A><FONT size=
=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif"> for<BR>d=
river availability.</FONT></DIV>=0A<DIV><FONT size=3D2 face=3D"Courier New,=
 courier, monaco, monospace, sans-serif">To load everything that is needed,=
 add this to /etc/modules:<BR>#----cut here----<BR># Adapter drivers<BR>ipm=
i-si<BR># Chip drivers<BR>w83627ehf<BR>#----cut here----<BR>If you have som=
e drivers built into your kernel, the list above will<BR>contain too many m=
odules. Skip the appropriate ones!</FONT></DIV>=0A<DIV><FONT size=3D2 face=
=3D"Courier New, courier, monaco, monospace, sans-serif">Do you want to add=
 these lines automatically to /etc/modules? (yes/NO)yes<BR>Successful!</FON=
T></DIV>=0A<DIV><FONT size=3D2 face=3D"Courier New, courier, monaco, monosp=
ace, sans-serif">Monitoring programs won't work until the needed modules ar=
e<BR>loaded. You may want to run '/etc/init.d/module-init-tools start'<BR>t=
o load them.</FONT></DIV>=0A<DIV><FONT size=3D2 face=3D"Courier New, courie=
r, monaco, monospace, sans-serif">Unloading i2c-dev... OK<BR></FONT></DIV>=
=0A<DIV>I then start the service:</DIV>=0A<P><FONT size=3D2 face=3D"Courier=
 New, courier, monaco, monospace, sans-serif">mahmood@localhost:~$ sudo /et=
c/init.d/module-init-tools start<BR>Rather than invoking init scripts throu=
gh /etc/init.d, use the service(8)<BR>utility, e.g. service module-init-too=
ls start</FONT></P>=0A<P><FONT size=3D2 face=3D"Courier New, courier, monac=
o, monospace, sans-serif">Since the script you are attempting to invoke has=
 been converted to an<BR>Upstart job, you may also use the start(8) utility=
, e.g. start module-init-tools<BR>module-init-tools stop/waiting<BR></FONT>=
</P>=0A<P>Seems that all things are fine, however when I run "sensors" ther=
e is no cpu temps:</P><FONT size=3D2 face=3D"Courier New, courier, monaco, =
monospace, sans-serif">mahmood@localhost:~$ sensors<BR>w83627dhg-isa-0a10<B=
R>Adapter: ISA adapter<BR>Vcore:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.11 =
V&nbsp; (min =3D&nbsp; +0.00 V, max =3D&nbsp; +1.74 V)<BR>in1:&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.11 V&nbsp; (min =3D&nbsp; +1.91 V, m=
ax =3D&nbsp; +1.63 V)&nbsp;&nbsp; ALARM<BR>AVCC:&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; +3.33 V&nbsp; (min =3D&nbsp; +2.98 V, max =3D&nbsp; +3.63 V=
)<BR>VCC:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.33 V&nbsp; (mi=
n =3D&nbsp; +2.98 V, max =3D&nbsp; +3.63 V)<BR>in4:&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; +2.03 V&nbsp; (min =3D&nbsp; +0.80 V, max =3D&nbsp=
; +1.18 V)&nbsp;&nbsp; ALARM<BR>in5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; +1.66 V&nbsp; (min =3D&nbsp; +1.52 V, max =3D&nbsp; +1.02 V)&nbsp=
;&nbsp;
 ALARM<BR>in6:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.12 V&nbsp=
; (min =3D&nbsp; +1.12 V, max =3D&nbsp; +1.71 V)<BR>3VSB:&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; +3.28 V&nbsp; (min =3D&nbsp; +2.98 V, max =3D&nbsp=
; +3.63 V)<BR>Vbat:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.25 V&nbsp;=
 (min =3D&nbsp; +2.70 V, max =3D&nbsp; +3.30 V)<BR>fan1:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min =3D 2109 RPM, div =3D =
128)&nbsp; ALARM<BR>fan2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0 RPM&nbsp; (min =3D 1757 RPM, div =3D 128)&nbsp; ALARM<BR>fan3:&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min =3D 10546=
 RPM, div =3D 128)&nbsp; ALARM<BR>fan4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min =3D&nbsp; 878 RPM, div =3D 128)&nbsp; A=
LARM<BR>fan5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&n=
bsp; (min =3D 10546 RPM, div =3D 128)&nbsp; ALARM<BR>temp1:&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
 +42.0=C2=B0C&nbsp; (high =3D -58.0=C2=B0C, hyst =3D +99.0=C2=B0C)&nbsp; se=
nsor =3D thermistor<BR>temp2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +41.0=C2=
=B0C&nbsp; (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)&nbsp; sensor =3D =
thermistor<BR>temp3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -60.0=C2=B0C&nbsp;=
 (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)&nbsp; sensor =3D transistor=
<BR>cpu0_vid:&nbsp;&nbsp; +0.375 V<BR></FONT>=0A<P>&nbsp;</P>=0A<P>I use Ub=
untu 10.04 on AMD64. Also I used the lm-sensors package from synaptick.</P>=
=0A<DIV>Any idea? k10temp is detected but not shown. Thanks<BR>&nbsp;</DIV>=
=0A<DIV>=0A<DIV><FONT style=3D"BACKGROUND-COLOR: #ffffff" color=3D#0080ff s=
ize=3D2 face=3D"arial, helvetica, sans-serif"><STRONG>// Naderan *Mahmood;<=
/STRONG></FONT></DIV></DIV></div><br>=0A=0A=0A=0A=0A=0A=0A=0A      </body><=
/html>
--0-1237385525-1287994458=:74607--


--===============7457800540023948897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7457800540023948897==--
