From: Daniel Willerud <daniel.willerud@stericsson.com>
Date: Tue, 30 Aug 2011 08:17:06 +0000
Subject: Re: [lm-sensors] Notifier in hwmon
Message-Id: <4E5C9C82.1020103@stericsson.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040707000606030708020905"
List-Id: <lm-sensors.vger.kernel.org>
References: <4E5B46A6.7010509@stericsson.com>
In-Reply-To: <4E5B46A6.7010509@stericsson.com>
To: lm-sensors@vger.kernel.org

--------------040707000606030708020905
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Günter,

Thanks for your answer.
Well, we start with the layout. When a thermal event occur, the ab8500 
hwmon driver will alarm via sysfs, a user space app will handle the 
alarm and either modify max/min levels or issue a shutdown of the system.
The shutdown will propagate to the sysctrl driver, and the sysctrl 
driver will power off the system via register access to the analog 
baseband. At this stage the sysctrl driver is not aware of the thermal 
alarm, so it will perform a regular power off, instead of a thermal 
power off.
This is were the notification is needed. In sysctrl probe it will 
register for the hwmon notification. Now the sysctrl driver gets 
notified for every thermal alarm in the ab8500 hwmon driver (and if the 
alarm is cleared by changing min/max levels). So, if there is a pending 
thermal alarm when power off gets called the correct bit pattern for 
thermal power off will be written to the analog baseband register.

I'll attach other patch, affecting sysctrl, as well for reference.

Thanks for the other comments. However, they are off topic for the 
notifier discussion.

Regards,
/Daniel Willerud

On 08/29/2011 06:02 PM, Guenter Roeck wrote:
> On Mon, 2011-08-29 at 03:58 -0400, Daniel Willerud wrote:
>> Hi,
>>
>> I need our hwmon driver to notify the sysctrl driver if there is a
>> thermal warning when powering off the system.
>>
>> Please advice whether it is a good idea to add the notifier to the core
>> hwmon driver. I've attached the hwmon patch and our driver using the
>> notification.
>>
> No idea either. Your code is a bit difficult to review since it is not
> in patch form. Might be better to send it as series of rfc patches
> instead.
>
> Couple of comments:
>
> There is no explanation in your code describing what the notifier is
> supposed to be used for. Your calls to the notifier always pass a
> boolean and NULL. The call actually registering the notifier function(s)
> is not included, so it is a bit difficult to determine what the notified
> code is expected to do. It gets a 1 as parameter - so what ? If the code
> is supposed to be for some generic use, as the unused pointer indicates,
> it should probably include some more useful parameters.
>
> Defining a power off delay in a hwmon driver seems like a bad idea. That
> kind of functionality does not belong into a hwmon driver.
>
> The hwmon sysfs ABI defines an attribute named update_interval, which
> you might want to use instead of temp_monitor_delay (which doesn't
> really match its name).
>
> Consider the following code sequence.
>
>      bool alarm;
>      ...
>      if (data->min[i] != 0) {
> 	alarm = val<  data->min[i];
> 	updated_min_alarm = alarm != data->min_alarm[i];
> 	data->min_alarm[i] = alarm;
>      }
>
> Instead of re-creating sysfs names again and again to generate sysfs
> notifications, you might consider using the existing name string in the
> attributes instead.
>
> I don't think your code compiles ;). If it does, gpadc_monitor() won't
> do what you expect it to do. Actually, it won't do what you expect it to
> do anyway, since you don't reset the updated_xxx flags after each loop
> iteration.
>
> Guenter
>
>

--------------040707000606030708020905
Content-Type: text/x-patch; name="0002-ux500-Thermal-power-off.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0002-ux500-Thermal-power-off.patch"

From 0b7dba4bb6d2bfc996758438a3118a931f7546f4 Mon Sep 17 00:00:00 2001
From: Daniel Willerud <daniel.willerud@stericsson.com>
Date: Thu, 25 Aug 2011 17:39:18 +0200
Subject: [PATCH 2/2] ux500: Thermal power off

