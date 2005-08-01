From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 01 Aug 2005 22:02:56 +0000
Subject: [lm-sensors] Re: [pc87360.c 3/23 - corrected] s/offset/attr->index/
Message-Id: <42EE7FAF.9060604@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jim Cromie wrote:

>
> use attr->index instead of offset in voltage get/set macros


> [jimc@harpo pset]$ diffstat 02x-sda-vin-quell-warns
> pc87360.c |   20 ++++++++++----------
> 1 files changed, 10 insertions(+), 10 deletions(-)
>
>
> Signed-off-by:  Jim Cromie <jcromie@divsol.com>


-------------- next part --------------
diff -ruNp -X exclude-diffs lxC-2/drivers/hwmon/pc87360.c lxC-3/drivers/hwmon/pc87360.c
--- lxC-2/drivers/hwmon/pc87360.c	2005-07-31 15:36:21.000000000 -0600
+++ lxC-3/drivers/hwmon/pc87360.c	2005-07-31 15:40:46.000000000 -0600
@@ -352,28 +352,28 @@ static ssize_t show_in##offset##_input(s
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index], \
 		       data->in_vref)); \
 } \
 static ssize_t show_in##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index], \
 		       data->in_vref)); \
 } \
 static ssize_t show_in##offset##_max(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index], \
 		       data->in_vref)); \
 } \
 static ssize_t show_in##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", data->in_status[offset]); \
+	return sprintf(buf, "%u\n", data->in_status[attr->index]); \
 } \
 static ssize_t set_in##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
@@ -384,9 +384,9 @@ static ssize_t set_in##offset##_min(stru
 	long val = simple_strtol(buf, NULL, 10); \
  \
 	down(&data->update_lock); \
-	data->in_min[offset] = IN_TO_REG(val, data->in_vref); \
-	pc87360_write_value(data, LD_IN, offset, PC87365_REG_IN_MIN, \
-			    data->in_min[offset]); \
+	data->in_min[attr->index] = IN_TO_REG(val, data->in_vref); \
+	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_IN_MIN, \
+			    data->in_min[attr->index]); \
 	up(&data->update_lock); \
 	return count; \
 } \
@@ -399,10 +399,10 @@ static ssize_t set_in##offset##_max(stru
 	long val = simple_strtol(buf, NULL, 10); \
  \
 	down(&data->update_lock); \
-	data->in_max[offset] = IN_TO_REG(val, \
+	data->in_max[attr->index] = IN_TO_REG(val, \
 			       data->in_vref); \
-	pc87360_write_value(data, LD_IN, offset, PC87365_REG_IN_MAX, \
-			    data->in_max[offset]); \
+	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_IN_MAX, \
+			    data->in_max[attr->index]); \
 	up(&data->update_lock); \
 	return count; \
 } \
