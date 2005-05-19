From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Troble with i2c-viapro and a VT8233A
Message-Id: <Pine.OSF.4.10.10204271913170.25254-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 26 Apr 2002, Norbert Tretkowski wrote:
> Hi,
> 
> I've tried to load the i2c-viapro module.
> 
> ,----
> | Apr 26 11:33:39 rollcage kernel: i2c-core.o: i2c core module version 2.6.3 (20020322)
> | Apr 26 11:33:39 rollcage kernel: i2c-viapro.o version 2.6.3 (20020322)
> | Apr 26 11:33:39 rollcage kernel: i2c-viapro.o: Can't detect vt82c596 or compatible device, module not inserted.
> `----
> 
> The Mainboard is a Asus A7V266-EX with Via VT8233A Chipset.

VIA may have changed the PCI Device ID for the -A release of the
chipset. I think VT8233 support (since 2.6.2) was invented by simpling
adding the Device ID on the list of probe device IDs in i2c-viapro.c
source, you could try the same with VT8233A.

> ,----[ lspci ]
> | 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3099
> | 00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b099
> | 00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
> | 00:0d.0 Non-VGA unclassified device: Symbios Logic Inc. (formerly NCR) 53c810 (rev 01)
> | 00:0f.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
> | 00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
> | 00:11.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
> | 00:11.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 23)
> | 00:11.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 23)
> | 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 85)
> `----
> 
> Is this a hardware problem oder a problem with i2c?

I think an "ACPI" device should appear as 00:11.x in the lspci listing
above, try to enable it manually in BIOS. Also, a numerical listing
with "lspci -n" might help us forwards. 

I am no longer actively involved in the development process, so
better contact the sensors list directly (see Cc:). Also, on the site's
support subpage you may find advice concerning particular motheboards.


-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi

