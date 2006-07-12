From: greg@kroah.com (Greg KH)
Date: Wed, 12 Jul 2006 23:27:22 +0000
Subject: [lm-sensors] [PATCH 10/13] [PATCH] pca9539: Honor the force
Message-Id: <11527468741731-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Ben Gardner <gardner.ben at gmail.com>

The pca9539 driver doesn't honor the force parameter; it always does
detection. This patch will skip detection if forced.

Signed-off-by: Ben Gardner <gardner.ben at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/chips/pca9539.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/chips/pca9539.c b/drivers/i2c/chips/pca9539.c
index 54b6e6a..cb22280 100644
--- a/drivers/i2c/chips/pca9539.c
+++ b/drivers/i2c/chips/pca9539.c
@@ -134,11 +134,13 @@ static int pca9539_detect(struct i2c_ada
 	new_client->driver = &pca9539_driver;
 	new_client->flags = 0;
 
-	/* Detection: the pca9539 only has 8 registers (0-7).
-	   A read of 7 should succeed, but a read of 8 should fail. */
-	if ((i2c_smbus_read_byte_data(new_client, 7) < 0) ||
-	    (i2c_smbus_read_byte_data(new_client, 8) >= 0))
-		goto exit_kfree;
+	if (kind < 0) {
+		/* Detection: the pca9539 only has 8 registers (0-7).
+		   A read of 7 should succeed, but a read of 8 should fail. */
+		if ((i2c_smbus_read_byte_data(new_client, 7) < 0) ||
+		    (i2c_smbus_read_byte_data(new_client, 8) >= 0))
+			goto exit_kfree;
+	}
 
 	strlcpy(new_client->name, "pca9539", I2C_NAME_SIZE);
 
-- 
1.4.1


