From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: [PATCH 2.4] i2c cleanups (4/4)
Message-Id: <20031213203614.2fc6dd05.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@stimpy.netroedge.com>

This small patch fixes the pcmcia sa1100 driver including the i2c.h
header, while it doesn't make any use of it. I found that while working
on my various i2c patches.

Please apply.

--- linux-2.4.24-pre1/drivers/pcmcia/sa1100_stork.c.orig	Tue Jul 15 12:23:03 2003
+++ linux-2.4.24-pre1/drivers/pcmcia/sa1100_stork.c	Sat Dec 13 18:57:40 2003
@@ -24,7 +24,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/i2c.h>
 
 #include <asm/hardware.h>
 #include <asm/irq.h>

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
