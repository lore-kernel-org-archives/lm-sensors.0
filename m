From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [PATCH] SCx200_ACB depends on PCI
Message-Id: <Pine.LNX.4.61.0410241309580.27184@anakin>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, sensors@stimpy.netroedge.com


SCx200_ACB is a PCI driver and thus should depend on PCI

--- linux-2.6.10-rc1/drivers/i2c/busses/Kconfig.orig	2004-10-23 10:33:01.000000000 +0200
+++ linux-2.6.10-rc1/drivers/i2c/busses/Kconfig	2004-10-24 12:50:17.000000000 +0200
@@ -339,7 +339,7 @@ config SCx200_I2C_SDA
 
 config SCx200_ACB
 	tristate "NatSemi SCx200 ACCESS.bus"
-	depends on I2C
+	depends on I2C && PCI
 	help
 	  Enable the use of the ACCESS.bus controllers of a SCx200 processor.
 
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
