From: Kevin Hilman <khilman@kernel.org>
Date: Wed, 14 Jan 2015 23:57:32 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ina2xx) Add ina231 compatible string
Message-Id: <1421279852-27965-1-git-send-email-khilman@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org
Cc: linux-samsung-soc@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, open list <linux-kernel@vger.kernel.org>

From: Kevin Hilman <khilman@linaro.org>

Add support for "ina231" as compatible string.

Tested with the Exynos5422-based odroid-xu3 board which has on-board
INA231 sensors.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/hwmon/ina2xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index e01feba909c3..8c4a29bd2eaf 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -287,6 +287,7 @@ static const struct i2c_device_id ina2xx_id[] = {
 	{ "ina220", ina219 },
 	{ "ina226", ina226 },
 	{ "ina230", ina226 },
+	{ "ina231", ina226 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ina2xx_id);
-- 
2.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
