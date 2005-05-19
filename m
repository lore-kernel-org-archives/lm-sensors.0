From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: [PATCH 2.4] i2c cleanups, third wave (2/8)
Message-Id: <20040111145917.0f29a79f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111144214.7a6a4e59.khali@linux-fr.org>
In-Reply-To: <20040111144214.7a6a4e59.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>

Remove old debugging stuff ("SLO_IO") from two algorithms
(i2c-algo-bit and i2c-algo-ite). This is unused and wouldn't even
compile if commented out.

A similar patch was sent to Greg KH for linux 2.6 and was applied in
2.6.1-rc1.

Note that this patch was voluntarily generated using diff -U2, because
it contains only removals, so much context isn't required.


diff -U2 -rN linux-2.4.24-pre3/drivers/i2c/i2c-algo-bit.c linux-2.4.24-pre3-k1/drivers/i2c/i2c-algo-bit.c
--- linux-2.4.24-pre3/drivers/i2c/i2c-algo-bit.c	2003-12-31 14:50:59.000000000 +0100
+++ linux-2.4.24-pre3-k1/drivers/i2c/i2c-algo-bit.c	2004-01-05 09:44:26.000000000 +0100
@@ -44,20 +44,7 @@
  	/* debug the protocol by showing transferred bits */
 
-/* debugging - slow down transfer to have a look at the data .. 	*/
-/* I use this with two leds&resistors, each one connected to sda,scl 	*/
-/* respectively. This makes sure that the algorithm works. Some chips   */
-/* might not like this, as they have an internal timeout of some mils	*/
-/*
-#define SLO_IO      jif=jiffies;while(time_before_eq(jiffies, jif+i2c_table[minor].veryslow))\
-                        if (need_resched) schedule();
-*/
-
 
 /* ----- global variables ---------------------------------------------	*/
 
-#ifdef SLO_IO
-	int jif;
-#endif
-
 /* module parameters:
  */
@@ -89,7 +76,4 @@
 	setscl(adap,0);
 	udelay(adap->udelay);
-#ifdef SLO_IO
-	SLO_IO
-#endif
 }
 
@@ -124,7 +108,4 @@
 	}
 	DEBSTAT(printk(KERN_DEBUG "needed %ld jiffies\n", jiffies-start));
-#ifdef SLO_IO
-	SLO_IO
-#endif
 	return 0;
 } 
diff -U2 -rN linux-2.4.24-pre3/drivers/i2c/i2c-algo-ite.c linux-2.4.24-pre3-k1/drivers/i2c/i2c-algo-ite.c
--- linux-2.4.24-pre3/drivers/i2c/i2c-algo-ite.c	2003-12-31 14:50:59.000000000 +0100
+++ linux-2.4.24-pre3-k1/drivers/i2c/i2c-algo-ite.c	2004-01-05 09:43:53.000000000 +0100
@@ -61,20 +61,7 @@
 #define DEF_TIMEOUT 16
 
-/* debugging - slow down transfer to have a look at the data .. 	*/
-/* I use this with two leds&resistors, each one connected to sda,scl 	*/
-/* respectively. This makes sure that the algorithm works. Some chips   */
-/* might not like this, as they have an internal timeout of some mils	*/
-/*
-#define SLO_IO      jif=jiffies;while(jiffies<=jif+i2c_table[minor].veryslow)\
-                        if (need_resched) schedule();
-*/
-
 
 /* ----- global variables ---------------------------------------------	*/
 
-#ifdef SLO_IO
-	int jif;
-#endif
-
 /* module parameters:
  */

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
