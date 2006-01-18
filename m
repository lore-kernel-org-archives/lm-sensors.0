From: dshiels@cox.net (Dave Shiels)
Date: Wed, 18 Jan 2006 13:09:03 +0000
Subject: [lm-sensors] support for Asus K8N-DL
Message-Id: <43CE3DEF.9060207@cox.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is the Nvidia Crush chip output from lspci -v
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 8162
        Flags: 66Mhz, fast devsel, IRQ 5
        I/O ports at fc00 [size2]
        I/O ports at 1c00 [sized]
        I/O ports at 1c40 [sized]
        Capabilities: [44] Power Management version 2

I suspect the nforce4 will not works here.

