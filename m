From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: [PATCH 2.6] it87 and via686a alarms
Message-Id: <20031121220837.0084cb1d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Don't know why we need both max and over. Just because some drivers
> have hyst instead of min doesn't mean we have to rename max to over.
> Why not leave everything max?
> What if a driver can do both hyst and min? Would it have to offer
> both max and over (identical)?

Well, there's no file named over AFAIK, neither in the sysfs-interface
document nor in the drivers. My comments about min/max vs. over/hyst
were to make it clear which drivers needed fixing, and which did not.
All files are named max, wether the other limit is min or hyst.

In other words, I fully agree with you ;)

> it87 and via686a violate the sysfs standard by having "alarm" instead
> of "alarms", would you please fix in your next patch?

I'm not the only one allowed to send patches to Greg, you know ;)
Anyway, here we go. Greg, here is a patch that corrects the standard
violation reported by Mark. Tested to compile.

(It also removes a useless comment in it87.c.)

diff -ru linux-2.6.0-test9/drivers/i2c/chips.k1/it87.c linux-2.6.0-test9/drivers/i2c/chips/it87.c
--- linux-2.6.0-test9/drivers/i2c/chips.k1/it87.c	Sun Nov 16 18:19:09 2003
+++ linux-2.6.0-test9/drivers/i2c/chips/it87.c	Fri Nov 21 21:22:20 2003
@@ -412,7 +412,6 @@
 show_temp_offset(2);
 show_temp_offset(3);
 
-/* more like overshoot temperature */
 static ssize_t show_sensor(struct device *dev, char *buf, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -561,15 +560,15 @@
 show_fan_offset(2);
 show_fan_offset(3);
 
-/* Alarm */
-static ssize_t show_alarm(struct device *dev, char *buf)
+/* Alarms */
+static ssize_t show_alarms(struct device *dev, char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	it87_update_client(client);
 	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
 }
-static DEVICE_ATTR(alarm, S_IRUGO | S_IWUSR, show_alarm, NULL);
+static DEVICE_ATTR(alarms, S_IRUGO | S_IWUSR, show_alarms, NULL);
 
 /* This function is called when:
      * it87_driver is inserted (when this module is loaded), for each
@@ -749,7 +748,7 @@
 	device_create_file(&new_client->dev, &dev_attr_fan_div1);
 	device_create_file(&new_client->dev, &dev_attr_fan_div2);
 	device_create_file(&new_client->dev, &dev_attr_fan_div3);
-	device_create_file(&new_client->dev, &dev_attr_alarm);
+	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
 
diff -ru linux-2.6.0-test9/drivers/i2c/chips.k1/via686a.c linux-2.6.0-test9/drivers/i2c/chips/via686a.c
--- linux-2.6.0-test9/drivers/i2c/chips.k1/via686a.c	Sun Nov 16 18:54:59 2003
+++ linux-2.6.0-test9/drivers/i2c/chips/via686a.c	Fri Nov 21 21:26:04 2003
@@ -635,14 +635,14 @@
 show_fan_offset(1);
 show_fan_offset(2);
 
-/* Alarm */
-static ssize_t show_alarm(struct device *dev, char *buf) {
+/* Alarms */
+static ssize_t show_alarms(struct device *dev, char *buf) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	via686a_update_client(client);
 	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
 }
-static DEVICE_ATTR(alarm, S_IRUGO | S_IWUSR, show_alarm, NULL);
+static DEVICE_ATTR(alarms, S_IRUGO | S_IWUSR, show_alarms, NULL);
 
 /* The driver. I choose to use type i2c_driver, as at is identical to both
    smbus_driver and isa_driver, and clients could be of either kind */
@@ -767,7 +767,7 @@
 	device_create_file(&new_client->dev, &dev_attr_fan_min2);
 	device_create_file(&new_client->dev, &dev_attr_fan_div1);
 	device_create_file(&new_client->dev, &dev_attr_fan_div2);
-	device_create_file(&new_client->dev, &dev_attr_alarm);
+	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
