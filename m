From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Apr 2015 21:55:13 +0000
Subject: [lm-sensors] [PATCH 22/22] hwmon: (it87) Formatting cleanup
Message-Id: <1428184513-22380-23-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix various checkpatch complaints to clean up the code and
make it easier to read.

CHECK: Do not include the paragraph about writing to the FSF
CHECK: Alignment should match open parenthesis
CHECK: Logical continuations should be on the previous line
CHECK: No space is necessary after a cast
CHECK: Please don't use multiple blank lines
CHECK: Please use a blank line after function/struct/union/enum declarations
CHECK: spaces preferred around that '+' (ctx:VxV)
WARNING: Missing a blank line after declarations

No functional change.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c | 157 +++++++++++++++++++++++++++------------------------
 1 file changed, 82 insertions(+), 75 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 845d4c095e2e..2c2d945e47e3 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -43,10 +43,6 @@
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -106,6 +102,7 @@ static inline void superio_outb(int ioreg, int reg, int val)
 static int superio_inw(int ioreg, int reg)
 {
 	int val;
+
 	outb(reg++, ioreg);
 	val = inb(ioreg + 1) << 8;
 	outb(reg, ioreg);
@@ -520,6 +517,7 @@ struct it87_data {
 static int adc_lsb(const struct it87_data *data, int nr)
 {
 	int lsb = has_12mv_adc(data) ? 12 : 16;
+
 	if (data->in_scaled & BIT(nr))
 		lsb <<= 1;
 	return lsb;
@@ -577,10 +575,10 @@ static int pwm_from_reg(const struct it87_data *data, u8 reg)
 		return (reg & 0x7f) << 1;
 }
 
-
 static int DIV_TO_REG(int val)
 {
 	int answer = 0;
+
 	while (answer < 7 && (val >>= 1))
 		answer++;
 	return answer;
@@ -665,8 +663,8 @@ static struct it87_data *it87_update_device(struct device *dev)
 
 	mutex_lock(&data->update_lock);
 
-	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
-	    || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2) ||
+	    !data->valid) {
 		if (update_vbat) {
 			/*
 			 * Cleared after each update, so reenable.  Value
@@ -777,10 +775,10 @@ static ssize_t show_in(struct device *dev, struct device_attribute *attr,
 		       char *buf)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	int nr = sattr->nr;
+	struct it87_data *data = it87_update_device(dev);
 	int index = sattr->index;
+	int nr = sattr->nr;
 
-	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", in_from_reg(data, nr, data->in[nr][index]));
 }
 
@@ -788,10 +786,9 @@ static ssize_t set_in(struct device *dev, struct device_attribute *attr,
 		      const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	int nr = sattr->nr;
-	int index = sattr->index;
-
 	struct it87_data *data = dev_get_drvdata(dev);
+	int index = sattr->index;
+	int nr = sattr->nr;
 	unsigned long val;
 
 	if (kstrtoul(buf, 10, &val) < 0)
@@ -947,8 +944,8 @@ static ssize_t show_temp_type(struct device *dev, struct device_attribute *attr,
 	u8 reg = data->sensor;	    /* In case value is updated while used */
 	u8 extra = data->extra;
 
-	if ((has_temp_peci(data, nr) && (reg >> 6 = nr + 1))
-	    || (has_temp_old_peci(data, nr) && (extra & 0x80)))
+	if ((has_temp_peci(data, nr) && (reg >> 6 = nr + 1)) ||
+	    (has_temp_old_peci(data, nr) && (extra & 0x80)))
 		return sprintf(buf, "6\n");  /* Intel PECI */
 	if (reg & (1 << nr))
 		return sprintf(buf, "3\n");  /* thermal diode */
@@ -1044,35 +1041,38 @@ static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
-		char *buf)
+			    char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	struct it87_data *data = it87_update_device(dev);
 	int nr = sensor_attr->index;
 
-	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%lu\n", DIV_FROM_REG(data->fan_div[nr]));
 }
+
 static ssize_t show_pwm_enable(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			       struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	struct it87_data *data = it87_update_device(dev);
 	int nr = sensor_attr->index;
 
-	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n", pwm_mode(data, nr));
 }
+
 static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
-		char *buf)
+			char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	struct it87_data *data = it87_update_device(dev);
 	int nr = sensor_attr->index;
 
-	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%d\n",
 		       pwm_from_reg(data, data->pwm_duty[nr]));
 }
+
 static ssize_t show_pwm_freq(struct device *dev, struct device_attribute *attr,
-		char *buf)
+			     char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	struct it87_data *data = it87_update_device(dev);
@@ -1136,12 +1136,11 @@ static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+			   const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index;
-
 	struct it87_data *data = dev_get_drvdata(dev);
+	int nr = sensor_attr->index;
 	unsigned long val;
 	int min;
 	u8 old;
