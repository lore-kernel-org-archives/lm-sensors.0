From: wah@uiuc.edu (Benjamin W. Wah)
Date: Thu, 09 Feb 2006 21:49:01 +0000
Subject: [lm-sensors] Question on PowerEdge 1850
Message-Id: <006901c62dc2$a3b855f0$2b8e7e82@trace3>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 

Would you please tell me whether lmsensors would run on the Dell PowerEduge
1850?  The following is the information on the machine:

 

[root at el236gw lm_sensors-2.9.2]# lspci

00:00.0 Host bridge: Intel Corporation E7520 Memory Controller Hub (rev 09)

00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express Port A
(rev 09)

00:04.0 PCI bridge: Intel Corporation E7525/E7520 PCI Express Port B (rev
09)

00:05.0 PCI bridge: Intel Corporation E7520 PCI Express Port B1 (rev 09)

00:06.0 PCI bridge: Intel Corporation E7520 PCI Express Port C (rev 09)

00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI
Controller #1 (rev 02)

00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI
Controller #2 (rev 02)

00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI
#3 (rev 02)

00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI
Controller (rev 02)

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)

00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface
Bridge (rev 02)

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE
Controller (rev 02)

01:00.0 PCI bridge: Intel Corporation 80332 [Dobson] I/O processor (rev 06)

01:00.2 PCI bridge: Intel Corporation 80332 [Dobson] I/O processor (rev 06)

02:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X
Fusion-MPT Dual Ultra320 SCSI (rev 08)

02:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)

03:0b.0 Network controller: Texas Instruments ACX 111 54Mbps Wireless
Interface

05:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge A
(rev 09)

05:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge B
(rev 09)

06:07.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet
Controller (rev 05)

07:08.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet
Controller (rev 05)

09:0d.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY
[Radeon 7000/VE]

 

[root at el236gw lm_sensors-2.9.2]# cat //proc/pci

PCI devices found:

  Bus  0, device   0, function  0:

    Class 0600: PCI device 8086:3590 (rev 9).

  Bus  0, device   2, function  0:

    Class 0604: PCI device 8086:3595 (rev 9).

      IRQ 169.

      Master Capable.  No bursts.  Min Gnt=7.

  Bus  0, device   4, function  0:

    Class 0604: PCI device 8086:3597 (rev 9).

      IRQ 169.

      Master Capable.  No bursts.  Min Gnt=7.

  Bus  0, device   5, function  0:

    Class 0604: PCI device 8086:3598 (rev 9).

      IRQ 169.

      Master Capable.  No bursts.  Min Gnt=7.

  Bus  0, device   6, function  0:

    Class 0604: PCI device 8086:3599 (rev 9).

      IRQ 169.

      Master Capable.  No bursts.  Min Gnt=7.

  Bus  0, device  29, function  0:

    Class 0c03: PCI device 8086:24d2 (rev 2).

      IRQ 169.

      I/O at 0xace0 [0xacff].

  Bus  0, device  29, function  1:

    Class 0c03: PCI device 8086:24d4 (rev 2).

      IRQ 217.

      I/O at 0xacc0 [0xacdf].

  Bus  0, device  29, function  2:

    Class 0c03: PCI device 8086:24d7 (rev 2).

      IRQ 225.

      I/O at 0xaca0 [0xacbf].

  Bus  0, device  29, function  7:

    Class 0c03: PCI device 8086:24dd (rev 2).

      IRQ 209.

      Non-prefetchable 32 bit memory at 0xdff00000 [0xdff003ff].

  Bus  0, device  30, function  0:

    Class 0604: PCI device 8086:244e (rev 194).

      Master Capable.  No bursts.  Min Gnt.

  Bus  0, device  31, function  0:

    Class 0601: PCI device 8086:24d0 (rev 2).

  Bus  0, device  31, function  1:

    Class 0101: PCI device 8086:24db (rev 2).

      I/O at 0xfc00 [0xfc0f].

      Non-prefetchable 32 bit memory at 0x40000000 [0x400003ff].

  Bus  1, device   0, function  0:

    Class 0604: PCI device 8086:0330 (rev 6).

      Master Capable.  No bursts.  Min Gnt=7.

  Bus  1, device   0, function  2:

    Class 0604: PCI device 8086:0332 (rev 6).

      Master Capable.  No bursts.  Min Gnt=7.

  Bus  2, device   5, function  0:

    Class 0100: PCI device 1000:0030 (rev 8).

      IRQ 177.

      Master Capable.  Latencyr.  Min Gnt.Max Lat.

      I/O at 0xec00 [0xecff].

      Non-prefetchable 64 bit memory at 0xdfdf0000 [0xdfdfffff].

      Non-prefetchable 64 bit memory at 0xdfde0000 [0xdfdeffff].

  Bus  2, device  12, function  0:

    Class 0200: PCI device 10ec:8139 (rev 16).

      IRQ 201.

      Master Capable.  Latency2.  Min Gnt2.Max Latd.

      I/O at 0xe800 [0xe8ff].

      Non-prefetchable 32 bit memory at 0xdfddfc00 [0xdfddfcff].

  Bus  3, device  11, function  0:

    Class 0280: PCI device 104c:9066 (rev 0).

      IRQ 7.

      Master Capable.  Latency2.  

      Non-prefetchable 32 bit memory at 0xdfbfe000 [0xdfbfffff].

      Non-prefetchable 32 bit memory at 0xdfbc0000 [0xdfbdffff].

  Bus  5, device   0, function  0:

    Class 0604: PCI device 8086:0329 (rev 9).

      Master Capable.  No bursts.  Min Gnt=7.

  Bus  5, device   0, function  2:

    Class 0604: PCI device 8086:032a (rev 9).

      Master Capable.  No bursts.  Min Gnt=7.

  Bus  6, device   7, function  0:

    Class 0200: PCI device 8086:1076 (rev 5).

      IRQ 185.

      Master Capable.  Latency2.  Min Gnt%5.

      Non-prefetchable 32 bit memory at 0xdf8e0000 [0xdf8fffff].

      I/O at 0xdcc0 [0xdcff].

  Bus  7, device   8, function  0:

    Class 0200: PCI device 8086:1076 (rev 5).

      IRQ 193.

      Master Capable.  Latency2.  Min Gnt%5.

      Non-prefetchable 32 bit memory at 0xdf6e0000 [0xdf6fffff].

      I/O at 0xccc0 [0xccff].

  Bus  9, device  13, function  0:

    Class 0300: PCI device 1002:5159 (rev 0).

      IRQ 225.

      Master Capable.  Latency2.  Min Gnt=8.

      Prefetchable 32 bit memory at 0xd0000000 [0xd7ffffff].

      I/O at 0xbc00 [0xbcff].

      Non-prefetchable 32 bit memory at 0xdf3f0000 [0xdf3fffff].

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060209/bb7d0e11/attachment-0001.html
