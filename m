From: Mahmood Naderan <nt_mahmood@yahoo.com>
Date: Wed, 01 Sep 2010 08:03:17 +0000
Subject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <811317.75109.qm@web50003.mail.re2.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1018791250499553743=="
List-Id: <lm-sensors.vger.kernel.org>
References: <929339.59525.qm@web50002.mail.re2.yahoo.com>
In-Reply-To: <929339.59525.qm@web50002.mail.re2.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============1018791250499553743==
Content-Type: multipart/alternative; boundary="0-507225290-1283328197=:75109"

--0-507225290-1283328197=:75109
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

>sudo ./sensors-detect=0AYes=0AIntel Core family thermal sensor...=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Success!=0A=
=A0=A0=A0 (driver `coretemp')=0A...=0ANow follows a summary of the probes I=
 have just done.=0AJust press ENTER to continue:=0ADriver `it87':=0A=A0 * I=
SA bus, address 0x290=0A=A0=A0=A0 Chip `ITE IT8720F Super IO Sensors' (conf=
idence: 9)=0ADriver `coretemp':=0A=A0 * Chip `Intel Core family thermal sen=
sor' (confidence: 9)=0ADo you want to generate /etc/sysconfig/lm_sensors? (=
yes/NO): y=0ACopy prog/init/lm_sensors.init to /etc/init.d/lm_sensors=0Afor=
 initialization at boot time.=0AYou should now start the lm_sensors service=
 to load the required=0Akernel modules.=0A=0AI then copy that file and rest=
art=0Amahmood@localhost:~$ls /etc/init.d/lm*=0A/etc/init.d/lm-sensors=0A=0A=
However this is what I see again=0Amahmood@localhost:~$sudo sensors=0Ait872=
0-isa-0290=0AAdapter: ISA adapter=0Ain0:=A0=A0=A0=A0=A0=A0=A0=A0 +0.86 V=A0=
 (min =3D=A0 +0.00 V, max =3D=A0 +4.08 V)=0Ain1:=A0=A0=A0=A0=A0=A0=A0=A0 +1=
.58 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +4.08 V)=0Ain2:=A0=A0=A0=A0=A0=A0=
=A0=A0 +3.39 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +4.08 V)=0Ain3:=A0=A0=A0=
=A0=A0=A0=A0=A0 +3.02 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +4.08 V)=0Ain4:=
=A0=A0=A0=A0=A0=A0=A0=A0 +0.05 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +4.08 V=
)=A0=A0 ALARM=0Ain5:=A0=A0=A0=A0=A0=A0=A0=A0 +3.12 V=A0 (min =3D=A0 +0.00 V=
, max =3D=A0 +4.08 V)=0Ain6:=A0=A0=A0=A0=A0=A0=A0=A0 +0.02 V=A0 (min =3D=A0=
 +0.00 V, max =3D=A0 +4.08 V)=A0=A0 ALARM=0Ain7:=A0=A0=A0=A0=A0=A0=A0=A0 +2=
.16 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +4.08 V)=0AVbat:=A0=A0=A0=A0=A0=A0=
=A0 +3.10 V=0Afan1:=A0=A0=A0=A0=A0=A0 1638 RPM=A0 (min =3D=A0=A0 10 RPM)=0A=
fan2:=A0=A0=A0=A0=A0=A0=A0 618 RPM=A0 (min =3D=A0=A0=A0 0 RPM)=0Afan3:=A0=
=A0=A0=A0=A0=A0 1278 RPM=A0 (min =3D=A0=A0 10 RPM)=0Afan4:=A0=A0=A0=A0=A0=
=A0 1203 RPM=A0 (min =3D=A0=A0=A0 0 RPM)=0Atemp1:=A0=A0=A0=A0=A0=A0 +35.0=
=C2=B0C=A0 (low=A0 =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C)=A0 sensor =3D=
 thermistor=0Atemp2:=A0=A0=A0=A0=A0=A0 +25.0=C2=B0C=A0 (low=A0 =3D +127.0=
=C2=B0C, high =3D +127.0=C2=B0C)=A0 sensor =3D thermistor=0Atemp3:=A0=A0=A0=
=A0=A0=A0 +33.0=C2=B0C=A0 (low=A0 =3D +127.0=C2=B0C, high =3D +90.0=C2=B0C)=
=A0 sensor =3D thermistor=0Acpu0_vid:=A0=A0 +0.313 V=0A=0ANo core-i7.... :(=
=0A// Naderan *Mahmood;=0A=0A=0A=0A=0A________________________________=0AFr=
om: Nikola Pajkovsky <npajkovs@redhat.com>=0ATo: lm-sensors@lm-sensors.org=
=0ASent: Wed, September 1, 2010 12:23:10 PM=0ASubject: Re: [lm-sensors] lms=
ensors doesn't detect core-i7 sensors=0A=0Asudo ./sensors-detect=0A=0AOn 09=
/01/2010 09:46 AM, Mahmood Naderan wrote:=0A>=A0 >just svn update # not nee=
ded if you have fresh checkout=0A> To double check and be sure again:=0A> m=
ahmood@localhost:~$ <mailto:mahmood@localhost:~$> svn update 5857=0A> Skipp=
ed '5857'=0A>=0A> Then:=0A>=0A>=0A> mahmood@localhost:~$ <mailto:mahmood@bl=
ackfish:~$> cd lm-sensors/prog/detect/=0A> mahmood@localhost:~/lm-sensors/p=
rog/detect$ =0A><mailto:mahmood@blackfish:~/lm-sensors/prog/detect$> sudo s=
ensors-detect=0A> # sensors-detect revision 5818 (2010-01-18 17:22:07 +0100=
)=0A> # System: Gigabyte Technology Co., Ltd. P55-USB3=0A> This program wil=
l help you determine which kernel modules you need=0A> to load to use lm_se=
nsors most effectively. It is generally safe=0A> and recommended to accept =
the default answers to all questions,=0A> unless you know what you're doing=
.=0A> Some south bridges, CPUs or memory controllers contain embedded senso=
rs.=0A> Do you want to scan for them? This is totally safe. (YES/no): y=0A>=
 Silicon Integrated Systems SIS5595... No=0A> VIA VT82C686 Integrated Senso=
