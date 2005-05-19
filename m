From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: Ticket 816
Message-Id: <3C6D5D90.1C8C73F3@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF2D57C1FB.997926F7-ON88256B60.007E151F@playstation.sony.com>
In-Reply-To: <OF2D57C1FB.997926F7-ON88256B60.007E151F@playstation.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the sensors-detect script change is only going to get detection working
and will list the driver as "to be written".
There won't be any driver until we get a datasheet.
sorry.
mds

Greg_Corson@playstation.sony.com wrote:
> 
> Hi,
> 
> As you requested in your reply to my ticket...here is the output from lspci
> -n and lspci on my nForce based motherboard.  Many of the devices on this
> chipset seem to emulate well-known ones (the sound system looks like an
> intel i810 for example) and the actual sensor chip seems to be a supported
> one ASUS 99127F so it may only need a proper hack to the detect script to
> get things working.  If you make any changes I'd be happy to give them a
> test, let me know.
> 
> 00:00.0 Class 0600: 10de:01a4 (rev b2)
> 00:00.1 Class 0500: 10de:01ac (rev b2)
> 00:00.2 Class 0500: 10de:01ad (rev b2)
> 00:00.3 Class 0500: 10de:01ab (rev b2)
> 00:01.0 Class 0601: 10de:01b2 (rev c3)
> 00:01.1 Class 0c05: 10de:01b4 (rev c1)
> 00:02.0 Class 0c03: 10de:01c2 (rev c3)
> 00:03.0 Class 0c03: 10de:01c2 (rev c3)
> 00:08.0 Class 0604: 10de:01b8 (rev c2)
> 00:09.0 Class 0101: 10de:01bc (rev c3)
> 00:1e.0 Class 0604: 10de:01b7 (rev b2)
> 01:02.0 Class 0200: 10ec:8139 (rev 10)
> 02:00.0 Class 0300: 10de:0250 (rev a2)
> 
> 00:00.0 Host bridge: nVidia Corporation: Unknown device 01a4 (rev b2)
> 00:00.1 RAM memory: nVidia Corporation: Unknown device 01ac (rev b2)
> 00:00.2 RAM memory: nVidia Corporation: Unknown device 01ad (rev b2)
> 00:00.3 RAM memory: nVidia Corporation: Unknown device 01ab (rev b2)
> 00:01.0 ISA bridge: nVidia Corporation: Unknown device 01b2 (rev c3)
> 00:01.1 SMBus: nVidia Corporation: Unknown device 01b4 (rev c1)
> 00:02.0 USB Controller: nVidia Corporation: Unknown device 01c2 (rev c3)
> 00:03.0 USB Controller: nVidia Corporation: Unknown device 01c2 (rev c3)
> 00:08.0 PCI bridge: nVidia Corporation: Unknown device 01b8 (rev c2)
> 00:09.0 IDE interface: nVidia Corporation: Unknown device 01bc (rev c3)
> 00:1e.0 PCI bridge: nVidia Corporation: Unknown device 01b7 (rev b2)
> 01:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
> 02:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0250 (rev a2)
> 
> Greg Corson
> Software Engineer Sony R&D
> 650-655-5615
