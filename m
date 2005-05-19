From: tilman.giese@globalview.de (Tilman Giese)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: [1133] i2c-sis645 conflicts with sis900
Message-Id: <200302171526.29053.tilman.giese@globalview.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> interesting. please send us the output of ?lspci? and ?lspci -n?.
> by email, reference your ticket number.

Here it is:

# lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 645 Host (rev 02)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS961 [MuTIOL Media IO]
00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 90)
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:08.0 VGA compatible controller: Matrox Graphics, Inc. MGA 1064SG [Mystique] 
(rev 03)
00:0a.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 43)

# lspci -n
00:00.0 Class 0600: 1039:0645 (rev 02)
00:01.0 Class 0604: 1039:0001
00:02.0 Class 0601: 1039:0961
00:02.2 Class 0c03: 1039:7001 (rev 07)
00:02.3 Class 0c03: 1039:7001 (rev 07)
00:02.5 Class 0101: 1039:5513 (rev d0)
00:03.0 Class 0200: 1039:0900 (rev 90)
00:05.0 Class 0401: 13f6:0111 (rev 10)
00:08.0 Class 0300: 102b:051a (rev 03)
00:0a.0 Class 0200: 1106:3065 (rev 43)

I hope it helps.

Tilman Giese
