From: olaf@fortytwo.eu.org (Olaf)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: Ticket #1545
Message-Id: <40140EAE.1010706@fortytwo.eu.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi *,

as mentioned in this ticked I checked by using lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] 
(rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 22)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev 30)
00:05.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 03)
00:0a.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 
[FasterNet] (rev 22)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF
02:04.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 05)
02:05.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 05)

Board is Asus CUV4X-CM.

dmesg iss full of iptables messages (it is a server), and I cannot reboot it 
right now - but will do if you need more input.

Regards
Olaf
