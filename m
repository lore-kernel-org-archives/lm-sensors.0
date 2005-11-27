From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 27 Nov 2005 08:56:08 +0000
Subject: [lm-sensors] [PATCH 09/25] i2c: Drop i2c_driver.flags, 3 of 3
Message-Id: <20051127085710.543e31ce.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> -EWRONGPATCH ?  This one is the same as 23/25 in the series.

Damn, you're right :( Here comes the right patch, sorry for the noise.
Thanks for watching me Mark.

* * * * *

Content-Disposition: inline; filename=i2c-drop-driver-flags-03-flags.patch

The flags member of the i2c_driver structure is no more used. Drop it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 include/linux/i2c.h |    3 ---
 1 file changed, 3 deletions(-)

--- linux-2.6.15-rc1.orig/include/linux/i2c.h	2005-11-15 23:05:48.000000000 +0100
+++ linux-2.6.15-rc1/include/linux/i2c.h	2005-11-15 23:05:55.000000000 +0100
@@ -112,7 +112,6 @@
 	char name[32];
 	int id;
 	unsigned int class;
-	unsigned int flags;		/* div., see below		*/
 
 	/* Notifies the driver that a new bus has appeared. This routine
 	 * can be used by the driver to test if the bus meets its conditions
@@ -250,8 +249,6 @@
 	dev_set_drvdata (&dev->dev, data);
 }
 
-/*flags for the driver struct: */
-
 /*flags for the client struct: */
 #define I2C_CLIENT_ALLOW_USE		0x01	/* Client allows access */
 #define I2C_CLIENT_ALLOW_MULTIPLE_USE 	0x02  	/* Allow multiple access-locks */



-- 
Jean Delvare
