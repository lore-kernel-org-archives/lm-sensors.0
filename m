From: Axel Lin <axel.lin@gmail.com>
Date: Tue, 09 Nov 2010 01:40:34 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ad7414) Return proper error code for
Message-Id: <1289266834.14461.3.camel@mola>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>, Sean MacLennan <smaclennan@pikatech.com>, lm-sensors@lm-sensors.org

Return proper error if i2c_check_functionality reports
the adapter does not support the capability we need.

Also remove unneeded initialization for err variable.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hwmon/ad7414.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
index 1e4c21f..86d822a 100644
--- a/drivers/hwmon/ad7414.c
+++ b/drivers/hwmon/ad7414.c
@@ -178,11 +178,13 @@ static int ad7414_probe(struct i2c_client *client,
 {
 	struct ad7414_data *data;
 	int conf;
-	int err = 0;
+	int err;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
-				     I2C_FUNC_SMBUS_READ_WORD_DATA))
+				     I2C_FUNC_SMBUS_READ_WORD_DATA)) {
+		err = -EOPNOTSUPP;
 		goto exit;
+	}
 
 	data = kzalloc(sizeof(struct ad7414_data), GFP_KERNEL);
 	if (!data) {
-- 
1.7.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
