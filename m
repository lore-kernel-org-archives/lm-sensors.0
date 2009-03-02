From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 02 Mar 2009 21:04:02 +0000
Subject: [lm-sensors] [PATCH] lm85: Fix the version check that broke adt7468
Message-Id: <20090302210402.GE6550@plum>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

The verstep check in the lm85 driver fails because the upper nibble of the
version register is 0x7, not 0x6, on the adt7468 chip.  Probing of all
adt7468s was broken by 69fc1feba2d5856ff74dedb6ae9d8c490210825c, and this
patch fixes that.  Also add in a missing i2c_device_id that accidentally
got dropped from the original patch.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/lm85.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index cfc1ee9..cf1422e 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -72,6 +72,7 @@ I2C_CLIENT_INSMOD_7(lm85b, lm85c, adm1027, adt7463, adt7468, emc6d100,
 #define	LM85_COMPANY_SMSC		0x5c
 #define	LM85_VERSTEP_VMASK              0xf0
 #define	LM85_VERSTEP_GENERIC		0x60
+#define	LM85_VERSTEP_GENERIC2		0x70
 #define	LM85_VERSTEP_LM85C		0x60
 #define	LM85_VERSTEP_LM85B		0x62
 #define	LM85_VERSTEP_ADM1027		0x60
@@ -334,6 +335,7 @@ static struct lm85_data *lm85_update_device(struct device *dev);
 static const struct i2c_device_id lm85_id[] = {
 	{ "adm1027", adm1027 },
 	{ "adt7463", adt7463 },
+	{ "adt7468", adt7468 },
 	{ "lm85", any_chip },
 	{ "lm85b", lm85b },
 	{ "lm85c", lm85c },
@@ -1153,7 +1155,8 @@ static int lm85_detect(struct i2c_client *client, int kind,
 			address, company, verstep);
 
 		/* All supported chips have the version in common */
-		if ((verstep & LM85_VERSTEP_VMASK) != LM85_VERSTEP_GENERIC) {
+		if ((verstep & LM85_VERSTEP_VMASK) != LM85_VERSTEP_GENERIC &&
+		    (verstep & LM85_VERSTEP_VMASK) != LM85_VERSTEP_GENERIC2) {
 			dev_dbg(&adapter->dev, "Autodetection failed: "
 				"unsupported version\n");
 			return -ENODEV;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
