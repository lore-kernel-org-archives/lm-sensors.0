From: Lars Lindquist <lars4910@hotmail.com>
Date: Fri, 16 Oct 2009 18:35:07 +0000
Subject: Re: [lm-sensors] Sensors-dectect ,
Message-Id: <BAY123-W1901C966F44E3C542D0AB5CFC40@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8151320790893174573=="
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.00.0910160554380.2841@p34.internal.lan>
In-Reply-To: <alpine.DEB.2.00.0910160554380.2841@p34.internal.lan>
To: lm-sensors@vger.kernel.org

--===============8151320790893174573==
Content-Type: multipart/alternative;
	boundary="_65a772da-c6b9-4fa8-ad0c-79dd4d5cd8e4_"

--_65a772da-c6b9-4fa8-ad0c-79dd4d5cd8e4_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable







Hi  Justin=2C

I am quite new to this...
The only info I can get about the chipset is that it is a :=20

            Intel=AE P55 Express Chipset(motherboard)  Asus P7P55D


Do you know how I can get more information?

I have opened the chassi but there is big heatsink over the chipset so I ca=
n not see anything.



Below is output from lspci=2Clsmod=2C2cdetect (no output)=2Cuname
Output from uname:

Linux august 2.6.28-15-generic #52-Ubuntu SMP Wed Sep 9 10:49:34 UTC 2009 i=
686 GNU/Linux
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
The output from lspci is:


            0:00.0 Host bridge: Intel Corporation Clarksfield/Lynnfield DMI=
 (rev 11)
00:08.0 System peripheral: Intel Corporation Clarksfield/Lynnfield System M=
anagement Registers (rev 11)
00:08.1 System peripheral: Intel Corporation Clarksfield/Lynnfield Semaphor=
e and Scratchpad Registers (rev 11)
00:08.2 System peripheral: Intel Corporation Clarksfield/Lynnfield System C=
ontrol and Status Registers (rev 11)
00:08.3 System peripheral: Intel Corporation Clarksfield/Lynnfield Miscella=
neous Registers (rev 11)
00:10.0 System peripheral: Intel Corporation QPI Link (rev 11)
00:10.1 System peripheral: Intel Corporation QPI Routing and Protocol Regis=
ters (rev 11)
00:1a.0 USB Controller: Intel Corporation Ibex Peak USB2 Enhanced Host Cont=
roller (rev 05)
00:1b.0 Audio device: Intel Corporation Ibex Peak High Definition Audio (re=
v 05)
00:1c.0 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Port 1 (re=
v 05)
00:1c.4 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Port 5 (re=
v 05)
00:1c.5 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Port 6 (re=
v 05)
00:1c.6 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Port 7 (re=
v 05)
00:1c.7 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Port 8 (re=
v 05)
00:1d.0 USB Controller: Intel Corporation Ibex Peak USB2 Enhanced Host Cont=
roller (rev 05)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev a5)
00:1f.0 ISA bridge: Intel Corporation Ibex Peak LPC Interface Controller (r=
ev 05)
00:1f.2 IDE interface: Intel Corporation Ibex Peak 4 port SATA IDE Controll=
er (rev 05)
00:1f.3 SMBus: Intel Corporation Ibex Peak SMBus Controller (rev 05)
00:1f.5 IDE interface: Intel Corporation Ibex Peak 2 port SATA IDE Controll=
er (rev 05)
01:00.0 Ethernet controller: Realtek Semiconductor Co.=2C Ltd. RTL8111/8168=
B PCI Express Gigabit Ethernet controller (rev 03)
02:00.0 SATA controller: JMicron Technologies=2C Inc. JMicron 20360/20363 A=
HCI Controller (rev 03)
02:00.1 IDE interface: JMicron Technologies=2C Inc. JMicron 20360/20363 AHC=
I Controller (rev 03)
05:00.0 VGA compatible controller: ATI Technologies Inc RV770 [Radeon HD 48=
50]
05:00.1 Audio device: ATI Technologies Inc HD48x0 audio
06:04.0 FireWire (IEEE 1394): VIA Technologies=2C Inc. VT6306 Fire II IEEE =
1394 OHCI Link Layer Controller (rev c0)
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++

