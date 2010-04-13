From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Tue, 13 Apr 2010 22:55:23 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (ltc4245) read only one GPIO pin
Message-Id: <1271199323-3345-3-git-send-email-iws@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Read only one of the GPIO pins as an analog voltage. The ADC can be
switched to a different GPIO pin at runtime, but this is not supported.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 Documentation/hwmon/ltc4245 |    4 +--
 drivers/hwmon/ltc4245.c     |   71 ++++---------------------------------------
 2 files changed, 7 insertions(+), 68 deletions(-)

diff --git a/Documentation/hwmon/ltc4245 b/Documentation/hwmon/ltc4245
index 02838a4..86b5880 100644
--- a/Documentation/hwmon/ltc4245
+++ b/Documentation/hwmon/ltc4245
@@ -72,9 +72,7 @@ in6_min_alarm		5v  output undervoltage alarm
 in7_min_alarm		3v  output undervoltage alarm
 in8_min_alarm		Vee (-12v) output undervoltage alarm
 
-in9_input		GPIO #1 voltage data
-in10_input		GPIO #2 voltage data
-in11_input		GPIO #3 voltage data
+in9_input		GPIO voltage data
 
 power1_input		12v power usage (mW)
 power2_input		5v  power usage (mW)
diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
index 1efa554..4926f3f 100644
--- a/drivers/hwmon/ltc4245.c
+++ b/drivers/hwmon/ltc4245.c
@@ -45,9 +45,7 @@ enum ltc4245_cmd {
 	LTC4245_VEEIN			= 0x19,
 	LTC4245_VEESENSE		= 0x1a,
 	LTC4245_VEEOUT			= 0x1b,
-	LTC4245_GPIOADC1		= 0x1c,
-	LTC4245_GPIOADC2		= 0x1d,
-	LTC4245_GPIOADC3		= 0x1e,
+	LTC4245_GPIOADC			= 0x1c,
 };
 
 struct ltc4245_data {
@@ -61,7 +59,7 @@ struct ltc4245_data {
 	u8 cregs[0x08];
 
 	/* Voltage registers */
-	u8 vregs[0x0f];
+	u8 vregs[0x0d];
 };
 
 static struct ltc4245_data *ltc4245_update_device(struct device *dev)
@@ -87,8 +85,8 @@ static struct ltc4245_data *ltc4245_update_device(struct device *dev)
 				data->cregs[i] = val;
 		}
 
-		/* Read non-GPIO voltage registers -- 0x10 to 0x1b */
-		for (i = 0; i < ARRAY_SIZE(data->vregs) - 3; i++) {
+		/* Read voltage registers -- 0x10 to 0x1c */
+		for (i = 0; i < ARRAY_SIZE(data->vregs); i++) {
 			val = i2c_smbus_read_byte_data(client, i + 0x10);
 			if (unlikely(val < 0))
 				data->vregs[i] = 0;
@@ -96,59 +94,6 @@ static struct ltc4245_data *ltc4245_update_device(struct device *dev)
 				data->vregs[i] = val;
 		}
 
-		/*
-		 * On the LTC4245, the GPIO registers act stupidly. Changing
-		 * the MUX to read from any GPIO puts the value into all three
-		 * GPIO registers. To avoid this, we cache a copy of the
-		 * current GPIO state, and advance the MUX to the next state.
-		 *
-		 * This will mean that readings can be up to 3 cycles old,
-		 * which shouldn't be a problem. The hwmon interface is not
-		 * expected to be fast.
-		 */
-		gpio = data->cregs[LTC4245_GPIO] & 0xC0;
-		switch (gpio) {
-		default:
-			/*
-			 * this is just to keep the compiler happy, we
-			 * handle every possible state of the top two
-			 * bits in this register
-			 */
-		case 0x00:
-		case 0x40:
-			addr = LTC4245_GPIOADC1;
-			nextgpio = (data->cregs[LTC4245_GPIO] & 0x3f) | 0x80;
-			break;
-		case 0x80:
-			addr = LTC4245_GPIOADC2;
-			nextgpio = (data->cregs[LTC4245_GPIO] & 0x3f) | 0xc0;
-			break;
-		case 0xc0:
-			addr = LTC4245_GPIOADC3;
-			nextgpio = (data->cregs[LTC4245_GPIO] & 0x3f) | 0x40;
-			break;
-		}
-
-		/* Read the current GPIO state, cache the value */
-		val = i2c_smbus_read_byte_data(client, addr);
-		if (unlikely(val < 0))
-			data->vregs[addr - 0x10] = 0;
-		else
-			data->vregs[addr - 0x10] = val;
-
-		/*
-		 * Set the GPIO MUX register to read the next GPIO
-		 *
-		 * According to the datasheet, the ADC must be stopped before
-		 * writing to the control register, so we disable it, and then
-		 * put it back to its earlier state
-		 */
-		ctl = data->cregs[LTC4245_CONTROL];
-		i2c_smbus_write_byte_data(client, LTC4245_CONTROL, ctl | 0x80);
-		i2c_smbus_write_byte_data(client, LTC4245_GPIO, nextgpio);
-		i2c_smbus_write_byte_data(client, LTC4245_CONTROL, ctl);
-		data->cregs[LTC4245_GPIO] = nextgpio;
-
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
@@ -182,9 +127,7 @@ static int ltc4245_get_voltage(struct device *dev, u8 reg)
 	case LTC4245_VEEOUT:
 		voltage = regval * -55;
 		break;
-	case LTC4245_GPIOADC1:
-	case LTC4245_GPIOADC2:
-	case LTC4245_GPIOADC3:
+	case LTC4245_GPIOADC:
 		voltage = regval * 10;
 		break;
 	default:
@@ -351,9 +294,7 @@ LTC4245_ALARM(in7_min_alarm,	(1 << 2),	LTC4245_FAULT2);
 LTC4245_ALARM(in8_min_alarm,	(1 << 3),	LTC4245_FAULT2);
 
 /* GPIO voltages */
-LTC4245_VOLTAGE(in9_input,			LTC4245_GPIOADC1);
-LTC4245_VOLTAGE(in10_input,			LTC4245_GPIOADC2);
-LTC4245_VOLTAGE(in11_input,			LTC4245_GPIOADC3);
+LTC4245_VOLTAGE(in9_input,			LTC4245_GPIOADC);
 
 /* Power Consumption (virtual) */
 LTC4245_POWER(power1_input,			LTC4245_12VSENSE);
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
