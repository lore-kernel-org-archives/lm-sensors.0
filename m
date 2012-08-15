From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 15 Aug 2012 07:49:43 +0000
Subject: [lm-sensors] [patch] hwmon: ADT7410: handle errors from adt7410_update_device()
Message-Id: <20120815074943.GA16112@elgon.mountain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

Smatch complains that adt7410_update_device() can return error pointers.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Only needed in linux-next.

diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
index f8606df..030c8d7 100644
--- a/drivers/hwmon/adt7410.c
+++ b/drivers/hwmon/adt7410.c
@@ -236,9 +236,14 @@ static ssize_t adt7410_show_t_hyst(struct device *dev,
 				   char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct adt7410_data *data = adt7410_update_device(dev);
+	struct adt7410_data *data;
 	int nr = attr->index;
-	int hyst = (data->hyst & ADT7410_T_HYST_MASK) * 1000;
+	int hyst;
+
+	data = adt7410_update_device(dev);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+	hyst = (data->hyst & ADT7410_T_HYST_MASK) * 1000;
 
 	/*
 	 * hysteresis is stored as a 4 bit offset in the device, convert it

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