output from sensors-detect
# sensors-detect revision 5729 (2009-06-02 15:51:29 +0200)
# System: System manufacturer System Product Name
# Board: ASUSTeK Computer INC. P7P55D

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions=2C
unless you know what you're doing.

Some south bridges=2C CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): y
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal and voltage sensors...                       No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): =20
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found unknown chip with ID 0xb353
    (logical device B has address 0x290=2C could be sensors)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI=2C a set of common interfaces
through which system health data may be retrieved=2C amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there=2C we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):=20
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes=2C you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):=20
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly=2C we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part=2C and while it works
reasonably well on most systems=2C it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):=20
Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.
Sorry=2C no supported PCI bus adapters found.
Module i2c-dev loaded successfully.

Sorry=2C no sensors were detected.
Either your system has no sensors=2C or they are not supported=2C or
they are connected to an I2C or SMBus adapter that is not
supported. If you find out what chips are on your board=2C check
http://www.lm-sensors.org/wiki/Devices for driver status.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

the output from lsmod:

Module                  Size  Used by
i2c_dev                14600  0=20
binfmt_misc            16776  1=20
fglrx                1974216  34=20
agpgart                42696  1 fglrx
ppdev                  15620  0=20
bridge                 56212  0=20
stp                    10500  1 bridge
bnep                   20224  2=20
video                  25872  0=20
output                 11008  1 video
input_polldev          11912  0=20
lp                     17156  0=20
parport                42220  2 ppdev=2Clp
snd_hda_intel         435252  3=20
snd_pcm_oss            46336  0=20
snd_mixer_oss          22656  1 snd_pcm_oss
snd_pcm                83076  2 snd_hda_intel=2Csnd_pcm_oss
snd_seq_dummy          10756  0=20
snd_seq_oss            37760  0=20
snd_seq_midi           14336  0=20
snd_rawmidi            29696  1 snd_seq_midi
snd_seq_midi_event     15104  2 snd_seq_oss=2Csnd_seq_midi
snd_seq                56880  6 snd_seq_dummy=2Csnd_seq_oss=2Csnd_seq_midi=
=2Csnd_seq_midi_event
snd_timer              29704  2 snd_pcm=2Csnd_seq
snd_seq_device         14988  5 snd_seq_dummy=2Csnd_seq_oss=2Csnd_seq_midi=
=2Csnd_rawmidi=2Csnd_seq
snd                    62756  15 snd_hda_intel=2Csnd_pcm_oss=2Csnd_mixer_os=
s=2Csnd_pcm=2Csnd_seq_oss=2Csnd_rawmidi=2Csnd_seq=2Csnd_timer=2Csnd_seq_dev=
ice
soundcore              15200  1 snd
psmouse                61972  0=20
usbhid                 42336  0=20
snd_page_alloc         16904  2 snd_hda_intel=2Csnd_pcm
serio_raw              13444  0=20
pcspkr                 10496  0=20
ohci1394               38576  0=20
ieee1394               94660  1 ohci1394
r8169                  40836  0=20
mii                    13312  1 r8169
fbcon                  46112  0=20
tileblit               10752  1 fbcon
font                   16384  1 fbcon
bitblit                13824  1 fbcon
softcursor              9984  1 bitblit
+++++++++++++++++++++++++++++++++++++++++++++



> Date: Fri=2C 16 Oct 2009 05:54:58 -0400
> From: jpiszcz@lucidpixels.com
> To: lars4910@hotmail.com
> CC: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] Sensors-dectect =2C Ubuntu 9.04 intel p55 expre=
ss chipset
>=20
> Hi=2C
>=20
> It depends on the chip=2C check for my recent thread on an Intel DP55KG=
=2C the=20
> chip is not supported yet.
>=20
> Justin.
>=20
> On Fri=2C 16 Oct 2009=2C Lars Lindquist wrote:
>=20
> >
> >
> > Dear Sirs=2C
> > I am using Ubuntu 9.04 and I have a Asus ASUS P7P55D motherboard with a=
 intel p55 express chipset
