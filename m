From: Lars Lindquist <lars4910@hotmail.com>
Date: Wed, 10 Feb 2010 19:30:58 +0000
Subject: Re: [lm-sensors] Sensors-dectect ,
Message-Id: <BAY123-W294FBC83F4510913686225CF4F0@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1536693174962342599=="
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.00.0910160554380.2841@p34.internal.lan>
In-Reply-To: <alpine.DEB.2.00.0910160554380.2841@p34.internal.lan>
To: lm-sensors@vger.kernel.org

--===============1536693174962342599==
Content-Type: multipart/alternative;
	boundary="_69cffa00-60c6-4809-a483-c95d58345450_"

--_69cffa00-60c6-4809-a483-c95d58345450_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi all=2C

 Is there any news for my device.
 * ISA bus=2C address 0x290
 Chip `Nuvoton W83667HG-B Super IO Sensors' (confidence: 9)
=20
 I can see in (Device at lm-sensors)  that there is no support for now...

Is anything I can do to speed up things?
A small donation perhaps ?

Cheers=2C
Lars



> Date: Wed=2C 11 Nov 2009 13:10:22 -0500
> From: jpiszcz@lucidpixels.com
> To: lars4910@hotmail.com
> Subject: RE: [lm-sensors] Sensors-dectect =2C Ubuntu 9.04 intel p55 expre=
ss chipset
>=20
> I have not heard anything from the developers yet=2C will see what they s=
ay=20
> in response to your e-mail.
>=20
> Justin.
>=20
> On Wed=2C 11 Nov 2009=2C Lars Lindquist wrote:
>=20
> >
> > Hi=2C
> > Is there any news for my device.
> > * ISA bus=2C address 0x290
> > Chip `Nuvoton W83667HG-B Super IO Sensors' (confidence: 9)
> >
> > I can see in (Device at lm-sensors)  that there is no support for now..=
.
> >
> > Do you when/if there will be support for the device ?
> >
> > Cheers=2C
> > /lars
> >
> >
> >
> >> Date: Sun=2C 18 Oct 2009 17:41:54 -0400
> >> From: jpiszcz@lucidpixels.com
> >> To: lars4910@hotmail.com
> >> Subject: RE: [lm-sensors] Sensors-dectect =2C Ubuntu 9.04 intel p55 ex=
press chipset
> >>
> >> Hi=2C
> >>
> >> Cool :)
> >>
> >> Yeah=2C just need to wait for the developers to add support for the
> >> device(s) now.
> >>
> >> Justin.
> >>
> >> On Sun=2C 18 Oct 2009=2C Lars Lindquist wrote:
> >>
> >>>
> >>> Hi Justin=2C
> >>> I downloaded the "sensors-detect" I found in your link below:
> >>> http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
> >>>
> >>> And the I got the following result:
> >>> It seems something is found :-))
> >>>
> >>> Cheers Lars
> >>>
> >>> sudo ./my_sensors_detect
> >>> # sensors-detect revision 5785 (2009-10-16 22:21:15 +0200)
> >>> # System: System manufacturer System Product Name
> >>> # Board: ASUSTeK Computer INC. P7P55D
> >>>
> >>> This program will help you determine which kernel modules you need
> >>> to load to use lm_sensors most effectively. It is generally safe
> >>> and recommended to accept the default answers to all questions=2C
> >>> unless you know what you're doing.
> >>>
> >>> Some south bridges=2C CPUs or memory controllers contain embedded sen=
sors.
> >>> Do you want to scan for them? This is totally safe. (YES/no): YES
> >>> Silicon Integrated Systems SIS5595...                       No
> >>> VIA VT82C686 Integrated Sensors...                          No
> >>> VIA VT8231 Integrated Sensors...                            No
> >>> AMD K8 thermal sensors...                                   No
> >>> AMD Family 11h thermal sensors...                           No
> >>> Intel Core family thermal sensor...                         No
> >>> Intel AMB FB-DIMM thermal sensor...                         No
> >>> VIA C7 thermal and voltage sensors...                       No
> >>>
> >>> Some Super I/O chips contain embedded sensors. We have to write to
> >>> standard I/O ports to probe them. This is usually safe.
> >>> Do you want to scan for Super I/O sensors? (YES/no): YES
> >>> Probing for Super-I/O at 0x2e/0x2f
> >>> Trying family `National Semiconductor'...                   No
> >>> Trying family `SMSC'...                                     No
> >>> Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
> >>> Found `Nuvoton W83667HG-B Super IO Sensors'                 Success!
> >>>    (address 0x290=2C driver `to-be-written')
> >>> Probing for Super-I/O at 0x4e/0x4f
> >>> Trying family `National Semiconductor'...                   No
> >>> Trying family `SMSC'...                                     No
> >>> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> >>> Trying family `ITE'...                                      No
> >>>
> >>> Some systems (mainly servers) implement IPMI=2C a set of common inter=
faces
> >>> through which system health data may be retrieved=2C amongst other th=
ings.
> >>> We first try to get the information from SMBIOS. If we don't find it
> >>> there=2C we have to read from arbitrary I/O ports to probe for such
> >>> interfaces. This is normally safe. Do you want to scan for IPMI
> >>> interfaces? (YES/no): YES
> >>> Probing for `IPMI BMC KCS' at 0xca0...                      No
> >>> Probing for `IPMI BMC SMIC' at 0xca8...                     No
> >>>
> >>> Some hardware monitoring chips are accessible through the ISA I/O por=
ts.
> >>> We have to write to arbitrary I/O ports to probe them. This is usuall=
y
> >>> safe though. Yes=2C you do have ISA I/O ports even if you do not have=
 any
> >>> ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): YES
> >>> Probing for `National Semiconductor LM78' at 0x290...       No
> >>> Probing for `National Semiconductor LM79' at 0x290...       No
> >>> Probing for `Winbond W83781D' at 0x290...                   No
> >>> Probing for `Winbond W83782D' at 0x290...                   No
> >>>
> >>> Lastly=2C we can probe the I2C/SMBus adapters for connected hardware
> >>> monitoring devices. This is the most risky part=2C and while it works
> >>> reasonably well on most systems=2C it has been reported to cause trou=
ble
> >>> on some systems.
> >>> Do you want to probe the I2C/SMBus adapters now? (YES/no): YES
> >>> Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.
> >>> Sorry=2C no supported PCI bus adapters found.
> >>> Module i2c-dev loaded successfully.
> >>>
> >>> Now follows a summary of the probes I have just done.
> >>> Just press ENTER to continue:
> >>>
> >>> Driver `to-be-written':
> >>>  * ISA bus=2C address 0x290
> >>>    Chip `Nuvoton W83667HG-B Super IO Sensors' (confidence: 9)
> >>>
> >>> Note: there is no driver for Nuvoton W83667HG-B Super IO Sensors yet.
> >>> Check http://www.lm-sensors.org/wiki/Devices for updates.
> >>>
> >>> No modules to load=2C skipping modules configuration.
> >>>
> >>> Unloading i2c-dev... OK
> >>>
> >>>
> >>>
> >>>
> >>>> Date: Fri=2C 16 Oct 2009 17:15:14 -0400
> >>>> From: jpiszcz@lucidpixels.com
> >>>> To: lars4910@hotmail.com
> >>>> CC: lm-sensors@lm-sensors.org
> >>>> Subject: RE: [lm-sensors] Sensors-dectect =2C Ubuntu 9.04 intel p55 =
express chipset
> >>>>
> >>>> Hi=2C
> >>>>
> >>>> Looks very close to my lspci (below)=2C please see:
> >>>> http://linux.derkeiler.com/Mailing-Lists/Kernel/2009-10/msg07587.htm=
l
> >>>>
> >>>> 00:00.0 Host bridge: Intel Corporation Clarksfield/Lynnfield DMI (re=
v 11)
> >>>> 00:03.0 PCI bridge: Intel Corporation Clarksfield/Lynnfield PCI Expr=
ess Root Port 1 (rev 11)
> >>>> 00:05.0 PCI bridge: Intel Corporation Clarksfield/Lynnfield PCI Expr=
ess Root Port 3 (rev 11)
> >>>> 00:08.0 System peripheral: Intel Corporation Clarksfield/Lynnfield S=
ystem Management Registers (rev 11)
> >>>> 00:08.1 System peripheral: Intel Corporation Clarksfield/Lynnfield S=
emaphore and Scratchpad Registers (rev 11)
> >>>> 00:08.2 System peripheral: Intel Corporation Clarksfield/Lynnfield S=
ystem Control and Status Registers (rev 11)
> >>>> 00:08.3 System peripheral: Intel Corporation Clarksfield/Lynnfield M=
iscellaneous Registers (rev 11)
> >>>> 00:10.0 System peripheral: Intel Corporation QPI Link (rev 11)
> >>>> 00:10.1 System peripheral: Intel Corporation QPI Routing and Protoco=
l Registers (rev 11)
> >>>> 00:19.0 Ethernet controller: Intel Corporation 82578DC Gigabit Netwo=
rk Connection (rev 05)
> >>>> 00:1a.0 USB Controller: Intel Corporation Ibex Peak USB2 Enhanced Ho=
st Controller (rev 05)
> >>>> 00:1b.0 Audio device: Intel Corporation Ibex Peak High Definition Au=
dio (rev 05)
> >>>> 00:1c.0 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Por=
t 1 (rev 05)
> >>>> 00:1c.4 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Por=
t 5 (rev 05)
> >>>> 00:1c.6 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Por=
t 7 (rev 05)
> >>>> 00:1c.7 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Por=
t 8 (rev 05)
> >>>> 00:1d.0 USB Controller: Intel Corporation Ibex Peak USB2 Enhanced Ho=
st Controller (rev 05)
> >>>> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev a5)
> >>>> 00:1f.0 ISA bridge: Intel Corporation Ibex Peak LPC Interface Contro=
ller (rev 05)
> >>>> 00:1f.2 SATA controller: Intel Corporation Ibex Peak 6 port SATA AHC=
I Controller (rev 05)
> >>>> 00:1f.3 SMBus: Intel Corporation Ibex Peak SMBus Controller (rev 05)
> >>>> 01:00.0 VGA compatible controller: nVidia Corporation G72 [GeForce 7=
300 SE/7200 GS] (rev a1)
> >>>> 02:00.0 RAID bus controller: 3ware Inc 9650SE SATA-II RAID PCIe (rev=
 01)
> >>>> 03:00.0 RAID bus controller: 3ware Inc 9650SE SATA-II RAID PCIe (rev=
 01)
> >>>> 04:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Networ=
k Connection
> >>>> 05:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Networ=
k Connection
> >>>> 06:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6145 SATA I=
I PCI-E controller (rev a1)
> >>>> 07:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-139=
4a-2000 Controller (PHY/Link)
> >>>>
> >>>>
> >>>>
> >>>> On Fri=2C 16 Oct 2009=2C Lars Lindquist wrote:
> >>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>> Hi  Justin=2C
> >>>>>
> >>>>> I am quite new to this...
> >>>>> The only info I can get about the chipset is that it is a :
> >>>>>
> >>>>>            Intel=AE P55 Express Chipset(motherboard)  Asus P7P55D
> >>>>>
> >>>>>
> >>>>> Do you know how I can get more information?
> >>>>>
> >>>>> I have opened the chassi but there is big heatsink over the chipset=
 so I can not see anything.
> >>>>>
> >>>>>
> >>>>>
> >>>>> Below is output from lspci=2Clsmod=2C2cdetect (no output)=2Cuname
> >>>>> Output from uname:
> >>>>>
> >>>>> Linux august 2.6.28-15-generic #52-Ubuntu SMP Wed Sep 9 10:49:34 UT=
C 2009 i686 GNU/Linux
> >>>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
> >>>>> The output from lspci is:
> >>>>>
> >>>>>
> >>>>>            0:00.0 Host bridge: Intel Corporation Clarksfield/Lynnfi=
eld DMI (rev 11)
> >>>>> 00:08.0 System peripheral: Intel Corporation Clarksfield/Lynnfield =
System Management Registers (rev 11)
> >>>>> 00:08.1 System peripheral: Intel Corporation Clarksfield/Lynnfield =
Semaphore and Scratchpad Registers (rev 11)
> >>>>> 00:08.2 System peripheral: Intel Corporation Clarksfield/Lynnfield =
System Control and Status Registers (rev 11)
> >>>>> 00:08.3 System peripheral: Intel Corporation Clarksfield/Lynnfield =
Miscellaneous Registers (rev 11)
> >>>>> 00:10.0 System peripheral: Intel Corporation QPI Link (rev 11)
> >>>>> 00:10.1 System peripheral: Intel Corporation QPI Routing and Protoc=
ol Registers (rev 11)
> >>>>> 00:1a.0 USB Controller: Intel Corporation Ibex Peak USB2 Enhanced H=
ost Controller (rev 05)
> >>>>> 00:1b.0 Audio device: Intel Corporation Ibex Peak High Definition A=
udio (rev 05)
> >>>>> 00:1c.0 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Po=
rt 1 (rev 05)
> >>>>> 00:1c.4 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Po=
rt 5 (rev 05)
> >>>>> 00:1c.5 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Po=
rt 6 (rev 05)
> >>>>> 00:1c.6 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Po=
rt 7 (rev 05)
> >>>>> 00:1c.7 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Po=
rt 8 (rev 05)
> >>>>> 00:1d.0 USB Controller: Intel Corporation Ibex Peak USB2 Enhanced H=
ost Controller (rev 05)
> >>>>> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev a5)
> >>>>> 00:1f.0 ISA bridge: Intel Corporation Ibex Peak LPC Interface Contr=
oller (rev 05)
> >>>>> 00:1f.2 IDE interface: Intel Corporation Ibex Peak 4 port SATA IDE =
Controller (rev 05)
> >>>>> 00:1f.3 SMBus: Intel Corporation Ibex Peak SMBus Controller (rev 05=
)
> >>>>> 00:1f.5 IDE interface: Intel Corporation Ibex Peak 2 port SATA IDE =
Controller (rev 05)
> >>>>> 01:00.0 Ethernet controller: Realtek Semiconductor Co.=2C Ltd. RTL8=
111/8168B PCI Express Gigabit Ethernet controller (rev 03)
> >>>>> 02:00.0 SATA controller: JMicron Technologies=2C Inc. JMicron 20360=
/20363 AHCI Controller (rev 03)
> >>>>> 02:00.1 IDE interface: JMicron Technologies=2C Inc. JMicron 20360/2=
0363 AHCI Controller (rev 03)
> >>>>> 05:00.0 VGA compatible controller: ATI Technologies Inc RV770 [Rade=
on HD 4850]
> >>>>> 05:00.1 Audio device: ATI Technologies Inc HD48x0 audio
> >>>>> 06:04.0 FireWire (IEEE 1394): VIA Technologies=2C Inc. VT6306 Fire =
II IEEE 1394 OHCI Link Layer Controller (rev c0)
> >>>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++
> >>>>>
> >>>>> output from sensors-detect
> >>>>> # sensors-detect revision 5729 (2009-06-02 15:51:29 +0200)
> >>>>> # System: System manufacturer System Product Name
> >>>>> # Board: ASUSTeK Computer INC. P7P55D
> >>>>>
> >>>>> This program will help you determine which kernel modules you need
> >>>>> to load to use lm_sensors most effectively. It is generally safe
> >>>>> and recommended to accept the default answers to all questions=2C
> >>>>> unless you know what you're doing.
> >>>>>
> >>>>> Some south bridges=2C CPUs or memory controllers contain embedded s=
ensors.
> >>>>> Do you want to scan for them? This is totally safe. (YES/no): y
> >>>>> Silicon Integrated Systems SIS5595...                       No
> >>>>> VIA VT82C686 Integrated Sensors...                          No
> >>>>> VIA VT8231 Integrated Sensors...                            No
> >>>>> AMD K8 thermal sensors...                                   No
> >>>>> AMD K10 thermal sensors...                                  No
> >>>>> Intel Core family thermal sensor...                         No
> >>>>> Intel AMB FB-DIMM thermal sensor...                         No
> >>>>> VIA C7 thermal and voltage sensors...                       No
> >>>>>
> >>>>> Some Super I/O chips contain embedded sensors. We have to write to
> >>>>> standard I/O ports to probe them. This is usually safe.
> >>>>> Do you want to scan for Super I/O sensors? (YES/no):
> >>>>> Probing for Super-I/O at 0x2e/0x2f
> >>>>> Trying family `National Semiconductor'...                   No
> >>>>> Trying family `SMSC'...                                     No
> >>>>> Trying family `VIA/Winbond/Fintek'...                       Yes
> >>>>> Found unknown chip with ID 0xb353
> >>>>>    (logical device B has address 0x290=2C could be sensors)
> >>>>> Probing for Super-I/O at 0x4e/0x4f
> >>>>> Trying family `National Semiconductor'...                   No
> >>>>> Trying family `SMSC'...                                     No
> >>>>> Trying family `VIA/Winbond/Fintek'...                       No
> >>>>> Trying family `ITE'...                                      No
> >>>>>
> >>>>> Some systems (mainly servers) implement IPMI=2C a set of common int=
erfaces
> >>>>> through which system health data may be retrieved=2C amongst other =
things.
> >>>>> We first try to get the information from SMBIOS. If we don't find i=
t
> >>>>> there=2C we have to read from arbitrary I/O ports to probe for such
> >>>>> interfaces. This is normally safe. Do you want to scan for IPMI
> >>>>> interfaces? (YES/no):
> >>>>> Probing for `IPMI BMC KCS' at 0xca0...                      No
> >>>>> Probing for `IPMI BMC SMIC' at 0xca8...                     No
> >>>>>
> >>>>> Some hardware monitoring chips are accessible through the ISA I/O p=
orts.
> >>>>> We have to write to arbitrary I/O ports to probe them. This is usua=
lly
> >>>>> safe though. Yes=2C you do have ISA I/O ports even if you do not ha=
ve any
> >>>>> ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
> >>>>> Probing for `National Semiconductor LM78' at 0x290...       No
> >>>>> Probing for `National Semiconductor LM79' at 0x290...       No
> >>>>> Probing for `Winbond W83781D' at 0x290...                   No
> >>>>> Probing for `Winbond W83782D' at 0x290...                   No
> >>>>>
> >>>>> Lastly=2C we can probe the I2C/SMBus adapters for connected hardwar=
e
> >>>>> monitoring devices. This is the most risky part=2C and while it wor=
ks
> >>>>> reasonably well on most systems=2C it has been reported to cause tr=
ouble
> >>>>> on some systems.
> >>>>> Do you want to probe the I2C/SMBus adapters now? (YES/no):
> >>>>> Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.
> >>>>> Sorry=2C no supported PCI bus adapters found.
> >>>>> Module i2c-dev loaded successfully.
> >>>>>
> >>>>> Sorry=2C no sensors were detected.
> >>>>> Either your system has no sensors=2C or they are not supported=2C o=
r
> >>>>> they are connected to an I2C or SMBus adapter that is not
> >>>>> supported. If you find out what chips are on your board=2C check
> >>>>> http://www.lm-sensors.org/wiki/Devices for driver status.
> >>>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>>
> >>>>> the output from lsmod:
> >>>>>
> >>>>> Module                  Size  Used by
> >>>>> i2c_dev                14600  0
> >>>>> binfmt_misc            16776  1
> >>>>> fglrx                1974216  34
> >>>>> agpgart                42696  1 fglrx
> >>>>> ppdev                  15620  0
> >>>>> bridge                 56212  0
> >>>>> stp                    10500  1 bridge
> >>>>> bnep                   20224  2
> >>>>> video                  25872  0
> >>>>> output                 11008  1 video
> >>>>> input_polldev          11912  0
> >>>>> lp                     17156  0
> >>>>> parport                42220  2 ppdev=2Clp
> >>>>> snd_hda_intel         435252  3
> >>>>> snd_pcm_oss            46336  0
> >>>>> snd_mixer_oss          22656  1 snd_pcm_oss
> >>>>> snd_pcm                83076  2 snd_hda_intel=2Csnd_pcm_oss
> >>>>> snd_seq_dummy          10756  0
> >>>>> snd_seq_oss            37760  0
> >>>>> snd_seq_midi           14336  0
> >>>>> snd_rawmidi            29696  1 snd_seq_midi
> >>>>> snd_seq_midi_event     15104  2 snd_seq_oss=2Csnd_seq_midi
> >>>>> snd_seq                56880  6 snd_seq_dummy=2Csnd_seq_oss=2Csnd_s=
eq_midi=2Csnd_seq_midi_event
> >>>>> snd_timer              29704  2 snd_pcm=2Csnd_seq
> >>>>> snd_seq_device         14988  5 snd_seq_dummy=2Csnd_seq_oss=2Csnd_s=
eq_midi=2Csnd_rawmidi=2Csnd_seq
> >>>>> snd                    62756  15 snd_hda_intel=2Csnd_pcm_oss=2Csnd_=
mixer_oss=2Csnd_pcm=2Csnd_seq_oss=2Csnd_rawmidi=2Csnd_seq=2Csnd_timer=2Csnd=
_seq_device
> >>>>> soundcore              15200  1 snd
> >>>>> psmouse                61972  0
> >>>>> usbhid                 42336  0
> >>>>> snd_page_alloc         16904  2 snd_hda_intel=2Csnd_pcm
> >>>>> serio_raw              13444  0
> >>>>> pcspkr                 10496  0
> >>>>> ohci1394               38576  0
> >>>>> ieee1394               94660  1 ohci1394
> >>>>> r8169                  40836  0
> >>>>> mii                    13312  1 r8169
> >>>>> fbcon                  46112  0
> >>>>> tileblit               10752  1 fbcon
> >>>>> font                   16384  1 fbcon
> >>>>> bitblit                13824  1 fbcon
> >>>>> softcursor              9984  1 bitblit
> >>>>> +++++++++++++++++++++++++++++++++++++++++++++
> >>>>>
> >>>>>
> >>>>>
> >>>>>> Date: Fri=2C 16 Oct 2009 05:54:58 -0400
> >>>>>> From: jpiszcz@lucidpixels.com
> >>>>>> To: lars4910@hotmail.com
> >>>>>> CC: lm-sensors@lm-sensors.org
> >>>>>> Subject: Re: [lm-sensors] Sensors-dectect =2C Ubuntu 9.04 intel p5=
5 express chipset
> >>>>>>
> >>>>>> Hi=2C
> >>>>>>
> >>>>>> It depends on the chip=2C check for my recent thread on an Intel D=
P55KG=2C the
> >>>>>> chip is not supported yet.
> >>>>>>
> >>>>>> Justin.
> >>>>>>
> >>>>>> On Fri=2C 16 Oct 2009=2C Lars Lindquist wrote:
> >>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> Dear Sirs=2C
> >>>>>>> I am using Ubuntu 9.04 and I have a Asus ASUS P7P55D motherboard =
with a intel p55 express chipset
> >>>>>>> I have downloaded the latest sensors-detect but no sensors are fo=
und.
> >>>>>>>
> >>>>>>> Is this a known issue or should it work ?
> >>>>>>>
> >>>>>>> Best regards
> >>>>>>> /Lars
> >>>>>>>
> >>>>>>> _________________________________________________________________
> >>>>>>> Keep your friends updated?even when you?re not signed in.
> >>>>>>> http://www.microsoft.com/middleeast/windows/windowslive/see-it-in=
-action/social-network-basics.aspx?ocid=3DPID23461::T:WLMTAGL:ON:WL:en-xm:S=
I_SB_5:092010
> >>>>>
> >>>>> _________________________________________________________________
> >>>>> Keep your friends updated?even when you?re not signed in.
> >>>>> http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-a=
ction/social-network-basics.aspx?ocid=3DPID23461::T:WLMTAGL:ON:WL:en-xm:SI_=
SB_5:092010
> >>>
> >>> _________________________________________________________________
> >>> Windows Live: Friends get your Flickr=2C Yelp=2C and Digg updates whe=
n they e-mail you.
> >>> http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-act=
ion/social-network-basics.aspx?ocid=3DPID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB=
_3:092010
> >
> > _________________________________________________________________
> > Windows Live Hotmail: Your friends can get your Facebook updates=2C rig=
ht from Hotmail=AE.
> > http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-actio=
n/social-network-basics.aspx?ocid=3DPID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_4=
:092009
 		 	   		 =20
