From: Mahmood Naderan <nt_mahmood@yahoo.com>
Date: Wed, 01 Sep 2010 06:38:46 +0000
Subject: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <929339.59525.qm@web50002.mail.re2.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7924992677915671728=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============7924992677915671728==
Content-Type: multipart/alternative; boundary="0-484768883-1283323126=:59525"

--0-484768883-1283323126=:59525
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all,=0AI ran sensors-detect to detect Core-i7 temperatures but it does=
n't show them. =0AHere is the output of sensors-detect:=0A=0Amahmood@localh=
ost:~$ sudo sensors-detect=0A# sensors-detect revision 5818 (2010-01-18 17:=
22:07 +0100)=0A# System: Gigabyte Technology Co., Ltd. P55-USB3=0AThis prog=
ram will help you determine which kernel modules you need=0Ato load to use =
lm_sensors most effectively. It is generally safe=0Aand recommended to acce=
pt the default answers to all questions,=0Aunless you know what you're doin=
g.=0ASome south bridges, CPUs or memory controllers contain embedded sensor=
s.=0ADo you want to scan for them? This is totally safe. (YES/no): y=0ASili=
con Integrated Systems SIS5595...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No=0AVIA VT82C686 Integrated Sensors...=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AVIA=
 VT8231 Integrated Sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AAMD K8 thermal sensors...=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 No=0AAMD Family 10h thermal sensors...=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AAMD Fa=
mily 11h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AIntel Core family thermal sensor...=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0A=
Intel Atom thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AIntel AMB FB-DIMM the=
rmal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 No=0AVIA C7 thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=
=0AVIA Nano thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0ASome Super I/O =
chips contain embedded sensors. We have to write to=0Astandard I/O ports to=
 probe them. This is usually safe.=0ADo you want to scan for Super I/O sens=
ors? (YES/no): y=0AProbing for Super-I/O at 0x2e/0x2f=0ATrying family `Nati=
onal Semiconductor'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 No=0ATrying family `SMSC'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0ATry=
ing family `VIA/Winbond/Nuvoton/Fintek'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 No=0ATrying family `ITE'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Yes=0AFound `ITE IT8720F Super IO Sensors'=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Success!=0A=A0=A0=A0 (address 0x290=
, driver `it87')=0AProbing for Super-I/O at 0x4e/0x4f=0ATrying family `Nati=
onal Semiconductor'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 No=0ATrying family `SMSC'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0ATry=
ing family `VIA/Winbond/Nuvoton/Fintek'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 No=0ATrying family `ITE'...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 No=0ASome systems (mainly servers) implement IPMI, a set of common interfa=
ces=0Athrough which system health data may be retrieved, amongst other thin=
gs.=0AWe first try to get the information from SMBIOS. If we don't find it=
=0Athere, we have to read from arbitrary I/O ports to probe for such=0Ainte=
rfaces. This is normally safe. Do you want to scan for IPMI=0Ainterfaces? (=
YES/no): y=0AProbing for `IPMI BMC KCS' at 0xca0...=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0AProbing for `IPMI BMC SMIC' at=
 0xca8...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0A=
Some hardware monitoring chips are accessible through the ISA I/O ports.=0A=
We have to write to arbitrary I/O ports to probe them. This is usually=0Asa=
fe though. Yes, you do have ISA I/O ports even if you do not have any=0AISA=
 slots! Do you want to scan the ISA I/O ports? (yes/NO): y=0AProbing for `N=
ational Semiconductor LM78' at 0x290...=A0=A0=A0=A0=A0=A0 No=0AProbing for =
`National Semiconductor LM79' at 0x290...=A0=A0=A0=A0=A0=A0 No=0AProbing fo=
r `Winbond W83781D' at 0x290...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 No=0AProbing for `Winbond W83782D' at 0x290...=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No=0ALastly, we can probe the I2C/S=
MBus adapters for connected hardware=0Amonitoring devices. This is the most=
 risky part, and while it works=0Areasonably well on most systems, it has b=
een reported to cause trouble=0Aon some systems.=0ADo you want to probe the=
 I2C/SMBus adapters now? (YES/no): y=0AFound unknown SMBus adapter 8086:3b3=
0 at 0000:00:1f.3.=0ASorry, no supported PCI bus adapters found.=0AModule i=
2c-dev loaded successfully.=0ANow follows a summary of the probes I have ju=
st done.=0AJust press ENTER to continue:=0ADriver `it87':=0A=A0 * ISA bus, =
address 0x290=0A=A0=A0=A0 Chip `ITE IT8720F Super IO Sensors' (confidence: =
9)=0ATo load everything that is needed, add this to /etc/modules:=0A#----cu=
t here----=0A# Chip drivers=0Ait87=0A#----cut here----=0AIf you have some d=
rivers built into your kernel, the list above will=0Acontain too many modul=
es. Skip the appropriate ones!=0ADo you want to add these lines automatical=
ly to /etc/modules? (yes/NO)yes=0ASuccessful!=0AMonitoring programs won't w=
ork until the needed modules are=0Aloaded. You may want to run '/etc/init.d=
/module-init-tools start'=0Ato load them.=0AUnloading i2c-dev... OK=0A=0ATh=
en I ran sensors:=0A=0Amahmood@localhost:~$sudo sensors=0Ait8720-isa-0290=
=0AAdapter: ISA adapter=0Ain0:=A0=A0=A0=A0=A0=A0=A0=A0 +0.86 V=A0 (min =3D=
=A0 +0.00 V, max =3D=A0 +4.08 V)=0Ain1:=A0=A0=A0=A0=A0=A0=A0=A0 +1.58 V=A0 =
(min =3D=A0 +0.00 V, max =3D=A0 +4.08 V)=0Ain2:=A0=A0=A0=A0=A0=A0=A0=A0 +3.=
39 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +4.08 V)=0Ain3:=A0=A0=A0=A0=A0=A0=
=A0=A0 +3.02 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +4.08 V)=0Ain4:=A0=A0=A0=
=A0=A0=A0=A0=A0 +0.05 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +4.08 V)=A0=A0 A=
LARM=0Ain5:=A0=A0=A0=A0=A0=A0=A0=A0 +3.12 V=A0 (min =3D=A0 +0.00 V, max =3D=
=A0 +4.08 V)=0Ain6:=A0=A0=A0=A0=A0=A0=A0=A0 +0.02 V=A0 (min =3D=A0 +0.00 V,=
 max =3D=A0 +4.08 V)=A0=A0 ALARM=0Ain7:=A0=A0=A0=A0=A0=A0=A0=A0 +2.16 V=A0 =
