From: Mahmood Naderan <nt_mahmood@yahoo.com>
Date: Wed, 01 Sep 2010 07:30:00 +0000
Subject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <839121.11578.qm@web50006.mail.re2.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5905773394260373541=="
List-Id: <lm-sensors.vger.kernel.org>
References: <929339.59525.qm@web50002.mail.re2.yahoo.com>
In-Reply-To: <929339.59525.qm@web50002.mail.re2.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============5905773394260373541==
Content-Type: multipart/alternative; boundary="0-1350264016-1283326200=:11578"

--0-1350264016-1283326200=:11578
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Here is what I did:=0Amahmood@localhost:~$ svn checkout http://lm-sensors.o=
rg/svn/lm-sensors/trunk =0Alm-sensors=0A...=0AChecked out revision 5857.=0A=
=A0=0Amahmood@localhost:~$ svn update http://lm-sensors.org/svn/lm-sensors/=
trunk =0Alm-sensors=0ASkipped 'http://lm-sensors.org/svn/lm-sensors/trunk'=
=0AAt revision 5857.=0ASummary of conflicts:=0A=A0 Skipped paths: 1=0A=0AIs=
 that what you meant?=0A// Naderan *Mahmood;=0A=0A=0A=0A=0A________________=
________________=0AFrom: Nikola Pajkovsky <npajkovs@redhat.com>=0ATo: lm-se=
nsors@lm-sensors.org=0ASent: Wed, September 1, 2010 11:49:03 AM=0ASubject: =
Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors=0A=0AOn 09/01/201=
0 08:38 AM, Mahmood Naderan wrote:=0A> Dear all,=0A>=0A> I ran sensors-dete=
ct to detect Core-i7 temperatures but it doesn't show them. =0A>Here is the=
 output of sensors-detect:=0A>=0A>=0A> mahmood@localhost:~$ sudo sensors-de=
tect=0A> # sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)=0A> # S=
ystem: Gigabyte Technology Co., Ltd. P55-USB3=0A>=0A> This program will hel=
p you determine which kernel modules you need=0A> to load to use lm_sensors=
 most effectively. It is generally safe=0A> and recommended to accept the d=
efault answers to all questions,=0A> unless you know what you're doing.=0A>=
=0A> Some south bridges, CPUs or memory controllers contain embedded sensor=
s.=0A> Do you want to scan for them? This is totally safe. (YES/no): y=0A> =
Silicon Integrated Systems SIS5595... No=0A> VIA VT82C686 Integrated Sensor=
s... No=0A> VIA VT8231 Integrated Sensors... No=0A> AMD K8 thermal sensors.=
.. No=0A> AMD Family 10h thermal sensors... No=0A> AMD Family 11h thermal s=
ensors... No=0A> Intel Core family thermal sensor... No=0A> Intel Atom ther=
mal sensor... No=0A> Intel AMB FB-DIMM thermal sensor... No=0A> VIA C7 ther=
mal sensor... No=0A> VIA Nano thermal sensor... No=0A>=0A> Some Super I/O c=
hips contain embedded sensors. We have to write to=0A> standard I/O ports t=
o probe them. This is usually safe.=0A> Do you want to scan for Super I/O s=
ensors? (YES/no): y=0A> Probing for Super-I/O at 0x2e/0x2f=0A> Trying famil=
y `National Semiconductor'... No=0A> Trying family `SMSC'... No=0A> Trying =
family `VIA/Winbond/Nuvoton/Fintek'... No=0A> Trying family `ITE'... Yes=0A=
> Found `ITE IT8720F Super IO Sensors' Success!=0A> (address 0x290, driver =
`it87')=0A> Probing for Super-I/O at 0x4e/0x4f=0A> Trying family `National =
Semiconductor'... No=0A> Trying family `SMSC'... No=0A> Trying family `VIA/=
Winbond/Nuvoton/Fintek'... No=0A> Trying family `ITE'... No=0A>=0A> Some sy=
stems (mainly servers) implement IPMI, a set of common interfaces=0A> throu=
gh which system health data may be retrieved, amongst other things.=0A> We =
first try to get the information from SMBIOS. If we don't find it=0A> there=
, we have to read from arbitrary I/O ports to probe for such=0A> interfaces=
. This is normally safe. Do you want to scan for IPMI=0A> interfaces? (YES/=
no): y=0A> Probing for `IPMI BMC KCS' at 0xca0... No=0A> Probing for `IPMI =
BMC SMIC' at 0xca8... No=0A>=0A> Some hardware monitoring chips are accessi=
ble through the ISA I/O ports.=0A> We have to write to arbitrary I/O ports =
to probe them. This is usually=0A> safe though. Yes, you do have ISA I/O po=
rts even if you do not have any=0A> ISA slots! Do you want to scan the ISA =
I/O ports? (yes/NO): y=0A> Probing for `National Semiconductor LM78' at 0x2=
90... No=0A> Probing for `National Semiconductor LM79' at 0x290... No=0A> P=
robing for `Winbond W83781D' at 0x290... No=0A> Probing for `Winbond W83782=
D' at 0x290... No=0A>=0A> Lastly, we can probe the I2C/SMBus adapters for c=
onnected hardware=0A> monitoring devices. This is the most risky part, and =
while it works=0A> reasonably well on most systems, it has been reported to=
 cause trouble=0A> on some systems.=0A> Do you want to probe the I2C/SMBus =
