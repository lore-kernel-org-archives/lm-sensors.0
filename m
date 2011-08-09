From: Matthew Garrett <mjg@redhat.com>
Date: Tue, 09 Aug 2011 16:14:41 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: Convert applesmc driver to pnp
Message-Id: <1312906483-3046-1-git-send-email-mjg@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The applesmc driver is current a platform device with DMI matching. All
machines with the appropriate hardware actually expose it via an acpipnp
device, so it makes sense to use that rather than hardcoding model names
and addresses.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/hwmon/applesmc.c |  660 +++++++++++++++++++++++++--------------------
 1 files changed, 367 insertions(+), 293 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 4c07436..62e2493 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -43,13 +43,15 @@
 #include <linux/leds.h>
 #include <linux/hwmon.h>
 #include <linux/workqueue.h>
+#include <linux/slab.h>
+#include <linux/pnp.h>
 
 /* data port used by Apple SMC */
-#define APPLESMC_DATA_PORT	0x300
+#define APPLESMC_DATA_PORT	0
 /* command/status port used by Apple SMC */
-#define APPLESMC_CMD_PORT	0x304
+#define APPLESMC_CMD_PORT	0x4
 
-#define APPLESMC_NR_PORTS	32 /* 0x300-0x31f */
+#define APPLESMC_NR_PORTS	32
 
 #define APPLESMC_MAX_DATA_LENGTH 32
 
@@ -128,7 +130,7 @@ struct applesmc_entry {
 };
 
 /* Register lookup and registers common to all SMCs */