rs... No=0A> VIA VT8231 Integrated Sensors... No=0A> AMD K8 thermal sensors=
... No=0A> AMD Family 10h thermal sensors... No=0A> AMD Family 11h thermal =
sensors... No=0A> Intel Core family thermal sensor... No=0A> Intel Atom the=
rmal sensor... No=0A> Intel AMB FB-DIMM thermal sensor... No=0A> VIA C7 the=
rmal sensor... No=0A> VIA Nano thermal sensor... No=0A> Some Super I/O chip=
s contain embedded sensors. We have to write to=0A> standard I/O ports to p=
robe them. This is usually safe.=0A> Do you want to scan for Super I/O sens=
ors? (YES/no): y=0A> Probing for Super-I/O at 0x2e/0x2f=0A> Trying family `=
National Semiconductor'... No=0A> Trying family `SMSC'... No=0A> Trying fam=
ily `VIA/Winbond/Nuvoton/Fintek'... No=0A> Trying family `ITE'... Yes=0A> F=
ound `ITE IT8720F Super IO Sensors' Success!=0A> (address 0x290, driver `it=
87')=0A> Probing for Super-I/O at 0x4e/0x4f=0A> Trying family `National Sem=
iconductor'... No=0A> Trying family `SMSC'... No=0A> Trying family `VIA/Win=
bond/Nuvoton/Fintek'... No=0A> Trying family `ITE'... No=0A> Some systems (=
mainly servers) implement IPMI, a set of common interfaces=0A> through whic=
h system health data may be retrieved, amongst other things.=0A> We first t=
ry to get the information from SMBIOS. If we don't find it=0A> there, we ha=
ve to read from arbitrary I/O ports to probe for such=0A> interfaces. This =
is normally safe. Do you want to scan for IPMI=0A> interfaces? (YES/no): y=
=0A> Probing for `IPMI BMC KCS' at 0xca0... No=0A> Probing for `IPMI BMC SM=
IC' at 0xca8... No=0A> Some hardware monitoring chips are accessible throug=
h the ISA I/O ports.=0A> We have to write to arbitrary I/O ports to probe t=
hem. This is usually=0A> safe though. Yes, you do have ISA I/O ports even i=
f you do not have any=0A> ISA slots! Do you want to scan the ISA I/O ports?=
 (yes/NO): y=0A> Probing for `National Semiconductor LM78' at 0x290... No=
=0A> Probing for `National Semiconductor LM79' at 0x290... No=0A> Probing f=
or `Winbond W83781D' at 0x290... No=0A> Probing for `Winbond W83782D' at 0x=
290... No=0A> Lastly, we can probe the I2C/SMBus adapters for connected har=
dware=0A> monitoring devices. This is the most risky part, and while it wor=
ks=0A> reasonably well on most systems, it has been reported to cause troub=
le=0A> on some systems.=0A> Do you want to probe the I2C/SMBus adapters now=
? (YES/no): y=0A> Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.=0A=
> Sorry, no supported PCI bus adapters found.=0A> Module i2c-dev loaded suc=
cessfully.=0A> Now follows a summary of the probes I have just done.=0A> Ju=
st press ENTER to continue:=0A> Driver `it87':=0A> * ISA bus, address 0x290=
=0A> Chip `ITE IT8720F Super IO Sensors' (confidence: 9)=0A> To load everyt=
hing that is needed, add this to /etc/modules:=0A> #----cut here----=0A> # =
Chip drivers=0A> it87=0A> #----cut here----=0A> If you have some drivers bu=
ilt into your kernel, the list above will=0A> contain too many modules. Ski=
p the appropriate ones!=0A> Do you want to add these lines automatically to=
 /etc/modules? (yes/NO)yes=0A> Successful!=0A> Monitoring programs won't wo=
rk until the needed modules are=0A> loaded. You may want to run '/etc/init.=
d/module-init-tools start'=0A> to load them.=0A> Unloading i2c-dev... OK=0A=
>=0A> But that didn't help. See the sensors output:=0A>=0A> mahmood@localho=
st:~/lm-sensors/prog/detect$ =0A><mailto:mahmood@blackfish:~/lm-sensors/pro=
g/detect$> sudo sensors=0A> it8720-isa-0290=0A> Adapter: ISA adapter=0A> in=
0: +0.86 V (min =3D +0.00 V, max =3D +4.08 V)=0A> in1: +1.58 V (min =3D +0.=
00 V, max =3D +4.08 V)=0A> in2: +3.39 V (min =3D +0.00 V, max =3D +4.08 V)=
=0A> in3: +3.02 V (min =3D +0.00 V, max =3D +4.08 V)=0A> in4: +0.05 V (min =
=3D +0.00 V, max =3D +4.08 V) ALARM=0A> in5: +3.12 V (min =3D +0.00 V, max =
=3D +4.08 V)=0A> in6: +0.02 V (min =3D +0.00 V, max =3D +4.08 V) ALARM=0A> =
in7: +2.16 V (min =3D +0.00 V, max =3D +4.08 V)=0A> Vbat: +3.10 V=0A> fan1:=
 1683 RPM (min =3D 10 RPM)=0A> fan2: 644 RPM (min =3D 0 RPM)=0A> fan3: 1280=
 RPM (min =3D 10 RPM)=0A> fan4: 1203 RPM (min =3D 0 RPM)=0A> temp1: +35.0=
