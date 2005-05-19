From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH] I2C: Fix up some build warnings in the fscpos driver.
Message-Id: <11099685931959@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1109968592905@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: greg@kroah.com

ChangeSet 1.2082, 2005/03/02 11:51:21-08:00, greg@kroah.com

[PATCH] I2C: Fix up some build warnings in the fscpos driver.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/fscpos.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/fscpos.c b/drivers/i2c/chips/fscpos.c
--- a/drivers/i2c/chips/fscpos.c	2005-03-04 12:26:32 -08:00
+++ b/drivers/i2c/chips/fscpos.c	2005-03-04 12:26:32 -08:00
@@ -51,8 +51,6 @@
  * The FSCPOS registers
  */
 
-#define DEBUG
-
 /* chip identification */
 #define FSCPOS_REG_IDENT_0		0x00
 #define FSCPOS_REG_IDENT_1		0x01
@@ -566,10 +564,10 @@
 
 	if ((jiffies - data->last_updated > 2 * HZ) ||
 			(jiffies < data->last_updated) || !data->valid) {
+		int i;
 
 		dev_dbg(&client->dev, "Starting fscpos update\n");
 
-		int i;
 		for (i = 0; i < 3; i++) {
 			data->temp_act[i] = fscpos_read_value(client,
 						FSCPOS_REG_TEMP_ACT[i]);

