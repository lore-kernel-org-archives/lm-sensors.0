From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 13 Mar 2013 23:23:57 +0000
Subject: [lm-sensors] [PATCH 5/5] hwmon: (w83627ehf) Use request_muxed_region
Message-Id: <1363217037-15723-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Serialize access to the hardware by using "request_muxed_region".
Calls to this macro will hold off the requestor if the resource is
currently busy. "superio_enter" will return an error if call to
"request_muxed_region" fails. Rest of the code change is to pass
errors returned from superio_enter to the top level, and ensures
that superio_exit is called in each error path.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83627ehf.c |   38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index a56c33e..45d949b 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -135,11 +135,14 @@ superio_select(int ioreg, int ld)
 	outb(ld, ioreg + 1);
 }
 
-static inline void
+static inline int
 superio_enter(int ioreg)
 {
+	if (!request_muxed_region(ioreg, 2, DRVNAME))
+		return -EBUSY;
 	outb(0x87, ioreg);
 	outb(0x87, ioreg);
+	return 0;
 }
 
 static inline void
@@ -148,6 +151,7 @@ superio_exit(int ioreg)
 	outb(0xaa, ioreg);
 	outb(0x02, ioreg);
 	outb(0x02, ioreg + 1);
+	release_region(ioreg, 2);
 }
 
 /*
@@ -1970,20 +1974,23 @@ w83627ehf_set_temp_reg_ehf(struct w83627ehf_data *data, int n_temp)
 	}
 }
 
-static void
+static int
 w83627ehf_check_fan_inputs(const struct w83627ehf_sio_data *sio_data,
 			   struct w83627ehf_data *data)
 {
 	int fan3pin, fan4pin, fan4min, fan5pin, regval;
+	int err;
 
 	/* The W83627UHG is simple, only two fan inputs, no config */
 	if (sio_data->kind = w83627uhg) {
 		data->has_fan = 0x03; /* fan1 and fan2 */
 		data->has_fan_min = 0x03;
-		return;
+		return 0;
 	}
 
-	superio_enter(sio_data->sioreg);
+	err = superio_enter(sio_data->sioreg);
+	if (err)
+		return err;
 
 	/* fan4 and fan5 share some pins with the GPIO and serial flash */
 	if (sio_data->kind = nct6775) {
@@ -2057,6 +2064,7 @@ w83627ehf_check_fan_inputs(const struct w83627ehf_sio_data *sio_data,
 			data->has_fan_min |= (1 << 4);
 		}
 	}
+	return 0;
 }
 
 static int w83627ehf_probe(struct platform_device *pdev)
@@ -2360,7 +2368,10 @@ static int w83627ehf_probe(struct platform_device *pdev)
 	w83627ehf_init_device(data, sio_data->kind);
 
 	data->vrm = vid_which_vrm();
-	superio_enter(sio_data->sioreg);
+	err = superio_enter(sio_data->sioreg);
+	if (err)
+		goto exit_release;
+
 	/* Read VID value */
 	if (sio_data->kind = w83667hg || sio_data->kind = w83667hg_b ||
 	    sio_data->kind = nct6775 || sio_data->kind = nct6776) {
@@ -2372,8 +2383,10 @@ static int w83627ehf_probe(struct platform_device *pdev)
 		superio_select(sio_data->sioreg, W83667HG_LD_VID);
 		data->vid = superio_inb(sio_data->sioreg, 0xe3);
 		err = device_create_file(dev, &dev_attr_cpu0_vid);
-		if (err)
+		if (err) {
+			superio_exit(sio_data->sioreg);
 			goto exit_release;
+		}
 	} else if (sio_data->kind != w83627uhg) {
 		superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
 		if (superio_inb(sio_data->sioreg, SIO_REG_VID_CTRL) & 0x80) {
@@ -2409,8 +2422,10 @@ static int w83627ehf_probe(struct platform_device *pdev)
 				data->vid &= 0x3f;
 
 			err = device_create_file(dev, &dev_attr_cpu0_vid);
-			if (err)
+			if (err) {
+				superio_exit(sio_data->sioreg);
 				goto exit_release;
+			}
 		} else {
 			dev_info(dev, "VID pins in output mode, CPU VID not "
 				 "available\n");
@@ -2434,7 +2449,9 @@ static int w83627ehf_probe(struct platform_device *pdev)
 
 	superio_exit(sio_data->sioreg);
 
-	w83627ehf_check_fan_inputs(sio_data, data);
+	err = w83627ehf_check_fan_inputs(sio_data, data);
+	if (err)
+		goto exit_remove;
 
 	/* Read fan clock dividers immediately */
 	w83627ehf_update_fan_div_common(dev, data);
@@ -2721,8 +2738,11 @@ static int __init w83627ehf_find(int sioaddr, unsigned short *addr,
 
 	u16 val;
 	const char *sio_name;
+	int err;
 
-	superio_enter(sioaddr);
+	err = superio_enter(sioaddr);
+	if (err)
+		return err;
 
 	if (force_id)
 		val = force_id;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
