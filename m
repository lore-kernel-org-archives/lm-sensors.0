From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Thu, 13 Mar 2008 01:15:38 +0000
Subject: [lm-sensors] [PATCH] ibmpex: Correct power use multipliers for QS2x
Message-Id: <20080313011538.GA5731@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors <lm-sensors@lm-sensors.org>, linux-kernel <linux-kernel@vger.kernel.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>

The QS2x blades ships with v2.54 of the firmware, which use the same multiplier
for all power meters.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/ibmpex.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
index 9c9cdb0..db551d8 100644
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -327,10 +327,14 @@ static int is_temp_sensor(const char *sensor_id, int len)
 	return 0;
 }
 
-static int power_sensor_multiplier(const char *sensor_id, int len)
+static int power_sensor_multiplier(struct ibmpex_bmc_data *data,
+				   const char *sensor_id, int len)
 {
 	int i;
 
+	if (data->sensor_major = 2)
+		return 1000000;
+
 	for (i = PEX_SENSOR_TYPE_LEN; i < len - 1; i++)
 		if (!memcmp(&sensor_id[i], watt_sensor_sig, PEX_MULT_LEN))
 			return 1000000;
@@ -398,8 +402,9 @@ static int ibmpex_find_sensors(struct ibmpex_bmc_data *data)
 			num_power++;
 			sensor_counter = num_power;
 			data->sensors[i].multiplier -				power_sensor_multiplier(data->rx_msg_data,
-						     data->rx_msg_len);
+				power_sensor_multiplier(data,
+							data->rx_msg_data,
+							data->rx_msg_len);
 		} else if (is_temp_sensor(data->rx_msg_data,
 					  data->rx_msg_len)) {
 			sensor_type = TEMP_SENSOR;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
