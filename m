From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 02 Jul 2014 00:29:55 +0000
Subject: [lm-sensors] [PATCH RESEND] hwmon: (adm1029) Ensure the fan_div cache is updated in set_fan_div
Message-Id: <1404260995.7829.5.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Writing to fanX_div does not clear the cache. As a result, reading
from fanX_div may return the old value for up to two seconds
after writing a new value.

This patch ensures the fan_div cache is updated in set_fan_div().

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Sorry, I have a typo in previous patch s/fad_div/fan_div/. So here is a resend.
 drivers/hwmon/adm1029.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 1cd11b3..8c5cdb560 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -242,6 +242,9 @@ static ssize_t set_fan_div(struct device *dev,
 	/* Update the value */
 	reg = (reg & 0x3F) | (val << 6);
 
+	/* Update the cache */
+	data->fan_div[attr->index] = reg;
+
 	/* Write value */
 	i2c_smbus_write_byte_data(client,
 				  ADM1029_REG_FAN_DIV[attr->index], reg);
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