> > I have downloaded the latest sensors-detect but no sensors are found.
> >
> > Is this a known issue or should it work ?
> >
> > Best regards
> > /Lars
> >
> > _________________________________________________________________
> > Keep your friends updated?even when you?re not signed in.
> > http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-actio=
n/social-network-basics.aspx?ocid=3DPID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_5=
:092010
 		 	   		 =20
_________________________________________________________________
Keep your friends updated=97even when you=92re not signed in.
http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-action/so=
cial-network-basics.aspx?ocid=3DPID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_5:092=
010=

--_65a772da-c6b9-4fa8-ad0c-79dd4d5cd8e4_
Content-Type: text/html; charset="Windows-1252"
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
font-family:Verdana
}
--></style>
</head>
<body class=3D'hmmessage'>


<meta http-equiv=3D"Content-Type" content=3D"text/html=3B charset=3Dunicode=
">
<meta name=3D"Generator" content=3D"Microsoft SafeHTML">
<style>
.hmmessage P
{margin:0px=3Bpadding:0px=3B}
body.hmmessage
{font-size:10pt=3Bfont-family:Verdana=3B}

</style>
Hi&nbsp=3B Justin=2C<br><br>I am quite new to this...<br>The only info I ca=
n get about the chipset is that it is a : <table><tbody><tr><td><strong></s=
trong><br></td>
            <td colspan=3D"6">Intel=AE P55 Express Chipset</td></tr></tbody=
></table>(motherboard)&nbsp=3B <font style=3D"font-size: 10pt=3B" size=3D"2=
"><b>Asus P7P55D<br><br><br></b></font>Do you know how I can get more infor=
mation?<br><br>I have opened the chassi but there is big heatsink over the =
chipset so I can not see anything.<br><font style=3D"font-size: 10pt=3B" si=
ze=3D"2"><br><br></font><br>Below is output from lspci=2Clsmod=2C2cdetect (=
no output)=2Cuname<br>Output from uname:<br><br>Linux august 2.6.28-15-gene=
ric #52-Ubuntu SMP Wed Sep 9 10:49:34 UTC 2009 i686 GNU/Linux<br>++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++<br>The output =
from lspci is:<br><table><tbody><tr><td><strong></strong><br></td>
            <td colspan=3D"6">0:00.0 Host bridge: Intel Corporation Clarksf=
ield/Lynnfield DMI (rev 11)<br>00:08.0 System peripheral: Intel Corporation=
 Clarksfield/Lynnfield System Management Registers (rev 11)<br>00:08.1 Syst=
em peripheral: Intel Corporation Clarksfield/Lynnfield Semaphore and Scratc=
hpad Registers (rev 11)<br>00:08.2 System peripheral: Intel Corporation Cla=
rksfield/Lynnfield System Control and Status Registers (rev 11)<br>00:08.3 =
System peripheral: Intel Corporation Clarksfield/Lynnfield Miscellaneous Re=
gisters (rev 11)<br>00:10.0 System peripheral: Intel Corporation QPI Link (=
rev 11)<br>00:10.1 System peripheral: Intel Corporation QPI Routing and Pro=
tocol Registers (rev 11)<br>00:1a.0 USB Controller: Intel Corporation Ibex =
Peak USB2 Enhanced Host Controller (rev 05)<br>00:1b.0 Audio device: Intel =
Corporation Ibex Peak High Definition Audio (rev 05)<br>00:1c.0 PCI bridge:=
 Intel Corporation Ibex Peak PCI Express Root Port 1 (rev 05)<br>00:1c.4 PC=
I bridge: Intel Corporation Ibex Peak PCI Express Root Port 5 (rev 05)<br>0=
0:1c.5 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Port 6 (rev=
 05)<br>00:1c.6 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Po=
