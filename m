From: Harvey Harrison <harvey.harrison@gmail.com>
Date: Wed, 27 Aug 2008 15:59:21 +0000
Subject: [lm-sensors] [PATCH] hwmon: ibmpex.c remove inline wrapper of
Message-Id: <1219852761.6069.43.camel@brick>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sparse noticed the helper was missing a cast:
drivers/hwmon/ibmpex.c:43:23: warning: incorrect type in argument 1 (different base types)
drivers/hwmon/ibmpex.c:43:23:    expected restricted __be16 const [usertype] *p
drivers/hwmon/ibmpex.c:43:23:    got unsigned short [usertype] *<noident>

Just open-code the helper as it didn't add anything.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/hwmon/ibmpex.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
index 4e9b19c..abc8fb0 100644
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -38,11 +38,6 @@
 #define PEX_NET_FUNCTION	0x3A
 #define PEX_COMMAND		0x3C
 
-static inline u16 extract_value(const char *data, int offset)
-{
-	return be16_to_cpup((u16 *)&data[offset]);
-}
-
 #define TEMP_SENSOR		1
 #define POWER_SENSOR		2
 
@@ -165,7 +160,7 @@ static int ibmpex_ver_check(struct ibmpex_bmc_data *data)
 		 "v%d.%d %d-%02d-%02d on interface %d\n",
 		 data->sensor_major,
 		 data->sensor_minor,
-		 extract_value(data->rx_msg_data, 2),
+		 be16_to_cpup((__be16 *)&data->rx_msg_data[2]),
 		 data->rx_msg_data[4],
 		 data->rx_msg_data[5],
 		 data->interface);
@@ -247,11 +242,11 @@ static void ibmpex_update_device(struct ibmpex_bmc_data *data)
 		if (err)
 			continue;
 		data->sensors[i].values[0] -			extract_value(data->rx_msg_data, 16);
+			be16_to_cpup((__be16 *)&data->rx_msg_data[16]);
 		data->sensors[i].values[1] -			extract_value(data->rx_msg_data, 18);
+			be16_to_cpup((__be16 *)&data->rx_msg_data[18]);
 		data->sensors[i].values[2] -			extract_value(data->rx_msg_data, 20);
+			be16_to_cpup((__be16 *)&data->rx_msg_data[20]);
 	}
 
 	data->last_updated = jiffies;
-- 
1.6.0.340.g84854




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
