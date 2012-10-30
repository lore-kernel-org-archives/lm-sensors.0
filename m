From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 30 Oct 2012 19:13:19 +0000
Subject: [lm-sensors] [PATCH v2 3/3] hwmon: (it87) Report thermal sensor type as Intel PECI if appropriate
Message-Id: <1351624399-22595-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

IT8721 and IT8728 support Intel PECI temperature reporting. Each sensor
can be programmed to display the temperature reported on the PECI interface.

If configured for Intel PECI, the driver reported the wrong sensor type for
the respective thermal sensor. Fix the code to correctly report it as
"Intel PECI (6)".

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I noticed that IT8718 and IT8720 also support PECI, but differently. Does it
make sense to add those ? That would be a separate patch, though.

v2: "diode connected"  -> diode-connected"
    Reported type was not necessarily 0 if PECI was selected. Fix description.
    FEAT_PECI -> FEAT_TEMP_PECI
    has_peci -> has_temp_peci
    Introduce flag "peci_mask" to indicate which attributes can be
    used to report the PECI temperature
    Reorder code in set_temp_type to check for peci only after checking for
    other types.

 Documentation/hwmon/it87 |    3 ++-
 drivers/hwmon/it87.c     |   20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
index e1f3828..8386aad 100644
--- a/Documentation/hwmon/it87
+++ b/Documentation/hwmon/it87
@@ -217,4 +217,5 @@ Temperature offset attributes
 The driver supports temp[1-3]_offset sysfs attributes to adjust the reported
 temperature for thermal diodes or diode-connected thermal transistors.
 If a temperature sensor is configured for thermistors, the attribute values
-are ignored.
+are ignored. If the thermal sensor type is Intel PECI, the temperature offset
+must be programmed to the critical CPU temperature.
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index c154d43..9023c3b 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -231,6 +231,7 @@ static const u8 IT87_REG_TEMP_OFFSET[]	= { 0x56, 0x57, 0x59 };
 struct it87_devices {
 	const char *name;
 	u16 features;
+	u16 peci_mask;
 };
 
 #define FEAT_12MV_ADC		(1 << 0)
@@ -238,6 +239,7 @@ struct it87_devices {
 #define FEAT_OLD_AUTOPWM	(1 << 2)
 #define FEAT_16BIT_FANS		(1 << 3)
 #define FEAT_TEMP_OFFSET	(1 << 4)
+#define FEAT_TEMP_PECI		(1 << 5)
 
 static const struct it87_devices it87_devices[] = {
 	[it87] = {
@@ -263,12 +265,14 @@ static const struct it87_devices it87_devices[] = {
 	[it8721] = {
 		.name = "it8721",
 		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
-		  | FEAT_TEMP_OFFSET,
+		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
+		.peci_mask = 0x05,
 	},
 	[it8728] = {
 		.name = "it8728",
 		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
-		  | FEAT_TEMP_OFFSET,
+		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
+		.peci_mask = 0x07,
 	},
 	[it8782] = {
 		.name = "it8782",
@@ -285,6 +289,8 @@ static const struct it87_devices it87_devices[] = {
 #define has_newer_autopwm(data)	((data)->features & FEAT_NEWER_AUTOPWM)
 #define has_old_autopwm(data)	((data)->features & FEAT_OLD_AUTOPWM)
 #define has_temp_offset(data)	((data)->features & FEAT_TEMP_OFFSET)
+#define has_temp_peci(data, nr)	(((data)->features & FEAT_TEMP_PECI) && \
+				 ((data)->peci_mask & (1 << nr)))
 
 struct it87_sio_data {
 	enum chips type;
@@ -309,6 +315,7 @@ struct it87_data {
 	struct device *hwmon_dev;
 	enum chips type;
 	u16 features;
+	u16 peci_mask;
 
 	unsigned short addr;
 	const char *name;
@@ -617,6 +624,8 @@ static ssize_t show_temp_type(struct device *dev, struct device_attribute *attr,
 	struct it87_data *data = it87_update_device(dev);
 	u8 reg = data->sensor;	    /* In case value is updated while used */
 
+	if (has_temp_peci(data, nr) && (reg >> 6 = nr + 1))
+		return sprintf(buf, "6\n");  /* Intel PECI */
 	if (reg & (1 << nr))
 		return sprintf(buf, "3\n");  /* thermal diode */
 	if (reg & (8 << nr))
@@ -640,16 +649,20 @@ static ssize_t set_temp_type(struct device *dev, struct device_attribute *attr,
 	reg = it87_read_value(data, IT87_REG_TEMP_ENABLE);
 	reg &= ~(1 << nr);
 	reg &= ~(8 << nr);
+	if (has_temp_peci(data, nr) && (reg >> 6 = nr + 1 || val = 6))
+		reg &= 0x3f;
 	if (val = 2) {	/* backwards compatibility */
 		dev_warn(dev,
 			 "Sensor type 2 is deprecated, please use 4 instead\n");
 		val = 4;
 	}
-	/* 3 = thermal diode; 4 = thermistor; 0 = disabled */
+	/* 3 = thermal diode; 4 = thermistor; 6 = Intel PECI; 0 = disabled */
 	if (val = 3)
 		reg |= 1 << nr;
 	else if (val = 4)
 		reg |= 8 << nr;
+	else if (has_temp_peci(data, nr) && val = 6)
+		reg |= (nr + 1) << 6;
 	else if (val != 0)
 		return -EINVAL;
 
@@ -1966,6 +1979,7 @@ static int __devinit it87_probe(struct platform_device *pdev)
 	data->addr = res->start;
 	data->type = sio_data->type;
 	data->features = it87_devices[sio_data->type].features;
+	data->peci_mask = it87_devices[sio_data->type].peci_mask;
 	data->name = it87_devices[sio_data->type].name;
 	/*
 	 * IT8705F Datasheet 0.4.1, 3h = Version G.
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
