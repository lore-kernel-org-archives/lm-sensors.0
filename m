From: mukund jampala <mukund.reg@gmail.com>
Date: Wed, 28 Apr 2010 00:20:02 +0000
Subject: [lm-sensors] x86- smbus interfaced eeprom disappears
Message-Id: <h2j2249bc5f1004271720s33a6c07byf0db65508c6fe174@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5689856303501653678=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5689856303501653678==
Content-Type: multipart/alternative; boundary=001636ed67a69eff80048540f8ff

--001636ed67a69eff80048540f8ff
Content-Type: text/plain; charset=ISO-8859-1

Hi Guys,

I have a this wierd problem.
I have a smbus interfaced eeprom device which I can read/write normally
untill I plug-in the Fiber PCI express card I have.

If I insert an optical Fiber PCI express card into this x86 board, the smbus
interfaces eeprom which I want to access is no more accessble. I can read
but what is get is Junk.
This happens when I insert only this Card. Not anyother Card.
It does not report an error or so when reading/writing.

I can still see it in /sys/class/i2c-dev/i2c-0/.
If I probe the bus, the sensors-detect detects the some device at 0x50 but
it happens to be the case where the values I read from the device are not
valid.
However, lm-sensors does not detect the eeprom device irrecpective of where
the PCI card is inserted or not.

Further Analysys shows,
The PCI-ID of the smbus device did not drift.
And here are my lspci outputs

Before inserting the Card:
00:00.0 Host bridge: Intel Corporation 5000P Chipset Memory Controller Hub
(rev b1)
00:02.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x8
Port 2-3 (rev b1)
00:03.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4
Port 3 (rev b1)
00:04.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4
Port 4 (rev b1)
00:05.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4
Port 5 (rev b1)
00:06.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4
Port 6 (rev b1)
00:07.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4
Port 7 (rev b1)
00:10.0 Host bridge: Intel Corporation 5000 Series Chipset FSB Registers
(rev b1)
00:10.1 Host bridge: Intel Corporation 5000 Series Chipset FSB Registers
(rev b1)
00:10.2 Host bridge: Intel Corporation 5000 Series Chipset FSB Registers
(rev b1)
00:11.0 Host bridge: Intel Corporation 5000 Series Chipset Reserved
Registers (rev b1)
00:13.0 Host bridge: Intel Corporation 5000 Series Chipset Reserved
Registers (rev b1)
00:15.0 Host bridge: Intel Corporation 5000 Series Chipset FBD Registers
(rev b1)
00:16.0 Host bridge: Intel Corporation 5000 Series Chipset FBD Registers
(rev b1)
00:1c.0 PCI bridge: Intel Corporation 631xESB/632xESB/3100 Chipset PCI
Express Root Port 1 (rev 09)
00:1d.0 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset UHCI
USB Controller #1 (rev 09)
00:1d.1 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset UHCI
USB Controller #2 (rev 09)
00:1d.7 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset EHCI
USB2 Controller (rev 09)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d9)
00:1f.0 ISA bridge: Intel Corporation 631xESB/632xESB/3100 Chipset LPC
Interface Controller (rev 09)
00:1f.2 IDE interface: Intel Corporation 631xESB/632xESB/3100 Chipset SATA
IDE Controller (rev 09)
00:1f.3 SMBus: Intel Corporation 631xESB/632xESB/3100 Chipset SMBus
Controller (rev 09)
02:00.0 Network and computing encryption device: Cavium Networks Unknown
device 0010 (rev 01)
03:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet
Controller (rev 06)
03:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet
Controller (rev 06)
04:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet
Controller (rev 06)
04:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet
Controller (rev 06)
05:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet
Controller (rev 06)
05:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet
Controller (rev 06)
06:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet
Controller (rev 06)
06:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet
Controller (rev 06)
08:00.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express Upstream
Port (rev 01)
08:00.3 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express to PCI-X
Bridge (rev 01)
0a:00.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express Downstream
Port E1 (rev 01)
0a:01.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express Downstream
Port E2 (rev 01)
0a:02.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express Downstream
Port E3 (rev 01)
0b:00.0 Ethernet controller: Intel Corporation 80003ES2LAN Gigabit Ethernet
Controller (Copper) (rev 01)
0b:00.1 Ethernet controller: Intel Corporation 80003ES2LAN Gigabit Ethernet
Controller (Copper) (rev 01)