=C2=B0C (low =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C) sensor =3D thermist=
or=0A> temp2: +25.0=C2=B0C (low =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C) =
sensor =3D thermistor=0A> temp3: +33.0=C2=B0C (low =3D +127.0=C2=B0C, high =
=3D +90.0=C2=B0C) sensor =3D thermistor=0A> cpu0_vid: +0.313 V=0A>=0A> Any =
idea? Thanks,=0A> *// Naderan *Mahmood;*=0A>=0A>=0A>-----------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------------------------------------
----------------------=0A>-=0A--=0A> *From:* Nikola Pajkovsky <npajkovs@red=
hat.com>=0A> *To:* lm-sensors@lm-sensors.org=0A> *Sent:* Wed, September 1, =
2010 12:08:07 PM=0A> *Subject:* Re: [lm-sensors] lmsensors doesn't detect c=
ore-i7 sensors=0A>=0A> On 09/01/2010 09:30 AM, Mahmood Naderan wrote:=0A>=
=A0 > Here is what I did:=0A>=A0 > mahmood@localhost:~$ <mailto:mahmood@loc=
alhost:~$> svn checkout =0A>http://lm-sensors.org/svn/lm-sensors/trunk lm-s=
ensors=0A>=A0 > ...=0A>=A0 > Checked out revision 5857.=0A> Yes=0A>=0A>=A0 =
> mahmood@localhost:~$ <mailto:mahmood@blackfish:~$> svn update =0A>http://=
lm-sensors.org/svn/lm-sensors/trunk lm-sensors=0A>=A0 > Skipped 'http://lm-=
sensors.org/svn/lm-sensors/trunk'=0A>=A0 > At revision 5857.=0A>=A0 > Summa=
ry of conflicts:=0A>=A0 > Skipped paths: 1=0A>=A0 > Is that what you meant?=
=0A>=A0 > *// Naderan *Mahmood;*=0A> just svn update # not needed if you ha=
ve fresh checkout=0A>=0A> in lm-sensors/prog/detect run sensors-detect and =
it should find your core-i7=0A>=0A>=A0 >=0A>=A0 >=0A>=A0 > =0A>------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------------------------------------------=0A> ----------------=
--=0A----=0A> --=0A>=A0 > *From:* Nikola Pajkovsky <npajkovs@redhat.com <ma=
ilto:npajkovs@redhat.com>>=0A>=A0 > *To:* lm-sensors@lm-sensors.org <mailto=
:lm-sensors@lm-sensors.org>=0A>=A0 > *Sent:* Wed, September 1, 2010 11:49:0=
3 AM=0A>=A0 > *Subject:* Re: [lm-sensors] lmsensors doesn't detect core-i7 =
sensors=0A>=A0 >=0A>=A0 > On 09/01/2010 08:38 AM, Mahmood Naderan wrote:=0A=
>=A0 > > Dear all,=0A>=A0 > >=0A>=A0 > > I ran sensors-detect to detect Cor=
e-i7 temperatures but it doesn't show =0A>them. Here is the output of senso=
rs-detect:=0A>=A0 > >=0A>=A0 > >=0A>=A0 > > mahmood@localhost:~$ sudo senso=
rs-detect=0A>=A0 > > # sensors-detect revision 5818 (2010-01-18 17:22:07 +0=
100)=0A>=A0 > > # System: Gigabyte Technology Co., Ltd. P55-USB3=0A>=A0 > >=
=0A>=A0 > > This program will help you determine which kernel modules you n=
eed=0A>=A0 > > to load to use lm_sensors most effectively. It is generally =
safe=0A>=A0 > > and recommended to accept the default answers to all questi=
ons,=0A>=A0 > > unless you know what you're doing.=0A>=A0 > >=0A>=A0 > > So=
me south bridges, CPUs or memory controllers contain embedded sensors.=0A>=
=A0 > > Do you want to scan for them? This is totally safe. (YES/no): y=0A>=
=A0 > > Silicon Integrated Systems SIS5595... No=0A>=A0 > > VIA VT82C686 In=
tegrated Sensors... No=0A>=A0 > > VIA VT8231 Integrated Sensors... No=0A>=
=A0 > > AMD K8 thermal sensors... No=0A>=A0 > > AMD Family 10h thermal sens=
ors... No=0A>=A0 > > AMD Family 11h thermal sensors... No=0A>=A0 > > Intel =
Core family thermal sensor... No=0A>=A0 > > Intel Atom thermal sensor... No=
=0A>=A0 > > Intel AMB FB-DIMM thermal sensor... No=0A>=A0 > > VIA C7 therma=
l sensor... No=0A>=A0 > > VIA Nano thermal sensor... No=0A>=A0 > >=0A>=A0 >=
 > Some Super I/O chips contain embedded sensors. We have to write to=0A>=
=A0 > > standard I/O ports to probe them. This is usually safe.=0A>=A0 > > =
Do you want to scan for Super I/O sensors? (YES/no): y=0A>=A0 > > Probing f=
or Super-I/O at 0x2e/0x2f=0A>=A0 > > Trying family `National Semiconductor'=
... No=0A>=A0 > > Trying family `SMSC'... No=0A>=A0 > > Trying family `VIA/=
Winbond/Nuvoton/Fintek'... No=0A>=A0 > > Trying family `ITE'... Yes=0A>=A0 =
> > Found `ITE IT8720F Super IO Sensors' Success!=0A>=A0 > > (address 0x290=
, driver `it87')=0A>=A0 > > Probing for Super-I/O at 0x4e/0x4f=0A>=A0 > > T=
rying family `National Semiconductor'... No=0A>=A0 > > Trying family `SMSC'=
... No=0A>=A0 > > Trying family `VIA/Winbond/Nuvoton/Fintek'... No=0A>=A0 >=
 > Trying family `ITE'... No=0A>=A0 > >=0A>=A0 > > Some systems (mainly ser=
vers) implement IPMI, a set of common interfaces=0A>=A0 > > through which s=
ystem health data may be retrieved, amongst other things.=0A>=A0 > > We fir=
st try to get the information from SMBIOS. If we don't find it=0A>=A0 > > t=
here, we have to read from arbitrary I/O ports to probe for such=0A>=A0 > >=
 interfaces. This is normally safe. Do you want to scan for IPMI=0A>=A0 > >=
 interfaces? (YES/no): y=0A>=A0 > > Probing for `IPMI BMC KCS' at 0xca0... =
No=0A>=A0 > > Probing for `IPMI BMC SMIC' at 0xca8... No=0A>=A0 > >=0A>=A0 =
> > Some hardware monitoring chips are accessible through the ISA I/O ports=
.=0A>=A0 > > We have to write to arbitrary I/O ports to probe them. This is=
 usually=0A>=A0 > > safe though. Yes, you do have ISA I/O ports even if you=
 do not have any=0A>=A0 > > ISA slots! Do you want to scan the ISA I/O port=
s? (yes/NO): y=0A>=A0 > > Probing for `National Semiconductor LM78' at 0x29=
0... No=0A>=A0 > > Probing for `National Semiconductor LM79' at 0x290... No=
=0A>=A0 > > Probing for `Winbond W83781D' at 0x290... No=0A>=A0 > > Probing=
 for `Winbond W83782D' at 0x290... No=0A>=A0 > >=0A>=A0 > > Lastly, we can =
probe the I2C/SMBus adapters for connected hardware=0A>=A0 > > monitoring d=
evices. This is the most risky part, and while it works=0A>=A0 > > reasonab=
ly well on most systems, it has been reported to cause trouble=0A>=A0 > > o=
n some systems.=0A>=A0 > > Do you want to probe the I2C/SMBus adapters now?=
 (YES/no): y=0A>=A0 > > Found unknown SMBus adapter 8086:3b30 at 0000:00:1f=
.3.=0A>=A0 > > Sorry, no supported PCI bus adapters found.=0A>=A0 > > Modul=
e i2c-dev loaded successfully.=0A>=A0 > >=0A>=A0 > > Now follows a summary =
of the probes I have just done.=0A>=A0 > > Just press ENTER to continue:=0A=
>=A0 > >=0A>=A0 > > Driver `it87':=0A>=A0 > > * ISA bus, address 0x290=0A>=
=A0 > > Chip `ITE IT8720F Super IO Sensors' (confidence: 9)=0A>=A0 > >=0A>=
=A0 > > To load everything that is needed, add this to /etc/modules:=0A>=A0=
 > > #----cut here----=0A>=A0 > > # Chip drivers=0A>=A0 > > it87=0A>=A0 > >=
 #----cut here----=0A>=A0 > > If you have some drivers built into your kern=
