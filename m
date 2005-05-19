From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Centrino (855PM, ICH4-M): 82801DBM w/o LPC Bridge/SMBus?
Message-Id: <20040412152503.GD6820@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've been trying to get the readings off a Centrino notebook (a
Toshiba Satelite M30).

The sensor relevant pci entries (24c3/24c0) are missing:
# lspci -n
00:00.0 Class 0600: 8086:3340 (rev 21)
00:01.0 Class 0604: 8086:3341 (rev 21)
00:1d.0 Class 0c03: 8086:24c2 (rev 03)
00:1d.1 Class 0c03: 8086:24c4 (rev 03)
00:1d.7 Class 0c03: 8086:24cd (rev 03)
00:1e.0 Class 0604: 8086:2448 (rev 83)
00:1f.0 Class 0601: 8086:24cc (rev 03)
00:1f.1 Class 0101: 8086:24ca (rev 03)
00:1f.5 Class 0401: 8086:24c5 (rev 03)
00:1f.6 Class 0703: 8086:24c6 (rev 03)
01:00.0 Class 0300: 10de:0328 (rev a1)
02:07.0 Class 0c00: 104c:8023
02:08.0 Class 0200: 8086:103d (rev 83)
02:0a.0 Class 0280: 8086:1043 (rev 04)
02:0b.0 Class 0607: 1179:0617 (rev 33)
02:0d.0 Class 0880: 1179:0805 (rev 05)
# lspci
00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 21)
00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 21)
00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 03)
00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 03)
00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83)
00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 03)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio Controller (rev 03)
00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 03)
01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0328 (rev a1)
02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
02:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (MOB) Ethernet Controller (rev 83)
02:0a.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
02:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 33)
02:0d.0 System peripheral: Toshiba America Info Systems SD TypA Controller (rev 05)

I searched through the tickets and found the following similar entry:

  http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket04

I updated my BIOS and checked the settings, which aren't more than the
very basic ones. I also tried to find any reports on people
successfully using Centrino and lm_sensors.

Could it be that these devices aren't only not activated by the BIOS,
but are perhaps missing/not connected? Is there any tool I can use to
scan all PCI devices, even the deactivated ones?
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040412/559f1b0a/attachment.bin
