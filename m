From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 25 Nov 2008 21:20:10 +0000
Subject: [lm-sensors] [PATCH 1/3] adt7470: Fix pwm at a certain level during
Message-Id: <20081125212010.22512.14851.stgit@elm3a70.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081125212005.22512.14523.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081125212005.22512.14523.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>, Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

In the small window that it takes to read the temperature sensors,
the pwm outputs momentarily drop to 0.  This causes a noticeable
hiccup in fan speed, which is slightly annoying.  The solution is
to manually program the pwm output with whatever the automatic value
is and then shift the fans to manual control while reading temperatures.
Once that is done, put the fans back to whatever mode of control was
there before.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---
 drivers/hwmon/adt7470.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index da6c930..b7a442a 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -74,6 +74,7 @@ I2C_CLIENT_INSMOD_1(adt7470);
 #define ADT7470_REG_PWM12_CFG			0x68
 #define		ADT7470_PWM2_AUTO_MASK		0x40
 #define		ADT7470_PWM1_AUTO_MASK		0x80
+#define		ADT7470_PWM_AUTO_MASK		0xC0
 #define ADT7470_REG_PWM34_CFG			0x69
 #define		ADT7470_PWM3_AUTO_MASK		0x40
 #define		ADT7470_PWM4_AUTO_MASK		0x80
@@ -223,7 +224,7 @@ static struct adt7470_data *adt7470_update_device(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7470_data *data = i2c_get_clientdata(client);
 	unsigned long local_jiffies = jiffies;
-	u8 cfg;
+	u8 cfg, pwm[4], pwm_cfg[2];
 	int i;
 
 	mutex_lock(&data->lock);
@@ -232,6 +233,24 @@ static struct adt7470_data *adt7470_update_device(struct device *dev)
 		&& data->sensors_valid)
 		goto no_sensor_update;
 
+	/* save pwm[1-4] config register */
+	pwm_cfg[0] = i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_CFG(0));
+	pwm_cfg[1] = i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_CFG(2));
+
+	/* set manual pwm to whatever it is set to now */
+	for (i = 0; i < ADT7470_FAN_COUNT; i++)
+		pwm[i] = i2c_smbus_read_byte_data(client, ADT7470_REG_PWM(i));
+
+	/* put pwm in manual mode */
+	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(0),
+		pwm_cfg[0] & ~(ADT7470_PWM_AUTO_MASK));
+	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(2),
+		pwm_cfg[1] & ~(ADT7470_PWM_AUTO_MASK));
+
+	/* write pwm control to whatever it was */
+	for (i = 0; i < ADT7470_FAN_COUNT; i++)
+		i2c_smbus_write_byte_data(client, ADT7470_REG_PWM(i), pwm[i]);
+
 	/* start reading temperature sensors */
 	cfg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
 	cfg |= 0x80;
@@ -249,6 +268,10 @@ static struct adt7470_data *adt7470_update_device(struct device *dev)
 	cfg &= ~0x80;
 	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
 
+	/* restore pwm[1-4] config registers */
+	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(0), pwm_cfg[0]);
+	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(2), pwm_cfg[1]);
+
 	for (i = 0; i < ADT7470_TEMP_COUNT; i++)
 		data->temp[i] = i2c_smbus_read_byte_data(client,
 						ADT7470_TEMP_REG(i));


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