el, the list above will=0A>=A0 > > contain too many modules. Skip the appro=
priate ones!=0A>=A0 > >=0A>=A0 > > Do you want to add these lines automatic=
ally to /etc/modules? (yes/NO)yes=0A>=A0 > > Successful!=0A>=A0 > >=0A>=A0 =
> > Monitoring programs won't work until the needed modules are=0A>=A0 > > =
loaded. You may want to run '/etc/init.d/module-init-tools start'=0A>=A0 > =
> to load them.=0A>=A0 > >=0A>=A0 > > Unloading i2c-dev... OK=0A>=A0 > >=0A=
>=A0 > >=0A>=A0 > > Then I ran sensors:=0A>=A0 > >=0A>=A0 > > mahmood@local=
host:~$ sudo sensors=0A>=A0 > > it8720-isa-0290=0A>=A0 > > Adapter: ISA ada=
pter=0A>=A0 > > in0: +0.86 V (min =3D +0.00 V, max =3D +4.08 V)=0A>=A0 > > =
in1: +1.58 V (min =3D +0.00 V, max =3D +4.08 V)=0A>=A0 > > in2: +3.39 V (mi=
n =3D +0.00 V, max =3D +4.08 V)=0A>=A0 > > in3: +3.02 V (min =3D +0.00 V, m=
ax =3D +4.08 V)=0A>=A0 > > in4: +0.05 V (min =3D +0.00 V, max =3D +4.08 V) =
ALARM=0A>=A0 > > in5: +3.12 V (min =3D +0.00 V, max =3D +4.08 V)=0A>=A0 > >=
 in6: +0.02 V (min =3D +0.00 V, max =3D +4.08 V) ALARM=0A>=A0 > > in7: +2.1=
6 V (min =3D +0.00 V, max =3D +4.08 V)=0A>=A0 > > Vbat: +3.10 V=0A>=A0 > > =
fan1: 1679 RPM (min =3D 10 RPM)=0A>=A0 > > fan2: 644 RPM (min =3D 0 RPM)=0A=
>=A0 > > fan3: 1278 RPM (min =3D 10 RPM)=0A>=A0 > > fan4: 1205 RPM (min =3D=
 0 RPM)=0A>=A0 > > temp1: +36.0=C2=B0C (low =3D +127.0=C2=B0C, high =3D +12=
7.0=C2=B0C) sensor =3D thermistor=0A>=A0 > > temp2: +25.0=C2=B0C (low =3D +=
127.0=C2=B0C, high =3D +127.0=C2=B0C) sensor =3D thermistor=0A>=A0 > > temp=
3: +33.0=C2=B0C (low =3D +127.0=C2=B0C, high =3D +90.0=C2=B0C) sensor =3D t=
hermistor=0A>=A0 > > cpu0_vid: +0.313 V=0A>=A0 > >=0A>=A0 > >=0A>=A0 > > Wh=
at can I do then? currently I have kubuntu 10.04=0A>=A0 > >=0A>=A0 > > *// =
Naderan *Mahmood;*=0A>=A0 > >=0A>=A0 > >=0A>=A0 >=0A>=A0 > Pick sensors-det=
ect from svn or file bug against lm-sensors in ubuntu and =0A>maintainer(if=
 he is nice) update lm-sensors.=0A>=A0 >=0A>=0A=0A=0A______________________=
_________________________=0Alm-sensors mailing list=0Alm-sensors@lm-sensors=
.org=0Ahttp://lists.lm-sensors.org/mailman/listinfo/lm-sensors=0A=0A=0A=0A =
     
--0-507225290-1283328197=:75109
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:tahoma, new york, times, serif;font-size=
:12pt"><DIV></DIV>=0A<DIV>&gt;sudo ./sensors-detect</DIV>=0A<DIV>Yes<BR><FO=
NT size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif">In=
tel Core family thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; Success!<BR>&nbsp;&nbsp;&nbsp; (driver `coretem=
p')</FONT><BR><FONT size=3D2 face=3D"Courier New, courier, monaco, monospac=
e, sans-serif">...</FONT></DIV>=0A<DIV><FONT size=3D2 face=3D"Courier New, =
courier, monaco, monospace, sans-serif">Now follows a summary of the probes=
 I have just done.<BR>Just press ENTER to continue:</FONT></DIV>=0A<DIV><FO=
NT size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif">Dr=
iver `it87':<BR>&nbsp; * ISA bus, address 0x290<BR>&nbsp;&nbsp;&nbsp; Chip =
`ITE IT8720F Super IO Sensors' (confidence: 9)</FONT></DIV>=0A<DIV><FONT si=
ze=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif">Driver =
`coretemp':<BR>&nbsp; * Chip `Intel Core family thermal sensor' (confidence=
: 9)</FONT></DIV>=0A<DIV><FONT size=3D2 face=3D"Courier New, courier, monac=
o, monospace, sans-serif">Do you want to generate /etc/sysconfig/lm_sensors=
? (yes/NO): y<BR>Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors<B=
R>for initialization at boot time.<BR>You should now start the lm_sensors s=
ervice to load the required<BR>kernel modules.</FONT><BR></DIV>=0A<DIV>I th=
en copy that file and restart</DIV>=0A<DIV><A href=3D"mailto:mahmood@blackf=
ish:~$"><FONT size=3D2 face=3D"Courier New, courier, monaco, monospace, san=
s-serif">mahmood@localhost:~$</FONT></A><FONT size=3D2 face=3D"Courier New,=
 courier, monaco, monospace, sans-serif"> ls /etc/init.d/lm*<BR>/etc/init.d=
/lm-sensors</FONT><BR></DIV>=0A<DIV>However this is what I see again</DIV>=
=0A<DIV><A href=3D"mailto:mahmood@localhost:~$"><FONT size=3D2 face=3D"Cour=
ier New, courier, monaco, monospace, sans-serif">mahmood@localhost:~$</FONT=
></A><FONT size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-s=
erif"> sudo sensors<BR>it8720-isa-0290<BR>Adapter: ISA adapter<BR>in0:&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.86 V&nbsp; (min =3D&nbsp; +0=
.00 V, max =3D&nbsp; +4.08 V)<BR>in1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; +1.58 V&nbsp; (min =3D&nbsp; +0.00 V, max =3D&nbsp; +4.08 V)<BR>=
in2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.39 V&nbsp; (min =3D=
&nbsp; +0.00 V, max =3D&nbsp; +4.08 V)<BR>in3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; +3.02 V&nbsp; (min =3D&nbsp; +0.00 V, max =3D&nbsp; +4.=
08 V)<BR>in4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.05 V&nbsp;=
 (min =3D&nbsp; +0.00 V, max =3D&nbsp; +4.08 V)&nbsp;&nbsp; ALARM<BR>in5:&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.12 V&nbsp; (min =3D&nbsp;=
 +0.00 V, max =3D&nbsp; +4.08
 V)<BR>in6:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.02 V&nbsp; (=
min =3D&nbsp; +0.00 V, max =3D&nbsp; +4.08 V)&nbsp;&nbsp; ALARM<BR>in7:&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +2.16 V&nbsp; (min =3D&nbsp; +=
0.00 V, max =3D&nbsp; +4.08 V)<BR>Vbat:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; +3.10 V<BR>fan1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1638 RPM&nbsp; =
(min =3D&nbsp;&nbsp; 10 RPM)<BR>fan2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 618 RPM&nbsp; (min =3D&nbsp;&nbsp;&nbsp; 0 RPM)<BR>fan3:&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 1278 RPM&nbsp; (min =3D&nbsp;&nbsp; 10 RPM)<BR>fan4:=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1203 RPM&nbsp; (min =3D&nbsp;&nbsp;&nb=
sp; 0 RPM)<BR>temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +35.0=C2=B0C&nbsp;=
 (low&nbsp; =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C)&nbsp; sensor =3D the=
