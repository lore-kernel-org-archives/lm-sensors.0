From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [patch] fscpos driver
Message-Id: <20050119232223.GA5880@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050104185338.3296d72d.khali@linux-fr.org>
In-Reply-To: <20050104185338.3296d72d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 19, 2005 at 09:21:29PM +0100, Stefan Ott wrote:
> Hello
> 
> This patch against 2.6.11-rc1 contains a driver for fscpos sensors.

Applied, but I had to add the following patch to fix up some compiler
warnings.  Try to be a bit more careful next time :)

thanks,

greg k-h

------

# I2C: Fix up some build warnings in the fscpos driver.
# 
# Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/i2c/chips/fscpos.c b/drivers/i2c/chips/fscpos.c
--- a/drivers/i2c/chips/fscpos.c	2005-01-19 15:19:14 -08:00
+++ b/drivers/i2c/chips/fscpos.c	2005-01-19 15:19:14 -08:00
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