adapters now? (YES/no): y=0A> Found unknown SMBus adapter 8086:3b30 at 0000=
:00:1f.3.=0A> Sorry, no supported PCI bus adapters found.=0A> Module i2c-de=
v loaded successfully.=0A>=0A> Now follows a summary of the probes I have j=
ust done.=0A> Just press ENTER to continue:=0A>=0A> Driver `it87':=0A> * IS=
A bus, address 0x290=0A> Chip `ITE IT8720F Super IO Sensors' (confidence: 9=
)=0A>=0A> To load everything that is needed, add this to /etc/modules:=0A> =
#----cut here----=0A> # Chip drivers=0A> it87=0A> #----cut here----=0A> If =
you have some drivers built into your kernel, the list above will=0A> conta=
in too many modules. Skip the appropriate ones!=0A>=0A> Do you want to add =
these lines automatically to /etc/modules? (yes/NO)yes=0A> Successful!=0A>=
=0A> Monitoring programs won't work until the needed modules are=0A> loaded=
. You may want to run '/etc/init.d/module-init-tools start'=0A> to load the=
m.=0A>=0A> Unloading i2c-dev... OK=0A>=0A>=0A> Then I ran sensors:=0A>=0A> =
mahmood@localhost:~$ sudo sensors=0A> it8720-isa-0290=0A> Adapter: ISA adap=
ter=0A> in0: +0.86 V (min =3D +0.00 V, max =3D +4.08 V)=0A> in1: +1.58 V (m=
in =3D +0.00 V, max =3D +4.08 V)=0A> in2: +3.39 V (min =3D +0.00 V, max =3D=
 +4.08 V)=0A> in3: +3.02 V (min =3D +0.00 V, max =3D +4.08 V)=0A> in4: +0.0=
5 V (min =3D +0.00 V, max =3D +4.08 V) ALARM=0A> in5: +3.12 V (min =3D +0.0=
0 V, max =3D +4.08 V)=0A> in6: +0.02 V (min =3D +0.00 V, max =3D +4.08 V) A=
LARM=0A> in7: +2.16 V (min =3D +0.00 V, max =3D +4.08 V)=0A> Vbat: +3.10 V=
=0A> fan1: 1679 RPM (min =3D 10 RPM)=0A> fan2: 644 RPM (min =3D 0 RPM)=0A> =
fan3: 1278 RPM (min =3D 10 RPM)=0A> fan4: 1205 RPM (min =3D 0 RPM)=0A> temp=
1: +36.0=C2=B0C (low =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C) sensor =3D =
thermistor=0A> temp2: +25.0=C2=B0C (low =3D +127.0=C2=B0C, high =3D +127.0=
=C2=B0C) sensor =3D thermistor=0A> temp3: +33.0=C2=B0C (low =3D +127.0=C2=
=B0C, high =3D +90.0=C2=B0C) sensor =3D thermistor=0A> cpu0_vid: +0.313 V=
=0A>=0A>=0A> What can I do then? currently I have kubuntu 10.04=0A>=0A> *//=
 Naderan *Mahmood;*=0A>=0A>=0A=0APick sensors-detect from svn or file bug a=
