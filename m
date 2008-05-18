From: "corentin.labbe" <corentin.labbe@geomatys.fr>
Date: Sun, 18 May 2008 12:33:08 +0000
Subject: [lm-sensors] [PATCH] hwmon/adm1029
Message-Id: <48302204.4080606@geomatys.fr>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040909070800070803020505"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040909070800070803020505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello

This is my patch for testing corrects values of fan div in adm1029.

Signed off by LABBE Corentin <corentin.labbe@geomatys.fr>

--------------040909070800070803020505
Content-Type: text/plain;
 name="adm1029.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adm1029.patch"

--- linux/drivers/hwmon/adm1029.orig	2008-05-17 13:25:59.000000000 +0200
+++ linux/drivers/hwmon/adm1029.c	2008-05-18 13:04:42.000000000 +0200
@@ -170,7 +170,8 @@
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm1029_data *data = adm1029_update_device(dev);
 	u16 val;
-	if (data->fan[attr->index] == 0 || data->fan_div[attr->index] == 0
+	if (data->fan[attr->index] == 0 
+	    || (data->fan_div[attr->index] & 0xC0) == 0
 	    || data->fan[attr->index] == 255) {
 		return sprintf(buf, "0\n");
 	}
@@ -185,7 +186,7 @@
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm1029_data *data = adm1029_update_device(dev);
-	if (data->fan_div[attr->index] == 0)
+	if ( (data->fan_div[attr->index] & 0xC0) == 0)
 		return sprintf(buf, "0\n");
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[attr->index]));
 }

--------------040909070800070803020505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040909070800070803020505--
