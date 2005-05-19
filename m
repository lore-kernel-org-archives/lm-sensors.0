From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH 2.6] Fix bus reset in i2c-philips-par
Message-Id: <20040123213024.79b69112.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This patch fixes the bus reset in i2c-philips-par when it is loaded with
type!=0. For now, the reset is always made as is type=0. I guess that
this driver will be abandoned in a while, but it probably doesn't hurt
to fix that.

I've committed a similar fix to our i2c CVS repository, and will send a
patch to Marcelo someday, in case he is interested in the fix for 2.4
too.

Thanks.

--- linux-2.6.2-rc1/drivers/i2c/busses/i2c-philips-par.c.orig	2004-01-23 11:28:51.000000000 +0100
+++ linux-2.6.2-rc1/drivers/i2c/busses/i2c-philips-par.c	2004-01-23 15:42:30.000000000 +0100
@@ -184,8 +184,8 @@
 		return;
 	}
 	/* reset hardware to sane state */
-	bit_lp_setsda(port, 1);
-	bit_lp_setscl(port, 1);
+	adapter->bit_lp_data.setsda(port, 1);
+	adapter->bit_lp_data.setscl(port, 1);
 	parport_release(adapter->pdev);
 
 	if (i2c_bit_add_bus(&adapter->adapter) < 0) {


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
