From: Kushal Koolwal <kushalkoolwal@hotmail.com>
Date: Thu, 23 Aug 2007 21:23:25 +0000
Subject: Re: [lm-sensors] AMD Geode LX(CS5536) - SMSC SCH3114 Temperature
Message-Id: <BAY107-W10525F08C87AF8FAF25832BAD60@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0261523617135004363=="
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY107-W421FB9A83ADA7ED4C6D32BAD60@phx.gbl>
In-Reply-To: <BAY107-W421FB9A83ADA7ED4C6D32BAD60@phx.gbl>
To: lm-sensors@vger.kernel.org

--===============0261523617135004363==
Content-Type: multipart/alternative;
	boundary="_38d89a84-b4c4-4f8d-8f46-ea5c4eedb1d9_"

--_38d89a84-b4c4-4f8d-8f46-ea5c4eedb1d9_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Thanks for your reply.

So that means I will have to get the kernel source for 2.6.22-5 from kernel=
.org and then apply those 3 patches mentioned at:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020605.html
and compile the dme1737 driver?

Is there any chances that those patches might work with 2.6.18/2.6.20 kerne=
l? If not, is there any way to back port them?

Thanks

Kushal Koolwal

> Date: Thu, 23 Aug 2007 14:18:07 -0700
> From: juergh@gmail.com
> To: kushalkoolwal@hotmail.com
> Subject: Re: [lm-sensors] AMD Geode LX(CS5536) - SMSC SCH3114 Temperature=
 mon. driver
> CC: lm-sensors@lm-sensors.org
>=20
> Hi Kushal,
>=20
>=20
> >
> > Hello,
> > I have a AMD Geode LX processor board (CS5536 companion chipset) with S=
MSC SCH3114 Super I/O Chip. I was looking to enable lm-sensors on it but di=
d'nt know where to start. I looked at the web page: http://www.lm-sensors.o=
rg/wiki/Devices and found two matching things:
> > ***********************************************************************=
********************
> > AMD      Geode CS5535, CS5536    yes     scx200_acb      -       2.6.17=
          Companion chips.
