From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:58:34 +0000
Subject: [lm-sensors] [patch 21/36] hwmon: (w83795) Report PECI agent Tbase
Message-Id: <20100915155834.3a67bd70@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On systems with PECI, report PECI agent Tbase temperature values.
This is informative only.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:13:52.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:13:54.000000000 +0200
@@ -236,6 +236,7 @@ static const u8 IN_LSB_SHIFT_IDX[][2]  #define W83795_REG_DTSC			0x301
 #define W83795_REG_DTSE			0x302
 #define W83795_REG_DTS(index)		(0x26 + (index))
+#define W83795_REG_PECI_TBASE(index)	(0x320 + (index))
 
 #define DTS_CRIT			0
 #define DTS_CRIT_HYST			1
@@ -1993,6 +1994,18 @@ static int w83795_probe(struct i2c_clien
 		data->has_dts = w83795_read(client, W83795_REG_DTSE);
 	}
 
+	/* Report PECI Tbase values */
+	if (data->enable_dts = 1) {
+		for (i = 0; i < 8; i++) {
+			if (!(data->has_dts & (1 << i)))
+				continue;
+			tmp = w83795_read(client, W83795_REG_PECI_TBASE(i));
+			dev_info(&client->dev,
+				 "PECI agent %d Tbase temperature: %u\n",
+				 i + 1, (unsigned int)tmp & 0x7f);
+		}
+	}
+
 	/* First update the voltages measured value and limits */
 	for (i = 0; i < ARRAY_SIZE(data->in); i++) {
 		if (!(data->has_in & (1 << i)))


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