(min =3D=A0 +0.00 V, max =3D=A0 +4.08 V)=0AVbat:=A0=A0=A0=A0=A0=A0=A0 +3.10=
 V=0Afan1:=A0=A0=A0=A0=A0=A0 1679 RPM=A0 (min =3D=A0=A0 10 RPM)=0Afan2:=A0=
=A0=A0=A0=A0=A0=A0 644 RPM=A0 (min =3D=A0=A0=A0 0 RPM)=0Afan3:=A0=A0=A0=A0=
=A0=A0 1278 RPM=A0 (min =3D=A0=A0 10 RPM)=0Afan4:=A0=A0=A0=A0=A0=A0 1205 RP=
M=A0 (min =3D=A0=A0=A0 0 RPM)=0Atemp1:=A0=A0=A0=A0=A0=A0 +36.0=C2=B0C=A0 (l=
ow=A0 =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C)=A0 sensor =3D thermistor=
=0Atemp2:=A0=A0=A0=A0=A0=A0 +25.0=C2=B0C=A0 (low=A0 =3D +127.0=C2=B0C, high=
 =3D +127.0=C2=B0C)=A0 sensor =3D thermistor=0Atemp3:=A0=A0=A0=A0=A0=A0 +33=
.0=C2=B0C=A0 (low=A0 =3D +127.0=C2=B0C, high =3D +90.0=C2=B0C)=A0 sensor =
=3D thermistor=0Acpu0_vid:=A0=A0 +0.313 V=0A=0AWhat can I do then? currentl=
y I have kubuntu 10.04=0A=A0=0A// Naderan *Mahmood;=0A=0A=0A      
--0-484768883-1283323126=:59525
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:tahoma, new york, times, serif;font-size=
:12pt;color:#000000;"><P>Dear all,</P>=0A<P>I ran sensors-detect to detect =
Core-i7 temperatures but it doesn't show them. Here is the output of sensor=
s-detect:</P>=0A<P><BR><FONT size=3D2 face=3D"Courier New, courier, monaco,=
 monospace, sans-serif">mahmood@localhost:~$ sudo sensors-detect<BR># senso=
