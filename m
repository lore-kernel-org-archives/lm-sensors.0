From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Fri, 16 Oct 2009 21:15:14 +0000
Subject: Re: [lm-sensors] Sensors-dectect ,
Message-Id: <alpine.DEB.2.00.0910161714400.11211@p34.internal.lan>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463747160-1339606035-1255727714=:11211"
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.00.0910160554380.2841@p34.internal.lan>
In-Reply-To: <alpine.DEB.2.00.0910160554380.2841@p34.internal.lan>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-1339606035-1255727714=:11211
Content-Type: TEXT/PLAIN; charset=Windows-1252; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

Looks very close to my lspci (below), please see:
http://linux.derkeiler.com/Mailing-Lists/Kernel/2009-10/msg07587.html

00:00.0 Host bridge: Intel Corporation Clarksfield/Lynnfield DMI (rev 11)
00:03.0 PCI bridge: Intel Corporation Clarksfield/Lynnfield PCI Express Roo=
t Port 1 (rev 11)
00:05.0 PCI bridge: Intel Corporation Clarksfield/Lynnfield PCI Express Roo=
t Port 3 (rev 11)
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
00:19.0 Ethernet controller: Intel Corporation 82578DC Gigabit Network Conn=
ection (rev 05)
00:1a.0 USB Controller: Intel Corporation Ibex Peak USB2 Enhanced Host Cont=
roller (rev 05)
00:1b.0 Audio device: Intel Corporation Ibex Peak High Definition Audio (re=
v 05)
00:1c.0 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Port 1 (re=
v 05)
00:1c.4 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Port 5 (re=
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
00:1f.2 SATA controller: Intel Corporation Ibex Peak 6 port SATA AHCI Contr=
oller (rev 05)
00:1f.3 SMBus: Intel Corporation Ibex Peak SMBus Controller (rev 05)
01:00.0 VGA compatible controller: nVidia Corporation G72 [GeForce 7300 SE/=
7200 GS] (rev a1)
02:00.0 RAID bus controller: 3ware Inc 9650SE SATA-II RAID PCIe (rev 01)
03:00.0 RAID bus controller: 3ware Inc 9650SE SATA-II RAID PCIe (rev 01)
04:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Conne=
ction
05:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Conne=
ction
06:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6145 SATA II PCI-E=
 controller (rev a1)
07:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000=
 Controller (PHY/Link)



On Fri, 16 Oct 2009, Lars Lindquist wrote:

>
>
>
>
>
>
> Hi  Justin,
>
> I am quite new to this...
> The only info I can get about the chipset is that it is a :
>
>            Intel=AE P55 Express Chipset(motherboard)  Asus P7P55D
>
>
> Do you know how I can get more information?
>
> I have opened the chassi but there is big heatsink over the chipset so I =
can not see anything.
>
>
>
> Below is output from lspci,lsmod,2cdetect (no output),uname
> Output from uname:
>
> Linux august 2.6.28-15-generic #52-Ubuntu SMP Wed Sep 9 10:49:34 UTC 2009=
 i686 GNU/Linux
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> The output from lspci is:
>
>
>            0:00.0 Host bridge: Intel Corporation Clarksfield/Lynnfield DM=
I (rev 11)
> 00:08.0 System peripheral: Intel Corporation Clarksfield/Lynnfield System=
 Management Registers (rev 11)
> 00:08.1 System peripheral: Intel Corporation Clarksfield/Lynnfield Semaph=
ore and Scratchpad Registers (rev 11)
> 00:08.2 System peripheral: Intel Corporation Clarksfield/Lynnfield System=
 Control and Status Registers (rev 11)
> 00:08.3 System peripheral: Intel Corporation Clarksfield/Lynnfield Miscel=
laneous Registers (rev 11)
> 00:10.0 System peripheral: Intel Corporation QPI Link (rev 11)
> 00:10.1 System peripheral: Intel Corporation QPI Routing and Protocol Reg=
isters (rev 11)
> 00:1a.0 USB Controller: Intel Corporation Ibex Peak USB2 Enhanced Host Co=
ntroller (rev 05)
> 00:1b.0 Audio device: Intel Corporation Ibex Peak High Definition Audio (=
rev 05)
> 00:1c.0 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Port 1 (=
rev 05)
> 00:1c.4 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Port 5 (=
rev 05)
> 00:1c.5 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Port 6 (=
rev 05)
> 00:1c.6 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Port 7 (=
rev 05)
> 00:1c.7 PCI bridge: Intel Corporation Ibex Peak PCI Express Root Port 8 (=
rev 05)
> 00:1d.0 USB Controller: Intel Corporation Ibex Peak USB2 Enhanced Host Co=
ntroller (rev 05)
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev a5)
> 00:1f.0 ISA bridge: Intel Corporation Ibex Peak LPC Interface Controller =
(rev 05)
> 00:1f.2 IDE interface: Intel Corporation Ibex Peak 4 port SATA IDE Contro=
ller (rev 05)
> 00:1f.3 SMBus: Intel Corporation Ibex Peak SMBus Controller (rev 05)
> 00:1f.5 IDE interface: Intel Corporation Ibex Peak 2 port SATA IDE Contro=
ller (rev 05)
> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168=
B PCI Express Gigabit Ethernet controller (rev 03)
> 02:00.0 SATA controller: JMicron Technologies, Inc. JMicron 20360/20363 A=
HCI Controller (rev 03)
> 02:00.1 IDE interface: JMicron Technologies, Inc. JMicron 20360/20363 AHC=
I Controller (rev 03)
> 05:00.0 VGA compatible controller: ATI Technologies Inc RV770 [Radeon HD =
4850]
> 05:00.1 Audio device: ATI Technologies Inc HD48x0 audio
> 06:04.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6306 Fire II IEEE =
1394 OHCI Link Layer Controller (rev c0)
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>
> output from sensors-detect
> # sensors-detect revision 5729 (2009-06-02 15:51:29 +0200)
> # System: System manufacturer System Product Name
> # Board: ASUSTeK Computer INC. P7P55D
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> Some south bridges, CPUs or memory controllers contain embedded sensors.
> Do you want to scan for them? This is totally safe. (YES/no): y
> Silicon Integrated Systems SIS5595...                       No
> VIA VT82C686 Integrated Sensors...                          No
> VIA VT8231 Integrated Sensors...                            No
> AMD K8 thermal sensors...                                   No
> AMD K10 thermal sensors...                                  No
> Intel Core family thermal sensor...                         No
> Intel AMB FB-DIMM thermal sensor...                         No
> VIA C7 thermal and voltage sensors...                       No
>
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       Yes
> Found unknown chip with ID 0xb353
>    (logical device B has address 0x290, could be sensors)
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No
>
> Some systems (mainly servers) implement IPMI, a set of common interfaces
> through which system health data may be retrieved, amongst other things.
> We first try to get the information from SMBIOS. If we don't find it
> there, we have to read from arbitrary I/O ports to probe for such
> interfaces. This is normally safe. Do you want to scan for IPMI
> interfaces? (YES/no):
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>
> Some hardware monitoring chips are accessible through the ISA I/O ports.
> We have to write to arbitrary I/O ports to probe them. This is usually
> safe though. Yes, you do have ISA I/O ports even if you do not have any
> ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
>
> Lastly, we can probe the I2C/SMBus adapters for connected hardware
> monitoring devices. This is the most risky part, and while it works
> reasonably well on most systems, it has been reported to cause trouble
> on some systems.
> Do you want to probe the I2C/SMBus adapters now? (YES/no):
> Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.
> Sorry, no supported PCI bus adapters found.
> Module i2c-dev loaded successfully.
>
> Sorry, no sensors were detected.
> Either your system has no sensors, or they are not supported, or
> they are connected to an I2C or SMBus adapter that is not
> supported. If you find out what chips are on your board, check
> http://www.lm-sensors.org/wiki/Devices for driver status.
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>
> the output from lsmod:
>
> Module                  Size  Used by
> i2c_dev                14600  0
> binfmt_misc            16776  1
> fglrx                1974216  34
> agpgart                42696  1 fglrx
> ppdev                  15620  0
> bridge                 56212  0
> stp                    10500  1 bridge
> bnep                   20224  2
> video                  25872  0
> output                 11008  1 video
> input_polldev          11912  0
> lp                     17156  0
> parport                42220  2 ppdev,lp
> snd_hda_intel         435252  3
> snd_pcm_oss            46336  0
> snd_mixer_oss          22656  1 snd_pcm_oss
> snd_pcm                83076  2 snd_hda_intel,snd_pcm_oss
> snd_seq_dummy          10756  0
> snd_seq_oss            37760  0
> snd_seq_midi           14336  0
> snd_rawmidi            29696  1 snd_seq_midi
> snd_seq_midi_event     15104  2 snd_seq_oss,snd_seq_midi
> snd_seq                56880  6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,sn=
d_seq_midi_event
> snd_timer              29704  2 snd_pcm,snd_seq
> snd_seq_device         14988  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi,sn=
d_rawmidi,snd_seq
> snd                    62756  15 snd_hda_intel,snd_pcm_oss,snd_mixer_oss,=
snd_pcm,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
> soundcore              15200  1 snd
> psmouse                61972  0
> usbhid                 42336  0
> snd_page_alloc         16904  2 snd_hda_intel,snd_pcm
> serio_raw              13444  0
> pcspkr                 10496  0
> ohci1394               38576  0
> ieee1394               94660  1 ohci1394
> r8169                  40836  0
> mii                    13312  1 r8169
> fbcon                  46112  0
> tileblit               10752  1 fbcon
> font                   16384  1 fbcon
> bitblit                13824  1 fbcon
> softcursor              9984  1 bitblit
> +++++++++++++++++++++++++++++++++++++++++++++
>
>
>
>> Date: Fri, 16 Oct 2009 05:54:58 -0400
>> From: jpiszcz@lucidpixels.com
>> To: lars4910@hotmail.com
>> CC: lm-sensors@lm-sensors.org
>> Subject: Re: [lm-sensors] Sensors-dectect , Ubuntu 9.04 intel p55 expres=
s chipset
>>
>> Hi,
>>
>> It depends on the chip, check for my recent thread on an Intel DP55KG, t=
he
>> chip is not supported yet.
>>
>> Justin.
>>
>> On Fri, 16 Oct 2009, Lars Lindquist wrote:
>>
>>>
>>>
>>> Dear Sirs,
>>> I am using Ubuntu 9.04 and I have a Asus ASUS P7P55D motherboard with a=
 intel p55 express chipset
>>> I have downloaded the latest sensors-detect but no sensors are found.
>>>
>>> Is this a known issue or should it work ?
>>>
>>> Best regards
>>> /Lars
>>>
>>> _________________________________________________________________
>>> Keep your friends updated?even when you?re not signed in.
>>> http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-actio=
n/social-network-basics.aspx?ocid=3DPID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_5=
:092010
>
> _________________________________________________________________
> Keep your friends updated?even when you?re not signed in.
> http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-action/=
social-network-basics.aspx?ocid=3DPID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_5:0=
92010
---1463747160-1339606035-1255727714=:11211
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
---1463747160-1339606035-1255727714=:11211--
