From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 May 2014 19:01:51 +0000
Subject: [lm-sensors] [PATCH 9/9] hwmon: (emc1403) Add device IDs for EMC1412, EMC1413, and EMC1414
Message-Id: <1399921311-9524-10-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

EMC1412, EMC1413, and EMC1414 are fully compatible to EMC1402, EMC1403,
and EMC1404, and even report the same chip ID. Add to device ID table
to enable instantiation with correct chip names.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/emc1403.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 9b1c45c..a40d35f 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -471,6 +471,9 @@ static const struct i2c_device_id emc1403_idtable[] = {
 	{ "emc1402", emc1402 },
 	{ "emc1403", emc1403 },
 	{ "emc1404", emc1404 },
+	{ "emc1412", emc1402 },
+	{ "emc1413", emc1403 },
+	{ "emc1414", emc1404 },
 	{ "emc1422", emc1402 },
 	{ "emc1423", emc1403 },
 	{ "emc1424", emc1404 },
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
