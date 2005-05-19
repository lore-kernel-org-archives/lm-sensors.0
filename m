From: robe@amd.co.at (Michael Renner)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Problems with Tyan Thunder LE-T
Message-Id: <Pine.LNX.4.50.0312052212300.7299-100000@trottelkunde.amd.co.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

I was trying to get I2C/lm_sensors running on one of our "refurbished"
servers, but ran into freezes while loading the i2c-piix driver.

Here's some basic info:

Kernel: 2.4.23 with modularized i2c/lm_sensors 2.8.1 or 2.6.0test11 with
builtin i2c/lm_sensors
Motherboard: Tyan Thunder LE-t (S2518) (flashed with the latest bios
(1.09))
lspci states:

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller

Currently running with SMP (two P3 1266 Mhz processors) and HIGHMEM (3 GB
ram) support.

As soon as I load the i2c-piix driver, it seems as if the userland commits
suicide:

Local console is dead (numlock works though), the box still responds to
icmp messages and accepts new tcp-connections on previously-openend ports
(e.g. ssh) (although no daemon actually responds on that port)

You can find the kernel output before the freeze at
http://amd.co.at/images/i2c-bug.jpg

Is this something which can be fixed in the driver or is the BIOS
fubar'ed?

Do you need any further information?

best regards and thanks in advance,
michael
