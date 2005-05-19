From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: [PATCH] i2c driver fixes for 2.6.2-rc2
Message-Id: <10752464532280@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10752464533223@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.148.4, 2004/01/26 16:58:46-08:00, khali@linux-fr.org

[PATCH] I2C: Add ADM1025EB support to i2c-parport

The following patch adds support for the ADM1025 evaluation board to the
i2c-parport (and i2c-parport-light) driver(s). In fact, it happens that
it was already supported as an ADM1032 evaluation board, so it is just a
matter of documenting it correctly.


 drivers/i2c/busses/i2c-parport.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-parport.h b/drivers/i2c/busses/i2c-parport.h
--- a/drivers/i2c/busses/i2c-parport.h	Tue Jan 27 15:26:57 2004
+++ b/drivers/i2c/busses/i2c-parport.h	Tue Jan 27 15:26:57 2004
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

