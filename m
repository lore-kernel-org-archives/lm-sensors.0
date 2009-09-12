From: Igor Santos <igorsantos07@gmail.com>
Date: Sat, 12 Sep 2009 02:04:56 +0000
Subject: Re: [lm-sensors] Problems with DG45ID sensors
Message-Id: <11d69f10909111904t79e31d95td2d161ad7a0ee19b@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2863942361698349135=="
List-Id: <lm-sensors.vger.kernel.org>
References: <11d69f10909101520u10eae0bfhe137338e336e186c@mail.gmail.com>
In-Reply-To: <11d69f10909101520u10eae0bfhe137338e336e186c@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============2863942361698349135==
Content-Type: multipart/alternative; boundary=000feaefba53f47cb3047357dbd6

--000feaefba53f47cb3047357dbd6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Someone told me to use lm83 instead of lm85. I tried. Now sensors simply
doesn't show any info about my motherboard sensors hahaha
Take back lm85 to /proc/modules... but before, downloaded the new
sensors-detect and ran:

# sensors-detect revision 5760 (2009-07-24 15:52:28 +0200)
> # Board: Intel Corporation DG45ID
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> Some south bridges, CPUs or memory controllers contain embedded sensors.
> Do you want to scan for them? This is totally safe. (YES/no):
> Silicon Integrated Systems SIS5595... No
> VIA VT82C686 Integrated Sensors... No
> VIA VT8231 Integrated Sensors... No
> AMD K8 thermal sensors... No
> AMD K10 thermal sensors... No
> Intel Core family thermal sensor... Success!
> (driver `coretemp')
> Intel AMB FB-DIMM thermal sensor... No
> VIA C7 thermal and voltage sensors... No
>
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'... Yes
> Found `Nuvoton WPCD377I Super IO'
> (no hardware monitoring capabilities)
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'... No
> Trying family `SMSC'... No
> Trying family `VIA/Winbond/Fintek'... No
> Trying family `ITE'... No
>
> Some systems (mainly servers) implement IPMI, a set of common interfaces
> through which system health data may be retrieved, amongst other things.
> We first try to get the information from SMBIOS. If we don't find it
> there, we have to read from arbitrary I/O ports to probe for such
> interfaces. This is normally safe. Do you want to scan for IPMI
> interfaces? (YES/no):
> Probing for `IPMI BMC KCS' at 0xca0... No
> Probing for `IPMI BMC SMIC' at 0xca8... No
>
> Some hardware monitoring chips are accessible through the ISA I/O ports.
> We have to write to arbitrary I/O ports to probe them. This is usually
> safe though. Yes, you do have ISA I/O ports even if you do not have any
> ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
> Probing for `National Semiconductor LM78' at 0x290... No
> Probing for `National Semiconductor LM79' at 0x290... No
> Probing for `Winbond W83781D' at 0x290... No
> Probing for `Winbond W83782D' at 0x290... No
>
> Lastly, we can probe the I2C/SMBus adapters for connected hardware
> monitoring devices. This is the most risky part, and while it works
> reasonably well on most systems, it has been reported to cause trouble
> on some systems.
> Do you want to probe the I2C/SMBus adapters now? (YES/no):
> Using driver `i2c-i801' for device 0000:00:1f.3: Intel ICH10
> Module i2c-dev loaded successfully.
>
> Next adapter: SMBus I801 adapter at e000 (i2c-0)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x2e
> Probing for `Myson MTP008'... No
> Probing for `National Semiconductor LM78'... No
> Probing for `National Semiconductor LM79'... No
> Probing for `National Semiconductor LM80'... No
> *Probing for `National Semiconductor LM85'... No*
> Probing for `National Semiconductor LM96000 or PC8374L'... No
> Probing for `Analog Devices ADM1027'... No
> Probing for `Analog Devices ADT7460 or ADT7463'... No
> Probing for `SMSC EMC6D100 or EMC6D101'... No
> Probing for `SMSC EMC6D102'... No
> Probing for `SMSC EMC6D103'... No
> Probing for `Winbond WPCD377I'... Yes
> (confidence 7, not a hardware monitoring chip)
> Probing for `Analog Devices ADT7467 or ADT7468'... No
> Probing for `Analog Devices ADT7470'... No
> Probing for `Analog Devices ADT7473'... No
> Probing for `Analog Devices ADT7475'... No
> Probing for `Analog Devices ADT7476'... No
> Probing for `Andigilog aSC7611'... No
> Probing for `Andigilog aSC7621'... No
> Probing for `National Semiconductor LM87'... No
> Probing for `Analog Devices ADM1024'... No
> Probing for `National Semiconductor LM93'... No
> Probing for `Winbond W83781D'... No
> Probing for `Winbond W83782D'... No
> Probing for `Winbond W83791D'... No
> Probing for `Winbond W83792D'... No
> Probing for `Winbond W83793R/G'... No
> Probing for `Nuvoton W83795G/ADG'... No
> Probing for `Winbond W83627HF'... No
> Probing for `Winbond W83627EHF'... No
> Probing for `Winbond W83627DHG'... No
> Probing for `Asus AS99127F (rev.1)'... No
> Probing for `Asus AS99127F (rev.2)'... No
> Probing for `Asus ASB100 Bach'... No
> Probing for `Winbond W83L786NR/NG/R/G'... No
> Probing for `Winbond W83L785TS-S'... No
> Probing for `Analog Devices ADM9240'... No
> Probing for `Dallas Semiconductor DS1780'... No
> Probing for `National Semiconductor LM81'... No
> Probing for `Analog Devices ADM1026'... No
> Probing for `Analog Devices ADM1025'... No
> Probing for `Analog Devices ADM1029'... No
> Probing for `Analog Devices ADM1030'... No
> Probing for `Analog Devices ADM1031'... No
> Probing for `Analog Devices ADM1022'... No
> Probing for `Texas Instruments THMC50'... No
> Probing for `Analog Devices ADM1028'... No
> Probing for `Texas Instruments THMC51'... No
> Probing for `ITE IT8712F'... No
> Probing for `SMSC DME1737'... No
> Probing for `SMSC SCH5027D-NW'... No
> Probing for `Fintek F75373S/SG'... No
> Probing for `Fintek F75375S/SP'... No
> Probing for `Fintek F75387SG/RG'... No
> Probing for `Winbond W83791SD'... No
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'... No
> Probing for `Analog Devices ADM1034'... No
> Probing for `SPD EEPROM'... Yes
> (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'... No
>
> Next adapter: NVIDIA i2c adapter (i2c-1)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'... No
> Probing for `Analog Devices ADM1034'... No
> Probing for `SPD EEPROM'... No
> Probing for `EDID EEPROM'... Yes
> (confidence 8, not a hardware monitoring chip)
>
> Next adapter: NVIDIA i2c adapter (i2c-2)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'... No
> Probing for `Analog Devices ADM1034'... No
> Probing for `SPD EEPROM'... No
> Probing for `EDID EEPROM'... Yes
> (confidence 8, not a hardware monitoring chip)
>
> Next adapter: NVIDIA i2c adapter (i2c-3)
> Do you want to scan it? (YES/no/selectively):
>
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>
> Driver `coretemp':
> * Chip `Intel Core family thermal sensor' (confidence: 9)
>
> Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
> Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors
> for initialization at boot time.
> You should now start the lm_sensors service to load the required
> kernel modules.
>
> Unloading i2c-dev... OK
>

I tried running the */etc/init.d/lm-sensors* (there's no underline, its an
hyphen). Same results, sensors was just showing my CPU temps.
I'll try to restart and send another mail with any result.

I've read the bug report you linked me after the part where someone talks
about my motherboard. Looks like they did some research and just ended on a=
n
empty point.

Everything that's possible I'll try to help you all.

Anything else I can do? I really wanna see this working and to collaborate
with this =3D]


Thank you,

Igor Santos
  Programador Web


On Fri, Sep 11, 2009 at 03:56, Jean Delvare <khali@linux-fr.org> wrote:

> On Thu, 10 Sep 2009 19:20:55 -0300, Igor Santos wrote:
> > Hello,
> >
> > I've been asking for help at superuser.com, but nobody could help me.
> > I've tried the last version of sensors-detect script, but it just gives
> me
> > the same modules to load up...
> >
> > This is my computer:
> > Intel Core2duo e4700
> > Motherboard Intel DG45ID
> > GeForce 9800 GT
> > 2 HD's, one SATA and one PATA with adapter
> >
> > It tolds me to load i2c-i801, lm85 and coretemp modules. And so I did.
> >
> > I can see properly my Videocard temp (I think it's provided by nvidia,
> > right?) and both HD (but sometimes the IDE disk simply goes 0=B0). My C=
PU
> > temps looks correct too.
> >
> > But all the temps from my motherboard are zeroed.
> > Take a look at the full output:
> >
> > igoru[~]$ sensors
> > > lm85-i2c-0-2e
> > > Adapter: SMBus I801 adapter at e000
> > > V1.5: +0.00 V (min =3D +0.00 V, max =3D +3.32 V)
> > > VCore: +0.00 V (min =3D +0.00 V, max =3D +2.99 V)
> > > V3.3: +0.00 V (min =3D +0.00 V, max =3D +4.38 V)
> > > V5: +0.00 V (min =3D +0.00 V, max =3D +6.64 V)
> > > V12: +0.00 V (min =3D +0.00 V, max =3D +15.94 V)
> > > CPU_Fan: 0 RPM (min =3D 0 RPM) ALARM
> > > fan2: 0 RPM (min =3D 0 RPM) ALARM
> > > fan3: 0 RPM (min =3D 0 RPM) ALARM
> > > fan4: 0 RPM (min =3D 0 RPM) ALARM
> > > CPU Temp: +0.0=B0C (low =3D -127.0=B0C, high =3D +127.0=B0C)
> > > Board Temp: +0.0=B0C (low =3D -127.0=B0C, high =3D +127.0=B0C)
> > > Remote Temp: +0.0=B0C (low =3D -127.0=B0C, high =3D +127.0=B0C)
> > > cpu0_vid: +2.050 V
>
> Looks very similar to:
> http://www.lm-sensors.org/ticket/2182
>
> Please post the output of the latest version of sensors-detect:
> http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
>
> Don't forget to "rmmod lm85" before you run sensors-detect.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

--000feaefba53f47cb3047357dbd6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Someone told me to use lm83 instead of lm85. I tried. Now sensors simp=
ly doesn&#39;t show any info about my motherboard sensors hahaha<br clear=
=3D"all"></div><div>Take back lm85 to /proc/modules... but before, download=
ed the new sensors-detect and ran:</div>
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex;"># sensors-detect revision 57=
60 (2009-07-24 15:52:28 +0200)<br># Board: Intel Corporation DG45ID<br><br>
This program will help you determine which kernel modules you need<br>to lo=
ad to use lm_sensors most effectively. It is generally safe<br>and recommen=
ded to accept the default answers to all questions,<br>unless you know what=
 you&#39;re doing.<br>
<br>Some south bridges, CPUs or memory controllers contain embedded sensors=
.<br>Do you want to scan for them? This is totally safe. (YES/no): <br>Sili=
con Integrated Systems SIS5595...                       No<br>VIA VT82C686 =
Integrated Sensors...                          No<br>
VIA VT8231 Integrated Sensors...                            No<br>AMD K8 th=
ermal sensors...                                   No<br>AMD K10 thermal se=
nsors...                                  No<br>Intel Core family thermal s=
ensor...                         Success!<br>
    (driver `coretemp&#39;)<br>Intel AMB FB-DIMM thermal sensor...         =
                No<br>VIA C7 thermal and voltage sensors...                =
       No<br><br>Some Super I/O chips contain embedded sensors. We have to =
write to<br>
standard I/O ports to probe them. This is usually safe.<br>Do you want to s=
can for Super I/O sensors? (YES/no): <br>Probing for Super-I/O at 0x2e/0x2f=
<br>Trying family `National Semiconductor&#39;...                   Yes<br>
Found `Nuvoton WPCD377I Super IO&#39;                           <br>    (no=
 hardware monitoring capabilities)<br>Probing for Super-I/O at 0x4e/0x4f<br=
