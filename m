From: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Date: Tue, 15 Mar 2011 16:02:43 +0000
Subject: [lm-sensors] [RFC PATCH 3/5] hwmon: lis3: Change exported function
Message-Id: <1300204965-7209-4-git-send-email-ilkka.koskinen@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300204965-7209-1-git-send-email-ilkka.koskinen@nokia.com>
In-Reply-To: <1300204965-7209-1-git-send-email-ilkka.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Change exported functions to use the device given as parameter
instead of the global one.

Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
---
 drivers/hwmon/hp_accel.c      |    4 ++--
 drivers/hwmon/lis3lv02d.c     |    6 +++---
 drivers/hwmon/lis3lv02d.h     |    4 ++--
 drivers/hwmon/lis3lv02d_i2c.c |    2 +-
 drivers/hwmon/lis3lv02d_spi.c |    2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/hp_accel.c b/drivers/hwmon/hp_accel.c
index 3d21fa2..14f8578 100644
--- a/drivers/hwmon/hp_accel.c
+++ b/drivers/hwmon/hp_accel.c
@@ -320,7 +320,7 @@ static int lis3lv02d_add(struct acpi_device *device)
 	INIT_WORK(&hpled_led.work, delayed_set_status_worker);
 	ret = led_classdev_register(NULL, &hpled_led.led_classdev);
 	if (ret) {
-		lis3lv02d_joystick_disable();
+		lis3lv02d_joystick_disable(&lis3_dev);
 		lis3lv02d_poweroff(&lis3_dev);
 		flush_work(&hpled_led.work);
 		return ret;
@@ -334,7 +334,7 @@ static int lis3lv02d_remove(struct acpi_device *device, int type)
 	if (!device)
 		return -EINVAL;
 
-	lis3lv02d_joystick_disable();
+	lis3lv02d_joystick_disable(&lis3_dev);
 	lis3lv02d_poweroff(&lis3_dev);
 
 	led_classdev_unregister(&hpled_led.led_classdev);
diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index 0e0e84c..b2558c7 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -610,7 +610,7 @@ static struct miscdevice lis3lv02d_misc_device = {
 	.fops    = &lis3lv02d_misc_fops,
 };
 
-int lis3lv02d_joystick_enable(void)
+int lis3lv02d_joystick_enable(struct lis3lv02d *lis3)
 {
 	struct input_dev *input_dev;
 	int err;
@@ -668,7 +668,7 @@ int lis3lv02d_joystick_enable(void)
 }
 EXPORT_SYMBOL_GPL(lis3lv02d_joystick_enable);
 
-void lis3lv02d_joystick_disable(void)
+void lis3lv02d_joystick_disable(struct lis3lv02d *lis3)
 {
 	if (lis3_dev.irq)
 		free_irq(lis3_dev.irq, &lis3_dev);
@@ -934,7 +934,7 @@ int lis3lv02d_init_device(struct lis3lv02d *lis3)
 		pm_runtime_enable(lis3->pm_dev);
 	}
 
-	if (lis3lv02d_joystick_enable())
+	if (lis3lv02d_joystick_enable(lis3))
 		pr_err("joystick initialization failed\n");
 
 	/* passing in platform specific data is purely optional and only
diff --git a/drivers/hwmon/lis3lv02d.h b/drivers/hwmon/lis3lv02d.h
index a193958..49cb1f1 100644
--- a/drivers/hwmon/lis3lv02d.h
+++ b/drivers/hwmon/lis3lv02d.h
@@ -282,8 +282,8 @@ struct lis3lv02d {
 };
 
 int lis3lv02d_init_device(struct lis3lv02d *lis3);
-int lis3lv02d_joystick_enable(void);
-void lis3lv02d_joystick_disable(void);
+int lis3lv02d_joystick_enable(struct lis3lv02d *lis3);
+void lis3lv02d_joystick_disable(struct lis3lv02d *lis3);
 void lis3lv02d_poweroff(struct lis3lv02d *lis3);
 void lis3lv02d_poweron(struct lis3lv02d *lis3);
 int lis3lv02d_remove_fs(struct lis3lv02d *lis3);
diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
index d834505..fa0cea1 100644
--- a/drivers/hwmon/lis3lv02d_i2c.c
+++ b/drivers/hwmon/lis3lv02d_i2c.c
@@ -182,7 +182,7 @@ static int __devexit lis3lv02d_i2c_remove(struct i2c_client *client)
 	if (pdata && pdata->release_resources)
 		pdata->release_resources();
 
-	lis3lv02d_joystick_disable();
+	lis3lv02d_joystick_disable(lis3);
 	lis3lv02d_remove_fs(&lis3_dev);
 
 	if (lis3_dev.reg_ctrl)
diff --git a/drivers/hwmon/lis3lv02d_spi.c b/drivers/hwmon/lis3lv02d_spi.c
index c1f8a8f..b2c1be1 100644
--- a/drivers/hwmon/lis3lv02d_spi.c
+++ b/drivers/hwmon/lis3lv02d_spi.c
@@ -83,7 +83,7 @@ static int __devinit lis302dl_spi_probe(struct spi_device *spi)
 static int __devexit lis302dl_spi_remove(struct spi_device *spi)
 {
 	struct lis3lv02d *lis3 = spi_get_drvdata(spi);
-	lis3lv02d_joystick_disable();
+	lis3lv02d_joystick_disable(lis3);
 	lis3lv02d_poweroff(lis3);
 
 	return lis3lv02d_remove_fs(&lis3_dev);
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
