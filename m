From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC PATCH remove W83781D_RT ???
Message-Id: <hhec41h8ba5mi0ds5d1ong46amvgm7s3f7@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Driver w83781d: W83781D_RT appears to have a bug, one suggested 
solution is to remove it if there are no users.

Anyone use it?  Need a second :)

Signed-off-by: Grant Coady <gcoady@gmail.com>


--- linux-2.6.12-rc1-mm3x/drivers/i2c/chips/w83781d.c.orig	2005-03-27 09:42:01.000000000 +1000
+++ linux-2.6.12-rc1-mm3x/drivers/i2c/chips/w83781d.c	2005-03-27 09:43:19.000000000 +1000
@@ -258,9 +258,6 @@
 				   3000-5000 = thermistor beta.
 				   Default = 3435. 
 				   Other Betas unimplemented */
-#ifdef W83781D_RT
-	u8 rt[3][32];		/* Register value */
-#endif
 	u8 vrm;
 };
 
@@ -859,69 +856,6 @@
 device_create_file(&client->dev, &dev_attr_temp##offset##_type); \
 } while (0)
 
-#ifdef W83781D_RT
-static ssize_t
-show_rt_reg(struct device *dev, char *buf, int nr)
-{
-	struct w83781d_data *data = w83781d_update_device(dev);
-	int i, j = 0;
-
-	for (i = 0; i < 32; i++) {
-		if (i > 0)
-			j += sprintf(buf, " %ld", (long) data->rt[nr - 1][i]);
-		else
-			j += sprintf(buf, "%ld", (long) data->rt[nr - 1][i]);
-	}
-	j += sprintf(buf, "\n");
-
-	return j;
-}
-
-static ssize_t
-store_rt_reg(struct device *dev, const char *buf, size_t count, int nr)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
-	u32 val, i;
-
-	down(&data->update_lock);
-
-	for (i = 0; i < count; i++) {
-		val = simple_strtoul(buf + count, NULL, 10);
-
-		/* fixme: no bounds checking 0-255 */
-		data->rt[nr - 1][i] = val & 0xff;
-		w83781d_write_value(client, W83781D_REG_RT_IDX, i);
-		w83781d_write_value(client, W83781D_REG_RT_VAL,
-				    data->rt[nr - 1][i]);
-	}
-
-	up(&data->update_lock);
-	return count;
-}
-
-#define sysfs_rt(offset) \
-static ssize_t show_regs_rt_##offset (struct device *dev, char *buf) \
-{ \
-	return show_rt_reg(dev, buf, offset); \
-} \
-static ssize_t store_regs_rt_##offset (struct device *dev, const char *buf, size_t count) \
-{ \
-    return store_rt_reg(dev, buf, count, offset); \
-} \
-static DEVICE_ATTR(rt##offset, S_IRUGO | S_IWUSR, show_regs_rt_##offset, store_regs_rt_##offset);
-
-sysfs_rt(1);
-sysfs_rt(2);
-sysfs_rt(3);
-
-#define device_create_file_rt(client, offset) \
-do { \
-device_create_file(&client->dev, &dev_attr_rt##offset); \
-} while (0)
-
-#endif				/* ifdef W83781D_RT */
-
 /* This function is called when:
      * w83781d_driver is inserted (when this module is loaded), for each
        available adapter
@@ -1332,13 +1266,6 @@
 		if (kind != w83783s && kind != w83697hf)
 			device_create_file_sensor(new_client, 3);
 	}
-#ifdef W83781D_RT
-	if (kind = w83781d) {
-		device_create_file_rt(new_client, 1);
-		device_create_file_rt(new_client, 2);
-		device_create_file_rt(new_client, 3);
-	}
-#endif
 
 	return 0;
 
@@ -1563,33 +1490,6 @@
 				break;
 		}
 	}
-#ifdef W83781D_RT
-/*
-   Fill up the RT Tables.
-   We assume that they are 32 bytes long, in order for temp 1-3.
-   Data sheet documentation is sparse.
-   We also assume that it is only for the 781D although I suspect
-   that the others support it as well....
-*/
-
-	if (init && type = w83781d) {
-		u16 k = 0;
-/*
-    Auto-indexing doesn't seem to work...
-    w83781d_write_value(client,W83781D_REG_RT_IDX,0);
-*/
-		for (i = 0; i < 3; i++) {
-			int j;
-			for (j = 0; j < 32; j++) {
-				w83781d_write_value(client,
-						    W83781D_REG_RT_IDX, k++);
-				data->rt[i][j] -				    w83781d_read_value(client,
-						       W83781D_REG_RT_VAL);
-			}
-		}
-	}
-#endif				/* W83781D_RT */
 
 	if (init && type != as99127f) {
 		/* Enable temp2 */