Only change to above output when I insert the card is:
> 0c:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet
Controller (rev 06)
> 0c:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet
Controller (rev 06)
> 0d:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet
Controller (rev 06)
> 0d:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet
Controller (rev 06)

Some sensor-detect messages:

Next adapter: SMBus I801 adapter at 0400 (i2c-0)
Client found at address 0x53
Client found at address 0x51
Client found at address 0x52
Client found at address 0x53
Client found at address 0x58
But when I insert the Card, I dont see the 0x58.
Next adapter: SMBus I801 adapter at 0400 (i2c-0)
 Client found at address 0x53
Client found at address 0x51
Client found at address 0x52
Client found at address 0x53

Why is this happening? Is this some wierd bus contention issue?

- James

--001636ed67a69eff80048540f8ff
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi Guys,</div>
<div>=A0</div>
<div>I have a this wierd problem.</div>
<div>I have a smbus interfaced eeprom device which I can read/write normall=
y untill I plug-in the Fiber PCI express card I have.</div>
<div>=A0</div>
<div>If I insert an optical Fiber PCI express card into this x86 board, the=
 smbus interfaces eeprom which I want to access is no more accessble. I can=
 read but what is get is Junk. </div>
<div>This happens when I insert only this Card. Not anyother Card.</div>
<div>It does not report an error or so when reading/writing.</div>
<div>=A0</div>
<div>I can still see it in /sys/class/i2c-dev/i2c-0/. </div>
<div>If I probe the bus, the sensors-detect detects the some device at 0x50=
 but it happens to be the case where the values I read from the device are =
not valid.</div>
<div>However, lm-sensors does not detect the eeprom device irrecpective of =
where the PCI card is inserted or not.</div>
<div>=A0</div>
<div>Further Analysys shows,</div>
<div>The PCI-ID of the smbus device did not drift.</div>
<div>And here are my lspci outputs</div>
<div>=A0</div>
<div>Before inserting the Card:</div>
<div>00:00.0 Host bridge: Intel Corporation 5000P Chipset Memory Controller=
 Hub (rev b1)<br>00:02.0 PCI bridge: Intel Corporation 5000 Series Chipset =
PCI Express x8 Port 2-3 (rev b1)<br>00:03.0 PCI bridge: Intel Corporation 5=
000 Series Chipset PCI Express x4 Port 3 (rev b1)<br>
00:04.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4 Po=
rt 4 (rev b1)<br>00:05.0 PCI bridge: Intel Corporation 5000 Series Chipset =
PCI Express x4 Port 5 (rev b1)<br>00:06.0 PCI bridge: Intel Corporation 500=
0 Series Chipset PCI Express x4 Port 6 (rev b1)<br>
00:07.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express x4 Po=
rt 7 (rev b1)<br>00:10.0 Host bridge: Intel Corporation 5000 Series Chipset=
 FSB Registers (rev b1)<br>00:10.1 Host bridge: Intel Corporation 5000 Seri=
es Chipset FSB Registers (rev b1)<br>
00:10.2 Host bridge: Intel Corporation 5000 Series Chipset FSB Registers (r=
ev b1)<br>00:11.0 Host bridge: Intel Corporation 5000 Series Chipset Reserv=
ed Registers (rev b1)<br>00:13.0 Host bridge: Intel Corporation 5000 Series=
 Chipset Reserved Registers (rev b1)<br>
00:15.0 Host bridge: Intel Corporation 5000 Series Chipset FBD Registers (r=
ev b1)<br>00:16.0 Host bridge: Intel Corporation 5000 Series Chipset FBD Re=
gisters (rev b1)<br>00:1c.0 PCI bridge: Intel Corporation 631xESB/632xESB/3=
100 Chipset PCI Express Root Port 1 (rev 09)<br>
00:1d.0 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset UHCI=
 USB Controller #1 (rev 09)<br>00:1d.1 USB Controller: Intel Corporation 63=