To determine whether the system had a thermal power off or a regular software
power off upon the next boot, the system must utilize the thermal power off
bit, ThDB8500SWoff, in AB8500 register STw4500Ctrl1.

ST-Ericsson ID: 354533
ST-Ericsson Linux next: N/A
ST-Ericsson FOSS-OUT ID: Trivial

Change-Id: I07440dcdc39a86cb72aa95d86411a1f020b05cae
Signed-off-by: Daniel Willerud <daniel.willerud@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c |    1 +
 drivers/hwmon/ab8500.c             |    2 +
 drivers/hwmon/abx500.c             |    1 +
 drivers/hwmon/dbx500.c             |    1 +
 drivers/mfd/ab8500-sysctrl.c       |   50 +++++++++++++++++++++++++++++++++---
 include/linux/mfd/ab8500.h         |    6 ++++
 6 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 1c8a18b..b654abd 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -944,6 +944,7 @@ static struct ab8500_audio_platform_data ab8500_audio_plat_data = {
 static struct ab8500_platform_data ab8500_platdata = {
 	.irq_base = MOP500_AB8500_IRQ_BASE,
 	.pm_power_off = true,
+	.thermal_time_out = 20, /* seconds */
 	.regulator_reg_init	= ab8500_regulator_reg_init,
 	.num_regulator_reg_init	= ARRAY_SIZE(ab8500_regulator_reg_init),
 	.regulator		= ab8500_regulators,
diff --git a/drivers/hwmon/ab8500.c b/drivers/hwmon/ab8500.c
index 83583c4..fb01cbc 100644
--- a/drivers/hwmon/ab8500.c
+++ b/drivers/hwmon/ab8500.c
@@ -117,6 +117,8 @@ static int ab8500_temp_irq_handler(int irq, struct abx500_temp *data)
 	mutex_lock(&data->lock);
 	data->crit_alarm[4] = 1;
 	mutex_unlock(&data->lock);
+
+	hwmon_notify(data->crit_alarm[4], NULL);
 	sysfs_notify(&data->pdev->dev.kobj, NULL, "temp5_crit_alarm");
 	dev_info(&data->pdev->dev, "AB8500 thermal warning,"
 		" power off in %lu s\n", data->power_off_delay);
diff --git a/drivers/hwmon/abx500.c b/drivers/hwmon/abx500.c
index 6666dc2..68da2d0 100644
--- a/drivers/hwmon/abx500.c
+++ b/drivers/hwmon/abx500.c
@@ -163,6 +163,7 @@ static void gpadc_monitor(struct work_struct *work)
 					ret);
 				break;
 			}