rmistor<BR>temp2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +25.0=C2=B0C&nbsp; (l=
ow&nbsp; =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C)&nbsp; sensor =3D
 thermistor<BR>temp3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +33.0=C2=B0C&nbsp=
; (low&nbsp; =3D +127.0=C2=B0C, high =3D +90.0=C2=B0C)&nbsp; sensor =3D the=
rmistor<BR>cpu0_vid:&nbsp;&nbsp; +0.313 V</FONT><BR></DIV>=0A<DIV>No core-i=
7.... :(</DIV>=0A<DIV>=0A<DIV><FONT style=3D"BACKGROUND-COLOR: #ffffff" col=
or=3D#0080ff size=3D2 face=3D"arial, helvetica, sans-serif"><STRONG>// Nade=
ran *Mahmood;</STRONG></FONT></DIV></DIV>=0A<DIV><BR></DIV>=0A<DIV style=3D=
"FONT-FAMILY: tahoma, new york, times, serif; FONT-SIZE: 12pt"><BR>=0A<DIV =
style=3D"FONT-FAMILY: tahoma, new york, times, serif; FONT-SIZE: 12pt"><FON=
T size=3D2 face=3DTahoma>=0A<HR SIZE=3D1>=0A<B><SPAN style=3D"FONT-WEIGHT: =
bold">From:</SPAN></B> Nikola Pajkovsky &lt;npajkovs@redhat.com&gt;<BR><B><=
SPAN style=3D"FONT-WEIGHT: bold">To:</SPAN></B> lm-sensors@lm-sensors.org<B=
R><B><SPAN style=3D"FONT-WEIGHT: bold">Sent:</SPAN></B> Wed, September 1, 2=
010 12:23:10 PM<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Subject:</SPAN></B>=
 Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors<BR></FONT><BR>su=
do ./sensors-detect<BR><BR>On 09/01/2010 09:46 AM, Mahmood Naderan wrote:<B=
R>&gt;&nbsp; &gt;just svn update # not needed if you have fresh checkout<BR=
>&gt; To double check and be sure again:<BR>&gt; mahmood@localhost:~$ &lt;m=
ailto:mahmood@localhost:~$&gt; svn update 5857<BR>&gt; Skipped '5857'<BR>&g=
t;<BR>&gt; Then:<BR>&gt;<BR>&gt;<BR>&gt; mahmood@localhost:~$ &lt;mailto:ma=
hmood@blackfish:~$&gt; cd lm-sensors/prog/detect/<BR>&gt; mahmood@localhost=
:~/lm-sensors/prog/detect$ &lt;mailto:mahmood@blackfish:~/lm-sensors/prog/d=
etect$&gt; sudo sensors-detect<BR>&gt; #
 sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)<BR>&gt; # System:=
 Gigabyte Technology Co., Ltd. P55-USB3<BR>&gt; This program will help you =
determine which kernel modules you need<BR>&gt; to load to use lm_sensors m=
ost effectively. It is generally safe<BR>&gt; and recommended to accept the=
 default answers to all questions,<BR>&gt; unless you know what you're doin=
g.<BR>&gt; Some south bridges, CPUs or memory controllers contain embedded =
sensors.<BR>&gt; Do you want to scan for them? This is totally safe. (YES/n=
o): y<BR>&gt; Silicon Integrated Systems SIS5595... No<BR>&gt; VIA VT82C686=
 Integrated Sensors... No<BR>&gt; VIA VT8231 Integrated Sensors... No<BR>&g=
t; AMD K8 thermal sensors... No<BR>&gt; AMD Family 10h thermal sensors... N=
o<BR>&gt; AMD Family 11h thermal sensors... No<BR>&gt; Intel Core family th=
ermal sensor... No<BR>&gt; Intel Atom thermal sensor... No<BR>&gt; Intel AM=
B FB-DIMM thermal sensor... No<BR>&gt; VIA C7 thermal sensor...
 No<BR>&gt; VIA Nano thermal sensor... No<BR>&gt; Some Super I/O chips cont=