gainst lm-sensors in ubuntu and =0Amaintainer(if he is nice) update lm-sens=
ors.=0A=0A_______________________________________________=0Alm-sensors mail=
ing list=0Alm-sensors@lm-sensors.org=0Ahttp://lists.lm-sensors.org/mailman/=
listinfo/lm-sensors=0A=0A=0A=0A      
--0-1350264016-1283326200=:11578
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:Courier New, courier, monaco, monospace,=
 sans-serif;font-size:10pt"><DIV></DIV>=0A<DIV><FONT size=3D3 face=3D"tahom=
a, new york, times, serif">Here is what I did:</FONT></DIV>=0A<DIV><A href=
=3D"mailto:mahmood@localhost:~$">mahmood@localhost:~$</A> svn checkout <A h=
ref=3D"http://lm-sensors.org/svn/lm-sensors/trunk">http://lm-sensors.org/sv=
n/lm-sensors/trunk</A> lm-sensors</DIV>=0A<DIV>...<BR>Checked out revision =
5857.<BR>&nbsp;</DIV>=0A<DIV><A href=3D"mailto:mahmood@blackfish:~$">mahmoo=
d@localhost:~$</A> svn update <A href=3D"http://lm-sensors.org/svn/lm-senso=
rs/trunk">http://lm-sensors.org/svn/lm-sensors/trunk</A> lm-sensors<BR>Skip=
ped 'http://lm-sensors.org/svn/lm-sensors/trunk'<BR>At revision 5857.<BR>Su=
mmary of conflicts:<BR>&nbsp; Skipped paths: 1<BR></DIV>=0A<DIV><FONT size=
=3D3 face=3D"tahoma, new york, times, serif">Is that what you meant?</FONT>=
</DIV>=0A<DIV>=0A<DIV><FONT style=3D"BACKGROUND-COLOR: #ffffff" color=3D#00=
80ff size=3D2 face=3D"arial, helvetica, sans-serif"><STRONG>// Naderan *Mah=
mood;</STRONG></FONT></DIV></DIV>=0A<DIV><BR></DIV>=0A<DIV style=3D"FONT-FA=
MILY: Courier New, courier, monaco, monospace, sans-serif; FONT-SIZE: 10pt"=
><BR>=0A<DIV style=3D"FONT-FAMILY: tahoma, new york, times, serif; FONT-SIZ=
E: 12pt"><FONT size=3D2 face=3DTahoma>=0A<HR SIZE=3D1>=0A<B><SPAN style=3D"=
FONT-WEIGHT: bold">From:</SPAN></B> Nikola Pajkovsky &lt;npajkovs@redhat.co=
m&gt;<BR><B><SPAN style=3D"FONT-WEIGHT: bold">To:</SPAN></B> lm-sensors@lm-=
sensors.org<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Sent:</SPAN></B> Wed, S=
eptember 1, 2010 11:49:03 AM<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Subjec=
t:</SPAN></B> Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors<BR>=
</FONT><BR>On 09/01/2010 08:38 AM, Mahmood Naderan wrote:<BR>&gt; Dear all,=
<BR>&gt;<BR>&gt; I ran sensors-detect to detect Core-i7 temperatures but it=
 doesn't show them. Here is the output of sensors-detect:<BR>&gt;<BR>&gt;<B=
R>&gt; mahmood@localhost:~$ sudo sensors-detect<BR>&gt; # sensors-detect re=
vision 5818 (2010-01-18 17:22:07 +0100)<BR>&gt; # System: Gigabyte Technolo=
gy Co., Ltd. P55-USB3<BR>&gt;<BR>&gt; This program will help you determine =
which kernel modules you need<BR>&gt; to load to use lm_sensors most effect=
ively. It is generally safe<BR>&gt; and recommended to
 accept the default answers to all questions,<BR>&gt; unless you know what =
