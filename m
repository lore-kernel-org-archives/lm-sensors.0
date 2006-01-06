From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:35 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop i2c_driver.flags, 3 of 3
Message-Id: <1136585255974@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop i2c_driver.flags, 3 of 3

The flags member of the i2c_driver structure is no more used. Drop it.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 5d7b851dcced3611e4a4432308618b1ed1a9fc31
tree 26f847cf68fe004827e4dfb588674d2bdfc3fdc6
parent 8a9947552d43b0d20d5fa23ac0ba435d526be454
author Jean Delvare <khali at linux-fr.org> Sun, 27 Nov 2005 08:57:10 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:22 -0800

 include/linux/i2c.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 99399fa..3c16a8f 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -112,7 +112,6 @@ struct i2c_driver {
 	char name[32];
 	int id;
 	unsigned int class;
-	unsigned int flags;		/* div., see below		*/
 
 	/* Notifies the driver that a new bus has appeared. This routine
 	 * can be used by the driver to test if the bus meets its conditions
@@ -250,8 +249,6 @@ static inline void i2c_set_adapdata (str
 	dev_set_drvdata (&dev->dev, data);
 }
 
-/*flags for the driver struct: */
-
 /*flags for the client struct: */
 #define I2C_CLIENT_ALLOW_USE		0x01	/* Client allows access */
 #define I2C_CLIENT_ALLOW_MULTIPLE_USE 	0x02  	/* Allow multiple access-locks */


