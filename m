From: Marc Titinger <mtitinger@baylibre.com>
Date: Tue, 20 Oct 2015 08:20:44 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: ina2xx: allow for actual measurement bandwidth above 160 Hz
Message-Id: <1445329244-21627-1-git-send-email-mtitinger@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <56259997.6080706@roeck-us.net>
In-Reply-To: <56259997.6080706@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, jdelvare@suse.com
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, mturquette@baylibre.com, Marc Titinger <mtitinger@baylibre.com>

With the current implementation, the driver will prevent a readout at a
pace faster than the default conversion time (2ms) times the averaging
setting, min AVG being 1:1.

Any sysfs "show" read access from the client app faster than 500 Hz will be
'cached' by the driver, but actually since do_update reads all 8 registers,
the best achievable measurement rate is roughly 8*800 us (for the time
spent in i2c-core) i.e. <= 156Hz with Beagle Bone Black.

This change set uses a register mask to allow for the readout of a single
i2c register at a time. Furthermore, performing subsequent reads on the
same register will make use of the ability of the i2c chip to retain the
last reg offset, hence use a shorter i2c message (roughly 400us instead of
800us spent in i2c-core.c).

The best readout rate for a single measurement is now around 2kHz. And for
four measurements around (1/(4*800us) = 312 Hz. Since for any readout rate
faster than 160 Hz the interval is set by the i2c transactions completion,
the 'last-update' anti-flooding code will not have a limiting effect in
practice. Hence I also remove the elapsed time checking in the hwmon driver
for ina2xx.

To summarize, the patch provides a max bandwidth improvement with hwmon
client apps from ~160 Hz to ~320 Hz, and better in single-channel
polling mode.

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---

	v2: remove local macro for BIT_MASK, use the bitops.h one.

 drivers/hwmon/ina2xx.c | 88 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 4d28150..2f82a9b 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -105,9 +105,14 @@ struct ina2xx_data {
 
 	struct mutex update_lock;
 	bool valid;
-	unsigned long last_updated;
 	int update_interval; /* in jiffies */
 
+	/* Last read register (slave address already set
+	 * reading out from this same register repeatedly will
+	 * be significantly faster!
+	 */
+	int last_reg;
+
 	int kind;
 	const struct attribute_group *groups[INA2XX_MAX_ATTRIBUTE_GROUPS];
 	u16 regs[INA2XX_MAX_REGISTERS];
@@ -203,21 +208,63 @@ static int ina2xx_init(struct ina2xx_data *data)
 	return ina2xx_calibrate(data);
 }
 
-static int ina2xx_do_update(struct device *dev)
+/*
+ * Most I2c chips will allow reading from the current register pointer
+ * w/o setting the register offset again.
+ */
+static inline s32 __i2c_read_same_word(const struct i2c_client *client)
+{
+	unsigned char msgbuf[2];
+
+	struct i2c_msg msg = {
+		.addr = client->addr,
+		.flags = client->flags | I2C_M_RD,
+		.len = 2,
+		.buf = msgbuf,
+		};
+
+	int status = i2c_transfer(client->adapter, &msg, 1);
+
+	return (status < 0) ? status : (msgbuf[1]|(msgbuf[0]<<8));
+}
+
+static int ina2xx_do_update(struct device *dev, int reg_mask)
 {
 	struct ina2xx_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
-	int i, rv, retry;
+	int i = 0, rv, retry;
 
 	dev_dbg(&client->dev, "Starting ina2xx update\n");
 
 	for (retry = 5; retry; retry--) {
-		/* Read all registers */
-		for (i = 0; i < data->config->registers; i++) {
-			rv = i2c_smbus_read_word_swapped(client, i);
+
+		/* Try to issue a shorter i2c message */
+		if (reg_mask & (1 << data->last_reg)) {
+			rv = __i2c_read_same_word(client);
 			if (rv < 0)
 				return rv;
-			data->regs[i] = rv;
+
+			reg_mask &= ~(1 << data->last_reg);
+			data->regs[data->last_reg] = rv;
+
+			dev_dbg(&client->dev, "%d, rv = %x, (last_reg)\n",
+						data->last_reg,
+						data->regs[data->last_reg]);
+		}
+
+		/* Check for remaining registers in mask. */
+		while (reg_mask && i < data->config->registers) {
+			if (reg_mask & (1L << i)) {
+				rv = i2c_smbus_read_word_swapped(client, i);
+				if (rv < 0)
+					return rv;
+				data->regs[i] = rv;
+				data->last_reg = i;
+
+				dev_dbg(&client->dev, "%d, rv = %x\n", i,
+							data->regs[i]);
+			}
+			i++;
 		}
 
 		/*
@@ -240,8 +287,6 @@ static int ina2xx_do_update(struct device *dev)
 			msleep(INA2XX_MAX_DELAY);
 			continue;
 		}
-
-		data->last_updated = jiffies;
 		data->valid = 1;
 
 		return 0;
@@ -256,22 +301,24 @@ static int ina2xx_do_update(struct device *dev)
 	return -ENODEV;
 }
 
-static struct ina2xx_data *ina2xx_update_device(struct device *dev)
+static struct ina2xx_data *ina2xx_update_device(struct device *dev,
+						int reg_mask)
 {
 	struct ina2xx_data *data = dev_get_drvdata(dev);
 	struct ina2xx_data *ret = data;
-	unsigned long after;
 	int rv;
 
 	mutex_lock(&data->update_lock);
 
-	after = data->last_updated + data->update_interval;
-	if (time_after(jiffies, after) || !data->valid) {
-		rv = ina2xx_do_update(dev);
-		if (rv < 0)
-			ret = ERR_PTR(rv);
+	if (!data->valid) {
+		reg_mask = 0xff; /* do all regs */
+		data->last_reg = 0xff;
 	}
 
+	rv = ina2xx_do_update(dev, reg_mask);
+	if (rv < 0)
+		ret = ERR_PTR(rv);
+
 	mutex_unlock(&data->update_lock);
 	return ret;
 }
@@ -316,7 +363,8 @@ static ssize_t ina2xx_show_value(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct ina2xx_data *data = ina2xx_update_device(dev);
+	struct ina2xx_data *data = ina2xx_update_device(dev,
+						BIT_MASK(attr->index));
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -329,7 +377,8 @@ static ssize_t ina2xx_set_shunt(struct device *dev,
 				struct device_attribute *da,
 				const char *buf, size_t count)
 {
-	struct ina2xx_data *data = ina2xx_update_device(dev);
+	struct ina2xx_data *data = ina2xx_update_device(dev,
+					BIT_MASK(INA2XX_CONFIG));
 	unsigned long val;
 	int status;
 
@@ -390,7 +439,8 @@ static ssize_t ina226_set_interval(struct device *dev,
 static ssize_t ina226_show_interval(struct device *dev,
 				    struct device_attribute *da, char *buf)
 {
-	struct ina2xx_data *data = ina2xx_update_device(dev);
+	struct ina2xx_data *data = ina2xx_update_device(dev,
+						BIT_MASK(INA2XX_CONFIG));
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