you're doing.<BR>&gt;<BR>&gt; Some south bridges, CPUs or memory controller=
s contain embedded sensors.<BR>&gt; Do you want to scan for them? This is t=
otally safe. (YES/no): y<BR>&gt; Silicon Integrated Systems SIS5595... No<B=
R>&gt; VIA VT82C686 Integrated Sensors... No<BR>&gt; VIA VT8231 Integrated =
Sensors... No<BR>&gt; AMD K8 thermal sensors... No<BR>&gt; AMD Family 10h t=
hermal sensors... No<BR>&gt; AMD Family 11h thermal sensors... No<BR>&gt; I=
ntel Core family thermal sensor... No<BR>&gt; Intel Atom thermal sensor... =
No<BR>&gt; Intel AMB FB-DIMM thermal sensor... No<BR>&gt; VIA C7 thermal se=
nsor... No<BR>&gt; VIA Nano thermal sensor... No<BR>&gt;<BR>&gt; Some Super=
 I/O chips contain embedded sensors. We have to write to<BR>&gt; standard I=
/O ports to probe them. This is usually safe.<BR>&gt; Do you want to scan f=
or Super I/O sensors? (YES/no): y<BR>&gt; Probing for Super-I/O at
 0x2e/0x2f<BR>&gt; Trying family `National Semiconductor'... No<BR>&gt; Try=
ing family `SMSC'... No<BR>&gt; Trying family `VIA/Winbond/Nuvoton/Fintek'.=
.. No<BR>&gt; Trying family `ITE'... Yes<BR>&gt; Found `ITE IT8720F Super I=
O Sensors' Success!<BR>&gt; (address 0x290, driver `it87')<BR>&gt; Probing =
for Super-I/O at 0x4e/0x4f<BR>&gt; Trying family `National Semiconductor'..=
. No<BR>&gt; Trying family `SMSC'... No<BR>&gt; Trying family `VIA/Winbond/=
Nuvoton/Fintek'... No<BR>&gt; Trying family `ITE'... No<BR>&gt;<BR>&gt; Som=
e systems (mainly servers) implement IPMI, a set of common interfaces<BR>&g=
t; through which system health data may be retrieved, amongst other things.=
<BR>&gt; We first try to get the information from SMBIOS. If we don't find =
it<BR>&gt; there, we have to read from arbitrary I/O ports to probe for suc=
h<BR>&gt; interfaces. This is normally safe. Do you want to scan for IPMI<B=
R>&gt; interfaces? (YES/no): y<BR>&gt; Probing for `IPMI BMC KCS' at
 0xca0... No<BR>&gt; Probing for `IPMI BMC SMIC' at 0xca8... No<BR>&gt;<BR>=
&gt; Some hardware monitoring chips are accessible through the ISA I/O port=
s.<BR>&gt; We have to write to arbitrary I/O ports to probe them. This is u=
sually<BR>&gt; safe though. Yes, you do have ISA I/O ports even if you do n=
ot have any<BR>&gt; ISA slots! Do you want to scan the ISA I/O ports? (yes/=
NO): y<BR>&gt; Probing for `National Semiconductor LM78' at 0x290... No<BR>=
&gt; Probing for `National Semiconductor LM79' at 0x290... No<BR>&gt; Probi=
ng for `Winbond W83781D' at 0x290... No<BR>&gt; Probing for `Winbond W83782=
D' at 0x290... No<BR>&gt;<BR>&gt; Lastly, we can probe the I2C/SMBus adapte=
rs for connected hardware<BR>&gt; monitoring devices. This is the most risk=
y part, and while it works<BR>&gt; reasonably well on most systems, it has =
been reported to cause trouble<BR>&gt; on some systems.<BR>&gt; Do you want=
 to probe the I2C/SMBus adapters now? (YES/no): y<BR>&gt; Found
 unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.<BR>&gt; Sorry, no support=
