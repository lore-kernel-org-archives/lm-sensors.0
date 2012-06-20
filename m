From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 20 Jun 2012 14:53:30 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (ntc_thermistor) Ensure that data->name string is terminated
Message-Id: <1340204010-14603-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix Coverity warning: Calling strncpy with a maximum size argument of 20 bytes
on destination array "data->name" of size 20 bytes might leave the destination
string unterminated.

Fix by replacing strncpy() with strlcpy() and by using sizeof() to determine
the maximum string length.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Use strlcpy instead of strncpy

 drivers/hwmon/ntc_thermistor.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 6da9696..74a6c58 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -351,7 +351,7 @@ static int __devinit ntc_thermistor_probe(struct platform_device *pdev)
 
 	data->dev = &pdev->dev;
 	data->pdata = pdata;
-	strncpy(data->name, pdev->id_entry->name, PLATFORM_NAME_SIZE);
+	strlcpy(data->name, pdev->id_entry->name, sizeof(data->name));
 
 	switch (pdev->id_entry->driver_data) {
 	case TYPE_NCPXXWB473:
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