_________________________________________________________________
Hotmail: Powerful Free email with security by Microsoft.
https://signup.live.com/signup.aspx?id=3D60969=

--_69cffa00-60c6-4809-a483-c95d58345450_
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
font-family:Verdana
}
--></style>
</head>
<body class=3D'hmmessage'>
Hi all=2C<br><br>&nbsp=3BIs there any news for my device.<br>&nbsp=3B* ISA =
bus=2C address 0x290<br>&nbsp=3BChip `Nuvoton W83667HG-B Super IO Sensors' =
(confidence: 9)<br>&nbsp=3B<br>&nbsp=3BI can see in (Device at lm-sensors) =
 that there is no support for now...<br><br>Is anything I can do to speed u=
p things?<br>A small donation perhaps ?<br><br>Cheers=2C<br>Lars<br><br><br=
><br>&gt=3B Date: Wed=2C 11 Nov 2009 13:10:22 -0500<br>&gt=3B From: jpiszcz=
@lucidpixels.com<br>&gt=3B To: lars4910@hotmail.com<br>&gt=3B Subject: RE: =
[lm-sensors] Sensors-dectect =2C Ubuntu 9.04 intel p55 express chipset<br>&=
gt=3B <br>&gt=3B I have not heard anything from the developers yet=2C will =
see what they say <br>&gt=3B in response to your e-mail.<br>&gt=3B <br>&gt=
=3B Justin.<br>&gt=3B <br>&gt=3B On Wed=2C 11 Nov 2009=2C Lars Lindquist wr=
ote:<br>&gt=3B <br>&gt=3B &gt=3B<br>&gt=3B &gt=3B Hi=2C<br>&gt=3B &gt=3B Is=
 there any news for my device.<br>&gt=3B &gt=3B * ISA bus=2C address 0x290<=
br>&gt=3B &gt=3B Chip `Nuvoton W83667HG-B Super IO Sensors' (confidence: 9)=
<br>&gt=3B &gt=3B<br>&gt=3B &gt=3B I can see in (Device at lm-sensors)  tha=
t there is no support for now...<br>&gt=3B &gt=3B<br>&gt=3B &gt=3B Do you w=
hen/if there will be support for the device ?<br>&gt=3B &gt=3B<br>&gt=3B &g=
t=3B Cheers=2C<br>&gt=3B &gt=3B /lars<br>&gt=3B &gt=3B<br>&gt=3B &gt=3B<br>=
&gt=3B &gt=3B<br>&gt=3B &gt=3B&gt=3B Date: Sun=2C 18 Oct 2009 17:41:54 -040=
0<br>&gt=3B &gt=3B&gt=3B From: jpiszcz@lucidpixels.com<br>&gt=3B &gt=3B&gt=
=3B To: lars4910@hotmail.com<br>&gt=3B &gt=3B&gt=3B Subject: RE: [lm-sensor=
s] Sensors-dectect =2C Ubuntu 9.04 intel p55 express chipset<br>&gt=3B &gt=
=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B Hi=2C<br>&gt=3B &gt=3B&gt=3B<br>&gt=3B &gt=
=3B&gt=3B Cool :)<br>&gt=3B &gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B Yeah=2C jus=
t need to wait for the developers to add support for the<br>&gt=3B &gt=3B&g=
t=3B device(s) now.<br>&gt=3B &gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B Justin.<b=
r>&gt=3B &gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B On Sun=2C 18 Oct 2009=2C Lars =
Lindquist wrote:<br>&gt=3B &gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B<br>&gt=
=3B &gt=3B&gt=3B&gt=3B Hi Justin=2C<br>&gt=3B &gt=3B&gt=3B&gt=3B I download=
ed the "sensors-detect" I found in your link below:<br>&gt=3B &gt=3B&gt=3B&=
gt=3B http://dl.lm-sensors.org/lm-sensors/files/sensors-detect<br>&gt=3B &g=
t=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B And the I got the following r=
esult:<br>&gt=3B &gt=3B&gt=3B&gt=3B It seems something is found :-))<br>&gt=
=3B &gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B Cheers Lars<br>&gt=3B &=
gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B sudo ./my_sensors_detect<br>=
&gt=3B &gt=3B&gt=3B&gt=3B # sensors-detect revision 5785 (2009-10-16 22:21:=
15 +0200)<br>&gt=3B &gt=3B&gt=3B&gt=3B # System: System manufacturer System=
 Product Name<br>&gt=3B &gt=3B&gt=3B&gt=3B # Board: ASUSTeK Computer INC. P=
