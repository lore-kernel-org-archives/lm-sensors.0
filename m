From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 24 Jun 2013 18:07:02 +0000
Subject: [lm-sensors] [PATCH v2 4/4] hwmon: (nct6775) Add support for critical low/high temperature limits on
Message-Id: <1372097222-11289-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Rebase to latest baseline

 drivers/hwmon/nct6775.c |   43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index bebddbb..1560f23 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -472,7 +472,11 @@ static const u16 NCT6106_REG_TEMP[] = { 0x10, 0x11, 0x12, 0x13, 0x14, 0x15 };
 static const u16 NCT6106_REG_TEMP_HYST[] = {
 	0xc3, 0xc7, 0xcb, 0xcf, 0xd3, 0xd7 };
 static const u16 NCT6106_REG_TEMP_OVER[] = {
-	0xc2, 0xc6, 0xca, 0xce, 0xd2, 0xd4 };
+	0xc2, 0xc6, 0xca, 0xce, 0xd2, 0xd6 };
+static const u16 NCT6106_REG_TEMP_CRIT_L[] = {
+	0xc0, 0xc4, 0xc8, 0xcc, 0xd0, 0xd4 };
+static const u16 NCT6106_REG_TEMP_CRIT_H[] = {
+	0xc1, 0xc5, 0xc9, 0xcf, 0xd1, 0xd5 };
 static const u16 NCT6106_REG_TEMP_OFFSET[] = { 0x311, 0x312, 0x313 };
 static const u16 NCT6106_REG_TEMP_CONFIG[] = {
 	0xb7, 0xb8, 0xb9, 0xba, 0xbb, 0xbc };
@@ -647,8 +651,8 @@ struct nct6775_data {
 	struct attribute_group *group_temp;
 	struct attribute_group *group_pwm;
 
-	u16 reg_temp[4][NUM_TEMP]; /* 0=temp, 1=temp_over, 2=temp_hyst,
-				    * 3=temp_crit
+	u16 reg_temp[5][NUM_TEMP]; /* 0=temp, 1=temp_over, 2=temp_hyst,
+				    * 3=temp_crit, 4=temp_lcrit
 				    */
 	u8 temp_src[NUM_TEMP];
 	u16 reg_temp_config[NUM_TEMP];
@@ -1851,8 +1855,8 @@ static umode_t nct6775_temp_is_visible(struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct nct6775_data *data = dev_get_drvdata(dev);
-	int temp = index / 8;	/* temp index */
-	int nr = index % 8;	/* attribute index */
+	int temp = index / 9;	/* temp index */
+	int nr = index % 9;	/* attribute index */
 
 	if (!(data->have_temp & (1 << temp)))
 		return 0;
@@ -1869,7 +1873,11 @@ static umode_t nct6775_temp_is_visible(struct kobject *kobj,
 	if (nr = 5 && !data->reg_temp[3][temp])	/* crit */
 		return 0;
 
-	if (nr > 5 && !(data->have_temp_fixed & (1 << temp)))
+	if (nr = 6 && !data->reg_temp[4][temp])	/* lcrit */
+		return 0;
+
+	/* offset and type only apply to fixed sensors */
+	if (nr > 6 && !(data->have_temp_fixed & (1 << temp)))
 		return 0;
 
 	return attr->mode;
@@ -1883,6 +1891,8 @@ SENSOR_TEMPLATE_2(temp_max_hyst, "temp%d_max_hyst", S_IRUGO | S_IWUSR,
 		  show_temp, store_temp, 0, 2);
 SENSOR_TEMPLATE_2(temp_crit, "temp%d_crit", S_IRUGO | S_IWUSR, show_temp,
 		  store_temp, 0, 3);
+SENSOR_TEMPLATE_2(temp_lcrit, "temp%d_lcrit", S_IRUGO | S_IWUSR, show_temp,
+		  store_temp, 0, 4);
 SENSOR_TEMPLATE(temp_offset, "temp%d_offset", S_IRUGO | S_IWUSR,
 		show_temp_offset, store_temp_offset, 0);
 SENSOR_TEMPLATE(temp_type, "temp%d_type", S_IRUGO | S_IWUSR, show_temp_type,
@@ -1901,8 +1911,9 @@ static struct sensor_device_template *nct6775_attributes_temp_template[] = {
 	&sensor_dev_template_temp_max,		/* 3 */
 	&sensor_dev_template_temp_max_hyst,	/* 4 */
 	&sensor_dev_template_temp_crit,		/* 5 */
-	&sensor_dev_template_temp_offset,	/* 6 */
-	&sensor_dev_template_temp_type,		/* 7 */
+	&sensor_dev_template_temp_lcrit,	/* 6 */
+	&sensor_dev_template_temp_offset,	/* 7 */
+	&sensor_dev_template_temp_type,		/* 8 */
 	NULL
 };
 
@@ -3054,6 +3065,7 @@ static int nct6775_probe(struct platform_device *pdev)
 	int src, mask, available;
 	const u16 *reg_temp, *reg_temp_over, *reg_temp_hyst, *reg_temp_config;
 	const u16 *reg_temp_alternate, *reg_temp_crit;
+	const u16 *reg_temp_crit_l = NULL, *reg_temp_crit_h = NULL;
 	int num_reg_temp;
 	u8 cr2a;
 	struct attribute_group *group;
@@ -3138,6 +3150,8 @@ static int nct6775_probe(struct platform_device *pdev)
 		reg_temp_config = NCT6106_REG_TEMP_CONFIG;
 		reg_temp_alternate = NCT6106_REG_TEMP_ALTERNATE;
 		reg_temp_crit = NCT6106_REG_TEMP_CRIT;
+		reg_temp_crit_l = NCT6106_REG_TEMP_CRIT_L;
+		reg_temp_crit_h = NCT6106_REG_TEMP_CRIT_H;
 
 		break;
 	case nct6775:
@@ -3406,6 +3420,13 @@ static int nct6775_probe(struct platform_device *pdev)
 			data->reg_temp[0][src - 1] = reg_temp[i];
 			data->reg_temp[1][src - 1] = reg_temp_over[i];
 			data->reg_temp[2][src - 1] = reg_temp_hyst[i];
+			if (reg_temp_crit_h && reg_temp_crit_h[i])
+				data->reg_temp[3][src - 1] = reg_temp_crit_h[i];
+			else if (reg_temp_crit[src - 1])
+				data->reg_temp[3][src - 1]
+				  = reg_temp_crit[src - 1];
+			if (reg_temp_crit_l && reg_temp_crit_l[i])
+				data->reg_temp[4][src - 1] = reg_temp_crit_l[i];
 			data->reg_temp_config[src - 1] = reg_temp_config[i];
 			data->temp_src[src - 1] = src;
 			continue;
@@ -3420,8 +3441,12 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->reg_temp[1][s] = reg_temp_over[i];
 		data->reg_temp[2][s] = reg_temp_hyst[i];
 		data->reg_temp_config[s] = reg_temp_config[i];
-		if (reg_temp_crit[src - 1])
+		if (reg_temp_crit_h && reg_temp_crit_h[i])
+			data->reg_temp[3][s] = reg_temp_crit_h[i];
+		else if (reg_temp_crit[src - 1])
 			data->reg_temp[3][s] = reg_temp_crit[src - 1];
+		if (reg_temp_crit_l && reg_temp_crit_l[i])
+			data->reg_temp[4][s] = reg_temp_crit_l[i];
 
 		data->temp_src[s] = src;
 		s++;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
