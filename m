From: Michael Thalmeier <michael.thalmeier@hale.at>
Date: Tue, 18 Nov 2014 16:08:04 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (lm75) Add support for the NXP LM75B
Message-Id: <1416326884-22623-1-git-send-email-michael.thalmeier@hale.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

It is basically a faster lm75 with improved (11 bit) resolution.

Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
---
v2: keep alphabetic order

 Documentation/hwmon/lm75 | 5 +++++
 drivers/hwmon/lm75.c     | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/hwmon/lm75 b/Documentation/hwmon/lm75
index c6a5ff1..67691a0a 100644
--- a/Documentation/hwmon/lm75
+++ b/Documentation/hwmon/lm75
@@ -53,6 +53,11 @@ Supported chips:
                http://www.ti.com/product/tmp75
                http://www.ti.com/product/tmp175
                http://www.ti.com/product/tmp275
+  * NXP LM75B
+    Prefix: 'lm75b'
+    Addresses scanned: none
+    Datasheet: Publicly available at the NXP website
+               http://www.nxp.com/documents/data_sheet/LM75B.pdf
 
 Author: Frodo Looijaard <frodol@dds.nl>
 
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index d16dbb33a..f58439b 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -44,6 +44,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
 	g751,
 	lm75,
 	lm75a,
+	lm75b,
 	max6625,
 	max6626,
 	mcp980x,
@@ -233,6 +234,10 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		data->resolution = 9;
 		data->sample_time = HZ / 2;
 		break;
+	case lm75b:
+		data->resolution = 11;
+		data->sample_time = HZ / 4;
+		break;
 	case max6625:
 		data->resolution = 9;
 		data->sample_time = HZ / 4;
@@ -322,6 +327,7 @@ static const struct i2c_device_id lm75_ids[] = {
 	{ "g751", g751, },
 	{ "lm75", lm75, },
 	{ "lm75a", lm75a, },
+	{ "lm75b", lm75b, },
 	{ "max6625", max6625, },
 	{ "max6626", max6626, },
 	{ "mcp980x", mcp980x, },
-- 
1.9.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