@@ -1206,13 +1205,12 @@ static int check_trip_points(struct device *dev, int nr)
 	return err;
 }
 
-static ssize_t set_pwm_enable(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index;
-
 	struct it87_data *data = dev_get_drvdata(dev);
+	int nr = sensor_attr->index;
 	long val;
 
 	if (kstrtol(buf, 10, &val) < 0 || val < 0 || val > 2)
@@ -1259,13 +1257,13 @@ static ssize_t set_pwm_enable(struct device *dev,
 	mutex_unlock(&data->update_lock);
 	return count;
 }
+
 static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+		       const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index;
-
 	struct it87_data *data = dev_get_drvdata(dev);
+	int nr = sensor_attr->index;
 	long val;
 
 	if (kstrtol(buf, 10, &val) < 0 || val < 0 || val > 255)
@@ -1299,8 +1297,9 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t set_pwm_freq(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
+
+static ssize_t set_pwm_freq(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	struct it87_data *data = dev_get_drvdata(dev);
@@ -1316,7 +1315,7 @@ static ssize_t set_pwm_freq(struct device *dev,
 
 	/* Search for the nearest available frequency */
 	for (i = 0; i < 7; i++) {
-		if (val > (pwm_freq[i] + pwm_freq[i+1]) / 2)
+		if (val > (pwm_freq[i] + pwm_freq[i + 1]) / 2)
 			break;
 	}
 
@@ -1334,13 +1333,13 @@ static ssize_t set_pwm_freq(struct device *dev,
 
 	return count;
 }
+
 static ssize_t show_pwm_temp_map(struct device *dev,
-		struct device_attribute *attr, char *buf)
+				 struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index;
-
 	struct it87_data *data = it87_update_device(dev);
+	int nr = sensor_attr->index;
 	int map;
 
 	if (data->pwm_temp_map[nr] < 3)
@@ -1349,13 +1348,14 @@ static ssize_t show_pwm_temp_map(struct device *dev,
 		map = 0;			/* Should never happen */
 	return sprintf(buf, "%d\n", map);
 }
+
 static ssize_t set_pwm_temp_map(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
+				struct device_attribute *attr, const char *buf,
+				size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index;
-
 	struct it87_data *data = dev_get_drvdata(dev);
+	int nr = sensor_attr->index;
 	long val;
 	u8 reg;
 
@@ -1390,8 +1390,8 @@ static ssize_t set_pwm_temp_map(struct device *dev,
 	return count;
 }
 
-static ssize_t show_auto_pwm(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t show_auto_pwm(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
 	struct sensor_device_attribute_2 *sensor_attr @@ -1403,8 +1403,8 @@ static ssize_t show_auto_pwm(struct device *dev,
 		       pwm_from_reg(data, data->auto_pwm[nr][point]));
 }
 
-static ssize_t set_auto_pwm(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_auto_pwm(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct it87_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute_2 *sensor_attr @@ -1424,8 +1424,8 @@ static ssize_t set_auto_pwm(struct device *dev,
 	return count;
 }
 
-static ssize_t show_auto_temp(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t show_auto_temp(struct device *dev, struct device_attribute *attr,
+			      char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
 	struct sensor_device_attribute_2 *sensor_attr @@ -1436,8 +1436,8 @@ static ssize_t show_auto_temp(struct device *dev,
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->auto_temp[nr][point]));
 }
 
-static ssize_t set_auto_temp(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_auto_temp(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
 	struct it87_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute_2 *sensor_attr @@ -1586,27 +1586,30 @@ static SENSOR_DEVICE_ATTR(pwm6_auto_channels_temp, S_IRUGO,
 
 /* Alarms */
 static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
-		char *buf)
+			   char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
+
 	return sprintf(buf, "%u\n", data->alarms);
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
-		char *buf)
+			  char *buf)
 {
-	int bitnr = to_sensor_dev_attr(attr)->index;
 	struct it87_data *data = it87_update_device(dev);
+	int bitnr = to_sensor_dev_attr(attr)->index;
+
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }
 
-static ssize_t clear_intrusion(struct device *dev, struct device_attribute
-		*attr, const char *buf, size_t count)
+static ssize_t clear_intrusion(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
 {
 	struct it87_data *data = dev_get_drvdata(dev);
-	long val;
 	int config;
+	long val;
 
 	if (kstrtol(buf, 10, &val) < 0 || val != 0)
 		return -EINVAL;
@@ -1647,21 +1650,22 @@ static SENSOR_DEVICE_ATTR(intrusion0_alarm, S_IRUGO | S_IWUSR,
 			  show_alarm, clear_intrusion, 4);
 
 static ssize_t show_beep(struct device *dev, struct device_attribute *attr,
-		char *buf)
+			 char *buf)
 {
-	int bitnr = to_sensor_dev_attr(attr)->index;
 	struct it87_data *data = it87_update_device(dev);
+	int bitnr = to_sensor_dev_attr(attr)->index;
+
 	return sprintf(buf, "%u\n", (data->beeps >> bitnr) & 1);
 }
+
 static ssize_t set_beep(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+			const char *buf, size_t count)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	struct it87_data *data = dev_get_drvdata(dev);
 	long val;
 
-	if (kstrtol(buf, 10, &val) < 0
-	 || (val != 0 && val != 1))
+	if (kstrtol(buf, 10, &val) < 0 || (val != 0 && val != 1))
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -1697,13 +1701,15 @@ static SENSOR_DEVICE_ATTR(temp2_beep, S_IRUGO, show_beep, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp3_beep, S_IRUGO, show_beep, NULL, 2);
 
 static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr,
-		char *buf)
+			    char *buf)
 {
 	struct it87_data *data = dev_get_drvdata(dev);
+
 	return sprintf(buf, "%u\n", data->vrm);
 }
+
 static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+			     const char *buf, size_t count)
 {
 	struct it87_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -1718,15 +1724,16 @@ static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
 
 static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr,
-		char *buf)
+			    char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
+
+	return sprintf(buf, "%ld\n", (long)vid_from_reg(data->vid, data->vrm));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
 static ssize_t show_label(struct device *dev, struct device_attribute *attr,
-		char *buf)
+			  char *buf)
 {
 	static const char * const labels[] = {
 		"+5V",
@@ -2243,8 +2250,8 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 		/* Check if fan3 is there or not */
 		if ((reg27 & BIT(0)) || !(reg2c & BIT(2)))
 			sio_data->skip_fan |= BIT(2);
-		if ((reg25 & BIT(4))
-		    || (!(reg2a & BIT(1)) && (regef & BIT(0))))
+		if ((reg25 & BIT(4)) ||
+		    (!(reg2a & BIT(1)) && (regef & BIT(0))))
 			sio_data->skip_pwm |= BIT(2);
 
 		/* Check if fan2 is there or not */
@@ -2392,8 +2399,8 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 		if (reg & BIT(2))
 			sio_data->skip_fan |= BIT(1);
 
-		if ((sio_data->type = it8718 || sio_data->type = it8720)
-		 && !(sio_data->skip_vid))
+		if ((sio_data->type = it8718 || sio_data->type = it8720) &&
+		    !(sio_data->skip_vid))
 			sio_data->vid_value = superio_inb(sioaddr,
 							  IT87_SIO_VID_REG);
 
@@ -2449,8 +2456,8 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 	board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
 	board_name = dmi_get_system_info(DMI_BOARD_NAME);
 	if (board_vendor && board_name) {
-		if (strcmp(board_vendor, "nVIDIA") = 0
-		 && strcmp(board_name, "FN68PT") = 0) {
+		if (strcmp(board_vendor, "nVIDIA") = 0 &&
+		    strcmp(board_name, "FN68PT") = 0) {
 			/*
 			 * On the Shuttle SN68PT, FAN_CTL2 is apparently not
 			 * connected to a fan, but to something else. One user
@@ -2590,6 +2597,7 @@ static int it87_check_pwm(struct device *dev)
 	 * disable pwm control to protect the user.
 	 */
 	int tmp = it87_read_value(data, IT87_REG_FAN_CTL);
+
 	if ((tmp & 0x87) = 0) {
 		if (fix_pwm_polarity) {
 			/*
@@ -2688,8 +2696,8 @@ static int it87_probe(struct platform_device *pdev)
 	}
 
 	/* Now, we do the remaining detection. */
-	if ((it87_read_value(data, IT87_REG_CONFIG) & 0x80)
-	 || it87_read_value(data, IT87_REG_CHIPID) != 0x90)
+	if ((it87_read_value(data, IT87_REG_CONFIG) & 0x80) ||
+	    it87_read_value(data, IT87_REG_CHIPID) != 0x90)
 		return -ENODEV;
 
 	platform_set_drvdata(pdev, data);
@@ -2719,8 +2727,8 @@ static int it87_probe(struct platform_device *pdev)
 
 	data->has_temp = 0x07;
 	if (sio_data->skip_temp & BIT(2)) {
-		if (sio_data->type = it8782
-		    && !(it87_read_value(data, IT87_REG_TEMP_EXTRA) & 0x80))
+		if (sio_data->type = it8782 &&
+		    !(it87_read_value(data, IT87_REG_TEMP_EXTRA) & 0x80))
 			data->has_temp &= ~BIT(2);
 	}
 
@@ -2881,7 +2889,6 @@ static void __exit sm_it87_exit(void)
 	platform_driver_unregister(&it87_driver);
 }
 
-
 MODULE_AUTHOR("Chris Gauthron, Jean Delvare <jdelvare@suse.de>");
 MODULE_DESCRIPTION("IT8705F/IT871xF/IT872xF hardware monitoring driver");
 module_param(update_vbat, bool, 0);
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
