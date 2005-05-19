From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:59 +0000
Subject: [PATCH 2.6] i2c-parport: support the ADM1031 evaluation board
Message-Id: <20040522225324.572fcdc9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

The following patch adds support for the ADM1030 and ADM1031 evaluation
boards to the i2c-parport and i2c-parport-light drivers. They are almost
compatible with the already supported ADM1025 and ADM1032 boards, except
that the ADM1032 board needs some pins to be set high to draw its power,
while the same pins power up heating resistors on the ADM1031 board. I
considered it was a bit dangerous to do that by default, so I ended up
with two different device definitions, one with powering pins set, and
one with these pins cleared.

Please apply,
thanks.

--- linux-2.6.6-rc3/drivers/i2c/busses/i2c-parport.h.orig	Thu Feb  5 22:24:55 2004
+++ linux-2.6.6-rc3/drivers/i2c/busses/i2c-parport.h	Sat May  1 18:01:02 2004
@@ -67,13 +67,18 @@
 		.getsda	= { 0x40, STAT, 1 },
 		.getscl	= { 0x08, STAT, 1 },
 	},
-	/* type 4: ADM1025 and ADM1032 evaluation boards */
+	/* type 4: ADM1032 evaluation board */
+	{
+		.setsda	= { 0x02, DATA, 1 },
+		.setscl	= { 0x01, DATA, 1 },
+		.getsda	= { 0x10, STAT, 1 },
+		.init	= { 0xf0, DATA, 0 },
+	},
+	/* type 5: ADM1025, ADM1030 and ADM1031 evaluation boards */
 	{
 		.setsda	= { 0x02, DATA, 1 },
 		.setscl	= { 0x01, DATA, 1 },
 		.getsda	= { 0x10, STAT, 1 },
-		.init	= { 0xf0, DATA, 0 }, /* ADM1025 doesn't need this,
-						but it doesn't hurt */
 	},
 };
 
@@ -85,4 +90,5 @@
 	" 1 = home brew teletext adapter\n"
 	" 2 = Velleman K8000 adapter\n"
 	" 3 = ELV adapter\n"
-	" 4 = ADM1025 and ADM1032 evaluation boards\n");
+	" 4 = ADM1032 evaluation board\n"
+	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n");


-- 
Jean Delvare
http://khali.linux-fr.org/