rt 7 (rev 05)<br>00:1c.7 PCI bridge: Intel Corporation Ibex Peak PCI Expres=
s Root Port 8 (rev 05)<br>00:1d.0 USB Controller: Intel Corporation Ibex Pe=
ak USB2 Enhanced Host Controller (rev 05)<br>00:1e.0 PCI bridge: Intel Corp=
oration 82801 PCI Bridge (rev a5)<br>00:1f.0 ISA bridge: Intel Corporation =
Ibex Peak LPC Interface Controller (rev 05)<br>00:1f.2 IDE interface: Intel=
 Corporation Ibex Peak 4 port SATA IDE Controller (rev 05)<br>00:1f.3 SMBus=
: Intel Corporation Ibex Peak SMBus Controller (rev 05)<br>00:1f.5 IDE inte=
rface: Intel Corporation Ibex Peak 2 port SATA IDE Controller (rev 05)<br>0=
1:00.0 Ethernet controller: Realtek Semiconductor Co.=2C Ltd. RTL8111/8168B=
 PCI Express Gigabit Ethernet controller (rev 03)<br>02:00.0 SATA controlle=
r: JMicron Technologies=2C Inc. JMicron 20360/20363 AHCI Controller (rev 03=
)<br>02:00.1 IDE interface: JMicron Technologies=2C Inc. JMicron 20360/2036=
3 AHCI Controller (rev 03)<br>05:00.0 VGA compatible controller: ATI Techno=
logies Inc RV770 [Radeon HD 4850]<br>05:00.1 Audio device: ATI Technologies=
 Inc HD48x0 audio<br>06:04.0 FireWire (IEEE 1394): VIA Technologies=2C Inc.=
 VT6306 Fire II IEEE 1394 OHCI Link Layer Controller (rev c0)<br>++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++<br=
><br>output from sensors-detect<br># sensors-detect revision 5729 (2009-06-=
02 15:51:29 +0200)<br># System: System manufacturer System Product Name<br>=
# Board: ASUSTeK Computer INC. P7P55D<br><br>This program will help you det=
ermine which kernel modules you need<br>to load to use lm_sensors most effe=
ctively. It is generally safe<br>and recommended to accept the default answ=
ers to all questions=2C<br>unless you know what you're doing.<br><br>Some s=
outh bridges=2C CPUs or memory controllers contain embedded sensors.<br>Do =
you want to scan for them? This is totally safe. (YES/no): y<br>Silicon Int=
egrated Systems SIS5595...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>VIA VT82C686 Int=
egrated Sensors...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>=
VIA VT8231 Integrated Sensors...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B No<br>AMD K8 thermal sensors...&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>AMD K10 thermal sensors...&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Intel Core family thermal sensor...&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Intel AMB FB-DIMM thermal senso=
r...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>VIA C7 thermal and v=
oltage sensors...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br><br>Some Super I/O chips =
contain embedded sensors. We have to write to<br>standard I/O ports to prob=
e them. This is usually safe.<br>Do you want to scan for Super I/O sensors?=
 (YES/no):&nbsp=3B <br>Probing for Super-I/O at 0x2e/0x2f<br>Trying family =
`National Semiconductor'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B No<br>Trying family `SMSC'...&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Trying family `VIA/Winbond/F=
intek'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B Yes<br>Found unknown chip with ID 0xb35=
3<br>&nbsp=3B&nbsp=3B&nbsp=3B (logical device B has address 0x290=2C could =
be sensors)<br>Probing for Super-I/O at 0x4e/0x4f<br>Trying family `Nationa=
l Semiconductor'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B No<br>Trying family `SMSC'...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Trying family `VIA/Winbond/Fintek'..=
.&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Trying family `ITE'...&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br><br>Some system=
s (mainly servers) implement IPMI=2C a set of common interfaces<br>through =
which system health data may be retrieved=2C amongst other things.<br>We fi=
rst try to get the information from SMBIOS. If we don't find it<br>there=2C=
 we have to read from arbitrary I/O ports to probe for such<br>interfaces. =
This is normally safe. Do you want to scan for IPMI<br>interfaces? (YES/no)=
: <br>Probing for `IPMI BMC KCS' at 0xca0...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Prob=
ing for `IPMI BMC SMIC' at 0xca8...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br><br>Some hardware monit=
oring chips are accessible through the ISA I/O ports.<br>We have to write t=
o arbitrary I/O ports to probe them. This is usually<br>safe though. Yes=2C=
 you do have ISA I/O ports even if you do not have any<br>ISA slots! Do you=
 want to scan the ISA I/O ports? (YES/no): <br>Probing for `National Semico=