ain embedded sensors. We have to write to<BR>&gt; standard I/O ports to pro=
be them. This is usually safe.<BR>&gt; Do you want to scan for Super I/O se=
nsors? (YES/no): y<BR>&gt; Probing for Super-I/O at 0x2e/0x2f<BR>&gt; Tryin=
g family `National Semiconductor'... No<BR>&gt; Trying family `SMSC'... No<=
BR>&gt; Trying family `VIA/Winbond/Nuvoton/Fintek'... No<BR>&gt; Trying fam=
ily `ITE'... Yes<BR>&gt; Found `ITE IT8720F Super IO Sensors' Success!<BR>&=
gt; (address 0x290, driver `it87')<BR>&gt; Probing for Super-I/O at 0x4e/0x=
4f<BR>&gt; Trying family `National Semiconductor'... No<BR>&gt; Trying fami=
ly `SMSC'... No<BR>&gt; Trying family `VIA/Winbond/Nuvoton/Fintek'... No<BR=
>&gt; Trying family `ITE'... No<BR>&gt; Some systems (mainly servers) imple=
ment IPMI, a set of common interfaces<BR>&gt; through which system health d=
ata may be retrieved, amongst other things.<BR>&gt; We first try to
 get the information from SMBIOS. If we don't find it<BR>&gt; there, we hav=
e to read from arbitrary I/O ports to probe for such<BR>&gt; interfaces. Th=
is is normally safe. Do you want to scan for IPMI<BR>&gt; interfaces? (YES/=
no): y<BR>&gt; Probing for `IPMI BMC KCS' at 0xca0... No<BR>&gt; Probing fo=
r `IPMI BMC SMIC' at 0xca8... No<BR>&gt; Some hardware monitoring chips are=
 accessible through the ISA I/O ports.<BR>&gt; We have to write to arbitrar=
y I/O ports to probe them. This is usually<BR>&gt; safe though. Yes, you do=
 have ISA I/O ports even if you do not have any<BR>&gt; ISA slots! Do you w=
ant to scan the ISA I/O ports? (yes/NO): y<BR>&gt; Probing for `National Se=
miconductor LM78' at 0x290... No<BR>&gt; Probing for `National Semiconducto=
r LM79' at 0x290... No<BR>&gt; Probing for `Winbond W83781D' at 0x290... No=
<BR>&gt; Probing for `Winbond W83782D' at 0x290... No<BR>&gt; Lastly, we ca=
n probe the I2C/SMBus adapters for connected hardware<BR>&gt;
 monitoring devices. This is the most risky part, and while it works<BR>&gt=
; reasonably well on most systems, it has been reported to cause trouble<BR=
>&gt; on some systems.<BR>&gt; Do you want to probe the I2C/SMBus adapters =
now? (YES/no): y<BR>&gt; Found unknown SMBus adapter 8086:3b30 at 0000:00:1=
f.3.<BR>&gt; Sorry, no supported PCI bus adapters found.<BR>&gt; Module i2c=
-dev loaded successfully.<BR>&gt; Now follows a summary of the probes I hav=
e just done.<BR>&gt; Just press ENTER to continue:<BR>&gt; Driver `it87':<B=
R>&gt; * ISA bus, address 0x290<BR>&gt; Chip `ITE IT8720F Super IO Sensors'=
 (confidence: 9)<BR>&gt; To load everything that is needed, add this to /et=
c/modules:<BR>&gt; #----cut here----<BR>&gt; # Chip drivers<BR>&gt; it87<BR=
>&gt; #----cut here----<BR>&gt; If you have some drivers built into your ke=
rnel, the list above will<BR>&gt; contain too many modules. Skip the approp=
riate ones!<BR>&gt; Do you want to add these lines automatically to
 /etc/modules? (yes/NO)yes<BR>&gt; Successful!<BR>&gt; Monitoring programs =
won't work until the needed modules are<BR>&gt; loaded. You may want to run=
 '/etc/init.d/module-init-tools start'<BR>&gt; to load them.<BR>&gt; Unload=
ing i2c-dev... OK<BR>&gt;<BR>&gt; But that didn't help. See the sensors out=
put:<BR>&gt;<BR>&gt; mahmood@localhost:~/lm-sensors/prog/detect$ &lt;mailto=
:mahmood@blackfish:~/lm-sensors/prog/detect$&gt; sudo sensors<BR>&gt; it872=
0-isa-0290<BR>&gt; Adapter: ISA adapter<BR>&gt; in0: +0.86 V (min =3D +0.00=
 V, max =3D +4.08 V)<BR>&gt; in1: +1.58 V (min =3D +0.00 V, max =3D +4.08 V=
)<BR>&gt; in2: +3.39 V (min =3D +0.00 V, max =3D +4.08 V)<BR>&gt; in3: +3.0=
2 V (min =3D +0.00 V, max =3D +4.08 V)<BR>&gt; in4: +0.05 V (min =3D +0.00 =
V, max =3D +4.08 V) ALARM<BR>&gt; in5: +3.12 V (min =3D +0.00 V, max =3D +4=
.08 V)<BR>&gt; in6: +0.02 V (min =3D +0.00 V, max =3D +4.08 V) ALARM<BR>&gt=
; in7: +2.16 V (min =3D +0.00 V, max =3D +4.08 V)<BR>&gt; Vbat: +3.10 V<BR>=
&gt; fan1: 1683 RPM (min
 =3D 10 RPM)<BR>&gt; fan2: 644 RPM (min =3D 0 RPM)<BR>&gt; fan3: 1280 RPM (=
min =3D 10 RPM)<BR>&gt; fan4: 1203 RPM (min =3D 0 RPM)<BR>&gt; temp1: +35.0=
=C2=B0C (low =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C) sensor =3D thermist=
or<BR>&gt; temp2: +25.0=C2=B0C (low =3D +127.0=C2=B0C, high =3D +127.0=C2=
=B0C) sensor =3D thermistor<BR>&gt; temp3: +33.0=C2=B0C (low =3D +127.0=C2=
=B0C, high =3D +90.0=C2=B0C) sensor =3D thermistor<BR>&gt; cpu0_vid: +0.313=
 V<BR>&gt;<BR>&gt; Any idea? Thanks,<BR>&gt; *// Naderan *Mahmood;*<BR>&gt;=
<BR>&gt;<BR>&gt;
 --------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------------------------------------------------------------
----------------------<BR>--<BR>&gt; *From:* Nikola Pajkovsky &lt;<A href=
=3D"mailto:npajkovs@redhat.com" ymailto=3D"mailto:npajkovs@redhat.com">npaj=
kovs@redhat.com</A>&gt;<BR>&gt; *To:* <A href=3D"mailto:lm-sensors@lm-senso=
rs.org" ymailto=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.=
org</A><BR>&gt; *Sent:* Wed, September 1, 2010 12:08:07 PM<BR>&gt; *Subject=
:* Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors<BR>&gt;<BR>&gt=
; On 09/01/2010 09:30 AM, Mahmood Naderan wrote:<BR>&gt;&nbsp; &gt; Here is=
 what I did:<BR>&gt;&nbsp; &gt; mahmood@localhost:~$ &lt;mailto:mahmood@loc=
alhost:~$&gt; svn checkout http://lm-sensors.org/svn/lm-sensors/trunk lm-se=
nsors<BR>&gt;&nbsp; &gt; ...<BR>&gt;&nbsp; &gt; Checked out revision 5857.<=
BR>&gt; Yes<BR>&gt;<BR>&gt;&nbsp; &gt; mahmood@localhost:~$ &lt;mailto:mahm=
ood@blackfish:~$&gt; svn update <A href=3D"http://lm-sensors.org/svn/lm-sen=
sors/trunk" target=3D_blank>http://lm-sensors.org/svn/lm-sensors/trunk</A>
 lm-sensors<BR>&gt;&nbsp; &gt; Skipped 'http://lm-sensors.org/svn/lm-sensor=
s/trunk'<BR>&gt;&nbsp; &gt; At revision 5857.<BR>&gt;&nbsp; &gt; Summary of=
 conflicts:<BR>&gt;&nbsp; &gt; Skipped paths: 1<BR>&gt;&nbsp; &gt; Is that =
what you meant?<BR>&gt;&nbsp; &gt; *// Naderan *Mahmood;*<BR>&gt; just svn =
update # not needed if you have fresh checkout<BR>&gt;<BR>&gt; in lm-sensor=
s/prog/detect run sensors-detect and it should find your core-i7<BR>&gt;<BR=
>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt;
 --------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------------------------------------------------------------
 ------------------<BR>----<BR>&gt; --<BR>&gt;&nbsp; &gt; *From:* Nikola Pa=
jkovsky &lt;<A href=3D"mailto:npajkovs@redhat.com" ymailto=3D"mailto:npajko=
vs@redhat.com">npajkovs@redhat.com</A> &lt;mailto:<A href=3D"mailto:npajkov=
s@redhat.com" ymailto=3D"mailto:npajkovs@redhat.com">npajkovs@redhat.com</A=
>&gt;&gt;<BR>&gt;&nbsp; &gt; *To:* <A href=3D"mailto:lm-sensors@lm-sensors.=
org" ymailto=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org=
</A> &lt;mailto:<A href=3D"mailto:lm-sensors@lm-sensors.org" ymailto=3D"mai=
lto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</A>&gt;<BR>&gt;&nb=
sp; &gt; *Sent:* Wed, September 1, 2010 11:49:03 AM<BR>&gt;&nbsp; &gt; *Sub=
ject:* Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors<BR>&gt;&nb=
sp; &gt;<BR>&gt;&nbsp; &gt; On 09/01/2010 08:38 AM, Mahmood Naderan wrote:<=
BR>&gt;&nbsp; &gt; &gt; Dear all,<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt=
; &gt; I ran sensors-detect to detect Core-i7 temperatures but it doesn't s=
how them.
 Here is the output of sensors-detect:<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp=
; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; mahmood@localhost:~$ sudo sensors-detec=
t<BR>&gt;&nbsp; &gt; &gt; # sensors-detect revision 5818 (2010-01-18 17:22:=
07 +0100)<BR>&gt;&nbsp; &gt; &gt; # System: Gigabyte Technology Co., Ltd. P=
55-USB3<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; This program will h=
elp you determine which kernel modules you need<BR>&gt;&nbsp; &gt; &gt; to =
load to use lm_sensors most effectively. It is generally safe<BR>&gt;&nbsp;=
 &gt; &gt; and recommended to accept the default answers to all questions,<=
BR>&gt;&nbsp; &gt; &gt; unless you know what you're doing.<BR>&gt;&nbsp; &g=
t; &gt;<BR>&gt;&nbsp; &gt; &gt; Some south bridges, CPUs or memory controll=
ers contain embedded sensors.<BR>&gt;&nbsp; &gt; &gt; Do you want to scan f=
or them? This is totally safe. (YES/no): y<BR>&gt;&nbsp; &gt; &gt; Silicon =
Integrated Systems SIS5595... No<BR>&gt;&nbsp; &gt; &gt; VIA
 VT82C686 Integrated Sensors... No<BR>&gt;&nbsp; &gt; &gt; VIA VT8231 Integ=
rated Sensors... No<BR>&gt;&nbsp; &gt; &gt; AMD K8 thermal sensors... No<BR=
>&gt;&nbsp; &gt; &gt; AMD Family 10h thermal sensors... No<BR>&gt;&nbsp; &g=
t; &gt; AMD Family 11h thermal sensors... No<BR>&gt;&nbsp; &gt; &gt; Intel =
Core family thermal sensor... No<BR>&gt;&nbsp; &gt; &gt; Intel Atom thermal=
 sensor... No<BR>&gt;&nbsp; &gt; &gt; Intel AMB FB-DIMM thermal sensor... N=
o<BR>&gt;&nbsp; &gt; &gt; VIA C7 thermal sensor... No<BR>&gt;&nbsp; &gt; &g=
t; VIA Nano thermal sensor... No<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt;=
 &gt; Some Super I/O chips contain embedded sensors. We have to write to<BR=
>&gt;&nbsp; &gt; &gt; standard I/O ports to probe them. This is usually saf=
e.<BR>&gt;&nbsp; &gt; &gt; Do you want to scan for Super I/O sensors? (YES/=
no): y<BR>&gt;&nbsp; &gt; &gt; Probing for Super-I/O at 0x2e/0x2f<BR>&gt;&n=
bsp; &gt; &gt; Trying family `National Semiconductor'...
 No<BR>&gt;&nbsp; &gt; &gt; Trying family `SMSC'... No<BR>&gt;&nbsp; &gt; &=
gt; Trying family `VIA/Winbond/Nuvoton/Fintek'... No<BR>&gt;&nbsp; &gt; &gt=
; Trying family `ITE'... Yes<BR>&gt;&nbsp; &gt; &gt; Found `ITE IT8720F Sup=
er IO Sensors' Success!<BR>&gt;&nbsp; &gt; &gt; (address 0x290, driver `it8=
7')<BR>&gt;&nbsp; &gt; &gt; Probing for Super-I/O at 0x4e/0x4f<BR>&gt;&nbsp=
; &gt; &gt; Trying family `National Semiconductor'... No<BR>&gt;&nbsp; &gt;=
 &gt; Trying family `SMSC'... No<BR>&gt;&nbsp; &gt; &gt; Trying family `VIA=
/Winbond/Nuvoton/Fintek'... No<BR>&gt;&nbsp; &gt; &gt; Trying family `ITE'.=
.. No<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; Some systems (mainly =
servers) implement IPMI, a set of common interfaces<BR>&gt;&nbsp; &gt; &gt;=
 through which system health data may be retrieved, amongst other things.<B=
R>&gt;&nbsp; &gt; &gt; We first try to get the information from SMBIOS. If =
we don't find it<BR>&gt;&nbsp; &gt; &gt; there, we have to read from
 arbitrary I/O ports to probe for such<BR>&gt;&nbsp; &gt; &gt; interfaces. =
This is normally safe. Do you want to scan for IPMI<BR>&gt;&nbsp; &gt; &gt;=
 interfaces? (YES/no): y<BR>&gt;&nbsp; &gt; &gt; Probing for `IPMI BMC KCS'=
 at 0xca0... No<BR>&gt;&nbsp; &gt; &gt; Probing for `IPMI BMC SMIC' at 0xca=
8... No<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; Some hardware monit=
oring chips are accessible through the ISA I/O ports.<BR>&gt;&nbsp; &gt; &g=
t; We have to write to arbitrary I/O ports to probe them. This is usually<B=
R>&gt;&nbsp; &gt; &gt; safe though. Yes, you do have ISA I/O ports even if =
you do not have any<BR>&gt;&nbsp; &gt; &gt; ISA slots! Do you want to scan =
the ISA I/O ports? (yes/NO): y<BR>&gt;&nbsp; &gt; &gt; Probing for `Nationa=
l Semiconductor LM78' at 0x290... No<BR>&gt;&nbsp; &gt; &gt; Probing for `N=
ational Semiconductor LM79' at 0x290... No<BR>&gt;&nbsp; &gt; &gt; Probing =
for `Winbond W83781D' at 0x290... No<BR>&gt;&nbsp; &gt; &gt; Probing
 for `Winbond W83782D' at 0x290... No<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp;=
 &gt; &gt; Lastly, we can probe the I2C/SMBus adapters for connected hardwa=
re<BR>&gt;&nbsp; &gt; &gt; monitoring devices. This is the most risky part,=
 and while it works<BR>&gt;&nbsp; &gt; &gt; reasonably well on most systems=
, it has been reported to cause trouble<BR>&gt;&nbsp; &gt; &gt; on some sys=
tems.<BR>&gt;&nbsp; &gt; &gt; Do you want to probe the I2C/SMBus adapters n=
ow? (YES/no): y<BR>&gt;&nbsp; &gt; &gt; Found unknown SMBus adapter 8086:3b=
30 at 0000:00:1f.3.<BR>&gt;&nbsp; &gt; &gt; Sorry, no supported PCI bus ada=
pters found.<BR>&gt;&nbsp; &gt; &gt; Module i2c-dev loaded successfully.<BR=
>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; Now follows a summary of the =
probes I have just done.<BR>&gt;&nbsp; &gt; &gt; Just press ENTER to contin=
ue:<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; Driver `it87':<BR>&gt;&=
nbsp; &gt; &gt; * ISA bus, address 0x290<BR>&gt;&nbsp; &gt; &gt;
 Chip `ITE IT8720F Super IO Sensors' (confidence: 9)<BR>&gt;&nbsp; &gt; &gt=
;<BR>&gt;&nbsp; &gt; &gt; To load everything that is needed, add this to /e=
tc/modules:<BR>&gt;&nbsp; &gt; &gt; #----cut here----<BR>&gt;&nbsp; &gt; &g=
t; # Chip drivers<BR>&gt;&nbsp; &gt; &gt; it87<BR>&gt;&nbsp; &gt; &gt; #---=
-cut here----<BR>&gt;&nbsp; &gt; &gt; If you have some drivers built into y=
our kernel, the list above will<BR>&gt;&nbsp; &gt; &gt; contain too many mo=
dules. Skip the appropriate ones!<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt=
; &gt; Do you want to add these lines automatically to /etc/modules? (yes/N=
O)yes<BR>&gt;&nbsp; &gt; &gt; Successful!<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&n=
bsp; &gt; &gt; Monitoring programs won't work until the needed modules are<=
BR>&gt;&nbsp; &gt; &gt; loaded. You may want to run '/etc/init.d/module-ini=
t-tools start'<BR>&gt;&nbsp; &gt; &gt; to load them.<BR>&gt;&nbsp; &gt; &gt=
;<BR>&gt;&nbsp; &gt; &gt; Unloading i2c-dev... OK<BR>&gt;&nbsp; &gt;
 &gt;<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; Then I ran sensors:<B=
R>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; mahmood@localhost:~$ sudo se=
nsors<BR>&gt;&nbsp; &gt; &gt; it8720-isa-0290<BR>&gt;&nbsp; &gt; &gt; Adapt=
er: ISA adapter<BR>&gt;&nbsp; &gt; &gt; in0: +0.86 V (min =3D +0.00 V, max =
=3D +4.08 V)<BR>&gt;&nbsp; &gt; &gt; in1: +1.58 V (min =3D +0.00 V, max =3D=
 +4.08 V)<BR>&gt;&nbsp; &gt; &gt; in2: +3.39 V (min =3D +0.00 V, max =3D +4=
.08 V)<BR>&gt;&nbsp; &gt; &gt; in3: +3.02 V (min =3D +0.00 V, max =3D +4.08=
 V)<BR>&gt;&nbsp; &gt; &gt; in4: +0.05 V (min =3D +0.00 V, max =3D +4.08 V)=
 ALARM<BR>&gt;&nbsp; &gt; &gt; in5: +3.12 V (min =3D +0.00 V, max =3D +4.08=
 V)<BR>&gt;&nbsp; &gt; &gt; in6: +0.02 V (min =3D +0.00 V, max =3D +4.08 V)=
 ALARM<BR>&gt;&nbsp; &gt; &gt; in7: +2.16 V (min =3D +0.00 V, max =3D +4.08=
 V)<BR>&gt;&nbsp; &gt; &gt; Vbat: +3.10 V<BR>&gt;&nbsp; &gt; &gt; fan1: 167=
9 RPM (min =3D 10 RPM)<BR>&gt;&nbsp; &gt; &gt; fan2: 644 RPM (min =3D 0 RPM=
)<BR>&gt;&nbsp; &gt; &gt;
 fan3: 1278 RPM (min =3D 10 RPM)<BR>&gt;&nbsp; &gt; &gt; fan4: 1205 RPM (mi=
n =3D 0 RPM)<BR>&gt;&nbsp; &gt; &gt; temp1: +36.0=C2=B0C (low =3D +127.0=C2=
=B0C, high =3D +127.0=C2=B0C) sensor =3D thermistor<BR>&gt;&nbsp; &gt; &gt;=
 temp2: +25.0=C2=B0C (low =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C) sensor=
 =3D thermistor<BR>&gt;&nbsp; &gt; &gt; temp3: +33.0=C2=B0C (low =3D +127.0=
=C2=B0C, high =3D +90.0=C2=B0C) sensor =3D thermistor<BR>&gt;&nbsp; &gt; &g=
t; cpu0_vid: +0.313 V<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt;<BR>&g=
t;&nbsp; &gt; &gt; What can I do then? currently I have kubuntu 10.04<BR>&g=
t;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; *// Naderan *Mahmood;*<BR>&gt;&n=
bsp; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt=
; Pick sensors-detect from svn or file bug against lm-sensors in ubuntu and=
 maintainer(if he is nice) update lm-sensors.<BR>&gt;&nbsp; &gt;<BR>&gt;<BR=
><BR><BR>_______________________________________________<BR>lm-sensors mail=
ing list<BR><A
 href=3D"mailto:lm-sensors@lm-sensors.org" ymailto=3D"mailto:lm-sensors@lm-=
sensors.org">lm-sensors@lm-sensors.org</A><BR>http://lists.lm-sensors.org/m=
ailman/listinfo/lm-sensors<BR></DIV></DIV></div><br>=0A=0A=0A=0A=0A=0A=0A=
=0A      </body></html>
--0-507225290-1283328197=:75109--


--===============1018791250499553743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1018791250499553743==--
