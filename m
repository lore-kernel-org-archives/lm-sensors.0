From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 19 Oct 2006 11:52:49 +0000
Subject: [lm-sensors] HP Pavilion ZV6000 & Abituguru?
Message-Id: <45376711.1030108@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200610191334.47848.Samuele.Kaplun@cern.ch>
In-Reply-To: <200610191334.47848.Samuele.Kaplun@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm the maintainer of the abituguru driver, and I must say I find it
highly unlikely that you have an abituguru chip as those are only found
on Abit motherboards. I think pcwizard is bugged here.

Regards,

Hans


I find it highly in

Samuele Kaplun wrote:
> Hello to the list.
> I have an HP Pavilion zv6069EA Laptop. Following your pages I succeeded in 
> using i2c-piix4 with eeprom (but 1st question: what can I do now, since this 
> is not a sensor?) and k8temp. i2c-stub seems to let me find something more, 
> but I'm not sure. 
> My question is: using PCWizard (http://www.cpuid.com/pcwizard.php) for the 
> Windows platform, it discovers that I own an abituguru sensors. 
> If that is true, how can I use it?
> here follows my laptop datas:
> 
> i2c-detect for piix4:
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX
> 
> i2c-detect for stub:
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
> 10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
> 20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
> 30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
> 40: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f
> 50: 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f
> 60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f
> 70: 70 71 72 73 74 75 76 77
> 
> lspci:
> 00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge
> 00:01.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge
> 00:04.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge
> 00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
> 00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
> 00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller
> 00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 10)
> 00:14.1 IDE interface: ATI Technologies Inc Standard Dual Channel PCI IDE 
> Controller ATI
> 00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge
> 00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge
> 00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400 AC'97 
> Audio Controller (rev 01)
> 00:14.6 Modem: ATI Technologies Inc ATI SB400 - AC'97 Modem Controller (rev 
> 01)
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
> HyperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
> Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM 
> Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
> Miscellaneous Control
> 01:05.0 VGA compatible controller: ATI Technologies Inc ATI Radeon XPRESS 200M 
> 5955 (PCIE)
> 03:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 
> Controller (PHY/Link)
> 03:02.0 Network controller: Broadcom Corporation BCM4306 802.11b/g Wireless 
> LAN Controller (rev 03)
> 03:04.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
> 03:04.3 Mass storage controller: Texas Instruments PCIxx21 Integrated 
> FlashMedia Controller
> 03:04.4 Class 0805: Texas Instruments PCI6411, PCI6421, PCI6611, PCI6621, 
> PCI7411, PCI7421, PCI7611, PCI7621 Secure Digital (SD) Controller
> 03:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
> RTL-8139/8139C/8139C+ (rev 10)
> 
> Is there something else you need to know? Will it be possible, then to use 
> abituguru on this machine?
> Kind regards,
> 	Samuele Kaplun