rs-detect revision 5818 (2010-01-18 17:22:07 +0100)<BR># System: Gigabyte T=
echnology Co., Ltd. P55-USB3</FONT></P>=0A<P><FONT size=3D2 face=3D"Courier=
 New, courier, monaco, monospace, sans-serif">This program will help you de=
termine which kernel modules you need<BR>to load to use lm_sensors most eff=
ectively. It is generally safe<BR>and recommended to accept the default ans=
wers to all questions,<BR>unless you know what you're doing.</FONT></P>=0A<=
P><FONT size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-seri=
f">Some south bridges, CPUs or memory controllers contain embedded sensors.=
<BR>Do you want to scan for them? This is totally safe. (YES/no): y<BR>Sili=
con Integrated Systems SIS5595...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; No<BR>VIA VT82C686 Integrated Sensors...&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>VIA VT8231 I=
ntegrated Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>AMD K8 thermal
 sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>AMD=
 Family 10h thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>AMD Family 11h thermal sensors..=
.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; No<BR>Intel Core family thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Intel Atom thermal
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
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No</FONT></P>=0A<P><FONT size=3D2 face=3D"Cou=
rier New, courier, monaco, monospace, sans-serif">Some Super I/O chips cont=
ain embedded sensors. We have to write to<BR>standard I/O ports to probe th=
em. This is usually safe.<BR>Do you want to scan for Super I/O sensors? (YE=
S/no): y<BR>Probing for Super-I/O at 0x2e/0x2f<BR>Trying family `National S=
emiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Trying family `SMSC=
'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<B=
R>Trying family `VIA/Winbond/Nuvoton/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Trying famil=
y
 `ITE'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; Yes<BR>Found `ITE IT8720F Super IO Sensors'&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!<BR>&nbsp;&nbsp;&nbsp; (addr=
ess 0x290, driver `it87')<BR>Probing for Super-I/O at 0x4e/0x4f<BR>Trying f=
amily `National Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Tr=
ying family `SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; No<BR>Trying family
 `VIA/Winbond/Nuvoton/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Trying family `ITE'...&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No</FON=
T></P>=0A<P><FONT size=3D2 face=3D"Courier New, courier, monaco, monospace,=
 sans-serif">Some systems (mainly servers) implement IPMI, a set of common =
interfaces<BR>through which system health data may be retrieved, amongst ot=
her things.<BR>We first try to get the information from SMBIOS. If we don't=
 find it<BR>there, we have to read from arbitrary I/O ports to probe for su=
ch<BR>interfaces. This is normally safe. Do you want to scan for IPMI<BR>in=
terfaces? (YES/no): y<BR>Probing for `IPMI BMC KCS' at 0xca0...&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `IPMI BMC SMIC' a=
t 0xca8...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No</FONT></P>=0A<P>=
<FONT size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif"=
>Some hardware monitoring chips are accessible through the ISA I/O ports.<B=
R>We have to write to arbitrary I/O ports to probe them. This is usually<BR=
>safe though. Yes, you do have ISA I/O ports even if you do not have any<BR=
>ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): y<BR>Probing f=
or `National Semiconductor LM78' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; No<BR>Probing for `National Semiconductor LM79' at 0x290...&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Winbond W83781D' at 0x290...&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>Probing for `Winbond W83782D' at 0x2=
90...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No</FONT></P>=0A<P><FONT size=3D2 fa=
ce=3D"Courier New, courier, monaco, monospace, sans-serif">Lastly, we can p=
robe the I2C/SMBus adapters for connected hardware<BR>monitoring devices. T=
his is the most risky part, and while it works<BR>reasonably well on most s=
ystems, it has been reported to cause trouble<BR>on some systems.<BR>Do you=
 want to probe the I2C/SMBus adapters now? (YES/no): y<BR>Found unknown SMB=
us adapter 8086:3b30 at 0000:00:1f.3.<BR>Sorry, no supported PCI bus adapte=
rs found.<BR>Module i2c-dev loaded successfully.</FONT></P>=0A<P><FONT size=
=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif">Now follo=
ws a summary of the probes I have just done.<BR>Just press ENTER to continu=
e:</FONT></P>=0A<P><FONT size=3D2 face=3D"Courier New, courier, monaco, mon=
ospace, sans-serif">Driver `it87':<BR>&nbsp; * ISA bus, address 0x290<BR>&n=
bsp;&nbsp;&nbsp; Chip `ITE IT8720F Super IO Sensors' (confidence: 9)</FONT>=
</P>=0A<P><FONT size=3D2 face=3D"Courier New, courier, monaco, monospace, s=
ans-serif">To load everything that is needed, add this to /etc/modules:<BR>=
#----cut here----<BR># Chip drivers<BR>it87<BR>#----cut here----<BR>If you =
have some drivers built into your kernel, the list above will<BR>contain to=
o many modules. Skip the appropriate ones!</FONT></P>=0A<P><FONT size=3D2 f=
ace=3D"Courier New, courier, monaco, monospace, sans-serif">Do you want to =
add these lines automatically to /etc/modules? (yes/NO)yes<BR>Successful!</=
FONT></P>=0A<P><FONT size=3D2 face=3D"Courier New, courier, monaco, monospa=
ce, sans-serif">Monitoring programs won't work until the needed modules are=
<BR>loaded. You may want to run '/etc/init.d/module-init-tools start'<BR>to=
 load them.</FONT></P>=0A<P><FONT size=3D2 face=3D"Courier New, courier, mo=
naco, monospace, sans-serif">Unloading i2c-dev... OK</FONT></P>=0A<P><BR>Th=
en I ran sensors:<BR><FONT size=3D2 face=3D"Courier New, courier, monaco, m=
onospace, sans-serif"></FONT></P>=0A<P><FONT size=3D2 face=3D"Courier New, =
courier, monaco, monospace, sans-serif">mahmood@localhost:~$</FONT><FONT si=
ze=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif"> sudo s=
ensors<BR>it8720-isa-0290<BR>Adapter: ISA adapter<BR>in0:&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.86 V&nbsp; (min =3D&nbsp; +0.00 V, max =
=3D&nbsp; +4.08 V)<BR>in1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
+1.58 V&nbsp; (min =3D&nbsp; +0.00 V, max =3D&nbsp; +4.08 V)<BR>in2:&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.39 V&nbsp; (min =3D&nbsp; +0.0=
0 V, max =3D&nbsp; +4.08 V)<BR>in3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; +3.02 V&nbsp; (min =3D&nbsp; +0.00 V, max =3D&nbsp; +4.08 V)<BR>in=
4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.05 V&nbsp; (min =3D&n=
bsp; +0.00 V, max =3D&nbsp; +4.08 V)&nbsp;&nbsp; ALARM<BR>in5:&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.12 V&nbsp; (min =3D&nbsp; +0.00 V, m=
ax =3D&nbsp; +4.08
 V)<BR>in6:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.02 V&nbsp; (=
min =3D&nbsp; +0.00 V, max =3D&nbsp; +4.08 V)&nbsp;&nbsp; ALARM<BR>in7:&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +2.16 V&nbsp; (min =3D&nbsp; +=
0.00 V, max =3D&nbsp; +4.08 V)<BR>Vbat:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; +3.10 V<BR>fan1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1679 RPM&nbsp; =
(min =3D&nbsp;&nbsp; 10 RPM)<BR>fan2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 644 RPM&nbsp; (min =3D&nbsp;&nbsp;&nbsp; 0 RPM)<BR>fan3:&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 1278 RPM&nbsp; (min =3D&nbsp;&nbsp; 10 RPM)<BR>fan4:=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1205 RPM&nbsp; (min =3D&nbsp;&nbsp;&nb=
sp; 0 RPM)<BR>temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +36.0=C2=B0C&nbsp;=
 (low&nbsp; =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C)&nbsp; sensor =3D the=
rmistor<BR>temp2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +25.0=C2=B0C&nbsp; (l=
ow&nbsp; =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C)&nbsp; sensor =3D
 thermistor<BR>temp3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +33.0=C2=B0C&nbsp=
; (low&nbsp; =3D +127.0=C2=B0C, high =3D +90.0=C2=B0C)&nbsp; sensor =3D the=
rmistor<BR>cpu0_vid:&nbsp;&nbsp; +0.313 V</FONT></P>=0A<P><BR>What can I do=
 then? currently I have kubuntu 10.04</P>=0A<P>&nbsp;</P>=0A<DIV>=0A<DIV><F=
ONT style=3D"BACKGROUND-COLOR: #ffffff" color=3D#0080ff size=3D2 face=3D"ar=
ial, helvetica, sans-serif"><STRONG>// Naderan *Mahmood;</STRONG></FONT></D=
IV></DIV></div><br>=0A=0A=0A=0A=0A=0A=0A=0A      </body></html>
--0-484768883-1283323126=:59525--


--===============7924992677915671728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7924992677915671728==--