nductor LM78' at 0x290...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B N=
o<br>Probing for `National Semiconductor LM79' at 0x290...&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br>Probing for `Winbond W83781D' at 0x29=
0...&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
 No<br>Probing for `Winbond W83782D' at 0x290...&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B No<br><br>Lastly=2C we can prob=
e the I2C/SMBus adapters for connected hardware<br>monitoring devices. This=
 is the most risky part=2C and while it works<br>reasonably well on most sy=
stems=2C it has been reported to cause trouble<br>on some systems.<br>Do yo=
u want to probe the I2C/SMBus adapters now? (YES/no): <br>Found unknown SMB=
us adapter 8086:3b30 at 0000:00:1f.3.<br>Sorry=2C no supported PCI bus adap=
ters found.<br>Module i2c-dev loaded successfully.<br><br>Sorry=2C no senso=
rs were detected.<br>Either your system has no sensors=2C or they are not s=
upported=2C or<br>they are connected to an I2C or SMBus adapter that is not=
<br>supported. If you find out what chips are on your board=2C check<br>htt=
p://www.lm-sensors.org/wiki/Devices for driver status.<br>+++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++<br><br>the output from lsmod:<=
br><br>Module&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
 Size&nbsp=3B Used by<br>i2c_dev&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B 14600&nbsp=3B 0 <br>binfmt_misc&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 16776&nbsp=3B 1 <br>fglrx&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 1974216&nbsp=3B 34 <br>agpgart=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 42696&nbsp=3B 1 fglrx<br>ppde=
v&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 15620&nbsp=
=3B 0 <br>bridge&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 56212=
&nbsp=3B 0 <br>stp&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B 10500&nbsp=3B 1 bridge<br>bnep&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 20224&nbsp=3B 2 <br>video&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 25872&nbsp=3B 0=
 <br>output&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 11008&nbsp=
=3B 1 video<br>input_polldev&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B 11912&nbsp=3B 0 <br>lp&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 17156&nbsp=3B =
0 <br>parport&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 42220&nbsp=3B 2=
 ppdev=2Clp<br>snd_hda_intel&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B 435252&nbsp=3B 3 <br>snd_pcm_oss&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 46336&n=
bsp=3B 0 <br>snd_mixer_oss&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B 22656&nbsp=3B 1 snd_pcm_oss<br>snd_pcm&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 83076&nbsp=3B 2 snd_hda_intel=2Csnd_pcm_os=
s<br>snd_seq_dummy&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B 10756&nbsp=3B 0 <br>snd_seq_oss&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 37760&nbsp=3B =
0 <br>snd_seq_midi&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B 14336&nbsp=3B 0 <br>snd_rawmidi&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 29696&=
nbsp=3B 1 snd_seq_midi<br>snd_seq_midi_event&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B 15104&nbsp=3B 2 snd_seq_oss=2Csnd_seq_midi<br>snd_seq&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B 56880&nbsp=3B 6 snd_seq_dummy=2Csnd_seq_oss=2Cs=
nd_seq_midi=2Csnd_seq_midi_event<br>snd_timer&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
 29704&nbsp=3B 2 snd_pcm=2Csnd_seq<br>snd_seq_device&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 14988&nbsp=3B 5 snd_seq_dummy=
=2Csnd_seq_oss=2Csnd_seq_midi=2Csnd_rawmidi=2Csnd_seq<br>snd&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 62756&nbsp=
=3B 15 snd_hda_intel=2Csnd_pcm_oss=2Csnd_mixer_oss=2Csnd_pcm=2Csnd_seq_oss=
=2Csnd_rawmidi=2Csnd_seq=2Csnd_timer=2Csnd_seq_device<br>soundcore&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B 15200&nbsp=3B 1 snd<br>psmouse&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B 61972&nbsp=3B 0 <br>usbhid&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B 42336&nbsp=3B 0 <br>snd_page_alloc&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 16904&nbsp=3B 2 snd_hda=
_intel=2Csnd_pcm<br>serio_raw&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 13444&nbsp=3B 0=
 <br>pcspkr&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 10496&nbsp=
=3B 0 <br>ohci1394&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 38576&nbsp=3B 0 <br=
>ieee1394&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 94660&nbsp=3B 1 ohci1394<br>=
r8169&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 40836&n=
bsp=3B 0 <br>mii&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B 13312&nbsp=3B 1 r8169<br>fbcon&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 46112&nbsp=3B 0 <br>tileblit&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B 10752&nbsp=3B 1 fbcon<br>font&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 16384&nbsp=3B 1 fbcon<b=
r>bitblit&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 13824&nbsp=3B 1 fbco=
n<br>softcursor&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 9984&nbsp=3B 1 bitblit<br>++++=
+++++++++++++++++++++++++++++++++++++++++<br><br><br></td></tr></tbody></ta=
ble><br>&gt=3B Date: Fri=2C 16 Oct 2009 05:54:58 -0400<br>&gt=3B From: jpis=
zcz@lucidpixels.com<br>&gt=3B To: lars4910@hotmail.com<br>&gt=3B CC: lm-sen=
sors@lm-sensors.org<br>&gt=3B Subject: Re: [lm-sensors] Sensors-dectect =2C=
 Ubuntu 9.04 intel p55 express chipset<br>&gt=3B <br>&gt=3B Hi=2C<br>&gt=3B=
 <br>&gt=3B It depends on the chip=2C check for my recent thread on an Inte=
l DP55KG=2C the <br>&gt=3B chip is not supported yet.<br>&gt=3B <br>&gt=3B =
Justin.<br>&gt=3B <br>&gt=3B On Fri=2C 16 Oct 2009=2C Lars Lindquist wrote:=
<br>&gt=3B <br>&gt=3B &gt=3B<br>&gt=3B &gt=3B<br>&gt=3B &gt=3B Dear Sirs=2C=
<br>&gt=3B &gt=3B I am using Ubuntu 9.04 and I have a Asus ASUS P7P55D moth=
erboard with a intel p55 express chipset<br>&gt=3B &gt=3B I have downloaded=
 the latest sensors-detect but no sensors are found.<br>&gt=3B &gt=3B<br>&g=
t=3B &gt=3B Is this a known issue or should it work ?<br>&gt=3B &gt=3B<br>&=
gt=3B &gt=3B Best regards<br>&gt=3B &gt=3B /Lars<br>&gt=3B &gt=3B<br>&gt=3B=
 &gt=3B _________________________________________________________________<b=
r>&gt=3B &gt=3B Keep your friends updated?even when you?re not signed in.<b=
r>&gt=3B &gt=3B http://www.microsoft.com/middleeast/windows/windowslive/see=
-it-in-action/social-network-basics.aspx?ocid=3DPID23461::T:WLMTAGL:ON:WL:e=
n-xm:SI_SB_5:092010<br> 		 	   		  <br /><hr />Keep your friends updated=97=
 <a href=3D'http://www.microsoft.com/middleeast/windows/windowslive/see-it-=
in-action/social-network-basics.aspx?ocid=3DPID23461::T:WLMTAGL:ON:WL:en-xm=
:SI_SB_5:092010' target=3D'_new'>even when you=92re not signed in.</a></bod=
y>
</html>=

--_65a772da-c6b9-4fa8-ad0c-79dd4d5cd8e4_--


--===============8151320790893174573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8151320790893174573==--