>Trying family `National Semiconductor&#39;...                   No<br>
Trying family `SMSC&#39;...                                     No<br>Tryin=
g family `VIA/Winbond/Fintek&#39;...                       No<br>Trying fam=
ily `ITE&#39;...                                      No<br><br>Some system=
s (mainly servers) implement IPMI, a set of common interfaces<br>
through which system health data may be retrieved, amongst other things.<br=
>We first try to get the information from SMBIOS. If we don&#39;t find it<b=
r>there, we have to read from arbitrary I/O ports to probe for such<br>
interfaces. This is normally safe. Do you want to scan for IPMI<br>interfac=
es? (YES/no): <br>Probing for `IPMI BMC KCS&#39; at 0xca0...               =
       No<br>Probing for `IPMI BMC SMIC&#39; at 0xca8...                   =
  No<br>
<br>Some hardware monitoring chips are accessible through the ISA I/O ports=
.<br>We have to write to arbitrary I/O ports to probe them. This is usually=
<br>safe though. Yes, you do have ISA I/O ports even if you do not have any=
<br>
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): <br>Probing for=
 `National Semiconductor LM78&#39; at 0x290...       No<br>Probing for `Nat=
ional Semiconductor LM79&#39; at 0x290...       No<br>Probing for `Winbond =
W83781D&#39; at 0x290...                   No<br>
Probing for `Winbond W83782D&#39; at 0x290...                   No<br><br>L=
astly, we can probe the I2C/SMBus adapters for connected hardware<br>monito=
ring devices. This is the most risky part, and while it works<br>reasonably=
 well on most systems, it has been reported to cause trouble<br>
on some systems.<br>Do you want to probe the I2C/SMBus adapters now? (YES/n=
o): <br>Using driver `i2c-i801&#39; for device 0000:00:1f.3: Intel ICH10<br=
>Module i2c-dev loaded successfully.<br><br>Next adapter: SMBus I801 adapte=
r at e000 (i2c-0)<br>
Do you want to scan it? (YES/no/selectively): <br>Client found at address 0=
x2e<br>Probing for `Myson MTP008&#39;...                               No<b=
r>Probing for `National Semiconductor LM78&#39;...                No<br>
Probing for `National Semiconductor LM79&#39;...                No<br>Probi=
ng for `National Semiconductor LM80&#39;...                No<br><strong>Pr=
obing for `National Semiconductor LM85&#39;...                No</strong><b=
r>
Probing for `National Semiconductor LM96000 or PC8374L&#39;...  No<br>Probi=
ng for `Analog Devices ADM1027&#39;...                     No<br>Probing fo=
r `Analog Devices ADT7460 or ADT7463&#39;...          No<br>Probing for `SM=
SC EMC6D100 or EMC6D101&#39;...                  No<br>
Probing for `SMSC EMC6D102&#39;...                              No<br>Probi=
ng for `SMSC EMC6D103&#39;...                              No<br>Probing fo=
r `Winbond WPCD377I&#39;...                           Yes<br>    (confidenc=
e 7, not a hardware monitoring chip)<br>
Probing for `Analog Devices ADT7467 or ADT7468&#39;...          No<br>Probi=
ng for `Analog Devices ADT7470&#39;...                     No<br>Probing fo=
r `Analog Devices ADT7473&#39;...                     No<br>Probing for `An=
alog Devices ADT7475&#39;...                     No<br>
Probing for `Analog Devices ADT7476&#39;...                     No<br>Probi=
ng for `Andigilog aSC7611&#39;...                          No<br>Probing fo=
r `Andigilog aSC7621&#39;...                          No<br>Probing for `Na=
tional Semiconductor LM87&#39;...                No<br>
Probing for `Analog Devices ADM1024&#39;...                     No<br>Probi=
ng for `National Semiconductor LM93&#39;...                No<br>Probing fo=
r `Winbond W83781D&#39;...                            No<br>Probing for `Wi=
nbond W83782D&#39;...                            No<br>
Probing for `Winbond W83791D&#39;...                            No<br>Probi=
ng for `Winbond W83792D&#39;...                            No<br>Probing fo=
r `Winbond W83793R/G&#39;...                          No<br>Probing for `Nu=
voton W83795G/ADG&#39;...                        No<br>
Probing for `Winbond W83627HF&#39;...                           No<br>Probi=
ng for `Winbond W83627EHF&#39;...                          No<br>Probing fo=
r `Winbond W83627DHG&#39;...                          No<br>Probing for `As=
us AS99127F (rev.1)&#39;...                      No<br>
Probing for `Asus AS99127F (rev.2)&#39;...                      No<br>Probi=
ng for `Asus ASB100 Bach&#39;...                           No<br>Probing fo=
r `Winbond W83L786NR/NG/R/G&#39;...                   No<br>Probing for `Wi=
nbond W83L785TS-S&#39;...                        No<br>
Probing for `Analog Devices ADM9240&#39;...                     No<br>Probi=
ng for `Dallas Semiconductor DS1780&#39;...                No<br>Probing fo=
r `National Semiconductor LM81&#39;...                No<br>Probing for `An=
alog Devices ADM1026&#39;...                     No<br>
Probing for `Analog Devices ADM1025&#39;...                     No<br>Probi=
ng for `Analog Devices ADM1029&#39;...                     No<br>Probing fo=
r `Analog Devices ADM1030&#39;...                     No<br>Probing for `An=
alog Devices ADM1031&#39;...                     No<br>
Probing for `Analog Devices ADM1022&#39;...                     No<br>Probi=
ng for `Texas Instruments THMC50&#39;...                   No<br>Probing fo=
r `Analog Devices ADM1028&#39;...                     No<br>Probing for `Te=
xas Instruments THMC51&#39;...                   No<br>
Probing for `ITE IT8712F&#39;...                                No<br>Probi=
ng for `SMSC DME1737&#39;...                               No<br>Probing fo=
r `SMSC SCH5027D-NW&#39;...                           No<br>Probing for `Fi=
ntek F75373S/SG&#39;...                          No<br>
Probing for `Fintek F75375S/SP&#39;...                          No<br>Probi=
ng for `Fintek F75387SG/RG&#39;...                         No<br>Probing fo=
r `Winbond W83791SD&#39;...                           No<br>Client found at=
 address 0x50<br>
Probing for `Analog Devices ADM1033&#39;...                     No<br>Probi=
ng for `Analog Devices ADM1034&#39;...                     No<br>Probing fo=
r `SPD EEPROM&#39;...                                 Yes<br>    (confidenc=
e 8, not a hardware monitoring chip)<br>
Probing for `EDID EEPROM&#39;...                                No<br><br>N=
ext adapter: NVIDIA i2c adapter  (i2c-1)<br>Do you want to scan it? (YES/no=
/selectively): <br>Client found at address 0x50<br>Probing for `Analog Devi=
ces ADM1033&#39;...                     No<br>
Probing for `Analog Devices ADM1034&#39;...                     No<br>Probi=
ng for `SPD EEPROM&#39;...                                 No<br>Probing fo=
r `EDID EEPROM&#39;...                                Yes<br>    (confidenc=
e 8, not a hardware monitoring chip)<br>
<br>Next adapter: NVIDIA i2c adapter  (i2c-2)<br>Do you want to scan it? (Y=
ES/no/selectively): <br>Client found at address 0x50<br>Probing for `Analog=
 Devices ADM1033&#39;...                     No<br>Probing for `Analog Devi=
