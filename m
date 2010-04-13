From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Tue, 13 Apr 2010 22:55:22 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (ltc4245) Read GPIO registers
Message-Id: <1271199323-3345-2-git-send-email-iws@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The GPIO registers on the ltc4245 behave in a strage way. Every time the
ADC updates the values for one GPIO, it updates all three GPIO registers to
the same value.

To read all three GPIO registers correctly, we cache copies of each
register and update the GPIO MUX to read the next GPIO register. Each GPIO
sample will take 3 * HZ to read, but at least we are returning the correct
values to userspace.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/hwmon/ltc4245.c |   60 ++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
index 65c232a..1efa554 100644
--- a/drivers/hwmon/ltc4245.c
+++ b/drivers/hwmon/ltc4245.c
@@ -68,6 +68,7 @@ static struct ltc4245_data *ltc4245_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct ltc4245_data *data = i2c_get_clientdata(client);
+	u8 gpio, nextgpio, addr, ctl;
 	s32 val;
 	int i;
 
@@ -86,15 +87,68 @@ static struct ltc4245_data *ltc4245_update_device(struct device *dev)
 				data->cregs[i] = val;
 		}
 
-		/* Read voltage registers -- 0x10 to 0x1f */
-		for (i = 0; i < ARRAY_SIZE(data->vregs); i++) {
-			val = i2c_smbus_read_byte_data(client, i+0x10);
+		/* Read non-GPIO voltage registers -- 0x10 to 0x1b */
+		for (i = 0; i < ARRAY_SIZE(data->vregs) - 3; i++) {
+			val = i2c_smbus_read_byte_data(client, i + 0x10);
 			if (unlikely(val < 0))
 				data->vregs[i] = 0;
 			else
 				data->vregs[i] = val;
 		}
 
+		/*
+		 * On the LTC4245, the GPIO registers act stupidly. Changing
+		 * the MUX to read from any GPIO puts the value into all three
+		 * GPIO registers. To avoid this, we cache a copy of the
+		 * current GPIO state, and advance the MUX to the next state.
+		 *
+		 * This will mean that readings can be up to 3 cycles old,
+		 * which shouldn't be a problem. The hwmon interface is not
+		 * expected to be fast.
+		 */
+		gpio = data->cregs[LTC4245_GPIO] & 0xC0;
+		switch (gpio) {
+		default:
+			/*
+			 * this is just to keep the compiler happy, we
+			 * handle every possible state of the top two
+			 * bits in this register
+			 */
+		case 0x00:
+		case 0x40:
+			addr = LTC4245_GPIOADC1;
+			nextgpio = (data->cregs[LTC4245_GPIO] & 0x3f) | 0x80;
+			break;
+		case 0x80:
+			addr = LTC4245_GPIOADC2;
+			nextgpio = (data->cregs[LTC4245_GPIO] & 0x3f) | 0xc0;
+			break;
+		case 0xc0:
+			addr = LTC4245_GPIOADC3;
+			nextgpio = (data->cregs[LTC4245_GPIO] & 0x3f) | 0x40;
+			break;
+		}
+
+		/* Read the current GPIO state, cache the value */
+		val = i2c_smbus_read_byte_data(client, addr);
+		if (unlikely(val < 0))
+			data->vregs[addr - 0x10] = 0;
+		else
+			data->vregs[addr - 0x10] = val;
+
+		/*
+		 * Set the GPIO MUX register to read the next GPIO
+		 *
+		 * According to the datasheet, the ADC must be stopped before
+		 * writing to the control register, so we disable it, and then
+		 * put it back to its earlier state
+		 */
+		ctl = data->cregs[LTC4245_CONTROL];
+		i2c_smbus_write_byte_data(client, LTC4245_CONTROL, ctl | 0x80);
+		i2c_smbus_write_byte_data(client, LTC4245_GPIO, nextgpio);
+		i2c_smbus_write_byte_data(client, LTC4245_CONTROL, ctl);
+		data->cregs[LTC4245_GPIO] = nextgpio;
+
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