-static struct applesmc_registers {
+struct applesmc_registers {
 	struct mutex mutex;		/* register read/write mutex */
 	unsigned int key_count;		/* number of SMC registers */
 	unsigned int fan_count;		/* number of fans */
@@ -140,33 +142,49 @@ static struct applesmc_registers {
 	bool has_key_backlight;		/* has keyboard backlight */
 	bool init_complete;		/* true when fully initialized */
 	struct applesmc_entry *cache;	/* cached key entries */
-} smcreg = {
-	.mutex = __MUTEX_INITIALIZER(smcreg.mutex),
 };
 
-static const int debug;
-static struct platform_device *pdev;
-static s16 rest_x;
-static s16 rest_y;
-static u8 backlight_state[2];
+struct applesmc_dev {
+	int iobase;
+	int iolen;
+	struct work_struct backlight_work;
+	struct applesmc_registers smcreg;
+	/*
+	 * Last index written to key_at_index sysfs file, and value to
+	 * use for all other key_at_index_* sysfs files.
+	 */
+	unsigned int key_at_index;
+	struct pnp_dev *pnpdev;
+
+	struct device *hwmon_dev;
+	struct input_polled_dev *applesmc_idev;
+
+	struct workqueue_struct *applesmc_led_wq;
+	s16 rest_x;
+	s16 rest_y;
+	u8 backlight_state[2];
+
+	struct led_classdev applesmc_backlight;
+};
 
-static struct device *hwmon_dev;
-static struct input_polled_dev *applesmc_idev;
+static const int debug;
 
-/*
- * Last index written to key_at_index sysfs file, and value to use for all other
- * key_at_index_* sysfs files.
- */
-static unsigned int key_at_index;
+static u8 applesmc_read_reg(struct applesmc_dev *pdev, u8 reg)
+{
+	return inb(pdev->iobase + reg);
+}
 
-static struct workqueue_struct *applesmc_led_wq;
+static void applesmc_write_reg(struct applesmc_dev *pdev, u8 val, u8 reg)
+{
+	outb(val, pdev->iobase + reg);
+}
 
 /*
  * __wait_status - Wait up to 32ms for the status port to get a certain value
  * (masked with 0x0f), returning zero if the value is obtained.  Callers must
  * hold applesmc_lock.
  */
-static int __wait_status(u8 val)
+static int __wait_status(struct applesmc_dev *pdev, u8 val)
 {
 	int us;
 
@@ -174,7 +192,8 @@ static int __wait_status(u8 val)
 
 	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
 		udelay(us);
-		if ((inb(APPLESMC_CMD_PORT) & APPLESMC_STATUS_MASK) = val)
+		if ((applesmc_read_reg(pdev, APPLESMC_CMD_PORT) &
+		     APPLESMC_STATUS_MASK) = val)
 			return 0;
 	}
 
@@ -186,80 +205,83 @@ static int __wait_status(u8 val)
  * to resend the command byte before polling the status again. Callers must
  * hold applesmc_lock.
  */
-static int send_command(u8 cmd)
+static int send_command(struct applesmc_dev *pdev, u8 cmd)
 {
 	int us;
 	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
-		outb(cmd, APPLESMC_CMD_PORT);
+		applesmc_write_reg(pdev, cmd, APPLESMC_CMD_PORT);
 		udelay(us);
-		if ((inb(APPLESMC_CMD_PORT) & APPLESMC_STATUS_MASK) = 0x0c)
+		if ((applesmc_read_reg(pdev, APPLESMC_CMD_PORT) &
+		     APPLESMC_STATUS_MASK) = 0x0c)
 			return 0;
 	}
 	return -EIO;
 }
 
-static int send_argument(const char *key)
+static int send_argument(struct applesmc_dev *pdev, const char *key)
 {
 	int i;
 
 	for (i = 0; i < 4; i++) {
-		outb(key[i], APPLESMC_DATA_PORT);
-		if (__wait_status(0x04))
+		applesmc_write_reg(pdev, key[i], APPLESMC_DATA_PORT);
+		if (__wait_status(pdev, 0x04))
 			return -EIO;
 	}
 	return 0;
 }
 
-static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
+static int read_smc(struct applesmc_dev *pdev, u8 cmd, const char *key,
+		    u8 *buffer, u8 len)
 {
 	int i;
 
-	if (send_command(cmd) || send_argument(key)) {
+	if (send_command(pdev, cmd) || send_argument(pdev, key)) {
 		pr_warn("%s: read arg fail\n", key);
 		return -EIO;
 	}
 
-	outb(len, APPLESMC_DATA_PORT);
+	applesmc_write_reg(pdev, len, APPLESMC_DATA_PORT);
 
 	for (i = 0; i < len; i++) {
-		if (__wait_status(0x05)) {
+		if (__wait_status(pdev, 0x05)) {
 			pr_warn("%s: read data fail\n", key);
 			return -EIO;
 		}
-		buffer[i] = inb(APPLESMC_DATA_PORT);
+		buffer[i] = applesmc_read_reg(pdev, APPLESMC_DATA_PORT);
 	}
 
 	return 0;
 }
 
-static int write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
+static int write_smc(struct applesmc_dev *pdev, u8 cmd, const char *key,
+		     const u8 *buffer, u8 len)
 {
 	int i;
 
-	if (send_command(cmd) || send_argument(key)) {
+	if (send_command(pdev, cmd) || send_argument(pdev, key)) {
 		pr_warn("%s: write arg fail\n", key);
 		return -EIO;
 	}
 
-	outb(len, APPLESMC_DATA_PORT);
+	applesmc_write_reg(pdev, len, APPLESMC_DATA_PORT);
 
 	for (i = 0; i < len; i++) {
-		if (__wait_status(0x04)) {
+		if (__wait_status(pdev, 0x04)) {
 			pr_warn("%s: write data fail\n", key);
 			return -EIO;
 		}
-		outb(buffer[i], APPLESMC_DATA_PORT);
+		applesmc_write_reg(pdev, buffer[i], APPLESMC_DATA_PORT);
 	}
 
 	return 0;
 }
 
-static int read_register_count(unsigned int *count)
+static int read_register_count(struct applesmc_dev *pdev, unsigned int *count)
 {
 	__be32 be;
 	int ret;
 
-	ret = read_smc(APPLESMC_READ_CMD, KEY_COUNT_KEY, (u8 *)&be, 4);
+	ret = read_smc(pdev, APPLESMC_READ_CMD, KEY_COUNT_KEY, (u8 *)&be, 4);
 	if (ret)
 		return ret;
 
@@ -274,36 +296,39 @@ static int read_register_count(unsigned int *count)
  * All functions below are concurrency safe - callers should NOT hold lock.
  */
 
-static int applesmc_read_entry(const struct applesmc_entry *entry,
+static int applesmc_read_entry(struct applesmc_dev *pdev,
+			       const struct applesmc_entry *entry,
 			       u8 *buf, u8 len)
 {
 	int ret;
 
 	if (entry->len != len)
 		return -EINVAL;
-	mutex_lock(&smcreg.mutex);
-	ret = read_smc(APPLESMC_READ_CMD, entry->key, buf, len);
-	mutex_unlock(&smcreg.mutex);
+	mutex_lock(&pdev->smcreg.mutex);
+	ret = read_smc(pdev, APPLESMC_READ_CMD, entry->key, buf, len);
+	mutex_unlock(&pdev->smcreg.mutex);
 
 	return ret;
 }
 
-static int applesmc_write_entry(const struct applesmc_entry *entry,
+static int applesmc_write_entry(struct applesmc_dev *pdev,
+				const struct applesmc_entry *entry,
 				const u8 *buf, u8 len)
 {
 	int ret;
 
 	if (entry->len != len)
 		return -EINVAL;
-	mutex_lock(&smcreg.mutex);
-	ret = write_smc(APPLESMC_WRITE_CMD, entry->key, buf, len);
-	mutex_unlock(&smcreg.mutex);
+	mutex_lock(&pdev->smcreg.mutex);
+	ret = write_smc(pdev, APPLESMC_WRITE_CMD, entry->key, buf, len);
+	mutex_unlock(&pdev->smcreg.mutex);
 	return ret;
 }
 
-static const struct applesmc_entry *applesmc_get_entry_by_index(int index)
+static const struct applesmc_entry *applesmc_get_entry_by_index(struct applesmc_dev *pdev,
+								int index)
 {
-	struct applesmc_entry *cache = &smcreg.cache[index];
+	struct applesmc_entry *cache = &pdev->smcreg.cache[index];
 	u8 key[4], info[6];
 	__be32 be;
 	int ret = 0;
@@ -311,15 +336,15 @@ static const struct applesmc_entry *applesmc_get_entry_by_index(int index)
 	if (cache->valid)
 		return cache;
 
-	mutex_lock(&smcreg.mutex);
+	mutex_lock(&pdev->smcreg.mutex);
 
 	if (cache->valid)
 		goto out;
 	be = cpu_to_be32(index);
-	ret = read_smc(APPLESMC_GET_KEY_BY_INDEX_CMD, (u8 *)&be, key, 4);
+	ret = read_smc(pdev, APPLESMC_GET_KEY_BY_INDEX_CMD, (u8 *)&be, key, 4);
 	if (ret)
 		goto out;
-	ret = read_smc(APPLESMC_GET_KEY_TYPE_CMD, key, info, 6);
+	ret = read_smc(pdev, APPLESMC_GET_KEY_TYPE_CMD, key, info, 6);
 	if (ret)
 		goto out;
 
@@ -330,20 +355,21 @@ static const struct applesmc_entry *applesmc_get_entry_by_index(int index)
 	cache->valid = 1;
 
 out:
-	mutex_unlock(&smcreg.mutex);
+	mutex_unlock(&pdev->smcreg.mutex);
 	if (ret)
 		return ERR_PTR(ret);
 	return cache;
 }
 
-static int applesmc_get_lower_bound(unsigned int *lo, const char *key)
+static int applesmc_get_lower_bound(struct applesmc_dev *pdev,
+				    unsigned int *lo, const char *key)
 {
-	int begin = 0, end = smcreg.key_count;
+	int begin = 0, end = pdev->smcreg.key_count;
 	const struct applesmc_entry *entry;
 
 	while (begin != end) {
 		int middle = begin + (end - begin) / 2;
-		entry = applesmc_get_entry_by_index(middle);
+		entry = applesmc_get_entry_by_index(pdev, middle);
 		if (IS_ERR(entry))
 			return PTR_ERR(entry);
 		if (strcmp(entry->key, key) < 0)
@@ -351,19 +377,19 @@ static int applesmc_get_lower_bound(unsigned int *lo, const char *key)
 		else
 			end = middle;
 	}
-
 	*lo = begin;
 	return 0;
 }
 
-static int applesmc_get_upper_bound(unsigned int *hi, const char *key)
+static int applesmc_get_upper_bound(struct applesmc_dev *pdev,
+				    unsigned int *hi, const char *key)
 {
-	int begin = 0, end = smcreg.key_count;
+	int begin = 0, end = pdev->smcreg.key_count;
 	const struct applesmc_entry *entry;
 
 	while (begin != end) {
 		int middle = begin + (end - begin) / 2;
-		entry = applesmc_get_entry_by_index(middle);
+		entry = applesmc_get_entry_by_index(pdev, middle);
 		if (IS_ERR(entry))
 			return PTR_ERR(entry);
 		if (strcmp(key, entry->key) < 0)
@@ -376,50 +402,57 @@ static int applesmc_get_upper_bound(unsigned int *hi, const char *key)
 	return 0;
 }
 
-static const struct applesmc_entry *applesmc_get_entry_by_key(const char *key)
+static const struct applesmc_entry *applesmc_get_entry_by_key(struct applesmc_dev *pdev,
+							      const char *key)
 {
 	int begin, end;
 	int ret;
 
-	ret = applesmc_get_lower_bound(&begin, key);
+	ret = applesmc_get_lower_bound(pdev, &begin, key);
 	if (ret)
 		return ERR_PTR(ret);
-	ret = applesmc_get_upper_bound(&end, key);
+
+	ret = applesmc_get_upper_bound(pdev, &end, key);
 	if (ret)
 		return ERR_PTR(ret);
+
 	if (end - begin != 1)
 		return ERR_PTR(-EINVAL);
 
-	return applesmc_get_entry_by_index(begin);
+	return applesmc_get_entry_by_index(pdev, begin);
 }
 
-static int applesmc_read_key(const char *key, u8 *buffer, u8 len)
+static int applesmc_read_key(struct applesmc_dev *pdev, const char *key,
+			     u8 *buffer, u8 len)
 {
 	const struct applesmc_entry *entry;
 
-	entry = applesmc_get_entry_by_key(key);
+	entry = applesmc_get_entry_by_key(pdev, key);
+
 	if (IS_ERR(entry))
 		return PTR_ERR(entry);
 
-	return applesmc_read_entry(entry, buffer, len);
+	return applesmc_read_entry(pdev, entry, buffer, len);
 }
 
-static int applesmc_write_key(const char *key, const u8 *buffer, u8 len)
+static int applesmc_write_key(struct applesmc_dev *pdev, const char *key,
+			      const u8 *buffer, u8 len)
 {
 	const struct applesmc_entry *entry;
 
-	entry = applesmc_get_entry_by_key(key);
+	entry = applesmc_get_entry_by_key(pdev, key);
 	if (IS_ERR(entry))
 		return PTR_ERR(entry);
 
-	return applesmc_write_entry(entry, buffer, len);
+	return applesmc_write_entry(pdev, entry, buffer, len);
 }
 
-static int applesmc_has_key(const char *key, bool *value)
+static int applesmc_has_key(struct applesmc_dev *pdev, const char *key,
+			    bool *value)
 {
 	const struct applesmc_entry *entry;
 
-	entry = applesmc_get_entry_by_key(key);
+	entry = applesmc_get_entry_by_key(pdev, key);
 	if (IS_ERR(entry) && PTR_ERR(entry) != -EINVAL)
 		return PTR_ERR(entry);
 
@@ -430,20 +463,21 @@ static int applesmc_has_key(const char *key, bool *value)
 /*
  * applesmc_read_motion_sensor - Read motion sensor (X, Y or Z).
  */
-static int applesmc_read_motion_sensor(int index, s16 *value)
+static int applesmc_read_motion_sensor(struct applesmc_dev *pdev, int index,
+				       s16 *value)
 {
 	u8 buffer[2];
 	int ret;
 
 	switch (index) {
 	case SENSOR_X:
-		ret = applesmc_read_key(MOTION_SENSOR_X_KEY, buffer, 2);
+		ret = applesmc_read_key(pdev, MOTION_SENSOR_X_KEY, buffer, 2);
 		break;
 	case SENSOR_Y:
-		ret = applesmc_read_key(MOTION_SENSOR_Y_KEY, buffer, 2);
+		ret = applesmc_read_key(pdev, MOTION_SENSOR_Y_KEY, buffer, 2);
 		break;
 	case SENSOR_Z:
-		ret = applesmc_read_key(MOTION_SENSOR_Z_KEY, buffer, 2);
+		ret = applesmc_read_key(pdev, MOTION_SENSOR_Z_KEY, buffer, 2);
 		break;
 	default:
 		ret = -EINVAL;
@@ -457,21 +491,21 @@ static int applesmc_read_motion_sensor(int index, s16 *value)
 /*
  * applesmc_device_init - initialize the accelerometer.  Can sleep.
  */
-static void applesmc_device_init(void)
+static void applesmc_device_init(struct applesmc_dev *pdev)
 {
 	int total;
 	u8 buffer[2];
 
-	if (!smcreg.has_accelerometer)
+	if (!pdev->smcreg.has_accelerometer)
 		return;
 
 	for (total = INIT_TIMEOUT_MSECS; total > 0; total -= INIT_WAIT_MSECS) {
-		if (!applesmc_read_key(MOTION_SENSOR_KEY, buffer, 2) &&
+		if (!applesmc_read_key(pdev, MOTION_SENSOR_KEY, buffer, 2) &&
 				(buffer[0] != 0x00 || buffer[1] != 0x00))
 			return;
 		buffer[0] = 0xe0;
 		buffer[1] = 0x00;
-		applesmc_write_key(MOTION_SENSOR_KEY, buffer, 2);
+		applesmc_write_key(pdev, MOTION_SENSOR_KEY, buffer, 2);
 		msleep(INIT_WAIT_MSECS);
 	}
 
@@ -481,9 +515,9 @@ static void applesmc_device_init(void)
 /*
  * applesmc_init_smcreg_try - Try to initialize register cache. Idempotent.
  */
-static int applesmc_init_smcreg_try(void)
+static int applesmc_init_smcreg_try(struct applesmc_dev *pdev)
 {
-	struct applesmc_registers *s = &smcreg;
+	struct applesmc_registers *s = &pdev->smcreg;
 	bool left_light_sensor, right_light_sensor;
 	u8 tmp[1];
 	int ret;
@@ -491,7 +525,7 @@ static int applesmc_init_smcreg_try(void)
 	if (s->init_complete)
 		return 0;
 
-	ret = read_register_count(&s->key_count);
+	ret = read_register_count(pdev, &s->key_count);
 	if (ret)
 		return ret;
 
@@ -500,29 +534,35 @@ static int applesmc_init_smcreg_try(void)
 	if (!s->cache)
 		return -ENOMEM;
 
-	ret = applesmc_read_key(FANS_COUNT, tmp, 1);
+	ret = applesmc_read_key(pdev, FANS_COUNT, tmp, 1);
 	if (ret)
 		return ret;
 	s->fan_count = tmp[0];
 
-	ret = applesmc_get_lower_bound(&s->temp_begin, "T");
+	ret = applesmc_get_lower_bound(pdev, &s->temp_begin, "T");
 	if (ret)
 		return ret;
-	ret = applesmc_get_lower_bound(&s->temp_end, "U");
+
+	ret = applesmc_get_lower_bound(pdev, &s->temp_end, "U");
 	if (ret)
 		return ret;
 	s->temp_count = s->temp_end - s->temp_begin;
 
-	ret = applesmc_has_key(LIGHT_SENSOR_LEFT_KEY, &left_light_sensor);
+	ret = applesmc_has_key(pdev, LIGHT_SENSOR_LEFT_KEY,
+			       &left_light_sensor);
 	if (ret)
 		return ret;
-	ret = applesmc_has_key(LIGHT_SENSOR_RIGHT_KEY, &right_light_sensor);
+
+	ret = applesmc_has_key(pdev, LIGHT_SENSOR_RIGHT_KEY,
+			       &right_light_sensor);
 	if (ret)
 		return ret;
-	ret = applesmc_has_key(MOTION_SENSOR_KEY, &s->has_accelerometer);
+
+	ret = applesmc_has_key(pdev, MOTION_SENSOR_KEY, &s->has_accelerometer);
 	if (ret)
 		return ret;
-	ret = applesmc_has_key(BACKLIGHT_KEY, &s->has_key_backlight);
+
+	ret = applesmc_has_key(pdev, BACKLIGHT_KEY, &s->has_key_backlight);
 	if (ret)
 		return ret;
 
@@ -544,12 +584,12 @@ static int applesmc_init_smcreg_try(void)
  * Retries until initialization is successful, or the operation times out.
  *
  */
-static int applesmc_init_smcreg(void)
+static int applesmc_init_smcreg(struct applesmc_dev *pdev)
 {
 	int ms, ret;
 
 	for (ms = 0; ms < INIT_TIMEOUT_MSECS; ms += INIT_WAIT_MSECS) {
-		ret = applesmc_init_smcreg_try();
+		ret = applesmc_init_smcreg_try(pdev);
 		if (!ret) {
 			if (ms)
 				pr_info("init_smcreg() took %d ms\n", ms);
@@ -558,45 +598,38 @@ static int applesmc_init_smcreg(void)
 		msleep(INIT_WAIT_MSECS);
 	}
 
-	kfree(smcreg.cache);
-	smcreg.cache = NULL;
+	kfree(pdev->smcreg.cache);
+	pdev->smcreg.cache = NULL;
 
 	return ret;
 }
 
-static void applesmc_destroy_smcreg(void)
-{
-	kfree(smcreg.cache);
-	smcreg.cache = NULL;
-	smcreg.init_complete = false;
-}
-
-/* Device model stuff */
-static int applesmc_probe(struct platform_device *dev)
+static void applesmc_destroy_smcreg(struct applesmc_dev *pdev)
 {
-	int ret;
-
-	ret = applesmc_init_smcreg();
-	if (ret)
-		return ret;
-
-	applesmc_device_init();
-
-	return 0;
+	kfree(pdev->smcreg.cache);
+	pdev->smcreg.cache = NULL;
+	pdev->smcreg.init_complete = false;
 }
 
 /* Synchronize device with memorized backlight state */
 static int applesmc_pm_resume(struct device *dev)
 {
-	if (smcreg.has_key_backlight)
-		applesmc_write_key(BACKLIGHT_KEY, backlight_state, 2);
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
+
+	if (pdev->smcreg.has_key_backlight)
+		applesmc_write_key(pdev, BACKLIGHT_KEY, pdev->backlight_state,
+				   2);
 	return 0;
 }
 
 /* Reinitialize device on resume from hibernation */
 static int applesmc_pm_restore(struct device *dev)
 {
-	applesmc_device_init();
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
+
+	applesmc_device_init(pdev);
 	return applesmc_pm_resume(dev);
 }
 
@@ -605,39 +638,32 @@ static const struct dev_pm_ops applesmc_pm_ops = {
 	.restore = applesmc_pm_restore,
 };
 
-static struct platform_driver applesmc_driver = {
-	.probe = applesmc_probe,
-	.driver	= {
-		.name = "applesmc",
-		.owner = THIS_MODULE,
-		.pm = &applesmc_pm_ops,
-	},
-};
-
 /*
  * applesmc_calibrate - Set our "resting" values.  Callers must
  * hold applesmc_lock.
  */
-static void applesmc_calibrate(void)
+static void applesmc_calibrate(struct applesmc_dev *pdev)
 {
-	applesmc_read_motion_sensor(SENSOR_X, &rest_x);
-	applesmc_read_motion_sensor(SENSOR_Y, &rest_y);
-	rest_x = -rest_x;
+	applesmc_read_motion_sensor(pdev, SENSOR_X, &pdev->rest_x);
+	applesmc_read_motion_sensor(pdev, SENSOR_Y, &pdev->rest_y);
+	pdev->rest_x = -pdev->rest_x;
 }
 
 static void applesmc_idev_poll(struct input_polled_dev *dev)
 {
 	struct input_dev *idev = dev->input;
+	struct pnp_dev *pnpdev = to_pnp_dev(idev->dev.parent);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
 	s16 x, y;
 
-	if (applesmc_read_motion_sensor(SENSOR_X, &x))
+	if (applesmc_read_motion_sensor(pdev, SENSOR_X, &x))
 		return;
-	if (applesmc_read_motion_sensor(SENSOR_Y, &y))
+	if (applesmc_read_motion_sensor(pdev, SENSOR_Y, &y))
 		return;
 
 	x = -x;
-	input_report_abs(idev, ABS_X, x - rest_x);
-	input_report_abs(idev, ABS_Y, y - rest_y);
+	input_report_abs(idev, ABS_X, x - pdev->rest_x);
+	input_report_abs(idev, ABS_Y, y - pdev->rest_y);
 	input_sync(idev);
 }
 
@@ -652,16 +678,18 @@ static ssize_t applesmc_name_show(struct device *dev,
 static ssize_t applesmc_position_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
 	int ret;
 	s16 x, y, z;
 
-	ret = applesmc_read_motion_sensor(SENSOR_X, &x);
+	ret = applesmc_read_motion_sensor(pdev, SENSOR_X, &x);
 	if (ret)
 		goto out;
-	ret = applesmc_read_motion_sensor(SENSOR_Y, &y);
+	ret = applesmc_read_motion_sensor(pdev, SENSOR_Y, &y);
 	if (ret)
 		goto out;
-	ret = applesmc_read_motion_sensor(SENSOR_Z, &z);
+	ret = applesmc_read_motion_sensor(pdev, SENSOR_Z, &z);
 	if (ret)
 		goto out;
 
@@ -675,6 +703,8 @@ out:
 static ssize_t applesmc_light_show(struct device *dev,
 				struct device_attribute *attr, char *sysfsbuf)
 {
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
 	const struct applesmc_entry *entry;
 	static int data_length;
 	int ret;
@@ -682,7 +712,7 @@ static ssize_t applesmc_light_show(struct device *dev,
 	u8 buffer[10];
 
 	if (!data_length) {
-		entry = applesmc_get_entry_by_key(LIGHT_SENSOR_LEFT_KEY);
+		entry = applesmc_get_entry_by_key(pdev, LIGHT_SENSOR_LEFT_KEY);
 		if (IS_ERR(entry))
 			return PTR_ERR(entry);
 		if (entry->len > 10)
@@ -691,7 +721,8 @@ static ssize_t applesmc_light_show(struct device *dev,
 		pr_info("light sensor data length set to %d\n", data_length);
 	}
 
-	ret = applesmc_read_key(LIGHT_SENSOR_LEFT_KEY, buffer, data_length);
+	ret = applesmc_read_key(pdev, LIGHT_SENSOR_LEFT_KEY, buffer,
+				data_length);
 	/* newer macbooks report a single 10-bit bigendian value */
 	if (data_length = 10) {
 		left = be16_to_cpu(*(__be16 *)(buffer + 6)) >> 2;
@@ -700,7 +731,8 @@ static ssize_t applesmc_light_show(struct device *dev,
 	left = buffer[2];
 	if (ret)
 		goto out;
-	ret = applesmc_read_key(LIGHT_SENSOR_RIGHT_KEY, buffer, data_length);
+	ret = applesmc_read_key(pdev, LIGHT_SENSOR_RIGHT_KEY, buffer,
+				data_length);
 	right = buffer[2];
 
 out:
@@ -714,10 +746,12 @@ out:
 static ssize_t applesmc_show_sensor_label(struct device *dev,
 			struct device_attribute *devattr, char *sysfsbuf)
 {
-	int index = smcreg.temp_begin + to_index(devattr);
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
+	int index = pdev->smcreg.temp_begin + to_index(devattr);
 	const struct applesmc_entry *entry;
 
-	entry = applesmc_get_entry_by_index(index);
+	entry = applesmc_get_entry_by_index(pdev, index);
 	if (IS_ERR(entry))
 		return PTR_ERR(entry);
 
@@ -728,19 +762,21 @@ static ssize_t applesmc_show_sensor_label(struct device *dev,
 static ssize_t applesmc_show_temperature(struct device *dev,
 			struct device_attribute *devattr, char *sysfsbuf)
 {
-	int index = smcreg.temp_begin + to_index(devattr);
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
+	int index = pdev->smcreg.temp_begin + to_index(devattr);
 	const struct applesmc_entry *entry;
 	int ret;
 	u8 buffer[2];
 	unsigned int temp;
 
-	entry = applesmc_get_entry_by_index(index);
+	entry = applesmc_get_entry_by_index(pdev, index);
 	if (IS_ERR(entry))
 		return PTR_ERR(entry);
 	if (entry->len > 2)
 		return -EINVAL;
 
-	ret = applesmc_read_entry(entry, buffer, entry->len);
+	ret = applesmc_read_entry(pdev, entry, buffer, entry->len);
 	if (ret)
 		return ret;
 
@@ -757,6 +793,8 @@ static ssize_t applesmc_show_temperature(struct device *dev,
 static ssize_t applesmc_show_fan_speed(struct device *dev,
 				struct device_attribute *attr, char *sysfsbuf)
 {
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
 	int ret;
 	unsigned int speed = 0;
 	char newkey[5];
@@ -764,7 +802,7 @@ static ssize_t applesmc_show_fan_speed(struct device *dev,
 
 	sprintf(newkey, fan_speed_fmt[to_option(attr)], to_index(attr));
 
-	ret = applesmc_read_key(newkey, buffer, 2);
+	ret = applesmc_read_key(pdev, newkey, buffer, 2);
 	speed = ((buffer[0] << 8 | buffer[1]) >> 2);
 
 	if (ret)
@@ -777,6 +815,8 @@ static ssize_t applesmc_store_fan_speed(struct device *dev,
 					struct device_attribute *attr,
 					const char *sysfsbuf, size_t count)
 {
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
 	int ret;
 	unsigned long speed;
 	char newkey[5];
@@ -789,7 +829,7 @@ static ssize_t applesmc_store_fan_speed(struct device *dev,
 
 	buffer[0] = (speed >> 6) & 0xff;
 	buffer[1] = (speed << 2) & 0xff;
-	ret = applesmc_write_key(newkey, buffer, 2);
+	ret = applesmc_write_key(pdev, newkey, buffer, 2);
 
 	if (ret)
 		return ret;
@@ -800,11 +840,13 @@ static ssize_t applesmc_store_fan_speed(struct device *dev,
 static ssize_t applesmc_show_fan_manual(struct device *dev,
 			struct device_attribute *attr, char *sysfsbuf)
 {
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
 	int ret;
 	u16 manual = 0;
 	u8 buffer[2];
 
-	ret = applesmc_read_key(FANS_MANUAL, buffer, 2);
+	ret = applesmc_read_key(pdev, FANS_MANUAL, buffer, 2);
 	manual = ((buffer[0] << 8 | buffer[1]) >> to_index(attr)) & 0x01;
 
 	if (ret)
@@ -817,6 +859,8 @@ static ssize_t applesmc_store_fan_manual(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *sysfsbuf, size_t count)
 {
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
 	int ret;
 	u8 buffer[2];
 	unsigned long input;
@@ -825,7 +869,7 @@ static ssize_t applesmc_store_fan_manual(struct device *dev,
 	if (strict_strtoul(sysfsbuf, 10, &input) < 0)
 		return -EINVAL;
 
-	ret = applesmc_read_key(FANS_MANUAL, buffer, 2);
+	ret = applesmc_read_key(pdev, FANS_MANUAL, buffer, 2);
 	val = (buffer[0] << 8 | buffer[1]);
 	if (ret)
 		goto out;
@@ -838,7 +882,7 @@ static ssize_t applesmc_store_fan_manual(struct device *dev,
 	buffer[0] = (val >> 8) & 0xFF;
 	buffer[1] = val & 0xFF;
 
-	ret = applesmc_write_key(FANS_MANUAL, buffer, 2);
+	ret = applesmc_write_key(pdev, FANS_MANUAL, buffer, 2);
 
 out:
 	if (ret)
@@ -850,13 +894,15 @@ out:
 static ssize_t applesmc_show_fan_position(struct device *dev,
 				struct device_attribute *attr, char *sysfsbuf)
 {
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
 	int ret;
 	char newkey[5];
 	u8 buffer[17];
 
 	sprintf(newkey, FAN_ID_FMT, to_index(attr));
 
-	ret = applesmc_read_key(newkey, buffer, 16);
+	ret = applesmc_read_key(pdev, newkey, buffer, 16);
 	buffer[16] = 0;
 
 	if (ret)
@@ -868,30 +914,41 @@ static ssize_t applesmc_show_fan_position(struct device *dev,
 static ssize_t applesmc_calibrate_show(struct device *dev,
 				struct device_attribute *attr, char *sysfsbuf)
 {
-	return snprintf(sysfsbuf, PAGE_SIZE, "(%d,%d)\n", rest_x, rest_y);
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
+
+	return snprintf(sysfsbuf, PAGE_SIZE, "(%d,%d)\n", pdev->rest_x,
+			pdev->rest_y);
 }
 
 static ssize_t applesmc_calibrate_store(struct device *dev,
 	struct device_attribute *attr, const char *sysfsbuf, size_t count)
 {
-	applesmc_calibrate();
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
+
+	applesmc_calibrate(pdev);
 
 	return count;
 }
 
 static void applesmc_backlight_set(struct work_struct *work)
 {
-	applesmc_write_key(BACKLIGHT_KEY, backlight_state, 2);
+	struct applesmc_dev *pdev = container_of(work, struct applesmc_dev,
+						 backlight_work);
+
+	applesmc_write_key(pdev, BACKLIGHT_KEY, pdev->backlight_state, 2);
 }
-static DECLARE_WORK(backlight_work, &applesmc_backlight_set);
 
 static void applesmc_brightness_set(struct led_classdev *led_cdev,
 						enum led_brightness value)
 {
+	struct pnp_dev *pnpdev = to_pnp_dev(led_cdev->dev->parent);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
 	int ret;
 
-	backlight_state[0] = value;
-	ret = queue_work(applesmc_led_wq, &backlight_work);
+	pdev->backlight_state[0] = value;
+	ret = queue_work(pdev->applesmc_led_wq, &pdev->backlight_work);
 
 	if (debug && (!ret))
 		printk(KERN_DEBUG "applesmc: work was already on the queue.\n");
@@ -900,11 +957,13 @@ static void applesmc_brightness_set(struct led_classdev *led_cdev,
 static ssize_t applesmc_key_count_show(struct device *dev,
 				struct device_attribute *attr, char *sysfsbuf)
 {
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
 	int ret;
 	u8 buffer[4];
 	u32 count;
 
-	ret = applesmc_read_key(KEY_COUNT_KEY, buffer, 4);
+	ret = applesmc_read_key(pdev, KEY_COUNT_KEY, buffer, 4);
 	count = ((u32)buffer[0]<<24) + ((u32)buffer[1]<<16) +
 						((u32)buffer[2]<<8) + buffer[3];
 
@@ -917,13 +976,15 @@ static ssize_t applesmc_key_count_show(struct device *dev,
 static ssize_t applesmc_key_at_index_read_show(struct device *dev,
 				struct device_attribute *attr, char *sysfsbuf)
 {
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
 	const struct applesmc_entry *entry;
 	int ret;
 
-	entry = applesmc_get_entry_by_index(key_at_index);
+	entry = applesmc_get_entry_by_index(pdev, pdev->key_at_index);
 	if (IS_ERR(entry))
 		return PTR_ERR(entry);
-	ret = applesmc_read_entry(entry, sysfsbuf, entry->len);
+	ret = applesmc_read_entry(pdev, entry, sysfsbuf, entry->len);
 	if (ret)
 		return ret;
 
@@ -933,9 +994,11 @@ static ssize_t applesmc_key_at_index_read_show(struct device *dev,
 static ssize_t applesmc_key_at_index_data_length_show(struct device *dev,
 				struct device_attribute *attr, char *sysfsbuf)
 {
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
 	const struct applesmc_entry *entry;
 
-	entry = applesmc_get_entry_by_index(key_at_index);
+	entry = applesmc_get_entry_by_index(pdev, pdev->key_at_index);
 	if (IS_ERR(entry))
 		return PTR_ERR(entry);
 
@@ -945,9 +1008,11 @@ static ssize_t applesmc_key_at_index_data_length_show(struct device *dev,
 static ssize_t applesmc_key_at_index_type_show(struct device *dev,
 				struct device_attribute *attr, char *sysfsbuf)
 {
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
 	const struct applesmc_entry *entry;
 
-	entry = applesmc_get_entry_by_index(key_at_index);
+	entry = applesmc_get_entry_by_index(pdev, pdev->key_at_index);
 	if (IS_ERR(entry))
 		return PTR_ERR(entry);
 
@@ -957,9 +1022,11 @@ static ssize_t applesmc_key_at_index_type_show(struct device *dev,
 static ssize_t applesmc_key_at_index_name_show(struct device *dev,
 				struct device_attribute *attr, char *sysfsbuf)
 {
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
 	const struct applesmc_entry *entry;
 
-	entry = applesmc_get_entry_by_index(key_at_index);
+	entry = applesmc_get_entry_by_index(pdev, pdev->key_at_index);
 	if (IS_ERR(entry))
 		return PTR_ERR(entry);
 
@@ -969,28 +1036,27 @@ static ssize_t applesmc_key_at_index_name_show(struct device *dev,
 static ssize_t applesmc_key_at_index_show(struct device *dev,
 				struct device_attribute *attr, char *sysfsbuf)
 {
-	return snprintf(sysfsbuf, PAGE_SIZE, "%d\n", key_at_index);
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
+
+	return snprintf(sysfsbuf, PAGE_SIZE, "%d\n", pdev->key_at_index);
 }
 
 static ssize_t applesmc_key_at_index_store(struct device *dev,
 	struct device_attribute *attr, const char *sysfsbuf, size_t count)
 {
+	struct pnp_dev *pnpdev = to_pnp_dev(dev);
+	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
 	unsigned long newkey;
 
 	if (strict_strtoul(sysfsbuf, 10, &newkey) < 0
-	    || newkey >= smcreg.key_count)
+	    || newkey >= pdev->smcreg.key_count)
 		return -EINVAL;
 
-	key_at_index = newkey;
+	pdev->key_at_index = newkey;
 	return count;
 }
 
-static struct led_classdev applesmc_backlight = {
-	.name			= "smc::kbd_backlight",
-	.default_trigger	= "nand-disk",
-	.brightness_set		= applesmc_brightness_set,
-};
-
 static struct applesmc_node_group info_group[] = {
 	{ "name", applesmc_name_show },
 	{ "key_count", applesmc_key_count_show },
@@ -1035,14 +1101,16 @@ static struct applesmc_node_group temp_group[] = {
 /*
  * applesmc_destroy_nodes - remove files and free associated memory
  */
-static void applesmc_destroy_nodes(struct applesmc_node_group *groups)
+static void applesmc_destroy_nodes(struct applesmc_dev *pdev,
+				   struct applesmc_node_group *groups)
 {
 	struct applesmc_node_group *grp;
 	struct applesmc_dev_attr *node;
+	struct pnp_dev *pnpdev = pdev->pnpdev;
 
 	for (grp = groups; grp->nodes; grp++) {
 		for (node = grp->nodes; node->sda.dev_attr.attr.name; node++)
-			sysfs_remove_file(&pdev->dev.kobj,
+			sysfs_remove_file(&pnpdev->dev.kobj,
 					  &node->sda.dev_attr.attr);
 		kfree(grp->nodes);
 		grp->nodes = NULL;
@@ -1052,11 +1120,13 @@ static void applesmc_destroy_nodes(struct applesmc_node_group *groups)
 /*
  * applesmc_create_nodes - create a two-dimensional group of sysfs files
  */
-static int applesmc_create_nodes(struct applesmc_node_group *groups, int num)
+static int applesmc_create_nodes(struct applesmc_dev *pdev,
+				 struct applesmc_node_group *groups, int num)
 {
 	struct applesmc_node_group *grp;
 	struct applesmc_dev_attr *node;
 	struct attribute *attr;
+	struct pnp_dev *pnpdev = pdev->pnpdev;
 	int ret, i;
 
 	for (grp = groups; grp->format; grp++) {
@@ -1075,7 +1145,7 @@ static int applesmc_create_nodes(struct applesmc_node_group *groups, int num)
 			sysfs_attr_init(attr);
 			attr->name = node->name;
 			attr->mode = S_IRUGO | (grp->store ? S_IWUSR : 0);
-			ret = sysfs_create_file(&pdev->dev.kobj, attr);
+			ret = sysfs_create_file(&pnpdev->dev.kobj, attr);
 			if (ret) {
 				attr->name = NULL;
 				goto out;
@@ -1085,57 +1155,58 @@ static int applesmc_create_nodes(struct applesmc_node_group *groups, int num)
 
 	return 0;
 out:
-	applesmc_destroy_nodes(groups);
+	applesmc_destroy_nodes(pdev, groups);
 	return ret;
 }
 
 /* Create accelerometer ressources */
-static int applesmc_create_accelerometer(void)
+static int applesmc_create_accelerometer(struct applesmc_dev *pdev)
 {
+	struct pnp_dev *pnpdev = pdev->pnpdev;
 	struct input_dev *idev;
 	int ret;
 
-	if (!smcreg.has_accelerometer)
+	if (!pdev->smcreg.has_accelerometer)
 		return 0;
 
-	ret = applesmc_create_nodes(accelerometer_group, 1);
+	ret = applesmc_create_nodes(pdev, accelerometer_group, 1);
 	if (ret)
 		goto out;
 
-	applesmc_idev = input_allocate_polled_device();
-	if (!applesmc_idev) {
+	pdev->applesmc_idev = input_allocate_polled_device();
+	if (!pdev->applesmc_idev) {
 		ret = -ENOMEM;
 		goto out_sysfs;
 	}
 
-	applesmc_idev->poll = applesmc_idev_poll;
-	applesmc_idev->poll_interval = APPLESMC_POLL_INTERVAL;
+	pdev->applesmc_idev->poll = applesmc_idev_poll;
+	pdev->applesmc_idev->poll_interval = APPLESMC_POLL_INTERVAL;
 
 	/* initial calibrate for the input device */
-	applesmc_calibrate();
+	applesmc_calibrate(pdev);
 
 	/* initialize the input device */
-	idev = applesmc_idev->input;
+	idev = pdev->applesmc_idev->input;
 	idev->name = "applesmc";
 	idev->id.bustype = BUS_HOST;
-	idev->dev.parent = &pdev->dev;
+	idev->dev.parent = &pnpdev->dev;
 	idev->evbit[0] = BIT_MASK(EV_ABS);
 	input_set_abs_params(idev, ABS_X,
 			-256, 256, APPLESMC_INPUT_FUZZ, APPLESMC_INPUT_FLAT);
 	input_set_abs_params(idev, ABS_Y,
 			-256, 256, APPLESMC_INPUT_FUZZ, APPLESMC_INPUT_FLAT);
 
-	ret = input_register_polled_device(applesmc_idev);
+	ret = input_register_polled_device(pdev->applesmc_idev);
 	if (ret)
 		goto out_idev;
 
 	return 0;
 
 out_idev:
-	input_free_polled_device(applesmc_idev);
+	input_free_polled_device(pdev->applesmc_idev);
 
 out_sysfs:
-	applesmc_destroy_nodes(accelerometer_group);
+	applesmc_destroy_nodes(pdev, accelerometer_group);
 
 out:
 	pr_warn("driver init failed (ret=%d)!\n", ret);
@@ -1143,184 +1214,188 @@ out:
 }
 
 /* Release all ressources used by the accelerometer */
-static void applesmc_release_accelerometer(void)
+static void applesmc_release_accelerometer(struct applesmc_dev *pdev)
 {
-	if (!smcreg.has_accelerometer)
+	if (!pdev->smcreg.has_accelerometer)
 		return;
-	input_unregister_polled_device(applesmc_idev);
-	input_free_polled_device(applesmc_idev);
-	applesmc_destroy_nodes(accelerometer_group);
+	input_unregister_polled_device(pdev->applesmc_idev);
+	input_free_polled_device(pdev->applesmc_idev);
+	applesmc_destroy_nodes(pdev, accelerometer_group);
 }
 
-static int applesmc_create_light_sensor(void)
+static int applesmc_create_light_sensor(struct applesmc_dev *pdev)
 {
-	if (!smcreg.num_light_sensors)
+	if (!pdev->smcreg.num_light_sensors)
 		return 0;
-	return applesmc_create_nodes(light_sensor_group, 1);
+	return applesmc_create_nodes(pdev, light_sensor_group, 1);
 }
 
-static void applesmc_release_light_sensor(void)
+static void applesmc_release_light_sensor(struct applesmc_dev *pdev)
 {
-	if (!smcreg.num_light_sensors)
+	if (!pdev->smcreg.num_light_sensors)
 		return;
-	applesmc_destroy_nodes(light_sensor_group);
+	applesmc_destroy_nodes(pdev, light_sensor_group);
 }
 
-static int applesmc_create_key_backlight(void)
+static int applesmc_create_key_backlight(struct applesmc_dev *pdev)
 {
-	if (!smcreg.has_key_backlight)
+	if (!pdev->smcreg.has_key_backlight)
 		return 0;
-	applesmc_led_wq = create_singlethread_workqueue("applesmc-led");
-	if (!applesmc_led_wq)
+	pdev->applesmc_led_wq = create_singlethread_workqueue("applesmc-led");
+	if (!pdev->applesmc_led_wq)
 		return -ENOMEM;
-	return led_classdev_register(&pdev->dev, &applesmc_backlight);
+
+	pdev->applesmc_backlight.name = "smc::kbd_backlight";
+	pdev->applesmc_backlight.default_trigger = "nand-disk";
+	pdev->applesmc_backlight.brightness_set = applesmc_brightness_set;
+
+	return led_classdev_register(&pdev->pnpdev->dev,
+				     &pdev->applesmc_backlight);
 }
 
-static void applesmc_release_key_backlight(void)
+static void applesmc_release_key_backlight(struct applesmc_dev *pdev)
 {
-	if (!smcreg.has_key_backlight)
+	if (!pdev->smcreg.has_key_backlight)
 		return;
-	led_classdev_unregister(&applesmc_backlight);
-	destroy_workqueue(applesmc_led_wq);
+	led_classdev_unregister(&pdev->applesmc_backlight);
+	destroy_workqueue(pdev->applesmc_led_wq);
 }
 
-static int applesmc_dmi_match(const struct dmi_system_id *id)
+static int __devinit applesmc_pnp_probe(struct pnp_dev *dev,
+					const struct pnp_device_id *dev_id)
 {
-	return 1;
-}
+	int ret;
+	struct resource *res;
+	struct applesmc_dev *pdev = kzalloc(sizeof(struct applesmc_dev),
+					    GFP_KERNEL);
 
-/* Note that DMI_MATCH(...,"MacBook") will match "MacBookPro1,1".
- * So we need to put "Apple MacBook Pro" before "Apple MacBook". */
-static __initdata struct dmi_system_id applesmc_whitelist[] = {
-	{ applesmc_dmi_match, "Apple MacBook Air", {
-	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
-	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir") },
-	},
-	{ applesmc_dmi_match, "Apple MacBook Pro", {
-	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
-	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro") },
-	},
-	{ applesmc_dmi_match, "Apple MacBook", {
-	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
-	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBook") },
-	},
-	{ applesmc_dmi_match, "Apple Macmini", {
-	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
-	  DMI_MATCH(DMI_PRODUCT_NAME, "Macmini") },
-	},
-	{ applesmc_dmi_match, "Apple MacPro", {
-	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
-	  DMI_MATCH(DMI_PRODUCT_NAME, "MacPro") },
-	},
-	{ applesmc_dmi_match, "Apple iMac", {
-	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
-	  DMI_MATCH(DMI_PRODUCT_NAME, "iMac") },
-	},
-	{ .ident = NULL }
-};
+	if (!pdev)
+		return -ENOMEM;
 
-static int __init applesmc_init(void)
-{
-	int ret;
+	mutex_init(&pdev->smcreg.mutex);
+	pdev->pnpdev = dev;
+	pnp_set_drvdata(dev, pdev);
 
-	if (!dmi_check_system(applesmc_whitelist)) {
-		pr_warn("supported laptop not found!\n");
-		ret = -ENODEV;
-		goto out;
-	}
+	res = pnp_get_resource(dev, IORESOURCE_IO, 0);
 
-	if (!request_region(APPLESMC_DATA_PORT, APPLESMC_NR_PORTS,
-								"applesmc")) {
+	if (!res) {
 		ret = -ENXIO;
 		goto out;
 	}
 
-	ret = platform_driver_register(&applesmc_driver);
-	if (ret)
-		goto out_region;
+	pdev->iobase = res->start;
+	pdev->iolen = res->end - res->start + 1;
 
-	pdev = platform_device_register_simple("applesmc", APPLESMC_DATA_PORT,
-					       NULL, 0);
-	if (IS_ERR(pdev)) {
-		ret = PTR_ERR(pdev);
-		goto out_driver;
+	if (!request_region(pdev->iobase, pdev->iolen, "applesmc")) {
+		ret = -ENXIO;
+		goto out;
 	}
 
 	/* create register cache */
-	ret = applesmc_init_smcreg();
+
+	ret = applesmc_init_smcreg(pdev);
 	if (ret)
-		goto out_device;
+		goto out_region;
 
-	ret = applesmc_create_nodes(info_group, 1);
+	ret = applesmc_create_nodes(pdev, info_group, 1);
 	if (ret)
 		goto out_smcreg;
 
-	ret = applesmc_create_nodes(fan_group, smcreg.fan_count);
+	ret = applesmc_create_nodes(pdev, fan_group, pdev->smcreg.fan_count);
 	if (ret)
 		goto out_info;
 
-	ret = applesmc_create_nodes(temp_group, smcreg.temp_count);
+	ret = applesmc_create_nodes(pdev, temp_group, pdev->smcreg.temp_count);
 	if (ret)
 		goto out_fans;
 
-	ret = applesmc_create_accelerometer();
+	ret = applesmc_create_accelerometer(pdev);
 	if (ret)
 		goto out_temperature;
 
-	ret = applesmc_create_light_sensor();
+	ret = applesmc_create_light_sensor(pdev);
 	if (ret)
 		goto out_accelerometer;
 
-	ret = applesmc_create_key_backlight();
+	ret = applesmc_create_key_backlight(pdev);
 	if (ret)
 		goto out_light_sysfs;
 
-	hwmon_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(hwmon_dev)) {
-		ret = PTR_ERR(hwmon_dev);
+	pdev->hwmon_dev = hwmon_device_register(&dev->dev);
+	if (IS_ERR(pdev->hwmon_dev)) {
+		ret = PTR_ERR(pdev->hwmon_dev);
 		goto out_light_ledclass;
 	}
 
+	INIT_WORK(&pdev->backlight_work, &applesmc_backlight_set);
+
+	applesmc_device_init(pdev);
+
 	return 0;
 
 out_light_ledclass:
-	applesmc_release_key_backlight();
+	applesmc_release_key_backlight(pdev);
 out_light_sysfs:
-	applesmc_release_light_sensor();
+	applesmc_release_light_sensor(pdev);
 out_accelerometer:
-	applesmc_release_accelerometer();
+	applesmc_release_accelerometer(pdev);
 out_temperature:
-	applesmc_destroy_nodes(temp_group);
+	applesmc_destroy_nodes(pdev, temp_group);
 out_fans:
-	applesmc_destroy_nodes(fan_group);
+	applesmc_destroy_nodes(pdev, fan_group);
 out_info:
-	applesmc_destroy_nodes(info_group);
+	applesmc_destroy_nodes(pdev, info_group);
 out_smcreg:
-	applesmc_destroy_smcreg();
-out_device:
-	platform_device_unregister(pdev);
-out_driver:
-	platform_driver_unregister(&applesmc_driver);
+	applesmc_destroy_smcreg(pdev);
 out_region:
-	release_region(APPLESMC_DATA_PORT, APPLESMC_NR_PORTS);
+	release_region(pdev->iobase, pdev->iolen);
 out:
+	kfree(pdev);
 	pr_warn("driver init failed (ret=%d)!\n", ret);
 	return ret;
 }
 
+static void __devexit applesmc_pnp_remove(struct pnp_dev *dev)
+{
+	struct applesmc_dev *pdev = pnp_get_drvdata(dev);
+
+	hwmon_device_unregister(pdev->hwmon_dev);
+	applesmc_release_key_backlight(pdev);
+	applesmc_release_light_sensor(pdev);
+	applesmc_release_accelerometer(pdev);
+	applesmc_destroy_nodes(pdev, temp_group);
+	applesmc_destroy_nodes(pdev, fan_group);
+	applesmc_destroy_nodes(pdev, info_group);
+	applesmc_destroy_smcreg(pdev);
+	release_region(pdev->iobase, pdev->iolen);
+	kfree(pdev);
+}
+
+static const struct pnp_device_id applesmc_dev_table[] = {
+	{"APP0001", 0},
+	{"", 0},
+};
+
+MODULE_DEVICE_TABLE(pnp, applesmc_dev_table);
+
+static struct pnp_driver applesmc_pnp_driver = {
+	.name = "Apple SMC",
+	.probe = applesmc_pnp_probe,
+	.remove = applesmc_pnp_remove,
+	.id_table = applesmc_dev_table,
+	.driver = {
+		.pm = &applesmc_pm_ops,
+	},
+};
+
+static int __init applesmc_init(void)
+{
+	return pnp_register_driver(&applesmc_pnp_driver);
+}
+
 static void __exit applesmc_exit(void)
 {
-	hwmon_device_unregister(hwmon_dev);
-	applesmc_release_key_backlight();
-	applesmc_release_light_sensor();
-	applesmc_release_accelerometer();
-	applesmc_destroy_nodes(temp_group);
-	applesmc_destroy_nodes(fan_group);
-	applesmc_destroy_nodes(info_group);
-	applesmc_destroy_smcreg();
-	platform_device_unregister(pdev);
-	platform_driver_unregister(&applesmc_driver);
-	release_region(APPLESMC_DATA_PORT, APPLESMC_NR_PORTS);
+	pnp_unregister_driver(&applesmc_pnp_driver);
 }
 
 module_init(applesmc_init);
@@ -1329,4 +1404,3 @@ module_exit(applesmc_exit);
 MODULE_AUTHOR("Nicolas Boichat");
 MODULE_DESCRIPTION("Apple SMC");
 MODULE_LICENSE("GPL v2");
-MODULE_DEVICE_TABLE(dmi, applesmc_whitelist);
-- 
1.7.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