7P55D<br>&gt=3B &gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B This progra=
m will help you determine which kernel modules you need<br>&gt=3B &gt=3B&gt=
=3B&gt=3B to load to use lm_sensors most effectively. It is generally safe<=
br>&gt=3B &gt=3B&gt=3B&gt=3B and recommended to accept the default answers =
to all questions=2C<br>&gt=3B &gt=3B&gt=3B&gt=3B unless you know what you'r=
e doing.<br>&gt=3B &gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B Some sou=
th bridges=2C CPUs or memory controllers contain embedded sensors.<br>&gt=
=3B &gt=3B&gt=3B&gt=3B Do you want to scan for them? This is totally safe. =
(YES/no): YES<br>&gt=3B &gt=3B&gt=3B&gt=3B Silicon Integrated Systems SIS55=
95...                       No<br>&gt=3B &gt=3B&gt=3B&gt=3B VIA VT82C686 In=
tegrated Sensors...                          No<br>&gt=3B &gt=3B&gt=3B&gt=
=3B VIA VT8231 Integrated Sensors...                            No<br>&gt=
=3B &gt=3B&gt=3B&gt=3B AMD K8 thermal sensors...                           =
        No<br>&gt=3B &gt=3B&gt=3B&gt=3B AMD Family 11h thermal sensors...  =
                         No<br>&gt=3B &gt=3B&gt=3B&gt=3B Intel Core family =
