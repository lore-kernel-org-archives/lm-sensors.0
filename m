From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:02:15 +0000
Subject: [lm-sensors] [patch 31/36] hwmon: (w83795) Pack similar register
Message-Id: <20100915160215.1c05d9a3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Pack similar register reads using for loops.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:15:24.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:15:29.000000000 +0200
@@ -1938,26 +1938,16 @@ static int w83795_probe(struct i2c_clien
 	for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
 		if (!(data->has_temp & (1 << i)))
 			continue;
-		data->temp[i][TEMP_CRIT] -			w83795_read(client, W83795_REG_TEMP[i][TEMP_CRIT]);
-		data->temp[i][TEMP_CRIT_HYST] -			w83795_read(client, W83795_REG_TEMP[i][TEMP_CRIT_HYST]);
-		data->temp[i][TEMP_WARN] -			w83795_read(client, W83795_REG_TEMP[i][TEMP_WARN]);
-		data->temp[i][TEMP_WARN_HYST] -			w83795_read(client, W83795_REG_TEMP[i][TEMP_WARN_HYST]);
+		for (tmp = TEMP_CRIT; tmp <= TEMP_WARN_HYST; tmp++)
+			data->temp[i][tmp] +				w83795_read(client, W83795_REG_TEMP[i][tmp]);
 	}
 
 	/* Read the DTS limits */
 	if (data->enable_dts != 0) {
-		data->dts_ext[DTS_CRIT] -			w83795_read(client, W83795_REG_DTS_EXT(DTS_CRIT));
-		data->dts_ext[DTS_CRIT_HYST] -			w83795_read(client, W83795_REG_DTS_EXT(DTS_CRIT_HYST));
-		data->dts_ext[DTS_WARN] -			w83795_read(client, W83795_REG_DTS_EXT(DTS_WARN));
-		data->dts_ext[DTS_WARN_HYST] -			w83795_read(client, W83795_REG_DTS_EXT(DTS_WARN_HYST));
+		for (i = DTS_CRIT; i <= DTS_WARN_HYST; i++)
+			data->dts_ext[i] +				w83795_read(client, W83795_REG_DTS_EXT(i));
 	}
 
 	/* First update temp source selction */


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
