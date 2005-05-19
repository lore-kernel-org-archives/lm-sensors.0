From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: [PATCH] I2C update for 2.6.7-rc1
Message-Id: <10857816431433@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10857816431296@kroah.com>
References: <1085781643100@kroah.com>
In-Reply-To: <1085781643100@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1717.6.29, 2004/05/28 13:47:51-07:00, khali@linux-fr.org

[PATCH] I2C: i2c-parport: support the ADM1031 evaluation board

The following patch adds support for the ADM1030 and ADM1031 evaluation
boards to the i2c-parport and i2c-parport-light drivers. They are almost
compatible with the already supported ADM1025 and ADM1032 boards, except
that the ADM1032 board needs some pins to be set high to draw its power,
while the same pins power up heating resistors on the ADM1031 board. I
considered it was a bit dangerous to do that by default, so I ended up
with two different device definitions, one with powering pins set, and
one with these pins cleared.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-parport.h |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-parport.h b/drivers/i2c/busses/i2c-parport.h
--- a/drivers/i2c/busses/i2c-parport.h	Fri May 28 14:52:07 2004
+++ b/drivers/i2c/busses/i2c-parport.h	Fri May 28 14:52:07 2004
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

