From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: Fwd: i2c-ali15x3 on hp omnibook xe3
Message-Id: <3E93795F.3020005@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Maybe some variant of Acer chip which has the base address in a different place or something.
It's been a long time but I think that's why I put the printf in there, because
people were having that problem.
sorry
mds

Mark Studebaker wrote:
> Note: forwarded message attached.
> 
> 
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Tax Center - File online, calculators, forms, and more
> http://tax.yahoo.com
> 
> 
> ------------------------------------------------------------------------
> 
> Subject:
> i2c-ali15x3 on hp omnibook xe3
> From:
> Pavel Machek <pavel@ucw.cz>
> Date:
> Fri, 28 Mar 2003 00:41:47 +0100
> To:
> phil@netroedge.com, frodol@dds.nl, mdsxyz123@yahoo.com, kernel list 
> <linux-kernel@vger.kernel.org>
> 
> 
> Hi!
> 
> Apparently bios failed to initialize ali properly; I tried to force
> address manually, but I get:
> 
> i2c-ali15x3.o version 2.7.0 (20021208)
> ali15x3 smbus 00:06.0: forcing ISA address 0x0200
> ali15x3 smbus 00:06.0: force address failed - not supported?
> ali15x3 smbus 00:06.0: ALI15X3 not detected, module not inserted.
> 
> Any ideas what more to try?
> 
> 00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1647 Northbridge
> [MAGiK 1 / MobileMAGiK 1] (rev 04)
> 00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] PCI to AGP Controller
> 00:02.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1
> Controller (rev 03)
> 00:04.0 CardBus bridge: Texas Instruments PCI1420
> 00:04.1 CardBus bridge: Texas Instruments PCI1420
> 00:06.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
> 00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA
> Bridge [Aladdin IV]
> 00:08.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1
> (rev 12)
> 00:08.1 Communication controller: ESS Technology ESS Modem (rev 12)
> 00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3)
> 00:10.0 Ethernet controller: Accton Technology Corporation EN-1216
> Ethernet Adapter (rev 11)
> 01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/XP
> (rev 63)
> 
> [Oops, do we have right PCI device? Should not it be 00:07.0?!]
> 
> 								Pavel
