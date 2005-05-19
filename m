From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC PATCH remove W83781D_RT ???
Message-Id: <crtd41pf3f587604ceg0lstjbpp8qa66pl@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <hhec41h8ba5mi0ds5d1ong46amvgm7s3f7@4ax.com>
In-Reply-To: <hhec41h8ba5mi0ds5d1ong46amvgm7s3f7@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 27 Mar 2005 18:59:25 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>"buf" and "count" are provided by sysfs. "buf" points to a buffer of
>length "count". "buf + count", by definition, is outside of the buffer,
>so there no chance simple_strtoul() returns anything useful (if it
>doesn't simply crash).
>
>So this code cannot work, which IMHO is a proof that nobody ever tried
>this so we can remove it.

Revised patch applies after lock-on-set series.

Signed-off-by: Grant Coady <gcoady@gmail.com>


--- linux-2.6.12-rc1-mm3b/drivers/i2c/chips/w83781d.c.lock	2005-03-27 21:31:57.000000000 +1000
+++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/w83781d.c	2005-03-27 21:32:09.000000000 +1000
@@ -46,9 +46,6 @@
 #include <asm/io.h>
 #include "lm75.h"
 
-/* RT Table support #defined so we can take it out if it gets bothersome */
-#define W83781D_RT			1
-
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24, 0x25,
 					0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b,
@@ -258,9 +255,6 @@
 				   3000-5000 = thermistor beta.
 				   Default = 3435. 
 				   Other Betas unimplemented */
-#ifdef W83781D_RT
-	u8 rt[3][32];		/* Register value */
-#endif
 	u8 vrm;
 };
 
@@ -859,69 +853,6 @@
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
@@ -1332,13 +1263,6 @@
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
 
@@ -1563,33 +1487,6 @@
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