ed PCI bus adapters found.<BR>&gt; Module i2c-dev loaded successfully.<BR>&=
gt;<BR>&gt; Now follows a summary of the probes I have just done.<BR>&gt; J=
ust press ENTER to continue:<BR>&gt;<BR>&gt; Driver `it87':<BR>&gt; * ISA b=
us, address 0x290<BR>&gt; Chip `ITE IT8720F Super IO Sensors' (confidence: =
9)<BR>&gt;<BR>&gt; To load everything that is needed, add this to /etc/modu=
les:<BR>&gt; #----cut here----<BR>&gt; # Chip drivers<BR>&gt; it87<BR>&gt; =
#----cut here----<BR>&gt; If you have some drivers built into your kernel, =
the list above will<BR>&gt; contain too many modules. Skip the appropriate =
ones!<BR>&gt;<BR>&gt; Do you want to add these lines automatically to /etc/=
modules? (yes/NO)yes<BR>&gt; Successful!<BR>&gt;<BR>&gt; Monitoring program=
s won't work until the needed modules are<BR>&gt; loaded. You may want to r=
un '/etc/init.d/module-init-tools start'<BR>&gt; to load
 them.<BR>&gt;<BR>&gt; Unloading i2c-dev... OK<BR>&gt;<BR>&gt;<BR>&gt; Then=
 I ran sensors:<BR>&gt;<BR>&gt; mahmood@localhost:~$ sudo sensors<BR>&gt; i=
t8720-isa-0290<BR>&gt; Adapter: ISA adapter<BR>&gt; in0: +0.86 V (min =3D +=
0.00 V, max =3D +4.08 V)<BR>&gt; in1: +1.58 V (min =3D +0.00 V, max =3D +4.=
08 V)<BR>&gt; in2: +3.39 V (min =3D +0.00 V, max =3D +4.08 V)<BR>&gt; in3: =
+3.02 V (min =3D +0.00 V, max =3D +4.08 V)<BR>&gt; in4: +0.05 V (min =3D +0=
.00 V, max =3D +4.08 V) ALARM<BR>&gt; in5: +3.12 V (min =3D +0.00 V, max =
=3D +4.08 V)<BR>&gt; in6: +0.02 V (min =3D +0.00 V, max =3D +4.08 V) ALARM<=
BR>&gt; in7: +2.16 V (min =3D +0.00 V, max =3D +4.08 V)<BR>&gt; Vbat: +3.10=
 V<BR>&gt; fan1: 1679 RPM (min =3D 10 RPM)<BR>&gt; fan2: 644 RPM (min =3D 0=
 RPM)<BR>&gt; fan3: 1278 RPM (min =3D 10 RPM)<BR>&gt; fan4: 1205 RPM (min =
=3D 0 RPM)<BR>&gt; temp1: +36.0=C2=B0C (low =3D +127.0=C2=B0C, high =3D +12=
7.0=C2=B0C) sensor =3D thermistor<BR>&gt; temp2: +25.0=C2=B0C (low =3D +127=
.0=C2=B0C, high =3D +127.0=C2=B0C) sensor =3D
 thermistor<BR>&gt; temp3: +33.0=C2=B0C (low =3D +127.0=C2=B0C, high =3D +9=
0.0=C2=B0C) sensor =3D thermistor<BR>&gt; cpu0_vid: +0.313 V<BR>&gt;<BR>&gt=
;<BR>&gt; What can I do then? currently I have kubuntu 10.04<BR>&gt;<BR>&gt=
; *// Naderan *Mahmood;*<BR>&gt;<BR>&gt;<BR><BR>Pick sensors-detect from sv=
n or file bug against lm-sensors in ubuntu and maintainer(if he is nice) up=
date lm-sensors.<BR><BR>_______________________________________________<BR>=
lm-sensors mailing list<BR><A href=3D"mailto:lm-sensors@lm-sensors.org" yma=
ilto=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</A><BR>=
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors<BR></DIV></DIV></di=
v><br>=0A=0A=0A=0A=0A=0A=0A=0A      </body></html>
--0-1350264016-1283326200=:11578--


--===============5905773394260373541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5905773394260373541==--
