From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 26 May 2007 07:59:28 +0000
Subject: [lm-sensors] Unknown SMSC superio with id 0xe01
Message-Id: <4657E8E0.8050309@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just ran sensors-detect on my compaq evo n600c laptop to try and get one more 
machine to test the generic chip support code on, but all that was found was an
SMSC superio with id 0xe01.

Also no smbus controller was found. Although I do have a 82830 + 82801CAM 
(ICH3) chipset.

lspci says:
00:00.0 Host bridge: Intel Corporation 82830 830 Chipset Host Bridge (rev 04)
00:01.0 PCI bridge: Intel Corporation 82830 830 Chipset AGP Bridge (rev 04)
00:1d.0 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #3) (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corporation 82801CAM ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801CAM IDE U100 (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY
02:03.0 CardBus 00:00.0 0600: 8086:3575 (rev 04) bridge: Texas Instruments 
PCI1420 PC card Cardbus Controller
02:03.1 CardBus bridge: Texas Instruments PCI1420 PC card Cardbus Controller
02:04.0 Communication controller: Agere Systems LT WinModem (rev 02)
02:08.0 Ethernet controller: Intel Corporation 82801CAM (ICH3) PRO/100 VM (KM) 
Ethernet Controller (rev 42)
02:09.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
03:00.0 Network controller: Intersil Corporation ISL3890 [Prism GT/Prism 
Duette]/ISL3886 [Prism Javelin/Prism Xbow] (rev 01)

and lspci -n says:

00:01.0 0604: 8086:3576 (rev 04)
00:1d.0 0c03: 8086:2482 (rev 02)
00:1d.1 0c03: 8086:2484 (rev 02)
00:1d.2 0c03: 8086:2487 (rev 02)
00:1e.0 0604: 8086:2448 (rev 42)
00:1f.0 0601: 8086:248c (rev 02)
00:1f.1 0101: 8086:248a (rev 02)
01:00.0 0300: 1002:4c59
02:03.0 0607: 104c:ac51
02:03.1 0607: 104c:ac51
02:04.0 0780: 11c1:0450 (rev 02)
02:08.0 0200: 8086:1038 (rev 42)
02:09.0 0401: 125d:1988 (rev 12)
03:00.0 0280: 1260:3890 (rev 01)

Can it be that the smbus is bios disabled?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
