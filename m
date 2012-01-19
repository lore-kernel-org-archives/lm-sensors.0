From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:02 +0000
Subject: [lm-sensors] [PATCH 08/82] hwmon: (adm9240) Fix multi-line comments
Message-Id: <1327017376-20466-9-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm9240.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 2de4511..303cdb7 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -756,9 +756,11 @@ static struct adm9240_data *adm9240_update_device(struct device *dev)
 					i2c_smbus_read_byte_data(client,
 					ADM9240_REG_INT(1)) << 8;
 
-		/* read temperature: assume temperature changes less than
+		/*
+		 * read temperature: assume temperature changes less than
 		 * 0.5'C per two measurement cycles thus ignore possible
-		 * but unlikely aliasing error on lsb reading. --Grant */
+		 * but unlikely aliasing error on lsb reading. --Grant
+		 */
 		data->temp = ((i2c_smbus_read_byte_data(client,
 					ADM9240_REG_TEMP) << 8) |
 					i2c_smbus_read_byte_data(client,
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
