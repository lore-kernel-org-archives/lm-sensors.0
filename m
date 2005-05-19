From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH 2.6] Add ADM1025EB support to i2c-parport
Message-Id: <20040125205333.21f91178.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

The following patch adds support for the ADM1025 evaluation board to the
i2c-parport (and i2c-parport-light) driver(s). In fact, it happens that
it was already supported as an ADM1032 evaluation board, so it is just a
matter of documenting it correctly.

Please apply,
thanks.

--- linux-2.6.2-rc1/drivers/i2c/busses/i2c-parport.h.orig	Wed Jan 21 21:22:29 2004
+++ linux-2.6.2-rc1/drivers/i2c/busses/i2c-parport.h	Sun Jan 25 11:25:37 2004
@@ -67,12 +67,13 @@
 		.getsda	= { 0x40, STAT, 1 },
 		.getscl	= { 0x08, STAT, 1 },
 	},
-	/* type 4: ADM 1032 evaluation board */
+	/* type 4: ADM1025 and ADM1032 evaluation boards */
 	{
 		.setsda	= { 0x02, DATA, 1 },
 		.setscl	= { 0x01, DATA, 1 },
 		.getsda	= { 0x10, STAT, 1 },
-		.init	= { 0xf0, DATA, 0 },
+		.init	= { 0xf0, DATA, 0 }, /* ADM1025 doesn't need this,
+						but it doesn't hurt */
 	},
 };
 
@@ -84,4 +85,4 @@
 	" 1 = home brew teletext adapter\n"
 	" 2 = Velleman K8000 adapter\n"
 	" 3 = ELV adapter\n"
-	" 4 = ADM 1032 evalulation board\n");
+	" 4 = ADM1025 and ADM1032 evaluation boards\n");


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
