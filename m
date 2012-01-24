From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:49 +0000
Subject: [lm-sensors] [PATCH 70/79] hwmon: (pc87427) Fix multi-line comments
Message-Id: <1327373398-997-71-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pc87427.c |   72 +++++++++++++++++++++++++++++-----------------
 1 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
index cb35461..37059a3 100644
--- a/drivers/hwmon/pc87427.c
+++ b/drivers/hwmon/pc87427.c
@@ -46,9 +46,11 @@ static struct platform_device *pdev;
 
 #define DRVNAME "pc87427"
 
-/* The lock mutex protects both the I/O accesses (needed because the
-   device is using banked registers) and the register cache (needed to keep
-   the data in the registers and the cache in sync at any time). */
+/*
+ * The lock mutex protects both the I/O accesses (needed because the
+ * device is using banked registers) and the register cache (needed to keep
+ * the data in the registers and the cache in sync at any time).
+ */
 struct pc87427_data {
 	struct device *hwmon_dev;
 	struct mutex lock;
@@ -173,10 +175,12 @@ static inline void pc87427_write8_bank(struct pc87427_data *data, u8 ldi,
 #define FAN_STATUS_LOSPD		(1 << 1)
 #define FAN_STATUS_MONEN		(1 << 0)
 
-/* Dedicated function to read all registers related to a given fan input.
-   This saves us quite a few locks and bank selections.
-   Must be called with data->lock held.
-   nr is from 0 to 7 */
+/*
+ * Dedicated function to read all registers related to a given fan input.
+ * This saves us quite a few locks and bank selections.
+ * Must be called with data->lock held.
+ * nr is from 0 to 7
+ */
 static void pc87427_readall_fan(struct pc87427_data *data, u8 nr)
 {
 	int iobase = data->address[LD_FAN];
@@ -189,8 +193,10 @@ static void pc87427_readall_fan(struct pc87427_data *data, u8 nr)
 	outb(data->fan_status[nr], iobase + PC87427_REG_FAN_STATUS);
 }
 
-/* The 2 LSB of fan speed registers are used for something different.
-   The actual 2 LSB of the measurements are not available. */
+/*
+ * The 2 LSB of fan speed registers are used for something different.
+ * The actual 2 LSB of the measurements are not available.
+ */
 static inline unsigned long fan_from_reg(u16 reg)
 {
 	reg &= 0xfffc;
@@ -224,10 +230,12 @@ static inline u16 fan_to_reg(unsigned long val)
 #define PWM_MODE_OFF			(2 << 4)
 #define PWM_MODE_ON			(7 << 4)
 
-/* Dedicated function to read all registers related to a given PWM output.
-   This saves us quite a few locks and bank selections.
-   Must be called with data->lock held.
-   nr is from 0 to 3 */
+/*
+ * Dedicated function to read all registers related to a given PWM output.
+ * This saves us quite a few locks and bank selections.
+ * Must be called with data->lock held.
+ * nr is from 0 to 3
+ */
 static void pc87427_readall_pwm(struct pc87427_data *data, u8 nr)
 {
 	int iobase = data->address[LD_FAN];
@@ -286,10 +294,12 @@ static inline u8 pwm_enable_to_reg(unsigned long val, u8 pwmval)
 #define TEMP_TYPE_REMOTE_DIODE		(2 << 5)
 #define TEMP_TYPE_LOCAL_DIODE		(3 << 5)
 
-/* Dedicated function to read all registers related to a given temperature
-   input. This saves us quite a few locks and bank selections.
-   Must be called with data->lock held.
-   nr is from 0 to 5 */
+/*
+ * Dedicated function to read all registers related to a given temperature
+ * input. This saves us quite a few locks and bank selections.
+ * Must be called with data->lock held.
+ * nr is from 0 to 5
+ */
 static void pc87427_readall_temp(struct pc87427_data *data, u8 nr)
 {
 	int iobase = data->address[LD_TEMP];
@@ -318,8 +328,10 @@ static inline unsigned int temp_type_from_reg(u8 reg)
 	}
 }
 
-/* We assume 8-bit thermal sensors; 9-bit thermal sensors are possible
-   too, but I have no idea how to figure out when they are used. */
+/*
+ * We assume 8-bit thermal sensors; 9-bit thermal sensors are possible
+ * too, but I have no idea how to figure out when they are used.
+ */
 static inline long temp_from_reg(s16 reg)
 {
 	return reg * 1000 / 256;
@@ -423,9 +435,11 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute
 
 	mutex_lock(&data->lock);
 	outb(BANK_FM(nr), iobase + PC87427_REG_BANK);
-	/* The low speed limit registers are read-only while monitoring
-	   is enabled, so we have to disable monitoring, then change the
-	   limit, and finally enable monitoring again. */
+	/*
+	 * The low speed limit registers are read-only while monitoring
+	 * is enabled, so we have to disable monitoring, then change the
+	 * limit, and finally enable monitoring again.
+	 */
 	outb(0, iobase + PC87427_REG_FAN_STATUS);
 	data->fan_min[nr] = fan_to_reg(val);
 	outw(data->fan_min[nr], iobase + PC87427_REG_FAN_MIN);
@@ -542,8 +556,10 @@ static const struct attribute_group pc87427_group_fan[8] = {
 	{ .attrs = pc87427_attributes_fan[7] },
 };
 
-/* Must be called with data->lock held and pc87427_readall_pwm() freshly
-   called */
+/*
+ * Must be called with data->lock held and pc87427_readall_pwm() freshly
+ * called
+ */
 static void update_pwm_enable(struct pc87427_data *data, int nr, u8 mode)
 {
 	int iobase = data->address[LD_FAN];
@@ -1023,9 +1039,11 @@ static void __devinit pc87427_init_device(struct device *dev)
 		if (reg & PWM_ENABLE_CTLEN)
 			data->pwm_enabled |= (1 << i);
 
-		/* We don't expose an interface to reconfigure the automatic
-		   fan control mode, so only allow to return to this mode if
-		   it was originally set. */
+		/*
+		 * We don't expose an interface to reconfigure the automatic
+		 * fan control mode, so only allow to return to this mode if
+		 * it was originally set.
+		 */
 		if ((reg & PWM_ENABLE_MODE_MASK) = PWM_MODE_AUTO) {
 			dev_dbg(dev, "PWM%d is in automatic control mode\n",
 				i + 1);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
