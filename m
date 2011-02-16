From: Clemens Ladisch <clemens@ladisch.de>
Date: Wed, 16 Feb 2011 13:01:49 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (jc42) fix type mismatch
Message-Id: <4D5BCABD.1060106@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D5BCA87.7010204@ladisch.de>
In-Reply-To: <4D5BCA87.7010204@ladisch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

In set_temp_crit_hyst(), make the variable 'val' have the correct
type for strict_strtoul().

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 drivers/hwmon/jc42.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -332,7 +332,7 @@ static ssize_t set_temp_crit_hyst(struct
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct jc42_data *data = i2c_get_clientdata(client);
-	long val;
+	unsigned long val;
 	int diff, hyst;
 	int err;
 	int ret = count;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