ces ADM1034&#39;...                     No<br>
Probing for `SPD EEPROM&#39;...                                 No<br>Probi=
ng for `EDID EEPROM&#39;...                                Yes<br>    (conf=
idence 8, not a hardware monitoring chip)<br><br>Next adapter: NVIDIA i2c a=
dapter  (i2c-3)<br>
Do you want to scan it? (YES/no/selectively): <br><br>Now follows a summary=
 of the probes I have just done.<br>Just press ENTER to continue: <br><br>D=
river `coretemp&#39;:<br>  * Chip `Intel Core family thermal sensor&#39; (c=
onfidence: 9)<br>
<br>Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): <br>Copy =
prog/init/lm_sensors.init to /etc/init.d/lm_sensors<br>for initialization a=
t boot time.<br>You should now start the lm_sensors service to load the req=
uired<br>
kernel modules.<br><br>Unloading i2c-dev... OK<br></blockquote><div><br></d=
iv><div>I tried running the <strong>/etc/init.d/lm-sensors</strong> (there&=
#39;s no underline, its an hyphen). Same results, sensors was just showing =
my CPU temps.</div>
<div>I&#39;ll try to restart and send another mail with any result.</div><d=
iv><br></div><div>I&#39;ve read the bug report you linked me after the part=
 where someone talks about my motherboard. Looks like they did some researc=
h and just ended on an empty point.</div>
<div><br></div><div>Everything that&#39;s possible I&#39;ll try to help you=
 all.</div><div><br></div><div>Anything else I can do? I really wanna see t=
his working and to collaborate with this =3D]</div><div><br></div><div><br>
</div><div>Thank you,</div><div><br></div>Igor Santos<br> =A0 Programador W=
eb<br>
<br><br><div class=3D"gmail_quote">On Fri, Sep 11, 2009 at 03:56, Jean Delv=
are <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux=
-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div><div class=3D"h5">On Thu, 10 Sep 2009 19:20:55 -0300, Igor Santos wrot=
e:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I&#39;ve been asking for help at <a href=3D"http://superuser.com" targ=
et=3D"_blank">superuser.com</a>, but nobody could help me.<br>
&gt; I&#39;ve tried the last version of sensors-detect script, but it just =
gives me<br>
&gt; the same modules to load up...<br>
&gt;<br>
&gt; This is my computer:<br>
&gt; Intel Core2duo e4700<br>
&gt; Motherboard Intel DG45ID<br>
&gt; GeForce 9800 GT<br>
&gt; 2 HD&#39;s, one SATA and one PATA with adapter<br>
&gt;<br>
&gt; It tolds me to load i2c-i801, lm85 and coretemp modules. And so I did.=
<br>
&gt;<br>
&gt; I can see properly my Videocard temp (I think it&#39;s provided by nvi=
dia,<br>
&gt; right?) and both HD (but sometimes the IDE disk simply goes 0=B0). My =
CPU<br>
&gt; temps looks correct too.<br>
&gt;<br>
&gt; But all the temps from my motherboard are zeroed.<br>
&gt; Take a look at the full output:<br>
&gt;<br>
&gt; igoru[~]$ sensors<br>
&gt; &gt; lm85-i2c-0-2e<br>
&gt; &gt; Adapter: SMBus I801 adapter at e000<br>
&gt; &gt; V1.5: +0.00 V (min =3D +0.00 V, max =3D +3.32 V)<br>
&gt; &gt; VCore: +0.00 V (min =3D +0.00 V, max =3D +2.99 V)<br>
&gt; &gt; V3.3: +0.00 V (min =3D +0.00 V, max =3D +4.38 V)<br>
&gt; &gt; V5: +0.00 V (min =3D +0.00 V, max =3D +6.64 V)<br>
&gt; &gt; V12: +0.00 V (min =3D +0.00 V, max =3D +15.94 V)<br>
&gt; &gt; CPU_Fan: 0 RPM (min =3D 0 RPM) ALARM<br>
&gt; &gt; fan2: 0 RPM (min =3D 0 RPM) ALARM<br>
&gt; &gt; fan3: 0 RPM (min =3D 0 RPM) ALARM<br>
&gt; &gt; fan4: 0 RPM (min =3D 0 RPM) ALARM<br>
&gt; &gt; CPU Temp: +0.0=B0C (low =3D -127.0=B0C, high =3D +127.0=B0C)<br>
&gt; &gt; Board Temp: +0.0=B0C (low =3D -127.0=B0C, high =3D +127.0=B0C)<br=
>
&gt; &gt; Remote Temp: +0.0=B0C (low =3D -127.0=B0C, high =3D +127.0=B0C)<b=
r>
&gt; &gt; cpu0_vid: +2.050 V<br>
<br>
</div></div>Looks very similar to:<br>
<a href=3D"http://www.lm-sensors.org/ticket/2182" target=3D"_blank">http://=
www.lm-sensors.org/ticket/2182</a><br>
<br>
Please post the output of the latest version of sensors-detect:<br>
<a href=3D"http://dl.lm-sensors.org/lm-sensors/files/sensors-detect" target=
=3D"_blank">http://dl.lm-sensors.org/lm-sensors/files/sensors-detect</a><br=
>
<br>
Don&#39;t forget to &quot;rmmod lm85&quot; before you run sensors-detect.<b=
r>
<font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
<a href=3D"http://khali.linux-fr.org/wishlist.html" target=3D"_blank">http:=
//khali.linux-fr.org/wishlist.html</a><br>
</font></blockquote></div><br>

--000feaefba53f47cb3047357dbd6--


--===============2863942361698349135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2863942361698349135==--
