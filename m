From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Dec 2009 15:41:14 +0000
Subject: [lm-sensors] [PATCH 08/11] hwmon: (adt7475) Voltage attenuators can
Message-Id: <20091202164114.2ea11729@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It is possible to bypass the voltage attenuators on the +2.5V, Vccp,
+5V and +12V voltage monitoring inputs. This is useful to connect
other voltage channels than the ones the monitoring chip was
originally designed for. When this feature is enabled, we must not
include the scaling factors in our computations.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jordan Crouse <jordan@cosmicpenguin.net>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>
---
 drivers/hwmon/adt7475.c |   42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

--- linux-2.6.32-rc8.orig/drivers/hwmon/adt7475.c	2009-12-02 14:31:16.000000000 +0100
+++ linux-2.6.32-rc8/drivers/hwmon/adt7475.c	2009-12-02 14:31:20.000000000 +0100
@@ -80,6 +80,8 @@
 
 #define REG_TEMP_OFFSET_BASE	0x70
 
+#define REG_CONFIG2		0x73
+
 #define REG_EXTEND1		0x76
 #define REG_EXTEND2		0x77
 
@@ -92,11 +94,15 @@
 #define REG_VTT_MIN		0x84	/* ADT7490 only */
 #define REG_VTT_MAX		0x86	/* ADT7490 only */
 
+#define CONFIG2_ATTN		0x20
+
 #define CONFIG3_SMBALERT	0x01
 #define CONFIG3_THERM		0x02
 
 #define CONFIG4_PINFUNC		0x03
 #define CONFIG4_MAXDUTY		0x08
+#define CONFIG4_ATTN_IN10	0x30
+#define CONFIG4_ATTN_IN43	0xC0
 
 #define CONFIG5_TWOSCOMP	0x01
 #define CONFIG5_TEMPOFFSET	0x02
@@ -157,6 +163,7 @@ struct adt7475_data {
 	u8 config4;
 	u8 config5;
 	u8 has_voltage;
+	u8 bypass_attn;		/* Bypass voltage attenuator */
 	u8 has_pwm2:1;
 	u8 has_fan4:1;
 	u32 alarms;
@@ -233,19 +240,24 @@ static const int adt7473_in_scaling[ADT7
 	{ 45, 45 },	/* Vtt */
 };
 
-static inline int reg2volt(int channel, u16 reg)
+static inline int reg2volt(int channel, u16 reg, u8 bypass_attn)
 {
 	const int *r = adt7473_in_scaling[channel];
 
+	if (bypass_attn & (1 << channel))
+		return DIV_ROUND_CLOSEST(reg * 2250, 1024);
 	return DIV_ROUND_CLOSEST(reg * (r[0] + r[1]) * 2250, r[1] * 1024);
 }
 
-static inline u16 volt2reg(int channel, long volt)
+static inline u16 volt2reg(int channel, long volt, u8 bypass_attn)
 {
 	const int *r = adt7473_in_scaling[channel];
 	long reg;
 
-	reg = (volt * r[1] * 1024) / ((r[0] + r[1]) * 2250);
+	if (bypass_attn & (1 << channel))
+		reg = (volt * 1024) / 2250;
+	else
+		reg = (volt * r[1] * 1024) / ((r[0] + r[1]) * 2250);
 	return SENSORS_LIMIT(reg, 0, 1023) & (0xff << 2);
 }
 
@@ -305,7 +317,8 @@ static ssize_t show_voltage(struct devic
 			       (data->alarms >> sattr->index) & 1);
 	default:
 		val = data->voltage[sattr->nr][sattr->index];
-		return sprintf(buf, "%d\n", reg2volt(sattr->index, val));
+		return sprintf(buf, "%d\n",
+			       reg2volt(sattr->index, val, data->bypass_attn));
 	}
 }
 
@@ -324,7 +337,8 @@ static ssize_t set_voltage(struct device
 
 	mutex_lock(&data->lock);
 
-	data->voltage[sattr->nr][sattr->index] = volt2reg(sattr->index, val);
+	data->voltage[sattr->nr][sattr->index] +				volt2reg(sattr->index, val, data->bypass_attn);
 
 	if (sattr->index < ADT7475_VOLTAGE_COUNT) {
 		if (sattr->nr = MIN)
@@ -1159,7 +1173,7 @@ static int adt7475_probe(struct i2c_clie
 
 	struct adt7475_data *data;
 	int i, ret = 0, revision;
-	u8 config3;
+	u8 config2, config3;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (data = NULL)
@@ -1205,6 +1219,16 @@ static int adt7475_probe(struct i2c_clie
 			data->has_voltage |= (1 << 0);		/* in0 */
 	}
 
+	/* Voltage attenuators can be bypassed, globally or individually */
+	config2 = adt7475_read(REG_CONFIG2);
+	if (config2 & CONFIG2_ATTN) {
+		data->bypass_attn = (0x3 << 3) | 0x3;
+	} else {
+		data->bypass_attn = ((data->config4 & CONFIG4_ATTN_IN10) >> 4) |
+				    ((data->config4 & CONFIG4_ATTN_IN43) >> 3);
+	}
+	data->bypass_attn &= data->has_voltage;
+
 	/* Call adt7475_read_pwm for all pwm's as this will reprogram any
 	   pwm's which are disabled to manual mode with 0% duty cycle */
 	for (i = 0; i < ADT7475_PWM_COUNT; i++)
@@ -1251,6 +1275,12 @@ static int adt7475_probe(struct i2c_clie
 			 (data->has_voltage & (1 << 0)) ? " in0" : "",
 			 data->has_fan4 ? " fan4" : "",
 			 data->has_pwm2 ? " pwm2" : "");
+	if (data->bypass_attn)
+		dev_info(&client->dev, "Bypassing attenuators on:%s%s%s%s\n",
+			 (data->bypass_attn & (1 << 0)) ? " in0" : "",
+			 (data->bypass_attn & (1 << 1)) ? " in1" : "",
+			 (data->bypass_attn & (1 << 3)) ? " in3" : "",
+			 (data->bypass_attn & (1 << 4)) ? " in4" : "");
 
 	return 0;
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