+			hwmon_notify(data->max_alarm[i], NULL);
 			sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
 		}
 		if (updated_max_hyst_alarm) {
diff --git a/drivers/hwmon/dbx500.c b/drivers/hwmon/dbx500.c
index a26e08b..cd44e78 100644
--- a/drivers/hwmon/dbx500.c
+++ b/drivers/hwmon/dbx500.c
@@ -323,6 +323,7 @@ static irqreturn_t prcmu_hotmon_high_irq_handler(int irq, void *irq_data)
 	data->max_alarm[0] = 1;
 	mutex_unlock(&data->lock);
 
+	hwmon_notify(data->max_alarm[0], NULL);
 	sysfs_notify(&pdev->dev.kobj, NULL, "temp1_max_alarm");
 	dev_dbg(&pdev->dev, "DBX500 thermal warning, power off in %lu s\n",
 		 (data->power_off_delay) / 1000);
diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index d24c41f..b22c6bf 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -13,11 +13,15 @@
 #include <linux/mfd/ab8500.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/ab8500/sysctrl.h>
+#include <linux/time.h>
+#include <linux/hwmon.h>
 
 static struct device *sysctrl_dev;
 
 void ab8500_power_off(void)
 {
+	struct ab8500_platform_data *plat;
+	struct timespec ts;
 	sigset_t old;
 	sigset_t all;
 	static char *pss[] = {"ab8500_ac", "ab8500_usb"};
@@ -65,14 +69,51 @@ void ab8500_power_off(void)
 shutdown:
 	sigfillset(&all);
 
+	plat = dev_get_platdata(sysctrl_dev->parent);
+		getnstimeofday(&ts);
 	if (!sigprocmask(SIG_BLOCK, &all, &old)) {
-		(void)ab8500_sysctrl_set(AB8500_STW4500CTRL1,
-					 AB8500_STW4500CTRL1_SWOFF |
-					 AB8500_STW4500CTRL1_SWRESET4500N);
-		(void)sigprocmask(SIG_SETMASK, &old, NULL);
+		if (ts.tv_sec == 0 ||
+			(ts.tv_sec - plat->thermal_set_time_sec >
+				plat->thermal_time_out))
+			plat->thermal_power_off_pending = false;
+		if (!plat->thermal_power_off_pending) {
+			(void)ab8500_sysctrl_set(AB8500_STW4500CTRL1,
+				AB8500_STW4500CTRL1_SWOFF |
+				AB8500_STW4500CTRL1_SWRESET4500N);
+			(void)sigprocmask(SIG_SETMASK, &old, NULL);
+		} else {
+			(void)ab8500_sysctrl_set(AB8500_STW4500CTRL1,
+				AB8500_STW4500CTRL1_THDB8500SWOFF |
+				AB8500_STW4500CTRL1_SWRESET4500N);
+			(void)sigprocmask(SIG_SETMASK, &old, NULL);
+		}
 	}
 }
 
+static int ab8500_notifier_call(struct notifier_block *this,
+				unsigned long val, void *data)
+{
+	struct ab8500_platform_data *plat;
+	static struct timespec ts;
+	if (sysctrl_dev == NULL)
+		return -EAGAIN;
+
+	plat = dev_get_platdata(sysctrl_dev->parent);
+	if (val) {
+		getnstimeofday(&ts);
+		plat->thermal_set_time_sec = ts.tv_sec;
+		plat->thermal_power_off_pending = true;
+	} else {
+		plat->thermal_set_time_sec = 0;
+		plat->thermal_power_off_pending = false;
+	}
+	return 0;
+}
+
+static struct notifier_block ab8500_notifier = {
+	.notifier_call = ab8500_notifier_call,
+};
+
 static inline bool valid_bank(u8 bank)
 {
 	return ((bank == AB8500_SYS_CTRL1_BLOCK) ||
@@ -117,6 +158,7 @@ static int __devinit ab8500_sysctrl_probe(struct platform_device *pdev)
 	plat = dev_get_platdata(pdev->dev.parent);
 	if (plat->pm_power_off)
 		pm_power_off = ab8500_power_off;
+	hwmon_notifier_register(&ab8500_notifier);
 	return 0;
 }
 
diff --git a/include/linux/mfd/ab8500.h b/include/linux/mfd/ab8500.h
index 6384046..efcc60e 100644
--- a/include/linux/mfd/ab8500.h
+++ b/include/linux/mfd/ab8500.h
@@ -180,6 +180,9 @@ struct ab8500_gpio_platform_data;
 /**
  * struct ab8500_platform_data - AB8500 platform data
  * @pm_power_off: Should machine pm power off hook be registered or not
+ * @thermal_power_off_pending: Set if there was a thermal alarm
+ * @thermal_set_time_sec: Time of the thermal alarm
+ * @thermal_time_out: Time out before the thermal alarm should be ignored
  * @irq_base: start of AB8500 IRQs, AB8500_NR_IRQS will be used
  * @init: board-specific initialization after detection of ab8500
  * @num_regulator_reg_init: number of regulator init registers
@@ -194,6 +197,9 @@ struct ab8500_gpio_platform_data;
 struct ab8500_platform_data {
 	int irq_base;
 	bool pm_power_off;
+	bool thermal_power_off_pending;
+	long thermal_set_time_sec;
+	long thermal_time_out;
 	void (*init) (struct ab8500 *);
 	int num_regulator_reg_init;
 	struct ab8500_regulator_reg_init *regulator_reg_init;
-- 
1.7.4.1


--------------040707000606030708020905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040707000606030708020905--
