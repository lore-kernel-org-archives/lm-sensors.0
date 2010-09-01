From: Mahmood Naderan <nt_mahmood@yahoo.com>
Date: Wed, 01 Sep 2010 08:16:41 +0000
Subject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <414392.2418.qm@web50008.mail.re2.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3739733468676070880=="
List-Id: <lm-sensors.vger.kernel.org>
References: <929339.59525.qm@web50002.mail.re2.yahoo.com>
In-Reply-To: <929339.59525.qm@web50002.mail.re2.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============3739733468676070880==
Content-Type: multipart/alternative; boundary="0-1292337673-1283329001=:2418"

--0-1292337673-1283329001=:2418
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

>sudo /etc/init.d/lm_sensors restart=0A=A0=0Amahmood@localhost:~$ sudo /etc=
/init.d/lm-sensors restart=0A.: 39: Can't open /etc/init.d/functions=0A=0AN=
ote there is no lm_sensors. I have lm-sensors=0A=A0=0A// Naderan *Mahmood;=
=0A=0A=0A=0A=0A________________________________=0AFrom: Nikola Pajkovsky <n=
pajkovs@redhat.com>=0ATo: lm-sensors@lm-sensors.org=0ASent: Wed, September =
1, 2010 12:41:56 PM=0ASubject: Re: [lm-sensors] lmsensors doesn't detect co=
re-i7 sensors=0A=0AOn 09/01/2010 10:03 AM, Mahmood Naderan wrote:=0A>=A0 >s=
udo ./sensors-detect=0A> Yes=0A> Intel Core family thermal sensor... Succes=
s!=0A> (driver `coretemp')=0A> ...=0A> Now follows a summary of the probes =
I have just done.=0A> Just press ENTER to continue:=0A> Driver `it87':=0A> =
* ISA bus, address 0x290=0A> Chip `ITE IT8720F Super IO Sensors' (confidenc=
e: 9)=0A> Driver `coretemp':=0A> * Chip `Intel Core family thermal sensor' =
(confidence: 9)=0A> Do you want to generate /etc/sysconfig/lm_sensors? (yes=
/NO): y=0A> Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors=0A> fo=
r initialization at boot time.=0A> You should now start the lm_sensors serv=
ice to load the required=0A> kernel modules.=0A> I then copy that file and =
restart=0A> mahmood@localhost:~$ <mailto:mahmood@blackfish:~$> ls /etc/init=
.d/lm*=0A> /etc/init.d/lm-sensors=0A> However this is what I see again=0A> =
mahmood@localhost:~$ <mailto:mahmood@localhost:~$> sudo sensors=0A> it8720-=
isa-0290=0A> Adapter: ISA adapter=0A> in0: +0.86 V (min =3D +0.00 V, max =
=3D +4.08 V)=0A> in1: +1.58 V (min =3D +0.00 V, max =3D +4.08 V)=0A> in2: +=
3.39 V (min =3D +0.00 V, max =3D +4.08 V)=0A> in3: +3.02 V (min =3D +0.00 V=
, max =3D +4.08 V)=0A> in4: +0.05 V (min =3D +0.00 V, max =3D +4.08 V) ALAR=
M=0A> in5: +3.12 V (min =3D +0.00 V, max =3D +4.08 V)=0A> in6: +0.02 V (min=
 =3D +0.00 V, max =3D +4.08 V) ALARM=0A> in7: +2.16 V (min =3D +0.00 V, max=
 =3D +4.08 V)=0A> Vbat: +3.10 V=0A> fan1: 1638 RPM (min =3D 10 RPM)=0A> fan=
2: 618 RPM (min =3D 0 RPM)=0A> fan3: 1278 RPM (min =3D 10 RPM)=0A> fan4: 12=
03 RPM (min =3D 0 RPM)=0A> temp1: +35.0=C2=B0C (low =3D +127.0=C2=B0C, high=
 =3D +127.0=C2=B0C) sensor =3D thermistor=0A> temp2: +25.0=C2=B0C (low =3D =
+127.0=C2=B0C, high =3D +127.0=C2=B0C) sensor =3D thermistor=0A> temp3: +33=
.0=C2=B0C (low =3D +127.0=C2=B0C, high =3D +90.0=C2=B0C) sensor =3D thermis=
tor=0A> cpu0_vid: +0.313 V=0A> No core-i7.... :(=0A> *// Naderan *Mahmood;*=
=0A>=0Asudo /etc/init.d/lm_sensors restart=0A=0A=0A>=0A>-------------------=
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
-----------------------------------------------
----------------------=0A>-=0A--=0A> *From:* Nikola Pajkovsky <npajkovs@red=
hat.com>=0A> *To:* lm-sensors@lm-sensors.org=0A> *Sent:* Wed, September 1, =
2010 12:23:10 PM=0A> *Subject:* Re: [lm-sensors] lmsensors doesn't detect c=
ore-i7 sensors=0A>=0A> sudo ./sensors-detect=0A>=0A> On 09/01/2010 09:46 AM=
, Mahmood Naderan wrote:=0A>=A0 > >just svn update # not needed if you have=
 fresh checkout=0A>=A0 > To double check and be sure again:=0A>=A0 > mahmoo=
d@localhost:~$ <mailto:mahmood@localhost:~$> svn update 5857=0A>=A0 > Skipp=
ed '5857'=0A>=A0 >=0A>=A0 > Then:=0A>=A0 >=0A>=A0 >=0A>=A0 > mahmood@localh=
ost:~$ <mailto:mahmood@blackfish:~$> cd =0A>lm-sensors/prog/detect/=0A>=A0 =
> mahmood@localhost:~/lm-sensors/prog/detect$ =0A><mailto:mahmood@blackfish=
:~/lm-sensors/prog/detect$> sudo sensors-detect=0A>=A0 > # sensors-detect r=
evision 5818 (2010-01-18 17:22:07 +0100)=0A>=A0 > # System: Gigabyte Techno=
logy Co., Ltd. P55-USB3=0A>=A0 > This program will help you determine which=
 kernel modules you need=0A>=A0 > to load to use lm_sensors most effectivel=
y. It is generally safe=0A>=A0 > and recommended to accept the default answ=
ers to all questions,=0A>=A0 > unless you know what you're doing.=0A>=A0 > =
Some south bridges, CPUs or memory controllers contain embedded sensors.=0A=
>=A0 > Do you want to scan for them? This is totally safe. (YES/no): y=0A>=
=A0 > Silicon Integrated Systems SIS5595... No=0A>=A0 > VIA VT82C686 Integr=
ated Sensors... No=0A>=A0 > VIA VT8231 Integrated Sensors... No=0A>=A0 > AM=
D K8 thermal sensors... No=0A>=A0 > AMD Family 10h thermal sensors... No=0A=
>=A0 > AMD Family 11h thermal sensors... No=0A>=A0 > Intel Core family ther=
mal sensor... No=0A>=A0 > Intel Atom thermal sensor... No=0A>=A0 > Intel AM=
B FB-DIMM thermal sensor... No=0A>=A0 > VIA C7 thermal sensor... No=0A>=A0 =
> VIA Nano thermal sensor... No=0A>=A0 > Some Super I/O chips contain embed=
ded sensors. We have to write to=0A>=A0 > standard I/O ports to probe them.=
 This is usually safe.=0A>=A0 > Do you want to scan for Super I/O sensors? =
(YES/no): y=0A>=A0 > Probing for Super-I/O at 0x2e/0x2f=0A>=A0 > Trying fam=
ily `National Semiconductor'... No=0A>=A0 > Trying family `SMSC'... No=0A>=
=A0 > Trying family `VIA/Winbond/Nuvoton/Fintek'... No=0A>=A0 > Trying fami=
ly `ITE'... Yes=0A>=A0 > Found `ITE IT8720F Super IO Sensors' Success!=0A>=
=A0 > (address 0x290, driver `it87')=0A>=A0 > Probing for Super-I/O at 0x4e=
/0x4f=0A>=A0 > Trying family `National Semiconductor'... No=0A>=A0 > Trying=
 family `SMSC'... No=0A>=A0 > Trying family `VIA/Winbond/Nuvoton/Fintek'...=
 No=0A>=A0 > Trying family `ITE'... No=0A>=A0 > Some systems (mainly server=
s) implement IPMI, a set of common interfaces=0A>=A0 > through which system=
 health data may be retrieved, amongst other things.=0A>=A0 > We first try =
to get the information from SMBIOS. If we don't find it=0A>=A0 > there, we =
have to read from arbitrary I/O ports to probe for such=0A>=A0 > interfaces=
. This is normally safe. Do you want to scan for IPMI=0A>=A0 > interfaces? =
(YES/no): y=0A>=A0 > Probing for `IPMI BMC KCS' at 0xca0... No=0A>=A0 > Pro=
bing for `IPMI BMC SMIC' at 0xca8... No=0A>=A0 > Some hardware monitoring c=
hips are accessible through the ISA I/O ports.=0A>=A0 > We have to write to=
 arbitrary I/O ports to probe them. This is usually=0A>=A0 > safe though. Y=
es, you do have ISA I/O ports even if you do not have any=0A>=A0 > ISA slot=
s! Do you want to scan the ISA I/O ports? (yes/NO): y=0A>=A0 > Probing for =
`National Semiconductor LM78' at 0x290... No=0A>=A0 > Probing for `National=
 Semiconductor LM79' at 0x290... No=0A>=A0 > Probing for `Winbond W83781D' =
at 0x290... No=0A>=A0 > Probing for `Winbond W83782D' at 0x290... No=0A>=A0=
 > Lastly, we can probe the I2C/SMBus adapters for connected hardware=0A>=
=A0 > monitoring devices. This is the most risky part, and while it works=
=0A>=A0 > reasonably well on most systems, it has been reported to cause tr=
ouble=0A>=A0 > on some systems.=0A>=A0 > Do you want to probe the I2C/SMBus=
 adapters now? (YES/no): y=0A>=A0 > Found unknown SMBus adapter 8086:3b30 a=
t 0000:00:1f.3.=0A>=A0 > Sorry, no supported PCI bus adapters found.=0A>=A0=
 > Module i2c-dev loaded successfully.=0A>=A0 > Now follows a summary of th=
e probes I have just done.=0A>=A0 > Just press ENTER to continue:=0A>=A0 > =
Driver `it87':=0A>=A0 > * ISA bus, address 0x290=0A>=A0 > Chip `ITE IT8720F=
 Super IO Sensors' (confidence: 9)=0A>=A0 > To load everything that is need=
ed, add this to /etc/modules:=0A>=A0 > #----cut here----=0A>=A0 > # Chip dr=
ivers=0A>=A0 > it87=0A>=A0 > #----cut here----=0A>=A0 > If you have some dr=
ivers built into your kernel, the list above will=0A>=A0 > contain too many=
 modules. Skip the appropriate ones!=0A>=A0 > Do you want to add these line=
s automatically to /etc/modules? (yes/NO)yes=0A>=A0 > Successful!=0A>=A0 > =
Monitoring programs won't work until the needed modules are=0A>=A0 > loaded=
. You may want to run '/etc/init.d/module-init-tools start'=0A>=A0 > to loa=
d them.=0A>=A0 > Unloading i2c-dev... OK=0A>=A0 >=0A>=A0 > But that didn't =
help. See the sensors output:=0A>=A0 >=0A>=A0 > mahmood@localhost:~/lm-sens=
ors/prog/detect$ =0A><mailto:mahmood@blackfish:~/lm-sensors/prog/detect$> s=
udo sensors=0A>=A0 > it8720-isa-0290=0A>=A0 > Adapter: ISA adapter=0A>=A0 >=
 in0: +0.86 V (min =3D +0.00 V, max =3D +4.08 V)=0A>=A0 > in1: +1.58 V (min=
 =3D +0.00 V, max =3D +4.08 V)=0A>=A0 > in2: +3.39 V (min =3D +0.00 V, max =
=3D +4.08 V)=0A>=A0 > in3: +3.02 V (min =3D +0.00 V, max =3D +4.08 V)=0A>=
=A0 > in4: +0.05 V (min =3D +0.00 V, max =3D +4.08 V) ALARM=0A>=A0 > in5: +=
3.12 V (min =3D +0.00 V, max =3D +4.08 V)=0A>=A0 > in6: +0.02 V (min =3D +0=
.00 V, max =3D +4.08 V) ALARM=0A>=A0 > in7: +2.16 V (min =3D +0.00 V, max =
=3D +4.08 V)=0A>=A0 > Vbat: +3.10 V=0A>=A0 > fan1: 1683 RPM (min =3D 10 RPM=
)=0A>=A0 > fan2: 644 RPM (min =3D 0 RPM)=0A>=A0 > fan3: 1280 RPM (min =3D 1=
0 RPM)=0A>=A0 > fan4: 1203 RPM (min =3D 0 RPM)=0A>=A0 > temp1: +35.0=C2=B0C=
 (low =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C) sensor =3D thermistor=0A>=
=A0 > temp2: +25.0=C2=B0C (low =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C) s=
ensor =3D thermistor=0A>=A0 > temp3: +33.0=C2=B0C (low =3D +127.0=C2=B0C, h=
igh =3D +90.0=C2=B0C) sensor =3D thermistor=0A>=A0 > cpu0_vid: +0.313 V=0A>=
=A0 >=0A>=A0 > Any idea? Thanks,=0A>=A0 > *// Naderan *Mahmood;*=0A>=A0 >=
=0A>=A0 >=0A>=A0 > =0A>----------------------------------------------------=
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
--------------=0A> ------------------=0A----=0A> --=0A>=A0 > *From:* Nikola=
 Pajkovsky <npajkovs@redhat.com <mailto:npajkovs@redhat.com>>=0A>=A0 > *To:=
* lm-sensors@lm-sensors.org <mailto:lm-sensors@lm-sensors.org>=0A>=A0 > *Se=
nt:* Wed, September 1, 2010 12:08:07 PM=0A>=A0 > *Subject:* Re: [lm-sensors=
] lmsensors doesn't detect core-i7 sensors=0A>=A0 >=0A>=A0 > On 09/01/2010 =
09:30 AM, Mahmood Naderan wrote:=0A>=A0 > > Here is what I did:=0A>=A0 > > =
mahmood@localhost:~$ <mailto:mahmood@localhost:~$> svn checkout =0A>http://=
lm-sensors.org/svn/lm-sensors/trunk lm-sensors=0A>=A0 > > ...=0A>=A0 > > Ch=
ecked out revision 5857.=0A>=A0 > Yes=0A>=A0 >=0A>=A0 > > mahmood@localhost=
:~$ <mailto:mahmood@blackfish:~$> svn update =0A>http://lm-sensors.org/svn/=
lm-sensors/trunk lm-sensors=0A>=A0 > > Skipped 'http://lm-sensors.org/svn/l=
m-sensors/trunk'=0A>=A0 > > At revision 5857.=0A>=A0 > > Summary of conflic=
ts:=0A>=A0 > > Skipped paths: 1=0A>=A0 > > Is that what you meant?=0A>=A0 >=
 > *// Naderan *Mahmood;*=0A>=A0 > just svn update # not needed if you have=
 fresh checkout=0A>=A0 >=0A>=A0 > in lm-sensors/prog/detect run sensors-det=
ect and it should find your =0Acore-i7=0A>=A0 >=0A>=A0 > >=0A>=A0 > >=0A>=
=A0 > > =0A>---------------------------------------------------------------=
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
---=0A> ----------------=0A--=0A> ----=0A>=A0 > --=0A>=A0 > > *From:* Nikol=
a Pajkovsky <npajkovs@redhat.com <mailto:npajkovs@redhat.com> =0A><mailto:n=
pajkovs@redhat.com <mailto:npajkovs@redhat.com>>>=0A>=A0 > > *To:* lm-senso=
rs@lm-sensors.org <mailto:lm-sensors@lm-sensors.org> =0A><mailto:lm-sensors=
@lm-sensors.org <mailto:lm-sensors@lm-sensors.org>>=0A>=A0 > > *Sent:* Wed,=
 September 1, 2010 11:49:03 AM=0A>=A0 > > *Subject:* Re: [lm-sensors] lmsen=
sors doesn't detect core-i7 sensors=0A>=A0 > >=0A>=A0 > > On 09/01/2010 08:=
38 AM, Mahmood Naderan wrote:=0A>=A0 > > > Dear all,=0A>=A0 > > >=0A>=A0 > =
> > I ran sensors-detect to detect Core-i7 temperatures but it doesn't show=
 =0A>them. Here is the output of sensors-detect:=0A>=A0 > > >=0A>=A0 > > >=
=0A>=A0 > > > mahmood@localhost:~$ sudo sensors-detect=0A>=A0 > > > # senso=
rs-detect revision 5818 (2010-01-18 17:22:07 +0100)=0A>=A0 > > > # System: =
Gigabyte Technology Co., Ltd. P55-USB3=0A>=A0 > > >=0A>=A0 > > > This progr=
am will help you determine which kernel modules you need=0A>=A0 > > > to lo=
ad to use lm_sensors most effectively. It is generally safe=0A>=A0 > > > an=
d recommended to accept the default answers to all questions,=0A>=A0 > > > =
unless you know what you're doing.=0A>=A0 > > >=0A>=A0 > > > Some south bri=
dges, CPUs or memory controllers contain embedded =0Asensors.=0A>=A0 > > > =
Do you want to scan for them? This is totally safe. (YES/no): y=0A>=A0 > > =
> Silicon Integrated Systems SIS5595... No=0A>=A0 > > > VIA VT82C686 Integr=
ated Sensors... No=0A>=A0 > > > VIA VT8231 Integrated Sensors... No=0A>=A0 =
> > > AMD K8 thermal sensors... No=0A>=A0 > > > AMD Family 10h thermal sens=
ors... No=0A>=A0 > > > AMD Family 11h thermal sensors... No=0A>=A0 > > > In=
tel Core family thermal sensor... No=0A>=A0 > > > Intel Atom thermal sensor=
... No=0A>=A0 > > > Intel AMB FB-DIMM thermal sensor... No=0A>=A0 > > > VIA=
 C7 thermal sensor... No=0A>=A0 > > > VIA Nano thermal sensor... No=0A>=A0 =
> > >=0A>=A0 > > > Some Super I/O chips contain embedded sensors. We have t=
o write to=0A>=A0 > > > standard I/O ports to probe them. This is usually s=
afe.=0A>=A0 > > > Do you want to scan for Super I/O sensors? (YES/no): y=0A=
>=A0 > > > Probing for Super-I/O at 0x2e/0x2f=0A>=A0 > > > Trying family `N=
ational Semiconductor'... No=0A>=A0 > > > Trying family `SMSC'... No=0A>=A0=
 > > > Trying family `VIA/Winbond/Nuvoton/Fintek'... No=0A>=A0 > > > Trying=
 family `ITE'... Yes=0A>=A0 > > > Found `ITE IT8720F Super IO Sensors' Succ=
ess!=0A>=A0 > > > (address 0x290, driver `it87')=0A>=A0 > > > Probing for S=
uper-I/O at 0x4e/0x4f=0A>=A0 > > > Trying family `National Semiconductor'..=
. No=0A>=A0 > > > Trying family `SMSC'... No=0A>=A0 > > > Trying family `VI=
A/Winbond/Nuvoton/Fintek'... No=0A>=A0 > > > Trying family `ITE'... No=0A>=
=A0 > > >=0A>=A0 > > > Some systems (mainly servers) implement IPMI, a set =
of common =0Ainterfaces=0A>=A0 > > > through which system health data may b=
e retrieved, amongst other =0Athings.=0A>=A0 > > > We first try to get the =
information from SMBIOS. If we don't find it=0A>=A0 > > > there, we have to=
 read from arbitrary I/O ports to probe for such=0A>=A0 > > > interfaces. T=
his is normally safe. Do you want to scan for IPMI=0A>=A0 > > > interfaces?=
 (YES/no): y=0A>=A0 > > > Probing for `IPMI BMC KCS' at 0xca0... No=0A>=A0 =
> > > Probing for `IPMI BMC SMIC' at 0xca8... No=0A>=A0 > > >=0A>=A0 > > > =
Some hardware monitoring chips are accessible through the ISA I/O =0Aports.=
=0A>=A0 > > > We have to write to arbitrary I/O ports to probe them. This i=
s usually=0A>=A0 > > > safe though. Yes, you do have ISA I/O ports even if =
you do not have any=0A>=A0 > > > ISA slots! Do you want to scan the ISA I/O=
 ports? (yes/NO): y=0A>=A0 > > > Probing for `National Semiconductor LM78' =
at 0x290... No=0A>=A0 > > > Probing for `National Semiconductor LM79' at 0x=
290... No=0A>=A0 > > > Probing for `Winbond W83781D' at 0x290... No=0A>=A0 =
> > > Probing for `Winbond W83782D' at 0x290... No=0A>=A0 > > >=0A>=A0 > > =
> Lastly, we can probe the I2C/SMBus adapters for connected hardware=0A>=A0=
 > > > monitoring devices. This is the most risky part, and while it works=
=0A>=A0 > > > reasonably well on most systems, it has been reported to caus=
e trouble=0A>=A0 > > > on some systems.=0A>=A0 > > > Do you want to probe t=
he I2C/SMBus adapters now? (YES/no): y=0A>=A0 > > > Found unknown SMBus ada=
pter 8086:3b30 at 0000:00:1f.3.=0A>=A0 > > > Sorry, no supported PCI bus ad=
apters found.=0A>=A0 > > > Module i2c-dev loaded successfully.=0A>=A0 > > >=
=0A>=A0 > > > Now follows a summary of the probes I have just done.=0A>=A0 =
> > > Just press ENTER to continue:=0A>=A0 > > >=0A>=A0 > > > Driver `it87'=
:=0A>=A0 > > > * ISA bus, address 0x290=0A>=A0 > > > Chip `ITE IT8720F Supe=
r IO Sensors' (confidence: 9)=0A>=A0 > > >=0A>=A0 > > > To load everything =
that is needed, add this to /etc/modules:=0A>=A0 > > > #----cut here----=0A=
>=A0 > > > # Chip drivers=0A>=A0 > > > it87=0A>=A0 > > > #----cut here----=
=0A>=A0 > > > If you have some drivers built into your kernel, the list abo=
ve will=0A>=A0 > > > contain too many modules. Skip the appropriate ones!=
=0A>=A0 > > >=0A>=A0 > > > Do you want to add these lines automatically to =
/etc/modules? =0A>(yes/NO)yes=0A>=A0 > > > Successful!=0A>=A0 > > >=0A>=A0 =
> > > Monitoring programs won't work until the needed modules are=0A>=A0 > =
> > loaded. You may want to run '/etc/init.d/module-init-tools start'=0A>=
=A0 > > > to load them.=0A>=A0 > > >=0A>=A0 > > > Unloading i2c-dev... OK=
=0A>=A0 > > >=0A>=A0 > > >=0A>=A0 > > > Then I ran sensors:=0A>=A0 > > >=0A=
>=A0 > > > mahmood@localhost:~$ sudo sensors=0A>=A0 > > > it8720-isa-0290=
=0A>=A0 > > > Adapter: ISA adapter=0A>=A0 > > > in0: +0.86 V (min =3D +0.00=
 V, max =3D +4.08 V)=0A>=A0 > > > in1: +1.58 V (min =3D +0.00 V, max =3D +4=
.08 V)=0A>=A0 > > > in2: +3.39 V (min =3D +0.00 V, max =3D +4.08 V)=0A>=A0 =
> > > in3: +3.02 V (min =3D +0.00 V, max =3D +4.08 V)=0A>=A0 > > > in4: +0.=
05 V (min =3D +0.00 V, max =3D +4.08 V) ALARM=0A>=A0 > > > in5: +3.12 V (mi=
n =3D +0.00 V, max =3D +4.08 V)=0A>=A0 > > > in6: +0.02 V (min =3D +0.00 V,=
 max =3D +4.08 V) ALARM=0A>=A0 > > > in7: +2.16 V (min =3D +0.00 V, max =3D=
 +4.08 V)=0A>=A0 > > > Vbat: +3.10 V=0A>=A0 > > > fan1: 1679 RPM (min =3D 1=
0 RPM)=0A>=A0 > > > fan2: 644 RPM (min =3D 0 RPM)=0A>=A0 > > > fan3: 1278 R=
PM (min =3D 10 RPM)=0A>=A0 > > > fan4: 1205 RPM (min =3D 0 RPM)=0A>=A0 > > =
> temp1: +36.0=C2=B0C (low =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C) senso=
r =3D thermistor=0A>=A0 > > > temp2: +25.0=C2=B0C (low =3D +127.0=C2=B0C, h=
igh =3D +127.0=C2=B0C) sensor =3D thermistor=0A>=A0 > > > temp3: +33.0=C2=
=B0C (low =3D +127.0=C2=B0C, high =3D +90.0=C2=B0C) sensor =3D thermistor=
=0A>=A0 > > > cpu0_vid: +0.313 V=0A>=A0 > > >=0A>=A0 > > >=0A>=A0 > > > Wha=
t can I do then? currently I have kubuntu 10.04=0A>=A0 > > >=0A>=A0 > > > *=
// Naderan *Mahmood;*=0A>=A0 > > >=0A>=A0 > > >=0A>=A0 > >=0A>=A0 > > Pick =
sensors-detect from svn or file bug against lm-sensors in ubuntu and =0A>ma=
intainer(if he is nice) update lm-sensors.=0A>=A0 > >=0A>=A0 >=0A>=0A=0A=0A=
_______________________________________________=0Alm-sensors mailing list=
=0Alm-sensors@lm-sensors.org=0Ahttp://lists.lm-sensors.org/mailman/listinfo=
/lm-sensors=0A=0A=0A=0A      
--0-1292337673-1283329001=:2418
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:Courier New, courier, monaco, monospace,=
 sans-serif;font-size:10pt"><DIV></DIV>=0A<DIV><FONT size=3D3 face=3D"tahom=
a, new york, times, serif">&gt;sudo /etc/init.d/lm_sensors restart</FONT></=
DIV>=0A<DIV><FONT size=3D3 face=3DTahoma></FONT>&nbsp;</DIV>=0A<DIV><A href=
=3D"mailto:mahmood@localhost:~$">mahmood@localhost:~$</A> sudo /etc/init.d/=
lm-sensors restart<BR>.: 39: Can't open /etc/init.d/functions</DIV>=0A<DIV>=
&nbsp;</DIV>=0A<DIV><FONT size=3D3 face=3D"tahoma, new york, times, serif">=
Note there is no lm_sensors. I have lm-sensors</FONT><BR>&nbsp;</DIV>=0A<DI=
V>=0A<DIV><FONT style=3D"BACKGROUND-COLOR: #ffffff" color=3D#0080ff size=3D=
2 face=3D"arial, helvetica, sans-serif"><STRONG>// Naderan *Mahmood;</STRON=
G></FONT></DIV></DIV>=0A<DIV><BR></DIV>=0A<DIV style=3D"FONT-FAMILY: Courie=
r New, courier, monaco, monospace, sans-serif; FONT-SIZE: 10pt"><BR>=0A<DIV=
 style=3D"FONT-FAMILY: tahoma, new york, times, serif; FONT-SIZE: 12pt"><FO=
NT size=3D2 face=3DTahoma>=0A<HR SIZE=3D1>=0A<B><SPAN style=3D"FONT-WEIGHT:=
 bold">From:</SPAN></B> Nikola Pajkovsky &lt;npajkovs@redhat.com&gt;<BR><B>=
<SPAN style=3D"FONT-WEIGHT: bold">To:</SPAN></B> lm-sensors@lm-sensors.org<=
BR><B><SPAN style=3D"FONT-WEIGHT: bold">Sent:</SPAN></B> Wed, September 1, =
2010 12:41:56 PM<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Subject:</SPAN></B=
> Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors<BR></FONT><BR>O=
n 09/01/2010 10:03 AM, Mahmood Naderan wrote:<BR>&gt;&nbsp; &gt;sudo ./sens=
ors-detect<BR>&gt; Yes<BR>&gt; Intel Core family thermal sensor... Success!=
<BR>&gt; (driver `coretemp')<BR>&gt; ...<BR>&gt; Now follows a summary of t=
he probes I have just done.<BR>&gt; Just press ENTER to continue:<BR>&gt; D=
river `it87':<BR>&gt; * ISA bus, address 0x290<BR>&gt; Chip `ITE IT8720F Su=
per IO Sensors' (confidence: 9)<BR>&gt; Driver `coretemp':<BR>&gt; * Chip `=
Intel Core family thermal sensor' (confidence: 9)<BR>&gt; Do you want to ge=
nerate /etc/sysconfig/lm_sensors? (yes/NO):
 y<BR>&gt; Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors<BR>&gt;=
 for initialization at boot time.<BR>&gt; You should now start the lm_senso=
rs service to load the required<BR>&gt; kernel modules.<BR>&gt; I then copy=
 that file and restart<BR>&gt; mahmood@localhost:~$ &lt;mailto:mahmood@blac=
kfish:~$&gt; ls /etc/init.d/lm*<BR>&gt; /etc/init.d/lm-sensors<BR>&gt; Howe=
ver this is what I see again<BR>&gt; mahmood@localhost:~$ &lt;mailto:mahmoo=
d@localhost:~$&gt; sudo sensors<BR>&gt; it8720-isa-0290<BR>&gt; Adapter: IS=
A adapter<BR>&gt; in0: +0.86 V (min =3D +0.00 V, max =3D +4.08 V)<BR>&gt; i=
n1: +1.58 V (min =3D +0.00 V, max =3D +4.08 V)<BR>&gt; in2: +3.39 V (min =
=3D +0.00 V, max =3D +4.08 V)<BR>&gt; in3: +3.02 V (min =3D +0.00 V, max =
=3D +4.08 V)<BR>&gt; in4: +0.05 V (min =3D +0.00 V, max =3D +4.08 V) ALARM<=
BR>&gt; in5: +3.12 V (min =3D +0.00 V, max =3D +4.08 V)<BR>&gt; in6: +0.02 =
V (min =3D +0.00 V, max =3D +4.08 V) ALARM<BR>&gt; in7: +2.16 V (min =3D +0=
.00 V, max =3D +4.08
 V)<BR>&gt; Vbat: +3.10 V<BR>&gt; fan1: 1638 RPM (min =3D 10 RPM)<BR>&gt; f=
an2: 618 RPM (min =3D 0 RPM)<BR>&gt; fan3: 1278 RPM (min =3D 10 RPM)<BR>&gt=
; fan4: 1203 RPM (min =3D 0 RPM)<BR>&gt; temp1: +35.0=C2=B0C (low =3D +127.=
0=C2=B0C, high =3D +127.0=C2=B0C) sensor =3D thermistor<BR>&gt; temp2: +25.=
0=C2=B0C (low =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C) sensor =3D thermis=
tor<BR>&gt; temp3: +33.0=C2=B0C (low =3D +127.0=C2=B0C, high =3D +90.0=C2=
=B0C) sensor =3D thermistor<BR>&gt; cpu0_vid: +0.313 V<BR>&gt; No core-i7..=
.. :(<BR>&gt; *// Naderan *Mahmood;*<BR>&gt;<BR>sudo /etc/init.d/lm_sensors=
 restart<BR><BR><BR>&gt;<BR>&gt;
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
org</A><BR>&gt; *Sent:* Wed, September 1, 2010 12:23:10 PM<BR>&gt; *Subject=
:* Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors<BR>&gt;<BR>&gt=
; sudo ./sensors-detect<BR>&gt;<BR>&gt; On 09/01/2010 09:46 AM, Mahmood Nad=
eran wrote:<BR>&gt;&nbsp; &gt; &gt;just svn update # not needed if you have=
 fresh checkout<BR>&gt;&nbsp; &gt; To double check and be sure again:<BR>&g=
t;&nbsp; &gt; mahmood@localhost:~$ &lt;mailto:mahmood@localhost:~$&gt; svn =
update 5857<BR>&gt;&nbsp; &gt; Skipped '5857'<BR>&gt;&nbsp; &gt;<BR>&gt;&nb=
sp; &gt; Then:<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt; mah=
mood@localhost:~$ &lt;mailto:mahmood@blackfish:~$&gt; cd
 lm-sensors/prog/detect/<BR>&gt;&nbsp; &gt; mahmood@localhost:~/lm-sensors/=
prog/detect$ &lt;mailto:mahmood@blackfish:~/lm-sensors/prog/detect$&gt; sud=
o sensors-detect<BR>&gt;&nbsp; &gt; # sensors-detect revision 5818 (2010-01=
-18 17:22:07 +0100)<BR>&gt;&nbsp; &gt; # System: Gigabyte Technology Co., L=
td. P55-USB3<BR>&gt;&nbsp; &gt; This program will help you determine which =
kernel modules you need<BR>&gt;&nbsp; &gt; to load to use lm_sensors most e=
ffectively. It is generally safe<BR>&gt;&nbsp; &gt; and recommended to acce=
pt the default answers to all questions,<BR>&gt;&nbsp; &gt; unless you know=
 what you're doing.<BR>&gt;&nbsp; &gt; Some south bridges, CPUs or memory c=
ontrollers contain embedded sensors.<BR>&gt;&nbsp; &gt; Do you want to scan=
 for them? This is totally safe. (YES/no): y<BR>&gt;&nbsp; &gt; Silicon Int=
egrated Systems SIS5595... No<BR>&gt;&nbsp; &gt; VIA VT82C686 Integrated Se=
nsors... No<BR>&gt;&nbsp; &gt; VIA VT8231 Integrated Sensors...
 No<BR>&gt;&nbsp; &gt; AMD K8 thermal sensors... No<BR>&gt;&nbsp; &gt; AMD =
Family 10h thermal sensors... No<BR>&gt;&nbsp; &gt; AMD Family 11h thermal =
sensors... No<BR>&gt;&nbsp; &gt; Intel Core family thermal sensor... No<BR>=
&gt;&nbsp; &gt; Intel Atom thermal sensor... No<BR>&gt;&nbsp; &gt; Intel AM=
B FB-DIMM thermal sensor... No<BR>&gt;&nbsp; &gt; VIA C7 thermal sensor... =
No<BR>&gt;&nbsp; &gt; VIA Nano thermal sensor... No<BR>&gt;&nbsp; &gt; Some=
 Super I/O chips contain embedded sensors. We have to write to<BR>&gt;&nbsp=
; &gt; standard I/O ports to probe them. This is usually safe.<BR>&gt;&nbsp=
; &gt; Do you want to scan for Super I/O sensors? (YES/no): y<BR>&gt;&nbsp;=
 &gt; Probing for Super-I/O at 0x2e/0x2f<BR>&gt;&nbsp; &gt; Trying family `=
National Semiconductor'... No<BR>&gt;&nbsp; &gt; Trying family `SMSC'... No=
<BR>&gt;&nbsp; &gt; Trying family `VIA/Winbond/Nuvoton/Fintek'... No<BR>&gt=
;&nbsp; &gt; Trying family `ITE'... Yes<BR>&gt;&nbsp; &gt; Found
 `ITE IT8720F Super IO Sensors' Success!<BR>&gt;&nbsp; &gt; (address 0x290,=
 driver `it87')<BR>&gt;&nbsp; &gt; Probing for Super-I/O at 0x4e/0x4f<BR>&g=
t;&nbsp; &gt; Trying family `National Semiconductor'... No<BR>&gt;&nbsp; &g=
t; Trying family `SMSC'... No<BR>&gt;&nbsp; &gt; Trying family `VIA/Winbond=
/Nuvoton/Fintek'... No<BR>&gt;&nbsp; &gt; Trying family `ITE'... No<BR>&gt;=
&nbsp; &gt; Some systems (mainly servers) implement IPMI, a set of common i=
nterfaces<BR>&gt;&nbsp; &gt; through which system health data may be retrie=
ved, amongst other things.<BR>&gt;&nbsp; &gt; We first try to get the infor=
mation from SMBIOS. If we don't find it<BR>&gt;&nbsp; &gt; there, we have t=
o read from arbitrary I/O ports to probe for such<BR>&gt;&nbsp; &gt; interf=
aces. This is normally safe. Do you want to scan for IPMI<BR>&gt;&nbsp; &gt=
; interfaces? (YES/no): y<BR>&gt;&nbsp; &gt; Probing for `IPMI BMC KCS' at =
0xca0... No<BR>&gt;&nbsp; &gt; Probing for `IPMI BMC SMIC' at
 0xca8... No<BR>&gt;&nbsp; &gt; Some hardware monitoring chips are accessib=
le through the ISA I/O ports.<BR>&gt;&nbsp; &gt; We have to write to arbitr=
ary I/O ports to probe them. This is usually<BR>&gt;&nbsp; &gt; safe though=
. Yes, you do have ISA I/O ports even if you do not have any<BR>&gt;&nbsp; =
&gt; ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): y<BR>&gt;&=
nbsp; &gt; Probing for `National Semiconductor LM78' at 0x290... No<BR>&gt;=
&nbsp; &gt; Probing for `National Semiconductor LM79' at 0x290... No<BR>&gt=
;&nbsp; &gt; Probing for `Winbond W83781D' at 0x290... No<BR>&gt;&nbsp; &gt=
; Probing for `Winbond W83782D' at 0x290... No<BR>&gt;&nbsp; &gt; Lastly, w=
e can probe the I2C/SMBus adapters for connected hardware<BR>&gt;&nbsp; &gt=
; monitoring devices. This is the most risky part, and while it works<BR>&g=
t;&nbsp; &gt; reasonably well on most systems, it has been reported to caus=
e trouble<BR>&gt;&nbsp; &gt; on some systems.<BR>&gt;&nbsp; &gt; Do
 you want to probe the I2C/SMBus adapters now? (YES/no): y<BR>&gt;&nbsp; &g=
t; Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.<BR>&gt;&nbsp; &gt=
; Sorry, no supported PCI bus adapters found.<BR>&gt;&nbsp; &gt; Module i2c=
-dev loaded successfully.<BR>&gt;&nbsp; &gt; Now follows a summary of the p=
robes I have just done.<BR>&gt;&nbsp; &gt; Just press ENTER to continue:<BR=
>&gt;&nbsp; &gt; Driver `it87':<BR>&gt;&nbsp; &gt; * ISA bus, address 0x290=
<BR>&gt;&nbsp; &gt; Chip `ITE IT8720F Super IO Sensors' (confidence: 9)<BR>=
&gt;&nbsp; &gt; To load everything that is needed, add this to /etc/modules=
:<BR>&gt;&nbsp; &gt; #----cut here----<BR>&gt;&nbsp; &gt; # Chip drivers<BR=
>&gt;&nbsp; &gt; it87<BR>&gt;&nbsp; &gt; #----cut here----<BR>&gt;&nbsp; &g=
t; If you have some drivers built into your kernel, the list above will<BR>=
&gt;&nbsp; &gt; contain too many modules. Skip the appropriate ones!<BR>&gt=
;&nbsp; &gt; Do you want to add these lines automatically to
 /etc/modules? (yes/NO)yes<BR>&gt;&nbsp; &gt; Successful!<BR>&gt;&nbsp; &gt=
; Monitoring programs won't work until the needed modules are<BR>&gt;&nbsp;=
 &gt; loaded. You may want to run '/etc/init.d/module-init-tools start'<BR>=
&gt;&nbsp; &gt; to load them.<BR>&gt;&nbsp; &gt; Unloading i2c-dev... OK<BR=
>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt; But that didn't help. See the sensors o=
utput:<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt; mahmood@localhost:~/lm-sensors=
/prog/detect$ &lt;mailto:mahmood@blackfish:~/lm-sensors/prog/detect$&gt; su=
do sensors<BR>&gt;&nbsp; &gt; it8720-isa-0290<BR>&gt;&nbsp; &gt; Adapter: I=
SA adapter<BR>&gt;&nbsp; &gt; in0: +0.86 V (min =3D +0.00 V, max =3D +4.08 =
V)<BR>&gt;&nbsp; &gt; in1: +1.58 V (min =3D +0.00 V, max =3D +4.08 V)<BR>&g=
t;&nbsp; &gt; in2: +3.39 V (min =3D +0.00 V, max =3D +4.08 V)<BR>&gt;&nbsp;=
 &gt; in3: +3.02 V (min =3D +0.00 V, max =3D +4.08 V)<BR>&gt;&nbsp; &gt; in=
4: +0.05 V (min =3D +0.00 V, max =3D +4.08 V) ALARM<BR>&gt;&nbsp; &gt; in5:=
 +3.12 V (min
 =3D +0.00 V, max =3D +4.08 V)<BR>&gt;&nbsp; &gt; in6: +0.02 V (min =3D +0.=
00 V, max =3D +4.08 V) ALARM<BR>&gt;&nbsp; &gt; in7: +2.16 V (min =3D +0.00=
 V, max =3D +4.08 V)<BR>&gt;&nbsp; &gt; Vbat: +3.10 V<BR>&gt;&nbsp; &gt; fa=
n1: 1683 RPM (min =3D 10 RPM)<BR>&gt;&nbsp; &gt; fan2: 644 RPM (min =3D 0 R=
PM)<BR>&gt;&nbsp; &gt; fan3: 1280 RPM (min =3D 10 RPM)<BR>&gt;&nbsp; &gt; f=
an4: 1203 RPM (min =3D 0 RPM)<BR>&gt;&nbsp; &gt; temp1: +35.0=C2=B0C (low =
=3D +127.0=C2=B0C, high =3D +127.0=C2=B0C) sensor =3D thermistor<BR>&gt;&nb=
sp; &gt; temp2: +25.0=C2=B0C (low =3D +127.0=C2=B0C, high =3D +127.0=C2=B0C=
) sensor =3D thermistor<BR>&gt;&nbsp; &gt; temp3: +33.0=C2=B0C (low =3D +12=
7.0=C2=B0C, high =3D +90.0=C2=B0C) sensor =3D thermistor<BR>&gt;&nbsp; &gt;=
 cpu0_vid: +0.313 V<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt; Any idea? Thanks,=
<BR>&gt;&nbsp; &gt; *// Naderan *Mahmood;*<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp;=
 &gt;<BR>&gt;&nbsp; &gt;
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
sp; &gt; *Sent:* Wed, September 1, 2010 12:08:07 PM<BR>&gt;&nbsp; &gt; *Sub=
ject:* Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors<BR>&gt;&nb=
sp; &gt;<BR>&gt;&nbsp; &gt; On 09/01/2010 09:30 AM, Mahmood Naderan wrote:<=
BR>&gt;&nbsp; &gt; &gt; Here is what I did:<BR>&gt;&nbsp; &gt; &gt; mahmood=
@localhost:~$ &lt;mailto:mahmood@localhost:~$&gt; svn checkout
 http://lm-sensors.org/svn/lm-sensors/trunk lm-sensors<BR>&gt;&nbsp; &gt; &=
gt; ...<BR>&gt;&nbsp; &gt; &gt; Checked out revision 5857.<BR>&gt;&nbsp; &g=
t; Yes<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt; &gt; mahmood@localhost:~$ &lt;=
mailto:mahmood@blackfish:~$&gt; svn update <A href=3D"http://lm-sensors.org=
/svn/lm-sensors/trunk" target=3D_blank>http://lm-sensors.org/svn/lm-sensors=
/trunk</A> lm-sensors<BR>&gt;&nbsp; &gt; &gt; Skipped 'http://lm-sensors.or=
g/svn/lm-sensors/trunk'<BR>&gt;&nbsp; &gt; &gt; At revision 5857.<BR>&gt;&n=
bsp; &gt; &gt; Summary of conflicts:<BR>&gt;&nbsp; &gt; &gt; Skipped paths:=
 1<BR>&gt;&nbsp; &gt; &gt; Is that what you meant?<BR>&gt;&nbsp; &gt; &gt; =
*// Naderan *Mahmood;*<BR>&gt;&nbsp; &gt; just svn update # not needed if y=
ou have fresh checkout<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt; in lm-sensors/=
prog/detect run sensors-detect and it should find your core-i7<BR>&gt;&nbsp=
; &gt;<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp;
 &gt; &gt;
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
 ----------------<BR>--<BR>&gt; ----<BR>&gt;&nbsp; &gt; --<BR>&gt;&nbsp; &g=
t; &gt; *From:* Nikola Pajkovsky &lt;<A href=3D"mailto:npajkovs@redhat.com"=
 ymailto=3D"mailto:npajkovs@redhat.com">npajkovs@redhat.com</A> &lt;mailto:=
<A href=3D"mailto:npajkovs@redhat.com" ymailto=3D"mailto:npajkovs@redhat.co=
m">npajkovs@redhat.com</A>&gt; &lt;mailto:<A href=3D"mailto:npajkovs@redhat=
.com" ymailto=3D"mailto:npajkovs@redhat.com">npajkovs@redhat.com</A> &lt;ma=
ilto:<A href=3D"mailto:npajkovs@redhat.com" ymailto=3D"mailto:npajkovs@redh=
at.com">npajkovs@redhat.com</A>&gt;&gt;&gt;<BR>&gt;&nbsp; &gt; &gt; *To:* <=
A href=3D"mailto:lm-sensors@lm-sensors.org" ymailto=3D"mailto:lm-sensors@lm=
-sensors.org">lm-sensors@lm-sensors.org</A> &lt;mailto:<A href=3D"mailto:lm=
-sensors@lm-sensors.org" ymailto=3D"mailto:lm-sensors@lm-sensors.org">lm-se=
nsors@lm-sensors.org</A>&gt; &lt;mailto:<A href=3D"mailto:lm-sensors@lm-sen=
sors.org" ymailto=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensor=
s.org</A>
 &lt;mailto:<A href=3D"mailto:lm-sensors@lm-sensors.org" ymailto=3D"mailto:=
lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</A>&gt;&gt;<BR>&gt;&nb=
sp; &gt; &gt; *Sent:* Wed, September 1, 2010 11:49:03 AM<BR>&gt;&nbsp; &gt;=
 &gt; *Subject:* Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors<=
BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; On 09/01/2010 08:38 AM, Mah=
mood Naderan wrote:<BR>&gt;&nbsp; &gt; &gt; &gt; Dear all,<BR>&gt;&nbsp; &g=
t; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; &gt; I ran sensors-detect to detect Co=
re-i7 temperatures but it doesn't show them. Here is the output of sensors-=
detect:<BR>&gt;&nbsp; &gt; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; &gt;<BR>&gt;&n=
bsp; &gt; &gt; &gt; mahmood@localhost:~$ sudo sensors-detect<BR>&gt;&nbsp; =
&gt; &gt; &gt; # sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)<B=
R>&gt;&nbsp; &gt; &gt; &gt; # System: Gigabyte Technology Co., Ltd. P55-USB=
3<BR>&gt;&nbsp; &gt; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; &gt; This program
 will help you determine which kernel modules you need<BR>&gt;&nbsp; &gt; &=
gt; &gt; to load to use lm_sensors most effectively. It is generally safe<B=
R>&gt;&nbsp; &gt; &gt; &gt; and recommended to accept the default answers t=
o all questions,<BR>&gt;&nbsp; &gt; &gt; &gt; unless you know what you're d=
oing.<BR>&gt;&nbsp; &gt; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; &gt; Some south =
bridges, CPUs or memory controllers contain embedded sensors.<BR>&gt;&nbsp;=
 &gt; &gt; &gt; Do you want to scan for them? This is totally safe. (YES/no=
): y<BR>&gt;&nbsp; &gt; &gt; &gt; Silicon Integrated Systems SIS5595... No<=
BR>&gt;&nbsp; &gt; &gt; &gt; VIA VT82C686 Integrated Sensors... No<BR>&gt;&=
nbsp; &gt; &gt; &gt; VIA VT8231 Integrated Sensors... No<BR>&gt;&nbsp; &gt;=
 &gt; &gt; AMD K8 thermal sensors... No<BR>&gt;&nbsp; &gt; &gt; &gt; AMD Fa=
mily 10h thermal sensors... No<BR>&gt;&nbsp; &gt; &gt; &gt; AMD Family 11h =
thermal sensors... No<BR>&gt;&nbsp; &gt; &gt; &gt; Intel Core family
 thermal sensor... No<BR>&gt;&nbsp; &gt; &gt; &gt; Intel Atom thermal senso=
r... No<BR>&gt;&nbsp; &gt; &gt; &gt; Intel AMB FB-DIMM thermal sensor... No=
<BR>&gt;&nbsp; &gt; &gt; &gt; VIA C7 thermal sensor... No<BR>&gt;&nbsp; &gt=
; &gt; &gt; VIA Nano thermal sensor... No<BR>&gt;&nbsp; &gt; &gt; &gt;<BR>&=
gt;&nbsp; &gt; &gt; &gt; Some Super I/O chips contain embedded sensors. We =
have to write to<BR>&gt;&nbsp; &gt; &gt; &gt; standard I/O ports to probe t=
hem. This is usually safe.<BR>&gt;&nbsp; &gt; &gt; &gt; Do you want to scan=
 for Super I/O sensors? (YES/no): y<BR>&gt;&nbsp; &gt; &gt; &gt; Probing fo=
r Super-I/O at 0x2e/0x2f<BR>&gt;&nbsp; &gt; &gt; &gt; Trying family `Nation=
al Semiconductor'... No<BR>&gt;&nbsp; &gt; &gt; &gt; Trying family `SMSC'..=
. No<BR>&gt;&nbsp; &gt; &gt; &gt; Trying family `VIA/Winbond/Nuvoton/Fintek=
'... No<BR>&gt;&nbsp; &gt; &gt; &gt; Trying family `ITE'... Yes<BR>&gt;&nbs=
p; &gt; &gt; &gt; Found `ITE IT8720F Super IO Sensors'
 Success!<BR>&gt;&nbsp; &gt; &gt; &gt; (address 0x290, driver `it87')<BR>&g=
t;&nbsp; &gt; &gt; &gt; Probing for Super-I/O at 0x4e/0x4f<BR>&gt;&nbsp; &g=
t; &gt; &gt; Trying family `National Semiconductor'... No<BR>&gt;&nbsp; &gt=
; &gt; &gt; Trying family `SMSC'... No<BR>&gt;&nbsp; &gt; &gt; &gt; Trying =
family `VIA/Winbond/Nuvoton/Fintek'... No<BR>&gt;&nbsp; &gt; &gt; &gt; Tryi=
ng family `ITE'... No<BR>&gt;&nbsp; &gt; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; =
&gt; Some systems (mainly servers) implement IPMI, a set of common interfac=
es<BR>&gt;&nbsp; &gt; &gt; &gt; through which system health data may be ret=
rieved, amongst other things.<BR>&gt;&nbsp; &gt; &gt; &gt; We first try to =
get the information from SMBIOS. If we don't find it<BR>&gt;&nbsp; &gt; &gt=
; &gt; there, we have to read from arbitrary I/O ports to probe for such<BR=
>&gt;&nbsp; &gt; &gt; &gt; interfaces. This is normally safe. Do you want t=
o scan for IPMI<BR>&gt;&nbsp; &gt; &gt; &gt; interfaces? (YES/no):
 y<BR>&gt;&nbsp; &gt; &gt; &gt; Probing for `IPMI BMC KCS' at 0xca0... No<B=
R>&gt;&nbsp; &gt; &gt; &gt; Probing for `IPMI BMC SMIC' at 0xca8... No<BR>&=
gt;&nbsp; &gt; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; &gt; Some hardware monitor=
ing chips are accessible through the ISA I/O ports.<BR>&gt;&nbsp; &gt; &gt;=
 &gt; We have to write to arbitrary I/O ports to probe them. This is usuall=
y<BR>&gt;&nbsp; &gt; &gt; &gt; safe though. Yes, you do have ISA I/O ports =
even if you do not have any<BR>&gt;&nbsp; &gt; &gt; &gt; ISA slots! Do you =
want to scan the ISA I/O ports? (yes/NO): y<BR>&gt;&nbsp; &gt; &gt; &gt; Pr=
obing for `National Semiconductor LM78' at 0x290... No<BR>&gt;&nbsp; &gt; &=
gt; &gt; Probing for `National Semiconductor LM79' at 0x290... No<BR>&gt;&n=
bsp; &gt; &gt; &gt; Probing for `Winbond W83781D' at 0x290... No<BR>&gt;&nb=
sp; &gt; &gt; &gt; Probing for `Winbond W83782D' at 0x290... No<BR>&gt;&nbs=
p; &gt; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; &gt; Lastly, we can probe
 the I2C/SMBus adapters for connected hardware<BR>&gt;&nbsp; &gt; &gt; &gt;=
 monitoring devices. This is the most risky part, and while it works<BR>&gt=
;&nbsp; &gt; &gt; &gt; reasonably well on most systems, it has been reporte=
d to cause trouble<BR>&gt;&nbsp; &gt; &gt; &gt; on some systems.<BR>&gt;&nb=
sp; &gt; &gt; &gt; Do you want to probe the I2C/SMBus adapters now? (YES/no=
): y<BR>&gt;&nbsp; &gt; &gt; &gt; Found unknown SMBus adapter 8086:3b30 at =
0000:00:1f.3.<BR>&gt;&nbsp; &gt; &gt; &gt; Sorry, no supported PCI bus adap=
ters found.<BR>&gt;&nbsp; &gt; &gt; &gt; Module i2c-dev loaded successfully=
.<BR>&gt;&nbsp; &gt; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; &gt; Now follows a s=
ummary of the probes I have just done.<BR>&gt;&nbsp; &gt; &gt; &gt; Just pr=
ess ENTER to continue:<BR>&gt;&nbsp; &gt; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt;=
 &gt; Driver `it87':<BR>&gt;&nbsp; &gt; &gt; &gt; * ISA bus, address 0x290<=
BR>&gt;&nbsp; &gt; &gt; &gt; Chip `ITE IT8720F Super IO Sensors'
 (confidence: 9)<BR>&gt;&nbsp; &gt; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; &gt; =
To load everything that is needed, add this to /etc/modules:<BR>&gt;&nbsp; =
&gt; &gt; &gt; #----cut here----<BR>&gt;&nbsp; &gt; &gt; &gt; # Chip driver=
s<BR>&gt;&nbsp; &gt; &gt; &gt; it87<BR>&gt;&nbsp; &gt; &gt; &gt; #----cut h=
ere----<BR>&gt;&nbsp; &gt; &gt; &gt; If you have some drivers built into yo=
ur kernel, the list above will<BR>&gt;&nbsp; &gt; &gt; &gt; contain too man=
y modules. Skip the appropriate ones!<BR>&gt;&nbsp; &gt; &gt; &gt;<BR>&gt;&=
nbsp; &gt; &gt; &gt; Do you want to add these lines automatically to /etc/m=
odules? (yes/NO)yes<BR>&gt;&nbsp; &gt; &gt; &gt; Successful!<BR>&gt;&nbsp; =
&gt; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; &gt; Monitoring programs won't work =
until the needed modules are<BR>&gt;&nbsp; &gt; &gt; &gt; loaded. You may w=
ant to run '/etc/init.d/module-init-tools start'<BR>&gt;&nbsp; &gt; &gt; &g=
t; to load them.<BR>&gt;&nbsp; &gt; &gt; &gt;<BR>&gt;&nbsp; &gt;
 &gt; &gt; Unloading i2c-dev... OK<BR>&gt;&nbsp; &gt; &gt; &gt;<BR>&gt;&nbs=
p; &gt; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; &gt; Then I ran sensors:<BR>&gt;&=
nbsp; &gt; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; &gt; mahmood@localhost:~$ sudo=
 sensors<BR>&gt;&nbsp; &gt; &gt; &gt; it8720-isa-0290<BR>&gt;&nbsp; &gt; &g=
t; &gt; Adapter: ISA adapter<BR>&gt;&nbsp; &gt; &gt; &gt; in0: +0.86 V (min=
 =3D +0.00 V, max =3D +4.08 V)<BR>&gt;&nbsp; &gt; &gt; &gt; in1: +1.58 V (m=
in =3D +0.00 V, max =3D +4.08 V)<BR>&gt;&nbsp; &gt; &gt; &gt; in2: +3.39 V =
(min =3D +0.00 V, max =3D +4.08 V)<BR>&gt;&nbsp; &gt; &gt; &gt; in3: +3.02 =
V (min =3D +0.00 V, max =3D +4.08 V)<BR>&gt;&nbsp; &gt; &gt; &gt; in4: +0.0=
5 V (min =3D +0.00 V, max =3D +4.08 V) ALARM<BR>&gt;&nbsp; &gt; &gt; &gt; i=
n5: +3.12 V (min =3D +0.00 V, max =3D +4.08 V)<BR>&gt;&nbsp; &gt; &gt; &gt;=
 in6: +0.02 V (min =3D +0.00 V, max =3D +4.08 V) ALARM<BR>&gt;&nbsp; &gt; &=
gt; &gt; in7: +2.16 V (min =3D +0.00 V, max =3D +4.08 V)<BR>&gt;&nbsp; &gt;=
 &gt; &gt; Vbat: +3.10
 V<BR>&gt;&nbsp; &gt; &gt; &gt; fan1: 1679 RPM (min =3D 10 RPM)<BR>&gt;&nbs=
p; &gt; &gt; &gt; fan2: 644 RPM (min =3D 0 RPM)<BR>&gt;&nbsp; &gt; &gt; &gt=
; fan3: 1278 RPM (min =3D 10 RPM)<BR>&gt;&nbsp; &gt; &gt; &gt; fan4: 1205 R=
PM (min =3D 0 RPM)<BR>&gt;&nbsp; &gt; &gt; &gt; temp1: +36.0=C2=B0C (low =
=3D +127.0=C2=B0C, high =3D +127.0=C2=B0C) sensor =3D thermistor<BR>&gt;&nb=
sp; &gt; &gt; &gt; temp2: +25.0=C2=B0C (low =3D +127.0=C2=B0C, high =3D +12=
7.0=C2=B0C) sensor =3D thermistor<BR>&gt;&nbsp; &gt; &gt; &gt; temp3: +33.0=
=C2=B0C (low =3D +127.0=C2=B0C, high =3D +90.0=C2=B0C) sensor =3D thermisto=
r<BR>&gt;&nbsp; &gt; &gt; &gt; cpu0_vid: +0.313 V<BR>&gt;&nbsp; &gt; &gt; &=
gt;<BR>&gt;&nbsp; &gt; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; &gt; What can I do=
 then? currently I have kubuntu 10.04<BR>&gt;&nbsp; &gt; &gt; &gt;<BR>&gt;&=
nbsp; &gt; &gt; &gt; *// Naderan *Mahmood;*<BR>&gt;&nbsp; &gt; &gt; &gt;<BR=
>&gt;&nbsp; &gt; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt; &gt; =
Pick sensors-detect from svn or file
 bug against lm-sensors in ubuntu and maintainer(if he is nice) update lm-s=
ensors.<BR>&gt;&nbsp; &gt; &gt;<BR>&gt;&nbsp; &gt;<BR>&gt;<BR><BR><BR>_____=
__________________________________________<BR>lm-sensors mailing list<BR><A=
 href=3D"mailto:lm-sensors@lm-sensors.org" ymailto=3D"mailto:lm-sensors@lm-=
sensors.org">lm-sensors@lm-sensors.org</A><BR>http://lists.lm-sensors.org/m=
ailman/listinfo/lm-sensors<BR></DIV></DIV></div><br>=0A=0A      </body></ht=
ml>
--0-1292337673-1283329001=:2418--


--===============3739733468676070880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3739733468676070880==--
