From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: i2c-ali15x3.c
Message-Id: <20011221152508.A789@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


It's it's reading 0's in the SMBus Base Addr reg, then your Bios
didn't do it's job intializing it for you.  Sometimes you need to turn
'on' ACPI or something in the Bios to get the Bios to initialize the
register for you.  It's possible to initialize it yourself (with a
force param?) but that's not nessesarily safe nor ideal.

Try adjusting some Bios settings or perhaps updating the Bios.  You
could also read the docs for the driver in our package to see if a
manual initialization can be attempted (at the risk of conflicting
with other hardware).


Phil

On Fri, Dec 21, 2001 at 05:48:39PM -0500, alvin wrote:
> I have a UP1100 which is an Alpha cpu based Motherboard that has a
> ali1543 on it. 
> It looks like the 1543 is set up somewhat correctly. The followin is
> from /proc/ioports
> 
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 03f8-03ff : serial(auto)
> 4000-403f : Acer Laboratories Inc. [ALi] M7101 PMU
> 5000-501f : Acer Laboratories Inc. [ALi] M7101 PMU
> 8000-80ff : PCI device 10b9:5451 (Acer Laboratories Inc. [ALi])
>   8000-80ff : ALi Audio Accelerator
> 8400-84ff : Adaptec AHA-7850
>   8400-84fe : aic7xxx
> 8800-887f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
>   8800-887f : 00:0a.0
> 8880-88ff : Digital Equipment Corporation DECchip 21142/43
>   8880-88ff : tulip
> 8c00-8c0f : Acer Laboratories Inc. [ALi] M5229 IDE
> 8c10-8c1f : Acer Laboratories Inc. [ALi] M5229 IDE
> 8c20-8c2f : Acer Laboratories Inc. [ALi] M5229 IDE
>   8c20-8c27 : ide0
>   8c28-8c2f : ide1
> 8c30-8c33 : Advanced Micro Devices [AMD] AMD-751 [Irongate] System
> Controller
> 8c34-8c37 : Acer Laboratories Inc. [ALi] M5229 IDE
> 8c38-8c3b : Acer Laboratories Inc. [ALi] M5229 IDE
> 
> 
> from lspci
> 
> 00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate]
> System Controller (rev 25)
> 00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP
> Bridge (rev 01)
> 00:03.0 Communication controller: Acer Laboratories Inc. [ALi]: Unknown
> device 5453
> 00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi]:
> Unknown device 5451 (rev 01)
> 00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
> [Aladdin IV]
> 00:08.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
> 00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
> (rev 30)
> 00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip
> 21142/43 (rev 41)
> 00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3)
> 00:11.0 Non-VGA unclassified device: Acer Laboratories Inc. [ALi] M7101
> PMU
> 00:14.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
> 01:05.0 VGA compatible controller: nVidia Corporation Riva TnT2 [NV5]
> (rev 15)
> 
> 
> 
> ali-15x3.c runs up and when it tries to read the 1543 it seems to get
> 0's for the values of the SMBBA word seems to return 0 and well things
> just seem to go down hill from there.
> 
> 
> Any help or suggestions would be greatly appreciated.
> 
> -- 
> Alvin Starr                   ||   voice: (416)785-4051
> Interlink Connectivity        ||   fax:   (416)785-3668
> alvin@iplink.net              ||

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