thermal sensor...                         No<br>&gt=3B &gt=3B&gt=3B&gt=3B I=
ntel AMB FB-DIMM thermal sensor...                         No<br>&gt=3B &gt=
=3B&gt=3B&gt=3B VIA C7 thermal and voltage sensors...                      =
 No<br>&gt=3B &gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B Some Super I/=
O chips contain embedded sensors. We have to write to<br>&gt=3B &gt=3B&gt=
=3B&gt=3B standard I/O ports to probe them. This is usually safe.<br>&gt=3B=
 &gt=3B&gt=3B&gt=3B Do you want to scan for Super I/O sensors? (YES/no): YE=
S<br>&gt=3B &gt=3B&gt=3B&gt=3B Probing for Super-I/O at 0x2e/0x2f<br>&gt=3B=
 &gt=3B&gt=3B&gt=3B Trying family `National Semiconductor'...              =
     No<br>&gt=3B &gt=3B&gt=3B&gt=3B Trying family `SMSC'...               =
                      No<br>&gt=3B &gt=3B&gt=3B&gt=3B Trying family `VIA/Wi=
nbond/Nuvoton/Fintek'...               Yes<br>&gt=3B &gt=3B&gt=3B&gt=3B Fou=
nd `Nuvoton W83667HG-B Super IO Sensors'                 Success!<br>&gt=3B=
 &gt=3B&gt=3B&gt=3B    (address 0x290=2C driver `to-be-written')<br>&gt=3B =
&gt=3B&gt=3B&gt=3B Probing for Super-I/O at 0x4e/0x4f<br>&gt=3B &gt=3B&gt=
=3B&gt=3B Trying family `National Semiconductor'...                   No<br=
>&gt=3B &gt=3B&gt=3B&gt=3B Trying family `SMSC'...                         =
            No<br>&gt=3B &gt=3B&gt=3B&gt=3B Trying family `VIA/Winbond/Nuvo=
ton/Fintek'...               No<br>&gt=3B &gt=3B&gt=3B&gt=3B Trying family =
`ITE'...                                      No<br>&gt=3B &gt=3B&gt=3B&gt=
=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B Some systems (mainly servers) implement IP=
MI=2C a set of common interfaces<br>&gt=3B &gt=3B&gt=3B&gt=3B through which=
 system health data may be retrieved=2C amongst other things.<br>&gt=3B &gt=
=3B&gt=3B&gt=3B We first try to get the information from SMBIOS. If we don'=
t find it<br>&gt=3B &gt=3B&gt=3B&gt=3B there=2C we have to read from arbitr=
ary I/O ports to probe for such<br>&gt=3B &gt=3B&gt=3B&gt=3B interfaces. Th=
is is normally safe. Do you want to scan for IPMI<br>&gt=3B &gt=3B&gt=3B&gt=
=3B interfaces? (YES/no): YES<br>&gt=3B &gt=3B&gt=3B&gt=3B Probing for `IPM=
I BMC KCS' at 0xca0...                      No<br>&gt=3B &gt=3B&gt=3B&gt=3B=
 Probing for `IPMI BMC SMIC' at 0xca8...                     No<br>&gt=3B &=
gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B Some hardware monitoring chi=
ps are accessible through the ISA I/O ports.<br>&gt=3B &gt=3B&gt=3B&gt=3B W=
e have to write to arbitrary I/O ports to probe them. This is usually<br>&g=
t=3B &gt=3B&gt=3B&gt=3B safe though. Yes=2C you do have ISA I/O ports even =
if you do not have any<br>&gt=3B &gt=3B&gt=3B&gt=3B ISA slots! Do you want =
to scan the ISA I/O ports? (yes/NO): YES<br>&gt=3B &gt=3B&gt=3B&gt=3B Probi=
ng for `National Semiconductor LM78' at 0x290...       No<br>&gt=3B &gt=3B&=
gt=3B&gt=3B Probing for `National Semiconductor LM79' at 0x290...       No<=
br>&gt=3B &gt=3B&gt=3B&gt=3B Probing for `Winbond W83781D' at 0x290...     =
              No<br>&gt=3B &gt=3B&gt=3B&gt=3B Probing for `Winbond W83782D'=
 at 0x290...                   No<br>&gt=3B &gt=3B&gt=3B&gt=3B<br>&gt=3B &g=
t=3B&gt=3B&gt=3B Lastly=2C we can probe the I2C/SMBus adapters for connecte=
d hardware<br>&gt=3B &gt=3B&gt=3B&gt=3B monitoring devices. This is the mos=
t risky part=2C and while it works<br>&gt=3B &gt=3B&gt=3B&gt=3B reasonably =
well on most systems=2C it has been reported to cause trouble<br>&gt=3B &gt=
=3B&gt=3B&gt=3B on some systems.<br>&gt=3B &gt=3B&gt=3B&gt=3B Do you want t=
o probe the I2C/SMBus adapters now? (YES/no): YES<br>&gt=3B &gt=3B&gt=3B&gt=
=3B Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.<br>&gt=3B &gt=3B=
&gt=3B&gt=3B Sorry=2C no supported PCI bus adapters found.<br>&gt=3B &gt=3B=
&gt=3B&gt=3B Module i2c-dev loaded successfully.<br>&gt=3B &gt=3B&gt=3B&gt=
=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B Now follows a summary of the probes I have=
 just done.<br>&gt=3B &gt=3B&gt=3B&gt=3B Just press ENTER to continue:<br>&=
gt=3B &gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B Driver `to-be-written=
':<br>&gt=3B &gt=3B&gt=3B&gt=3B  * ISA bus=2C address 0x290<br>&gt=3B &gt=
=3B&gt=3B&gt=3B    Chip `Nuvoton W83667HG-B Super IO Sensors' (confidence: =
9)<br>&gt=3B &gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B Note: there is=
 no driver for Nuvoton W83667HG-B Super IO Sensors yet.<br>&gt=3B &gt=3B&gt=
=3B&gt=3B Check http://www.lm-sensors.org/wiki/Devices for updates.<br>&gt=
=3B &gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B No modules to load=2C s=
kipping modules configuration.<br>&gt=3B &gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=
=3B&gt=3B&gt=3B Unloading i2c-dev... OK<br>&gt=3B &gt=3B&gt=3B&gt=3B<br>&gt=
=3B &gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&=
gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B Date: Fri=2C 16 Oct 2009 17:15:14 =
-0400<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B From: jpiszcz@lucidpixels.com<br>&=
gt=3B &gt=3B&gt=3B&gt=3B&gt=3B To: lars4910@hotmail.com<br>&gt=3B &gt=3B&gt=
=3B&gt=3B&gt=3B CC: lm-sensors@lm-sensors.org<br>&gt=3B &gt=3B&gt=3B&gt=3B&=
gt=3B Subject: RE: [lm-sensors] Sensors-dectect =2C Ubuntu 9.04 intel p55 e=
xpress chipset<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=
=3B&gt=3B Hi=2C<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&g=
t=3B&gt=3B Looks very close to my lspci (below)=2C please see:<br>&gt=3B &g=
t=3B&gt=3B&gt=3B&gt=3B http://linux.derkeiler.com/Mailing-Lists/Kernel/2009=
-10/msg07587.html<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B=
&gt=3B&gt=3B 00:00.0 Host bridge: Intel Corporation Clarksfield/Lynnfield D=
MI (rev 11)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 00:03.0 PCI bridge: Intel Co=
rporation Clarksfield/Lynnfield PCI Express Root Port 1 (rev 11)<br>&gt=3B =
&gt=3B&gt=3B&gt=3B&gt=3B 00:05.0 PCI bridge: Intel Corporation Clarksfield/=
Lynnfield PCI Express Root Port 3 (rev 11)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=
=3B 00:08.0 System peripheral: Intel Corporation Clarksfield/Lynnfield Syst=
em Management Registers (rev 11)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 00:08.1=
 System peripheral: Intel Corporation Clarksfield/Lynnfield Semaphore and S=
cratchpad Registers (rev 11)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 00:08.2 Sys=
tem peripheral: Intel Corporation Clarksfield/Lynnfield System Control and =
Status Registers (rev 11)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 00:08.3 System=
 peripheral: Intel Corporation Clarksfield/Lynnfield Miscellaneous Register=
s (rev 11)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 00:10.0 System peripheral: In=
tel Corporation QPI Link (rev 11)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 00:10.=
1 System peripheral: Intel Corporation QPI Routing and Protocol Registers (=
rev 11)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 00:19.0 Ethernet controller: Int=
el Corporation 82578DC Gigabit Network Connection (rev 05)<br>&gt=3B &gt=3B=
&gt=3B&gt=3B&gt=3B 00:1a.0 USB Controller: Intel Corporation Ibex Peak USB2=
 Enhanced Host Controller (rev 05)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 00:1b=
.0 Audio device: Intel Corporation Ibex Peak High Definition Audio (rev 05)=
<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 00:1c.0 PCI bridge: Intel Corporation I=
bex Peak PCI Express Root Port 1 (rev 05)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=
=3B 00:1c.4 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Port 5=
 (rev 05)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 00:1c.6 PCI bridge: Intel Corp=
oration Ibex Peak PCI Express Root Port 7 (rev 05)<br>&gt=3B &gt=3B&gt=3B&g=
t=3B&gt=3B 00:1c.7 PCI bridge: Intel Corporation Ibex Peak PCI Express Root=
 Port 8 (rev 05)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 00:1d.0 USB Controller:=
 Intel Corporation Ibex Peak USB2 Enhanced Host Controller (rev 05)<br>&gt=
=3B &gt=3B&gt=3B&gt=3B&gt=3B 00:1e.0 PCI bridge: Intel Corporation 82801 PC=
I Bridge (rev a5)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 00:1f.0 ISA bridge: In=
tel Corporation Ibex Peak LPC Interface Controller (rev 05)<br>&gt=3B &gt=
=3B&gt=3B&gt=3B&gt=3B 00:1f.2 SATA controller: Intel Corporation Ibex Peak =
6 port SATA AHCI Controller (rev 05)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 00:=
1f.3 SMBus: Intel Corporation Ibex Peak SMBus Controller (rev 05)<br>&gt=3B=
 &gt=3B&gt=3B&gt=3B&gt=3B 01:00.0 VGA compatible controller: nVidia Corpora=
tion G72 [GeForce 7300 SE/7200 GS] (rev a1)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=
=3B 02:00.0 RAID bus controller: 3ware Inc 9650SE SATA-II RAID PCIe (rev 01=
)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 03:00.0 RAID bus controller: 3ware Inc=
 9650SE SATA-II RAID PCIe (rev 01)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 04:00=
.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection=
<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 05:00.0 Ethernet controller: Intel Corp=
oration 82574L Gigabit Network Connection<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=
=3B 06:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6145 SATA II P=
CI-E controller (rev a1)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B 07:03.0 FireWir=
e (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PH=
Y/Link)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=
=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B O=
n Fri=2C 16 Oct 2009=2C Lars Lindquist wrote:<br>&gt=3B &gt=3B&gt=3B&gt=3B&=
gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B=
&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=
=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &g=
t=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Hi  J=
ustin=2C<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=
=3B&gt=3B&gt=3B I am quite new to this...<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=
=3B&gt=3B The only info I can get about the chipset is that it is a :<br>&g=
t=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=
=3B            Intel=AE P55 Express Chipset(motherboard)  Asus P7P55D<br>&g=
t=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=
=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Do you know how I can get more=
 information?<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=
=3B&gt=3B&gt=3B&gt=3B I have opened the chassi but there is big heatsink ov=
er the chipset so I can not see anything.<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=
=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&g=
t=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Below is output f=
rom lspci=2Clsmod=2C2cdetect (no output)=2Cuname<br>&gt=3B &gt=3B&gt=3B&gt=
=3B&gt=3B&gt=3B Output from uname:<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B=
<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Linux august 2.6.28-15-generic #5=
2-Ubuntu SMP Wed Sep 9 10:49:34 UTC 2009 i686 GNU/Linux<br>&gt=3B &gt=3B&gt=
=3B&gt=3B&gt=3B&gt=3B +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B The output from =
lspci is:<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&g=
t=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B            0:00.0=
 Host bridge: Intel Corporation Clarksfield/Lynnfield DMI (rev 11)<br>&gt=
=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 00:08.0 System peripheral: Intel Corpora=
tion Clarksfield/Lynnfield System Management Registers (rev 11)<br>&gt=3B &=
gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 00:08.1 System peripheral: Intel Corporation =
Clarksfield/Lynnfield Semaphore and Scratchpad Registers (rev 11)<br>&gt=3B=
 &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 00:08.2 System peripheral: Intel Corporatio=
n Clarksfield/Lynnfield System Control and Status Registers (rev 11)<br>&gt=
=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 00:08.3 System peripheral: Intel Corpora=
tion Clarksfield/Lynnfield Miscellaneous Registers (rev 11)<br>&gt=3B &gt=
=3B&gt=3B&gt=3B&gt=3B&gt=3B 00:10.0 System peripheral: Intel Corporation QP=
I Link (rev 11)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 00:10.1 System per=
ipheral: Intel Corporation QPI Routing and Protocol Registers (rev 11)<br>&=
gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 00:1a.0 USB Controller: Intel Corporat=
ion Ibex Peak USB2 Enhanced Host Controller (rev 05)<br>&gt=3B &gt=3B&gt=3B=
&gt=3B&gt=3B&gt=3B 00:1b.0 Audio device: Intel Corporation Ibex Peak High D=
efinition Audio (rev 05)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 00:1c.0 P=
CI bridge: Intel Corporation Ibex Peak PCI Express Root Port 1 (rev 05)<br>=
&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 00:1c.4 PCI bridge: Intel Corporation=
 Ibex Peak PCI Express Root Port 5 (rev 05)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=
=3B&gt=3B 00:1c.5 PCI bridge: Intel Corporation Ibex Peak PCI Express Root =
Port 6 (rev 05)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 00:1c.6 PCI bridge=
: Intel Corporation Ibex Peak PCI Express Root Port 7 (rev 05)<br>&gt=3B &g=
t=3B&gt=3B&gt=3B&gt=3B&gt=3B 00:1c.7 PCI bridge: Intel Corporation Ibex Pea=
k PCI Express Root Port 8 (rev 05)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B=
 00:1d.0 USB Controller: Intel Corporation Ibex Peak USB2 Enhanced Host Con=
troller (rev 05)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 00:1e.0 PCI bridg=
e: Intel Corporation 82801 PCI Bridge (rev a5)<br>&gt=3B &gt=3B&gt=3B&gt=3B=
&gt=3B&gt=3B 00:1f.0 ISA bridge: Intel Corporation Ibex Peak LPC Interface =
Controller (rev 05)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 00:1f.2 IDE in=
terface: Intel Corporation Ibex Peak 4 port SATA IDE Controller (rev 05)<br=
>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 00:1f.3 SMBus: Intel Corporation Ibe=
x Peak SMBus Controller (rev 05)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 0=
0:1f.5 IDE interface: Intel Corporation Ibex Peak 2 port SATA IDE Controlle=
r (rev 05)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 01:00.0 Ethernet contro=
ller: Realtek Semiconductor Co.=2C Ltd. RTL8111/8168B PCI Express Gigabit E=
thernet controller (rev 03)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 02:00.=
0 SATA controller: JMicron Technologies=2C Inc. JMicron 20360/20363 AHCI Co=
ntroller (rev 03)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 02:00.1 IDE inte=
rface: JMicron Technologies=2C Inc. JMicron 20360/20363 AHCI Controller (re=
v 03)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 05:00.0 VGA compatible contr=
oller: ATI Technologies Inc RV770 [Radeon HD 4850]<br>&gt=3B &gt=3B&gt=3B&g=
t=3B&gt=3B&gt=3B 05:00.1 Audio device: ATI Technologies Inc HD48x0 audio<br=
>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B 06:04.0 FireWire (IEEE 1394): VIA Te=
chnologies=2C Inc. VT6306 Fire II IEEE 1394 OHCI Link Layer Controller (rev=
 c0)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B +++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++<br>&gt=3B &gt=3B&gt=
=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B output from =
sensors-detect<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B # sensors-detect re=
vision 5729 (2009-06-02 15:51:29 +0200)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&=
gt=3B # System: System manufacturer System Product Name<br>&gt=3B &gt=3B&gt=
=3B&gt=3B&gt=3B&gt=3B # Board: ASUSTeK Computer INC. P7P55D<br>&gt=3B &gt=
=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B This p=
rogram will help you determine which kernel modules you need<br>&gt=3B &gt=
=3B&gt=3B&gt=3B&gt=3B&gt=3B to load to use lm_sensors most effectively. It =
is generally safe<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B and recommended =
to accept the default answers to all questions=2C<br>&gt=3B &gt=3B&gt=3B&gt=
=3B&gt=3B&gt=3B unless you know what you're doing.<br>&gt=3B &gt=3B&gt=3B&g=
t=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Some south bridge=
s=2C CPUs or memory controllers contain embedded sensors.<br>&gt=3B &gt=3B&=
gt=3B&gt=3B&gt=3B&gt=3B Do you want to scan for them? This is totally safe.=
 (YES/no): y<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Silicon Integrated Sy=
stems SIS5595...                       No<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=
=3B&gt=3B VIA VT82C686 Integrated Sensors...                          No<br=
>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B VIA VT8231 Integrated Sensors...    =
                        No<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B AMD K8 =
thermal sensors...                                   No<br>&gt=3B &gt=3B&gt=
=3B&gt=3B&gt=3B&gt=3B AMD K10 thermal sensors...                           =
       No<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Intel Core family therma=
l sensor...                         No<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&g=
t=3B Intel AMB FB-DIMM thermal sensor...                         No<br>&gt=
=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B VIA C7 thermal and voltage sensors...   =
                    No<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &=
gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Some Super I/O chips contain embedded sensors=
. We have to write to<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B standard I/O=
 ports to probe them. This is usually safe.<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=
=3B&gt=3B Do you want to scan for Super I/O sensors? (YES/no):<br>&gt=3B &g=
t=3B&gt=3B&gt=3B&gt=3B&gt=3B Probing for Super-I/O at 0x2e/0x2f<br>&gt=3B &=
gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Trying family `National Semiconductor'...    =
               No<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Trying family `S=
MSC'...                                     No<br>&gt=3B &gt=3B&gt=3B&gt=3B=
&gt=3B&gt=3B Trying family `VIA/Winbond/Fintek'...                       Ye=
s<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Found unknown chip with ID 0xb35=
3<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B    (logical device B has address=
 0x290=2C could be sensors)<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Probin=
g for Super-I/O at 0x4e/0x4f<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Tryin=
g family `National Semiconductor'...                   No<br>&gt=3B &gt=3B&=
gt=3B&gt=3B&gt=3B&gt=3B Trying family `SMSC'...                            =
         No<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Trying family `VIA/Win=
bond/Fintek'...                       No<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B=
&gt=3B Trying family `ITE'...                                      No<br>&g=
t=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=
=3B Some systems (mainly servers) implement IPMI=2C a set of common interfa=
ces<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B through which system health da=
ta may be retrieved=2C amongst other things.<br>&gt=3B &gt=3B&gt=3B&gt=3B&g=
t=3B&gt=3B We first try to get the information from SMBIOS. If we don't fin=
d it<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B there=2C we have to read from=
 arbitrary I/O ports to probe for such<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&g=
t=3B interfaces. This is normally safe. Do you want to scan for IPMI<br>&gt=
=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B interfaces? (YES/no):<br>&gt=3B &gt=3B&g=
t=3B&gt=3B&gt=3B&gt=3B Probing for `IPMI BMC KCS' at 0xca0...              =
        No<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Probing for `IPMI BMC S=
MIC' at 0xca8...                     No<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&=
gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Some hardware monitoring chi=
ps are accessible through the ISA I/O ports.<br>&gt=3B &gt=3B&gt=3B&gt=3B&g=
t=3B&gt=3B We have to write to arbitrary I/O ports to probe them. This is u=
sually<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B safe though. Yes=2C you do =
have ISA I/O ports even if you do not have any<br>&gt=3B &gt=3B&gt=3B&gt=3B=
&gt=3B&gt=3B ISA slots! Do you want to scan the ISA I/O ports? (YES/no):<br=
>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Probing for `National Semiconductor =
LM78' at 0x290...       No<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Probing=
 for `National Semiconductor LM79' at 0x290...       No<br>&gt=3B &gt=3B&gt=
=3B&gt=3B&gt=3B&gt=3B Probing for `Winbond W83781D' at 0x290...            =
       No<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Probing for `Winbond W83=
782D' at 0x290...                   No<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&g=
t=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Lastly=2C we can probe the I2=
C/SMBus adapters for connected hardware<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&=
gt=3B monitoring devices. This is the most risky part=2C and while it works=
<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B reasonably well on most systems=
=2C it has been reported to cause trouble<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=
=3B&gt=3B on some systems.<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Do you =
want to probe the I2C/SMBus adapters now? (YES/no):<br>&gt=3B &gt=3B&gt=3B&=
gt=3B&gt=3B&gt=3B Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.<br=
>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Sorry=2C no supported PCI bus adapte=
rs found.<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Module i2c-dev loaded su=
ccessfully.<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B=
&gt=3B&gt=3B&gt=3B Sorry=2C no sensors were detected.<br>&gt=3B &gt=3B&gt=
=3B&gt=3B&gt=3B&gt=3B Either your system has no sensors=2C or they are not =
supported=2C or<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B they are connected=
 to an I2C or SMBus adapter that is not<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&=
gt=3B supported. If you find out what chips are on your board=2C check<br>&=
gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B http://www.lm-sensors.org/wiki/Devices=
 for driver status.<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B ++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++<br>&gt=3B &gt=3B&gt=3B&gt=
=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B the output from ls=
mod:<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&=
gt=3B&gt=3B Module                  Size  Used by<br>&gt=3B &gt=3B&gt=3B&gt=
=3B&gt=3B&gt=3B i2c_dev                14600  0<br>&gt=3B &gt=3B&gt=3B&gt=
=3B&gt=3B&gt=3B binfmt_misc            16776  1<br>&gt=3B &gt=3B&gt=3B&gt=
=3B&gt=3B&gt=3B fglrx                1974216  34<br>&gt=3B &gt=3B&gt=3B&gt=
=3B&gt=3B&gt=3B agpgart                42696  1 fglrx<br>&gt=3B &gt=3B&gt=
=3B&gt=3B&gt=3B&gt=3B ppdev                  15620  0<br>&gt=3B &gt=3B&gt=
=3B&gt=3B&gt=3B&gt=3B bridge                 56212  0<br>&gt=3B &gt=3B&gt=
=3B&gt=3B&gt=3B&gt=3B stp                    10500  1 bridge<br>&gt=3B &gt=
=3B&gt=3B&gt=3B&gt=3B&gt=3B bnep                   20224  2<br>&gt=3B &gt=
=3B&gt=3B&gt=3B&gt=3B&gt=3B video                  25872  0<br>&gt=3B &gt=
=3B&gt=3B&gt=3B&gt=3B&gt=3B output                 11008  1 video<br>&gt=3B=
 &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B input_polldev          11912  0<br>&gt=3B &=
gt=3B&gt=3B&gt=3B&gt=3B&gt=3B lp                     17156  0<br>&gt=3B &gt=
=3B&gt=3B&gt=3B&gt=3B&gt=3B parport                42220  2 ppdev=2Clp<br>&=
gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B snd_hda_intel         435252  3<br>&gt=
=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B snd_pcm_oss            46336  0<br>&gt=
=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B snd_mixer_oss          22656  1 snd_pcm_=
oss<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B snd_pcm                83076  =
2 snd_hda_intel=2Csnd_pcm_oss<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B snd_=
seq_dummy          10756  0<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B snd_se=
q_oss            37760  0<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B snd_seq_=
midi           14336  0<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B snd_rawmid=
i            29696  1 snd_seq_midi<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B=
 snd_seq_midi_event     15104  2 snd_seq_oss=2Csnd_seq_midi<br>&gt=3B &gt=
=3B&gt=3B&gt=3B&gt=3B&gt=3B snd_seq                56880  6 snd_seq_dummy=
=2Csnd_seq_oss=2Csnd_seq_midi=2Csnd_seq_midi_event<br>&gt=3B &gt=3B&gt=3B&g=
t=3B&gt=3B&gt=3B snd_timer              29704  2 snd_pcm=2Csnd_seq<br>&gt=
=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B snd_seq_device         14988  5 snd_seq_=
dummy=2Csnd_seq_oss=2Csnd_seq_midi=2Csnd_rawmidi=2Csnd_seq<br>&gt=3B &gt=3B=
&gt=3B&gt=3B&gt=3B&gt=3B snd                    62756  15 snd_hda_intel=2Cs=
nd_pcm_oss=2Csnd_mixer_oss=2Csnd_pcm=2Csnd_seq_oss=2Csnd_rawmidi=2Csnd_seq=
=2Csnd_timer=2Csnd_seq_device<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B soun=
dcore              15200  1 snd<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B ps=
mouse                61972  0<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B usbh=
id                 42336  0<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B snd_pa=
ge_alloc         16904  2 snd_hda_intel=2Csnd_pcm<br>&gt=3B &gt=3B&gt=3B&gt=
=3B&gt=3B&gt=3B serio_raw              13444  0<br>&gt=3B &gt=3B&gt=3B&gt=
=3B&gt=3B&gt=3B pcspkr                 10496  0<br>&gt=3B &gt=3B&gt=3B&gt=
=3B&gt=3B&gt=3B ohci1394               38576  0<br>&gt=3B &gt=3B&gt=3B&gt=
=3B&gt=3B&gt=3B ieee1394               94660  1 ohci1394<br>&gt=3B &gt=3B&g=
t=3B&gt=3B&gt=3B&gt=3B r8169                  40836  0<br>&gt=3B &gt=3B&gt=
=3B&gt=3B&gt=3B&gt=3B mii                    13312  1 r8169<br>&gt=3B &gt=
=3B&gt=3B&gt=3B&gt=3B&gt=3B fbcon                  46112  0<br>&gt=3B &gt=
=3B&gt=3B&gt=3B&gt=3B&gt=3B tileblit               10752  1 fbcon<br>&gt=3B=
 &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B font                   16384  1 fbcon<br>&g=
t=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B bitblit                13824  1 fbcon<b=
r>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B softcursor              9984  1 bit=
blit<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B +++++++++++++++++++++++++++++=
++++++++++++++++<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&=
gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B =
&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Date: Fri=2C 16 Oct 2009 05:54:58 -040=
0<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B From: jpiszcz@lucidpixels.=
com<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B To: lars4910@hotmail.com=
<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B CC: lm-sensors@lm-sensors.o=
rg<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Subject: Re: [lm-sensors]=
 Sensors-dectect =2C Ubuntu 9.04 intel p55 express chipset<br>&gt=3B &gt=3B=
&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=
=3B Hi=2C<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&g=
t=3B&gt=3B&gt=3B&gt=3B&gt=3B It depends on the chip=2C check for my recent =
thread on an Intel DP55KG=2C the<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&g=
t=3B chip is not supported yet.<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=
=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Justin.<br>&gt=3B &gt=3B=
&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=
=3B On Fri=2C 16 Oct 2009=2C Lars Lindquist wrote:<br>&gt=3B &gt=3B&gt=3B&g=
t=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B=
<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=
=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Dear Sirs=2C<br>&gt=3B &gt=3B&gt=3B&gt=3B=
&gt=3B&gt=3B&gt=3B&gt=3B I am using Ubuntu 9.04 and I have a Asus ASUS P7P5=
5D motherboard with a intel p55 express chipset<br>&gt=3B &gt=3B&gt=3B&gt=
=3B&gt=3B&gt=3B&gt=3B&gt=3B I have downloaded the latest sensors-detect but=
 no sensors are found.<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B=
<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Is this a known issue=
 or should it work ?<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<b=
r>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Best regards<br>&gt=3B =
&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B /Lars<br>&gt=3B &gt=3B&gt=3B&gt=
=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&=
gt=3B _________________________________________________________________<br>=
&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Keep your friends updated=
?even when you?re not signed in.<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B&g=
t=3B&gt=3B http://www.microsoft.com/middleeast/windows/windowslive/see-it-i=
n-action/social-network-basics.aspx?ocid=3DPID23461::T:WLMTAGL:ON:WL:en-xm:=
SI_SB_5:092010<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=
=3B&gt=3B&gt=3B&gt=3B _____________________________________________________=
____________<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=3B Keep your friends upd=
ated?even when you?re not signed in.<br>&gt=3B &gt=3B&gt=3B&gt=3B&gt=3B&gt=
=3B http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-actio=
n/social-network-basics.aspx?ocid=3DPID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_5=
:092010<br>&gt=3B &gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B&gt=3B _________=
________________________________________________________<br>&gt=3B &gt=3B&g=
t=3B&gt=3B Windows Live: Friends get your Flickr=2C Yelp=2C and Digg update=
s when they e-mail you.<br>&gt=3B &gt=3B&gt=3B&gt=3B http://www.microsoft.c=
om/middleeast/windows/windowslive/see-it-in-action/social-network-basics.as=
px?ocid=3DPID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_3:092010<br>&gt=3B &gt=3B<b=
r>&gt=3B &gt=3B ___________________________________________________________=
______<br>&gt=3B &gt=3B Windows Live Hotmail: Your friends can get your Fac=
ebook updates=2C right from Hotmail=AE.<br>&gt=3B &gt=3B http://www.microso=
ft.com/middleeast/windows/windowslive/see-it-in-action/social-network-basic=
s.aspx?ocid=3DPID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_4:092009<br> 		 	   		 =
 <br /><hr />Hotmail: Powerful Free email with security by Microsoft. <a hr=
ef=3D'https://signup.live.com/signup.aspx?id=3D60969' target=3D'_new'>Get i=
t now.</a></body>
</html>=

--_69cffa00-60c6-4809-a483-c95d58345450_--


--===============1536693174962342599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1536693174962342599==--
