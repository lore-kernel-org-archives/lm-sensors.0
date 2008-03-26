From: Juerg Haefliger <juergh@gmail.com>
Date: Wed, 26 Mar 2008 04:49:15 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon (dme1737): fix voltage scaling
Message-Id: <47E9D5CB.2090205@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020306000104070207000004"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020306000104070207000004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a voltage scaling issue for the sch311x device.

Signed-Off-By: Juerg Haefliger <juergh at gmail.com>

--------------020306000104070207000004
Content-Type: text/plain;
 name="dme1737-fix-voltage-scaling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dme1737-fix-voltage-scaling.patch"

This patch fixes a voltage scaling issue for the sch311x device.

Signed-Off-By: Juerg Haefliger <juergh at gmail.com>
Index: linux/drivers/hwmon/dme1737.c
===================================================================
--- linux.orig/drivers/hwmon/dme1737.c	2008-03-15 22:25:06.000000000 -0700
+++ linux/drivers/hwmon/dme1737.c	2008-03-15 23:01:21.000000000 -0700
@@ -181,6 +181,7 @@
 	int valid;			/* !=0 if following fields are valid */
 	unsigned long last_update;	/* in jiffies */
 	unsigned long last_vbat;	/* in jiffies */
+	enum chips type;
 
 	u8 vid;
 	u8 pwm_rr_en;
@@ -215,20 +216,27 @@
 };
 
 /* Nominal voltage values */
-static const int IN_NOMINAL[] = {5000, 2250, 3300, 5000, 12000, 3300, 3300};
+static const int IN_NOMINAL_DME1737[] = {5000, 2250, 3300, 5000, 12000, 3300,
+					 3300};
+static const int IN_NOMINAL_SCH311x[] = {2500, 1500, 3300, 5000, 12000, 3300,
+					 3300};
+#define IN_NOMINAL(ix, type)	(((type) == dme1737) ? \
+				IN_NOMINAL_DME1737[(ix)] : \
+				IN_NOMINAL_SCH311x[(ix)])
 
 /* Voltage input
  * Voltage inputs have 16 bits resolution, limit values have 8 bits
  * resolution. */
-static inline int IN_FROM_REG(int reg, int ix, int res)
+static inline int IN_FROM_REG(int reg, int ix, int res, int type)
 {
-	return (reg * IN_NOMINAL[ix] + (3 << (res - 3))) / (3 << (res - 2));
+	return (reg * IN_NOMINAL(ix, type) + (3 << (res - 3))) /
+		(3 << (res - 2));
 }
 
-static inline int IN_TO_REG(int val, int ix)
+static inline int IN_TO_REG(int val, int ix, int type)
 {
-	return SENSORS_LIMIT((val * 192 + IN_NOMINAL[ix] / 2) /
-			     IN_NOMINAL[ix], 0, 255);
+	return SENSORS_LIMIT((val * 192 + IN_NOMINAL(ix, type) / 2) /
+			     IN_NOMINAL(ix, type), 0, 255);
 }
 
 /* Temperature input
@@ -727,13 +735,13 @@
 
 	switch (fn) {
 	case SYS_IN_INPUT:
-		res = IN_FROM_REG(data->in[ix], ix, 16);
+		res = IN_FROM_REG(data->in[ix], ix, 16, data->type);
 		break;
 	case SYS_IN_MIN:
-		res = IN_FROM_REG(data->in_min[ix], ix, 8);
+		res = IN_FROM_REG(data->in_min[ix], ix, 8, data->type);
 		break;
 	case SYS_IN_MAX:
-		res = IN_FROM_REG(data->in_max[ix], ix, 8);
+		res = IN_FROM_REG(data->in_max[ix], ix, 8, data->type);
 		break;
 	case SYS_IN_ALARM:
 		res = (data->alarms >> DME1737_BIT_ALARM_IN[ix]) & 0x01;
@@ -760,12 +768,12 @@
 	mutex_lock(&data->update_lock);
 	switch (fn) {
 	case SYS_IN_MIN:
-		data->in_min[ix] = IN_TO_REG(val, ix);
+		data->in_min[ix] = IN_TO_REG(val, ix, data->type);
 		dme1737_write(client, DME1737_REG_IN_MIN(ix),
 			      data->in_min[ix]);
 		break;
 	case SYS_IN_MAX:
-		data->in_max[ix] = IN_TO_REG(val, ix);
+		data->in_max[ix] = IN_TO_REG(val, ix, data->type);
 		dme1737_write(client, DME1737_REG_IN_MAX(ix),
 			      data->in_max[ix]);
 		break;
@@ -2167,6 +2175,7 @@
 
 	kind = dme1737;
 	name = "dme1737";
+	data->type = kind;
 
 	/* Fill in the remaining client fields and put it into the global
 	 * list */
@@ -2359,6 +2368,7 @@
 		err = -ENODEV;
 		goto exit_kfree;
 	}
+	data->type = -1;
 
 	/* Fill in the remaining client fields and initialize the mutex */
 	strlcpy(client->name, "sch311x", I2C_NAME_SIZE);

--------------020306000104070207000004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020306000104070207000004--