> > and
> > SMSC     SCH3112, SCH3114, SCH3116       yes  (2007-07-24) Updated dme1=
737 driver available: patch 1/3, patch 2/3, and patch 3/3.
> > ***********************************************************************=
********************
> >
> > Now I am not sure which device I should look for. I tried sensors-detec=
t but it just ended loading eeprom module and said that it is not really a =
hardware monitoring ship.
>=20
> You need both. The scx200_acb is your I2C bus driver and the patched
> DME1737 is the HW monitor chip driver. You also need the latest
> version of the lm-sensors package which will correctly identify the
> sch3114.
>=20
> Get the latest kernel source, apply the patches mentioned on the
> wiki/devices page (for the sch3114) and compile the dme1737 driver
> against your running kernel.
>=20
> ...juerg
>=20
>=20
>=20
> > Here are my system specs:
> > Debian etch (stable), 2.6.18 Kernel
> > javascript:onSubmitToolbarItemClicked('SendMessage','SendMessageLight.a=
spx?_ec=3D1&n=3D1566811031');
> > Send
> > I am attaching my sensors-detect output with this mail. Please let me k=
now if you need more details.
> >
> > Also I just verified that the temperature monitoring sensors are on SMS=
C SCH3114 Super I/O Chip. Which drivers should I use?
> >
> > Thanks
> >
> > KK
> >
> > _________________________________________________________________
> > Invite your mail contacts to join your friends list with Windows Live S=
paces. It's easy!
> > http://spaces.live.com/spacesapi.aspx?wx_action=3Dcreate&wx_url=3D/frie=
nds.aspx&mkt=3Den-us
> >
> > ---------- Forwarded message ----------
> > From:
> > To:
> > Date:
> > Subject:
> > This program will help you determine which kernel modules you need
> > to load to use lm_sensors most effectively. It is generally safe
> > and recommended to accept the default answers to all questions,
> > unless you know what you're doing.
> >
> > We can start with probing for (PCI) I2C or SMBus adapters.
> > Do you want to probe now? (YES/no): YES
> > Probing for PCI bus adapters...
> > Use driver `scx200_acb' for device 0000:00:0f.0: CS5536 [Geode companio=
n] ISA
> >
> > We will now try to load each adapter module in turn.
> > Load `scx200_acb' (say NO if built into your kernel)? (YES/no): YES
> > Module loaded successfully.
> > If you have undetectable or unsupported adapters, you can have them
> > scanned by manually loading the modules before running this script.
> >
> > To continue, we need module `i2c-dev' to be loaded.
> > Do you want to load `i2c-dev' now? (YES/no): YES
> > Module loaded successfully.
> >
> > We are now going to do the I2C/SMBus adapter probings. Some chips may
> > be double detected; we choose the one with the highest confidence
> > value in that case.
> > If you found that the adapter hung after probing a certain address,
> > you can specify that address to remain unprobed.
> >
> > Next adapter: CS5536 ACB0
> > Do you want to scan it? (YES/no/selectively): YES
> > Client found at address 0x30
> > Client found at address 0x50
> > Handled by driver `eeprom' (already loaded), chip type `eeprom'
> >
> > Some chips are also accessible through the ISA I/O ports. We have to
> > write to arbitrary I/O ports to probe them. This is usually safe though=
.
> > Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> > Do you want to scan the ISA I/O ports? (YES/no): YES
> > Probing for `National Semiconductor LM78' at 0x290...       No
> > Probing for `National Semiconductor LM78-J' at 0x290...     No
> > Probing for `National Semiconductor LM79' at 0x290...       No
> > Probing for `Winbond W83781D' at 0x290...                   No
> > Probing for `Winbond W83782D' at 0x290...                   No
> > Probing for `Winbond W83627HF' at 0x290...                  No
> > Probing for `Silicon Integrated Systems SIS5595'...         No
> > Probing for `VIA VT82C686 Integrated Sensors'...            No
> > Probing for `VIA VT8231 Integrated Sensors'...              No
> > Probing for `AMD K8 thermal sensors'...                     No
> > Probing for `IPMI BMC KCS' at 0xca0...                      No
> > Probing for `IPMI BMC SMIC' at 0xca8...                     No
> >
> > Some Super I/O chips may also contain sensors. We have to write to
> > standard I/O ports to probe them. This is usually safe.
> > Do you want to scan for Super I/O sensors? (YES/no): YES
> > Probing for Super-I/O at 0x2e/0x2f
> > Trying family `ITE'...                                      Yes
> > Found unknown chip with ID 0x7d02
> > Trying family `National Semiconductor'...                   No
> > Trying family `SMSC'...                                     Yes
> > Found unknown chip with ID 0x7d02
> > Trying family `VIA/Winbond/Fintek'...                       No
> > Probing for Super-I/O at 0x4e/0x4f
> > Trying family `ITE'...                                      No
> > Trying family `National Semiconductor'...                   No
> > Trying family `SMSC'...                                     No
> > Trying family `VIA/Winbond/Fintek'...                       No
> >
> > Now follows a summary of the probes I have just done.
> > Just press ENTER to continue:
> >
> > Driver `eeprom' (should be inserted):
> >   Detects correctly:
> >   * Bus `CS5536 ACB0'
> >     Busdriver `UNKNOWN', I2C address 0x50
> >     Chip `eeprom' (confidence: 6)
> >
> >   EEPROMs are *NOT* sensors! They are data storage chips commonly
> >   found on memory modules (SPD), in monitors (EDID), or in some
> >   laptops, for example.
> >
> > I will now generate the commands needed to load the required modules.
> > Just press ENTER to continue:
> >
> > To make the sensors modules behave correctly, add these lines to
> > /etc/modules:
> >
> > #----cut here----
> > # I2C adapter drivers
> > # modprobe unknown adapter CS5536 ACB0
> > # Chip drivers
> > eeprom
> > #----cut here----
> >
> >
> > Do you want to add these lines to /etc/modules automatically? (yes/NO)n=
o
> > debian:~# sensors
> > No sensors found!
> > Make sure you loaded all the kernel drivers you need.
> > Try sensors-detect to find out which these are.
> > debian:~#
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >

_________________________________________________________________
News, entertainment and everything you care about at Live.com. Get it now!
http://www.live.com/getstarted.aspx=

--_38d89a84-b4c4-4f8d-8f46-ea5c4eedb1d9_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>
Thanks for your reply.<br><br>So that means I will have to get the kernel s=
ource for 2.6.22-5 from kernel.org and then apply those 3 patches mentioned=
 at:<br>http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020605.h=
tml<br>and compile the dme1737 driver?<br><br>Is there any chances that tho=
se patches might work with 2.6.18/2.6.20 kernel? If not, is there any way t=
o back port them?<br><br>Thanks<br><br>Kushal Koolwal<br><br>&gt; Date: Thu=
, 23 Aug 2007 14:18:07 -0700<br>&gt; From: juergh@gmail.com<br>&gt; To: kus=
halkoolwal@hotmail.com<br>&gt; Subject: Re: [lm-sensors] AMD Geode LX(CS553=
6) - SMSC SCH3114 Temperature mon. driver<br>&gt; CC: lm-sensors@lm-sensors=
.org<br>&gt; <br>&gt; Hi Kushal,<br>&gt; <br>&gt; <br>&gt; &gt;<br>&gt; &gt=
; Hello,<br>&gt; &gt; I have a AMD Geode LX processor board (CS5536 compani=
on chipset) with SMSC SCH3114 Super I/O Chip. I was looking to enable lm-se=
nsors on it but did'nt know where to start. I looked at the web page: http:=
//www.lm-sensors.org/wiki/Devices and found two matching things:<br>&gt; &g=
t; ************************************************************************=
*******************<br>&gt; &gt; AMD      Geode CS5535, CS5536    yes     s=
cx200_acb      -       2.6.17          Companion chips.<br>&gt; &gt; and<br=
>&gt; &gt; SMSC     SCH3112, SCH3114, SCH3116       yes  (2007-07-24) Updat=
ed dme1737 driver available: patch 1/3, patch 2/3, and patch 3/3.<br>&gt; &=
gt; ***********************************************************************=
********************<br>&gt; &gt;<br>&gt; &gt; Now I am not sure which devi=
ce I should look for. I tried sensors-detect but it just ended loading eepr=
om module and said that it is not really a hardware monitoring ship.<br>&gt=
; <br>&gt; You need both. The scx200_acb is your I2C bus driver and the pat=
ched<br>&gt; DME1737 is the HW monitor chip driver. You also need the lates=
t<br>&gt; version of the lm-sensors package which will correctly identify t=
he<br>&gt; sch3114.<br>&gt; <br>&gt; Get the latest kernel source, apply th=
e patches mentioned on the<br>&gt; wiki/devices page (for the sch3114) and =
compile the dme1737 driver<br>&gt; against your running kernel.<br>&gt; <br=
>&gt; ...juerg<br>&gt; <br>&gt; <br>&gt; <br>&gt; &gt; Here are my system s=
pecs:<br>&gt; &gt; Debian etch (stable), 2.6.18 Kernel<br>&gt; &gt; javascr=
ipt:onSubmitToolbarItemClicked('SendMessage','SendMessageLight.aspx?_ec=3D1=
&amp;n=3D1566811031');<br>&gt; &gt; Send<br>&gt; &gt; I am attaching my sen=
sors-detect output with this mail. Please let me know if you need more deta=
ils.<br>&gt; &gt;<br>&gt; &gt; Also I just verified that the temperature mo=
nitoring sensors are on SMSC SCH3114 Super I/O Chip. Which drivers should I=
 use?<br>&gt; &gt;<br>&gt; &gt; Thanks<br>&gt; &gt;<br>&gt; &gt; KK<br>&gt;=
 &gt;<br>&gt; &gt; ________________________________________________________=
_________<br>&gt; &gt; Invite your mail contacts to join your friends list =
with Windows Live Spaces. It's easy!<br>&gt; &gt; http://spaces.live.com/sp=
acesapi.aspx?wx_action=3Dcreate&amp;wx_url=3D/friends.aspx&amp;mkt=3Den-us<=
br>&gt; &gt;<br>&gt; &gt; ---------- Forwarded message ----------<br>&gt; &=
gt; From:<br>&gt; &gt; To:<br>&gt; &gt; Date:<br>&gt; &gt; Subject:<br>&gt;=
 &gt; This program will help you determine which kernel modules you need<br=
>&gt; &gt; to load to use lm_sensors most effectively. It is generally safe=
<br>&gt; &gt; and recommended to accept the default answers to all question=
s,<br>&gt; &gt; unless you know what you're doing.<br>&gt; &gt;<br>&gt; &gt=
; We can start with probing for (PCI) I2C or SMBus adapters.<br>&gt; &gt; D=
o you want to probe now? (YES/no): YES<br>&gt; &gt; Probing for PCI bus ada=
pters...<br>&gt; &gt; Use driver `scx200_acb' for device 0000:00:0f.0: CS55=
36 [Geode companion] ISA<br>&gt; &gt;<br>&gt; &gt; We will now try to load =
each adapter module in turn.<br>&gt; &gt; Load `scx200_acb' (say NO if buil=
t into your kernel)? (YES/no): YES<br>&gt; &gt; Module loaded successfully.=
<br>&gt; &gt; If you have undetectable or unsupported adapters, you can hav=
e them<br>&gt; &gt; scanned by manually loading the modules before running =
this script.<br>&gt; &gt;<br>&gt; &gt; To continue, we need module `i2c-dev=
' to be loaded.<br>&gt; &gt; Do you want to load `i2c-dev' now? (YES/no): Y=
ES<br>&gt; &gt; Module loaded successfully.<br>&gt; &gt;<br>&gt; &gt; We ar=
e now going to do the I2C/SMBus adapter probings. Some chips may<br>&gt; &g=
t; be double detected; we choose the one with the highest confidence<br>&gt=
; &gt; value in that case.<br>&gt; &gt; If you found that the adapter hung =
after probing a certain address,<br>&gt; &gt; you can specify that address =
to remain unprobed.<br>&gt; &gt;<br>&gt; &gt; Next adapter: CS5536 ACB0<br>=
&gt; &gt; Do you want to scan it? (YES/no/selectively): YES<br>&gt; &gt; Cl=
ient found at address 0x30<br>&gt; &gt; Client found at address 0x50<br>&gt=
; &gt; Handled by driver `eeprom' (already loaded), chip type `eeprom'<br>&=
gt; &gt;<br>&gt; &gt; Some chips are also accessible through the ISA I/O po=
rts. We have to<br>&gt; &gt; write to arbitrary I/O ports to probe them. Th=
is is usually safe though.<br>&gt; &gt; Yes, you do have ISA I/O ports even=
 if you do not have any ISA slots!<br>&gt; &gt; Do you want to scan the ISA=
 I/O ports? (YES/no): YES<br>&gt; &gt; Probing for `National Semiconductor =
LM78' at 0x290...       No<br>&gt; &gt; Probing for `National Semiconductor=
 LM78-J' at 0x290...     No<br>&gt; &gt; Probing for `National Semiconducto=
r LM79' at 0x290...       No<br>&gt; &gt; Probing for `Winbond W83781D' at =
0x290...                   No<br>&gt; &gt; Probing for `Winbond W83782D' at=
 0x290...                   No<br>&gt; &gt; Probing for `Winbond W83627HF' =
at 0x290...                  No<br>&gt; &gt; Probing for `Silicon Integrate=
d Systems SIS5595'...         No<br>&gt; &gt; Probing for `VIA VT82C686 Int=
egrated Sensors'...            No<br>&gt; &gt; Probing for `VIA VT8231 Inte=
grated Sensors'...              No<br>&gt; &gt; Probing for `AMD K8 thermal=
 sensors'...                     No<br>&gt; &gt; Probing for `IPMI BMC KCS'=
 at 0xca0...                      No<br>&gt; &gt; Probing for `IPMI BMC SMI=
C' at 0xca8...                     No<br>&gt; &gt;<br>&gt; &gt; Some Super =
I/O chips may also contain sensors. We have to write to<br>&gt; &gt; standa=
rd I/O ports to probe them. This is usually safe.<br>&gt; &gt; Do you want =
to scan for Super I/O sensors? (YES/no): YES<br>&gt; &gt; Probing for Super=
-I/O at 0x2e/0x2f<br>&gt; &gt; Trying family `ITE'...                      =
                Yes<br>&gt; &gt; Found unknown chip with ID 0x7d02<br>&gt; =
&gt; Trying family `National Semiconductor'...                   No<br>&gt;=
 &gt; Trying family `SMSC'...                                     Yes<br>&g=
t; &gt; Found unknown chip with ID 0x7d02<br>&gt; &gt; Trying family `VIA/W=
inbond/Fintek'...                       No<br>&gt; &gt; Probing for Super-I=
/O at 0x4e/0x4f<br>&gt; &gt; Trying family `ITE'...                        =
              No<br>&gt; &gt; Trying family `National Semiconductor'...    =
               No<br>&gt; &gt; Trying family `SMSC'...                     =
                No<br>&gt; &gt; Trying family `VIA/Winbond/Fintek'...      =
                 No<br>&gt; &gt;<br>&gt; &gt; Now follows a summary of the =
probes I have just done.<br>&gt; &gt; Just press ENTER to continue:<br>&gt;=
 &gt;<br>&gt; &gt; Driver `eeprom' (should be inserted):<br>&gt; &gt;   Det=
ects correctly:<br>&gt; &gt;   * Bus `CS5536 ACB0'<br>&gt; &gt;     Busdriv=
er `UNKNOWN', I2C address 0x50<br>&gt; &gt;     Chip `eeprom' (confidence: =
6)<br>&gt; &gt;<br>&gt; &gt;   EEPROMs are *NOT* sensors! They are data sto=
rage chips commonly<br>&gt; &gt;   found on memory modules (SPD), in monito=
rs (EDID), or in some<br>&gt; &gt;   laptops, for example.<br>&gt; &gt;<br>=
&gt; &gt; I will now generate the commands needed to load the required modu=
les.<br>&gt; &gt; Just press ENTER to continue:<br>&gt; &gt;<br>&gt; &gt; T=
o make the sensors modules behave correctly, add these lines to<br>&gt; &gt=
; /etc/modules:<br>&gt; &gt;<br>&gt; &gt; #----cut here----<br>&gt; &gt; # =
I2C adapter drivers<br>&gt; &gt; # modprobe unknown adapter CS5536 ACB0<br>=
&gt; &gt; # Chip drivers<br>&gt; &gt; eeprom<br>&gt; &gt; #----cut here----=
<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; Do you want to add these lines to /=
etc/modules automatically? (yes/NO)no<br>&gt; &gt; debian:~# sensors<br>&gt=
; &gt; No sensors found!<br>&gt; &gt; Make sure you loaded all the kernel d=
rivers you need.<br>&gt; &gt; Try sensors-detect to find out which these ar=
e.<br>&gt; &gt; debian:~#<br>&gt; &gt;<br>&gt; &gt; _______________________=
________________________<br>&gt; &gt; lm-sensors mailing list<br>&gt; &gt; =
lm-sensors@lm-sensors.org<br>&gt; &gt; http://lists.lm-sensors.org/mailman/=
listinfo/lm-sensors<br>&gt; &gt;<br><br /><hr />Get news, entertainment and=
 everything you care about at Live.com. <a href=3D'http://www.live.com/gets=
tarted.aspx ' target=3D'_new'>Check it out!</a></body>
</html>=

--_38d89a84-b4c4-4f8d-8f46-ea5c4eedb1d9_--


--===============0261523617135004363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0261523617135004363==--
