From: bob@cemetery.homeunix.org (Andrew Basterfield)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: lm_sensors on gigabyte GA-5AA (Alladin V chipset)
Message-Id: <20030227120157.0a3303df.bob@cemetery.homeunix.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I've been trying to get the motherboard sensors to work on my gigabyte
GA-5AA (Alladin V chipset) board, I know they are there 'cos my fan has
3 wires, and a few years back I got some motherboard voltages in
window$.

It seems that i2c bus should be supported by the ali15x3 driver (agpgart
and the IDE driver both report ALI15x3) but it won't find it. I am
running kernel 2.5.53 with the 2.5.53-i2c-1-patch & 2.5.53-i2c-5-patch
linked from your website. The patches don't apply cleanly to virgin
kernel source, I had to merge bits in by hand.

Any suggestions where to start hacking would be appreciated.

root@snot:bob# lspci
00:00.0 Host bridge: Acer Laboratories Inc. M1541 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. M5243 (rev 04)
00:02.0 USB Controller: Acer Laboratories Inc. M5237 (rev 03)
00:07.0 ISA bridge: Acer Laboratories Inc. M1533 (rev c3)
00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 24)
00:0f.0 IDE interface: Acer Laboratories Inc. M5229 (rev c1)
01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8a13 (rev 02)

root@snot:bob# scanpci 

pci bus 0x0000 cardnum 0x00 function 0x00: vendor 0x10b9 device 0x1541
 ALI  Device unknown

pci bus 0x0000 cardnum 0x01 function 0x00: vendor 0x10b9 device 0x5243
 ALI  Device unknown

pci bus 0x0000 cardnum 0x02 function 0x00: vendor 0x10b9 device 0x5237
 ALI  Device unknown

pci bus 0x0000 cardnum 0x07 function 0x00: vendor 0x10b9 device 0x1533
 ALI M1533 Aladdin IV

pci bus 0x0000 cardnum 0x09 function 0x00: vendor 0x10b7 device 0x9055
 3COM  Device unknown

pci bus 0x0000 cardnum 0x0f function 0x00: vendor 0x10b9 device 0x5229
 ALI M5229 TXpro

pci bus 0x0001 cardnum 0x00 function 0x00: vendor 0x5333 device 0x8a13
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030227/34b0784a/attachment.bin
