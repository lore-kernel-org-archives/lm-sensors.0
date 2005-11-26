From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:57:33 +0000
Subject: [lm-sensors] [PATCH 21/25] i2c: Rework client usage count, 1 of 3
Message-Id: <20051126205835.29f1b5e8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-client-use-01-drop-multiple-use-flag.patch

No i2c client uses the I2C_CLIENT_ALLOW_MULTIPLE_USE flag, drop it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/i2c-core.c |    4 +---
 include/linux/i2c.h    |    2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

--- linux-2.6.15-rc1.orig/drivers/i2c/i2c-core.c	2005-11-15 23:05:59.000000000 +0100
+++ linux-2.6.15-rc1/drivers/i2c/i2c-core.c	2005-11-15 23:06:30.000000000 +0100
@@ -500,9 +500,7 @@
 		return ret;
 
 	if (client->flags & I2C_CLIENT_ALLOW_USE) {
-		if (client->flags & I2C_CLIENT_ALLOW_MULTIPLE_USE)
-			client->usage_count++;
-		else if (client->usage_count > 0) 
+		if (client->usage_count > 0)
 			goto busy;
 		else 
 			client->usage_count++;
--- linux-2.6.15-rc1.orig/include/linux/i2c.h	2005-11-15 23:05:59.000000000 +0100
+++ linux-2.6.15-rc1/include/linux/i2c.h	2005-11-15 23:06:30.000000000 +0100
@@ -252,8 +252,6 @@
 
 /*flags for the client struct: */
 #define I2C_CLIENT_ALLOW_USE		0x01	/* Client allows access */
-#define I2C_CLIENT_ALLOW_MULTIPLE_USE 	0x02  	/* Allow multiple access-locks */
-						/* on an i2c_client */
 #define I2C_CLIENT_PEC  0x04			/* Use Packet Error Checking */
 #define I2C_CLIENT_TEN	0x10			/* we have a ten bit chip address	*/
 						/* Must equal I2C_M_TEN below */

-- 
Jean Delvare