1xESB/632xESB/3100 Chipset UHCI USB Controller #2 (rev 09)<br>00:1d.7 USB C=
ontroller: Intel Corporation 631xESB/632xESB/3100 Chipset EHCI USB2 Control=
ler (rev 09)<br>
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d9)<br>00:1f.0 =
ISA bridge: Intel Corporation 631xESB/632xESB/3100 Chipset LPC Interface Co=
ntroller (rev 09)<br>00:1f.2 IDE interface: Intel Corporation 631xESB/632xE=
SB/3100 Chipset SATA IDE Controller (rev 09)<br>
00:1f.3 SMBus: Intel Corporation 631xESB/632xESB/3100 Chipset SMBus Control=
ler (rev 09)<br>02:00.0 Network and computing encryption device: Cavium Net=
works Unknown device 0010 (rev 01)<br>03:00.0 Ethernet controller: Intel Co=
rporation 82571EB Gigabit Ethernet Controller (rev 06)<br>
03:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Con=
troller (rev 06)<br>04:00.0 Ethernet controller: Intel Corporation 82571EB =
Gigabit Ethernet Controller (rev 06)<br>04:00.1 Ethernet controller: Intel =
Corporation 82571EB Gigabit Ethernet Controller (rev 06)<br>
05:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Con=
troller (rev 06)<br>05:00.1 Ethernet controller: Intel Corporation 82571EB =
Gigabit Ethernet Controller (rev 06)<br>06:00.0 Ethernet controller: Intel =
Corporation 82571EB Gigabit Ethernet Controller (rev 06)<br>
06:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Con=
troller (rev 06)<br>08:00.0 PCI bridge: Intel Corporation 6311ESB/6321ESB P=
CI Express Upstream Port (rev 01)<br>08:00.3 PCI bridge: Intel Corporation =
6311ESB/6321ESB PCI Express to PCI-X Bridge (rev 01)<br>
0a:00.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express Downstrea=
m Port E1 (rev 01)<br>0a:01.0 PCI bridge: Intel Corporation 6311ESB/6321ESB=
 PCI Express Downstream Port E2 (rev 01)<br>0a:02.0 PCI bridge: Intel Corpo=
ration 6311ESB/6321ESB PCI Express Downstream Port E3 (rev 01)<br>
0b:00.0 Ethernet controller: Intel Corporation 80003ES2LAN Gigabit Ethernet=
 Controller (Copper) (rev 01)<br>0b:00.1 Ethernet controller: Intel Corpora=
tion 80003ES2LAN Gigabit Ethernet Controller (Copper) (rev 01)<br></div>

<div>=A0</div>
<div>Only change to above output when I insert the card is:</div>
<div>&gt; 0c:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Et=
hernet Controller (rev 06)<br>&gt; 0c:00.1 Ethernet controller: Intel Corpo=
ration 82571EB Gigabit Ethernet Controller (rev 06)<br>&gt; 0d:00.0 Etherne=
t controller: Intel Corporation 82571EB Gigabit Ethernet Controller (rev 06=
)<br>
&gt; 0d:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Etherne=
t Controller (rev 06)<br></div>
<div>
<div>=A0</div>
<div>Some sensor-detect messages:</div>
<div>=A0</div>
<div>Next adapter: SMBus I801 adapter at 0400 (i2c-0)</div>
<div>Client found at address 0x53<br>Client found at address 0x51<br>Client=
 found at address 0x52<br>Client found at address 0x53<br>Client found at a=
ddress 0x58<br></div>
<div>But when I insert the Card, I dont see the 0x58.</div>
<div>Next adapter: SMBus I801 adapter at 0400 (i2c-0)</div>
<div>
<div>Client found at address 0x53<br>Client found at address 0x51<br>Client=
 found at address 0x52<br>Client found at address 0x53<br></div></div></div=
>
<div>=A0</div>
<div>Why is this happening? Is this some wierd bus contention issue?</div>
<div>=A0</div>
<div>- James</div>
<div>=A0</div>

--001636ed67a69eff80048540f8ff--


--===============5689856303501653678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5689856303501653678==--
