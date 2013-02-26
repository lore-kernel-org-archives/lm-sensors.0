From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 26 Feb 2013 18:23:40 +0000
Subject: [lm-sensors] [PATCH 12/12] hwmon: (nct6775) Only report VID if supported and enabled
Message-Id: <1361903020-18526-13-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361903020-18526-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1361903020-18526-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

VID is not always enabled (NCT6775, NCT6776) or supported (NCT6779).

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index a4b076a..aeeb0a1 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -3398,6 +3398,8 @@ static int nct6775_probe(struct platform_device *pdev)
 	const u16 *reg_temp, *reg_temp_over, *reg_temp_hyst, *reg_temp_config;
 	const u16 *reg_temp_alternate, *reg_temp_crit;
 	int num_reg_temp;
+	bool have_vid = false;
+	u8 cr2a;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!devm_request_region(&pdev->dev, res->start, IOREGION_LENGTH,
@@ -3766,17 +3768,31 @@ static int nct6775_probe(struct platform_device *pdev)
 	/* Initialize the chip */
 	nct6775_init_device(data);
 
-	data->vrm = vid_which_vrm();
 	err = superio_enter(sio_data->sioreg);
 	if (err)
 		return err;
 
+	cr2a = superio_inb(sio_data->sioreg, 0x2a);
+	switch (data->kind) {
+	case nct6775:
+		have_vid = (cr2a & 0x40);
+		break;
+	case nct6776:
+		have_vid = (cr2a & 0x60) = 0x40;
+		break;
+	case nct6779:
+		break;
+	}
+
 	/*
 	 * Read VID value
 	 * We can get the VID input values directly at logical device D 0xe3.
 	 */
-	superio_select(sio_data->sioreg, NCT6775_LD_VID);
-	data->vid = superio_inb(sio_data->sioreg, 0xe3);
+	if (have_vid) {
+		superio_select(sio_data->sioreg, NCT6775_LD_VID);
+		data->vid = superio_inb(sio_data->sioreg, 0xe3);
+		data->vrm = vid_which_vrm();
+	}
 
 	if (fan_debounce) {
 		u8 tmp;
@@ -3801,9 +3817,11 @@ static int nct6775_probe(struct platform_device *pdev)
 
 	superio_exit(sio_data->sioreg);
 
-	err = device_create_file(dev, &dev_attr_cpu0_vid);
-	if (err)
-		return err;
+	if (have_vid) {
+		err = device_create_file(dev, &dev_attr_cpu0_vid);
+		if (err)
+			return err;
+	}
 
 	err = nct6775_check_fan_inputs(sio_data, data);
 	if (err)
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
