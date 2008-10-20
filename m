From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Mon, 20 Oct 2008 16:13:57 +0000
Subject: Re: [lm-sensors] Using hwmon in-kernel
Message-Id: <20081020161357.GA10652@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081008003041.GA20169@srcf.ucam.org>
In-Reply-To: <20081008003041.GA20169@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here's the patch I mentioned. Most of it is noise to update all the 
drivers, but the substantive portion is in the hunks modifying hwmon.c 
and hwmon.h. lm90.c has been updated to add the callbacks. This only 
scratches my own itch, so doesn't add voltage or fanspeed handling (or 
whatever) - adding those would be trivial if anyone needs them. Like I 
said, individual drivers can be updated piecemeal.

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index 4dbdb81..7878bea 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -176,7 +176,7 @@ MODULE_PARM_DESC(verbose, "How verbose should the driver be? (0-3):\n"
    The structure is dynamically allocated, at the same time when a new
    abituguru device is allocated. */
 struct abituguru_data {
-	struct device *hwmon_dev;	/* hwmon registered device */
+	struct hwmon_device *hwmon_dev;	/* hwmon registered device */
 	struct mutex update_lock;	/* protect access to data and uGuru */
 	unsigned long last_updated;	/* In jiffies */
 	unsigned short addr;		/* uguru base address */
diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index d9e7a49..c840cd7 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -128,7 +128,7 @@ struct abituguru3_motherboard_info {
    The structure is dynamically allocated, at the same time when a new
    abituguru3 device is allocated. */
 struct abituguru3_data {
-	struct device *hwmon_dev;	/* hwmon registered device */
+	struct hwmon_device *hwmon_dev;	/* hwmon registered device */
 	struct mutex update_lock;	/* protect access to data and uGuru */
 	unsigned short addr;		/* uguru base address */
 	char valid;			/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
index bfda8c8..286068d 100644
--- a/drivers/hwmon/ad7414.c
+++ b/drivers/hwmon/ad7414.c
@@ -38,7 +38,7 @@
 static u8 AD7414_REG_LIMIT[] = { AD7414_REG_T_HIGH, AD7414_REG_T_LOW };
 
 struct ad7414_data {
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct mutex		lock;	/* atomic read data updates */
 	char			valid;	/* !=0 if following fields are valid */
 	unsigned long		next_update;	/* In jiffies */
diff --git a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
index f97b5b3..3cd178a 100644
--- a/drivers/hwmon/ad7418.c
+++ b/drivers/hwmon/ad7418.c
@@ -43,7 +43,7 @@ static const u8 AD7418_REG_TEMP[] = { AD7418_REG_TEMP_IN,
 					AD7418_REG_TEMP_OS };
 
 struct ad7418_data {
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct attribute_group	attrs;
 	enum chips		type;
 	struct mutex		lock;
diff --git a/drivers/hwmon/adcxx.c b/drivers/hwmon/adcxx.c
index 242294d..4c5e1f4 100644
--- a/drivers/hwmon/adcxx.c
+++ b/drivers/hwmon/adcxx.c
@@ -48,7 +48,7 @@
 #define DRVNAME		"adcxx"
 
 struct adcxx {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 	u32 channels;
 	u32 reference; /* in millivolts */
diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index b11e06f..1decaba 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -78,7 +78,7 @@ clearing it.  Weird, ey?   --Phil  */
 
 /* Each client has this additional data */
 struct adm1021_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	enum chips type;
 
 	struct mutex update_lock;
diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
index 4db04d6..c1fdc4a 100644
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -145,7 +145,7 @@ static struct i2c_driver adm1025_driver = {
  */
 
 struct adm1025_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index 7fe2441..ef975e7 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -259,7 +259,7 @@ struct pwm_data {
 };
 
 struct adm1026_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	int valid;		/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index ba84ca5..6a95c43 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -150,7 +150,7 @@ static struct i2c_driver adm1029_driver = {
  */
 
 struct adm1029_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* zero until following fields are valid */
 	unsigned long last_updated;	/* in jiffies */
diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 7894418..34ff66a 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -70,7 +70,7 @@ typedef u8 auto_chan_table_t[8][2];
 
 /* Each client has this additional data */
 struct adm1031_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	int chip_type;
 	char valid;		/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 2444b15..74e73f4 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -161,7 +161,7 @@ static struct i2c_driver adm9240_driver = {
 
 /* per client data */
 struct adm9240_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;
 	unsigned long last_updated_measure;
diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index 5c39b4a..12eca87 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -64,7 +64,7 @@ static unsigned int ads7828_lsb_resol; /* resolution of the ADC sample lsb */
 
 /* Each client has this additional data */
 struct ads7828_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock; /* mutex protect updates */
 	char valid; /* !=0 if following fields are valid */
 	unsigned long last_updated; /* In jiffies */
diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index d368d8f..241ea4b 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -138,7 +138,7 @@ I2C_CLIENT_INSMOD_1(adt7470);
 #define FAN_DATA_VALID(x)	((x) && (x) != FAN_PERIOD_INVALID)
 
 struct adt7470_data {
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct attribute_group	attrs;
 	struct mutex		lock;
 	char			sensors_valid;
diff --git a/drivers/hwmon/adt7473.c b/drivers/hwmon/adt7473.c
index 3a0b631..dd3c236 100644
--- a/drivers/hwmon/adt7473.c
+++ b/drivers/hwmon/adt7473.c
@@ -130,7 +130,7 @@ I2C_CLIENT_INSMOD_1(adt7473);
 #define FAN_DATA_VALID(x)	((x) && (x) != FAN_PERIOD_INVALID)
 
 struct adt7473_data {
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct attribute_group	attrs;
 	struct mutex		lock;
 	char			sensors_valid;
diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index b06b8e0..b3d3a52 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -140,7 +140,7 @@ static const int debug;
 static struct platform_device *pdev;
 static s16 rest_x;
 static s16 rest_y;
-static struct device *hwmon_dev;
+static struct hwmon_device *hwmon_dev;
 static struct input_polled_dev *applesmc_idev;
 
 /* Indicates whether this computer has an accelerometer. */
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index 8a45a2e..798016a 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -176,7 +176,7 @@ static u8 DIV_TO_REG(long val)
    data is pointed to by client->data. The structure itself is
    dynamically allocated, at the same time the client itself is allocated. */
 struct asb100_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 
 	struct mutex update_lock;
diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index d6b490d..1ddb0a7 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -72,7 +72,7 @@ static struct i2c_driver atxp1_driver = {
 };
 
 struct atxp1_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	unsigned long last_updated;
 	u8 valid;
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 93c1722..45ea5e8 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -48,7 +48,7 @@ typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
 static struct coretemp_data *coretemp_update_device(struct device *dev);
 
 struct coretemp_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	const char *name;
 	u32 id;
diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index 27a5d39..3dba1bf 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -177,7 +177,7 @@ static const u8 DME1737_BIT_ALARM_FAN[] = {10, 11, 12, 13, 22, 23};
 
 struct dme1737_data {
 	struct i2c_client *client;	/* for I2C devices only */
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	const char *name;
 	unsigned int addr;		/* for ISA devices only */
 
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index 7415381..7228f87 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -72,7 +72,7 @@ static const u8 DS1621_REG_TEMP[3] = {
 
 /* Each client has this additional data */
 struct ds1621_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index 7a14a2d..d765601 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -166,7 +166,7 @@ struct f71805f_auto_point {
 struct f71805f_data {
 	unsigned short addr;
 	const char *name;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 67067e9..f1e1daf 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -89,7 +89,7 @@ static inline void superio_exit(int base);
 
 struct f71882fg_data {
 	unsigned short addr;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 1692de3..a2c5089 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -87,7 +87,7 @@ I2C_CLIENT_INSMOD_2(f75373, f75375);
 
 struct f75375_data {
 	unsigned short addr;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	const char *name;
 	int kind;
diff --git a/drivers/hwmon/fscher.c b/drivers/hwmon/fscher.c
index 12c70e4..c03025f 100644
--- a/drivers/hwmon/fscher.c
+++ b/drivers/hwmon/fscher.c
@@ -143,7 +143,7 @@ static struct i2c_driver fscher_driver = {
  */
 
 struct fscher_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index 9671703..5ac59bc 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -209,7 +209,7 @@ static struct i2c_driver fschmd_driver = {
  */
 
 struct fschmd_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	int kind;
 	char valid; /* zero until following fields are valid */
diff --git a/drivers/hwmon/fscpos.c b/drivers/hwmon/fscpos.c
index 8a7bcf5..e8dab64 100644
--- a/drivers/hwmon/fscpos.c
+++ b/drivers/hwmon/fscpos.c
@@ -124,7 +124,7 @@ static struct i2c_driver fscpos_driver = {
  * Client data (each client gets its own)
  */
 struct fscpos_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; 		/* 0 until following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
index 7820df4..84f088d 100644
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -114,7 +114,7 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 
 /* Each client has this additional data */
 struct gl518_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	enum chips type;
 
 	struct mutex update_lock;
diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
index 19616f2..891a843 100644
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -110,7 +110,7 @@ static struct i2c_driver gl520_driver = {
 
 /* Client data */
 struct gl520_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* zero until the following fields are valid */
 	unsigned long last_updated;	/* in jiffies */
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 076a59c..4d395fe 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -27,6 +27,9 @@ static struct class *hwmon_class;
 static DEFINE_IDR(hwmon_idr);
 static DEFINE_SPINLOCK(idr_lock);
 
+static LIST_HEAD(hwmon_list);
+static DEFINE_SPINLOCK(hwmon_list_lock);
+
 /**
  * hwmon_device_register - register w/ hwmon
  * @dev: the device to register
@@ -36,9 +39,10 @@ static DEFINE_SPINLOCK(idr_lock);
  *
  * Returns the pointer to the new device.
  */
-struct device *hwmon_device_register(struct device *dev)
+struct hwmon_device *hwmon_device_register(struct device *dev)
 {
 	struct device *hwdev;
+	struct hwmon_device *hwmon;
 	int id, err;
 
 again:
@@ -62,9 +66,17 @@ again:
 		spin_lock(&idr_lock);
 		idr_remove(&hwmon_idr, id);
 		spin_unlock(&idr_lock);
+		return NULL;
 	}
 
-	return hwdev;
+	hwmon = kzalloc(sizeof(struct hwmon_device), GFP_KERNEL);
+	hwmon->dev = dev;
+
+	spin_lock(&hwmon_list_lock);
+	list_add_tail(&hwmon->node, &hwmon_list);
+	spin_unlock(&hwmon_list_lock);
+
+	return hwmon;
 }
 
 /**
@@ -72,20 +84,79 @@ again:
  *
  * @dev: the class device to destroy
  */
-void hwmon_device_unregister(struct device *dev)
+void hwmon_device_unregister(struct hwmon_device *hwmon)
 {
 	int id;
+	struct device *dev = hwmon->dev;
 
 	if (likely(sscanf(dev->bus_id, HWMON_ID_FORMAT, &id) = 1)) {
+		spin_lock(&hwmon_list_lock);
+		list_del(&hwmon->node);
+		spin_unlock(&hwmon_list_lock);
 		device_unregister(dev);
 		spin_lock(&idr_lock);
 		idr_remove(&hwmon_idr, id);
 		spin_unlock(&idr_lock);
+		kfree(hwmon);
 	} else
 		dev_dbg(dev->parent,
 			"hwmon_device_unregister() failed: bad class ID!\n");
 }
 
+/**
+ * hwmon_get_device - return the hwmon structure associated with a device
+ *
+ * @dev: the device with hwmon capabilities
+ */
+
+struct hwmon_device *hwmon_get_device(struct device *dev)
+{
+	struct hwmon_device *hwmon_dev = NULL;
+
+	spin_lock(&hwmon_list_lock);
+	list_for_each_entry(hwmon_dev, &hwmon_list, node) {
+		if (hwmon_dev->dev = dev)
+			break;
+	}
+	spin_unlock(&hwmon_list_lock);
+	return hwmon_dev;
+}
+EXPORT_SYMBOL(hwmon_get_device);
+
+/**
+ * hwmon_get_temp - return the temperature of a given channel on the hwmon dev
+ *
+ * @dev: the hwmon device
+ * @channel: the channel to return
+ * @temp: integer to return the temperature in
+ */
+
+int hwmon_get_temp(struct hwmon_device *hwmon, int channel, int *temp)
+{
+	if (hwmon->ops.get_temp)
+		return hwmon->ops.get_temp(hwmon, channel, temp);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hwmon_get_temp);
+
+/**
+ * hwmon_set_temp - set the temperature for a given channel on the hwmon dev
+ *
+ * @dev: the hwmon device
+ * @channel: the channel to set
+ * @temp: temperature in millidegrees
+ */
+
+int hwmon_set_temp(struct hwmon_device *hwmon, int channel, int temp)
+{
+	if (hwmon->ops.set_temp)
+		return hwmon->ops.set_temp(hwmon, channel, temp);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hwmon_set_temp);
+
 static int __init hwmon_init(void)
 {
 	hwmon_class = class_create(THIS_MODULE, "hwmon");
diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index 2ede938..32925e8 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -105,7 +105,7 @@ struct i5k_device_attribute {
 };
 
 struct i5k_amb_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	unsigned long amb_base;
 	unsigned long amb_len;
diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index 0f70dc2..7e2311c 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -132,7 +132,7 @@ struct aem_rw_sensor_template {
 struct aem_data {
 	struct list_head	list;
 
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct platform_device	*pdev;
 	struct mutex		lock;
 	char			valid;
diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
index 4e9b19c..a98ded4 100644
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -79,7 +79,7 @@ struct ibmpex_sensor_data {
 
 struct ibmpex_bmc_data {
 	struct list_head	list;
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct device		*bmc_device;
 	struct mutex		lock;
 	char			valid;
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index d793cc0..1257226 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -245,7 +245,7 @@ struct it87_sio_data {
 /* For each registered chip, we need to keep some data in memory.
    The structure is dynamically allocated. */
 struct it87_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	enum chips type;
 	u8 revision;
 
diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index bd2bde0..8a9558c 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -38,7 +38,7 @@
 #define SEL_CORE	0x04
 
 struct k8temp_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	const char *name;
 	char valid;		/* zero until following fields are valid */
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 3195a26..1b22608 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -165,7 +165,7 @@ static struct i2c_driver lm63_driver = {
  */
 
 struct lm63_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index d435f00..1b39f12 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -38,7 +38,7 @@
 #define DRVNAME		"lm70"
 
 struct lm70 {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 };
 
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 8f9595f..578f8ac 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -72,7 +72,7 @@ static const u8 LM75_REG_TEMP[3] = {
 
 /* Each client has this additional data */
 struct lm75_data {
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct mutex		update_lock;
 	u8			orig_conf;
 	char			valid;		/* !=0 if registers are valid */
@@ -190,7 +190,7 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	}
 
 	dev_info(&client->dev, "%s: sensor '%s'\n",
-		data->hwmon_dev->bus_id, client->name);
+		data->hwmon_dev->dev->bus_id, client->name);
 
 	return 0;
 
diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index 866b401..eda4e29 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -52,7 +52,7 @@ I2C_CLIENT_INSMOD_1(lm77);
 
 /* Each client has this additional data */
 struct lm77_data {
-	struct device 		*hwmon_dev;
+	struct hwmon_device 		*hwmon_dev;
 	struct mutex		update_lock;
 	char			valid;
 	unsigned long		last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index ed7859f..2ca4f71 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -129,7 +129,7 @@ static inline int TEMP_FROM_REG(s8 val)
    the driver field to differentiate between I2C and ISA chips. */
 struct lm78_data {
 	struct i2c_client client;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 	enum chips type;
 
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index bcffc18..187e60c 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -108,7 +108,7 @@ static inline long TEMP_FROM_REG(u16 temp)
  */
 
 struct lm80_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index e59e2d1..550b992 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -153,7 +153,7 @@ static struct i2c_driver lm83_driver = {
  */
 
 struct lm83_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 12d446f..3f73859 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -284,7 +284,7 @@ struct lm85_autofan {
    The structure is dynamically allocated. */
 struct lm85_data {
 	struct i2c_client client;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	enum chips type;
 
 	struct mutex update_lock;
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index 21970f0..74e536b 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -193,7 +193,7 @@ static struct i2c_driver lm87_driver = {
  */
 
 struct lm87_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* In jiffies */
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index c24fe36..6cd210d 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -232,7 +232,7 @@ static struct i2c_driver lm90_driver = {
  */
 
 struct lm90_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -252,6 +252,58 @@ struct lm90_data {
 	u8 alarms; /* bitvector */
 };
 
+static int lm90_get_temp(struct hwmon_device *hwmon_dev, int channel, int *temp)
+{
+	struct lm90_data *data = lm90_update_device(hwmon_dev->dev);
+	if (channel < 5)
+		*temp = TEMP1_FROM_REG(data->temp8[channel]);
+	else
+		*temp = TEMP2_FROM_REG(data->temp11[channel-5]);
+	return 0;
+}
+
+static int lm90_set_temp(struct hwmon_device *hwmon_dev, int channel, int val)
+{
+	static const u8 reg[10] = {
+		LM90_REG_W_LOCAL_LOW,
+		LM90_REG_W_LOCAL_HIGH,
+		LM90_REG_W_LOCAL_CRIT,
+		LM90_REG_W_REMOTE_CRIT,
+		LM90_REG_W_REMOTE_LOWH,
+		LM90_REG_W_REMOTE_LOWL,
+		LM90_REG_W_REMOTE_HIGHH,
+		LM90_REG_W_REMOTE_HIGHL,
+		LM90_REG_W_REMOTE_OFFSH,
+		LM90_REG_W_REMOTE_OFFSL,
+	};
+
+	struct i2c_client *client = container_of(hwmon_dev->dev,
+						 struct i2c_client, dev);
+	struct lm90_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+	if (channel < 5) {
+		if (data->kind = adt7461)
+			data->temp8[channel] = TEMP1_TO_REG_ADT7461(val);
+		else
+			data->temp8[channel] = TEMP1_TO_REG(val);
+		i2c_smbus_write_byte_data(client, reg[channel - 1],
+					  data->temp8[channel]);
+	} else {
+		channel -= 5;
+		if (data->kind = adt7461)
+			data->temp11[channel] = TEMP2_TO_REG_ADT7461(val);
+		else
+			data->temp11[channel] = TEMP2_TO_REG(val);
+		i2c_smbus_write_byte_data(client, reg[((channel - 1) * 2) + 4],
+					  data->temp11[channel] >> 8);
+		i2c_smbus_write_byte_data(client, reg[((channel - 1) * 2) + 5],
+					  data->temp11[channel] & 0xff);
+	}
+	mutex_unlock(&data->update_lock);
+	return 0;
+}
+
 /*
  * Sysfs stuff
  */
@@ -260,33 +312,26 @@ static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
 			  char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct lm90_data *data = lm90_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->temp8[attr->index]));
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm90_data *data = i2c_get_clientdata(client);
+	int temp;
+
+	lm90_get_temp(data->hwmon_dev, attr->index, &temp);
+
+	return sprintf(buf, "%d\n", temp);
 }
 
 static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
 			 const char *buf, size_t count)
 {
-	static const u8 reg[4] = {
-		LM90_REG_W_LOCAL_LOW,
-		LM90_REG_W_LOCAL_HIGH,
-		LM90_REG_W_LOCAL_CRIT,
-		LM90_REG_W_REMOTE_CRIT,
-	};
-
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm90_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
 	int nr = attr->index;
 
-	mutex_lock(&data->update_lock);
-	if (data->kind = adt7461)
-		data->temp8[nr] = TEMP1_TO_REG_ADT7461(val);
-	else
-		data->temp8[nr] = TEMP1_TO_REG(val);
-	i2c_smbus_write_byte_data(client, reg[nr - 1], data->temp8[nr]);
-	mutex_unlock(&data->update_lock);
+	lm90_set_temp(data->hwmon_dev, nr, val);
+
 	return count;
 }
 
@@ -294,38 +339,26 @@ static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
 			   char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct lm90_data *data = lm90_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP2_FROM_REG(data->temp11[attr->index]));
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm90_data *data = i2c_get_clientdata(client);
+	int temp;
+
+	lm90_get_temp(data->hwmon_dev, attr->index, &temp);
+
+	return sprintf(buf, "%d\n", temp);
 }
 
 static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
 			  const char *buf, size_t count)
 {
-	static const u8 reg[6] = {
-		LM90_REG_W_REMOTE_LOWH,
-		LM90_REG_W_REMOTE_LOWL,
-		LM90_REG_W_REMOTE_HIGHH,
-		LM90_REG_W_REMOTE_HIGHL,
-		LM90_REG_W_REMOTE_OFFSH,
-		LM90_REG_W_REMOTE_OFFSL,
-	};
-
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm90_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
 	int nr = attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm90_data *data = i2c_get_clientdata(client);
+	
+	lm90_set_temp(data->hwmon_dev, nr, val);
 
-	mutex_lock(&data->update_lock);
-	if (data->kind = adt7461)
-		data->temp11[nr] = TEMP2_TO_REG_ADT7461(val);
-	else
-		data->temp11[nr] = TEMP2_TO_REG(val);
-	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2],
-				  data->temp11[nr] >> 8);
-	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2 + 1],
-				  data->temp11[nr] & 0xff);
-	mutex_unlock(&data->update_lock);
 	return count;
 }
 
@@ -372,15 +405,15 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute
 }
 
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp8, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp11, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp11, NULL, 5);
 static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp8,
 	set_temp8, 1);
 static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp11,
-	set_temp11, 1);
+	set_temp11, 6);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp8,
 	set_temp8, 2);
 static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp11,
-	set_temp11, 2);
+	set_temp11, 7);
 static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp8,
 	set_temp8, 3);
 static SENSOR_DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp8,
@@ -389,7 +422,7 @@ static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temphyst,
 	set_temphyst, 3);
 static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_temphyst, NULL, 4);
 static SENSOR_DEVICE_ATTR(temp2_offset, S_IWUSR | S_IRUGO, show_temp11,
-	set_temp11, 3);
+	set_temp11, 8);
 
 /* Individual alarm files */
 static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 0);
@@ -680,6 +713,9 @@ static int lm90_probe(struct i2c_client *new_client,
 		goto exit_remove_files;
 	}
 
+	data->hwmon_dev->ops.get_temp = lm90_get_temp;
+	data->hwmon_dev->ops.set_temp = lm90_set_temp;
+
 	return 0;
 
 exit_remove_files:
diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index b2e00c5..5157b2f 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -96,7 +96,7 @@ static struct i2c_driver lm92_driver;
 
 /* Client data (each client gets its own) */
 struct lm92_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index fc36cad..1ad7d84 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -200,7 +200,7 @@ struct block1_t {
  * Client-specific data
  */
 struct lm93_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	unsigned long last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
index 1ab1cac..6b92c85 100644
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -114,7 +114,7 @@ static struct i2c_driver max1619_driver = {
  */
 
 struct max1619_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index f27af6a..a5da8e4 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -140,7 +140,7 @@ static struct i2c_driver max6650_driver = {
 
 struct max6650_data
 {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 9b462bb..65c2d90 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -184,7 +184,7 @@ static inline u8 PWM_TO_REG(int val, int inv)
 
 struct pc87360_data {
 	const char *name;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
index 7265f22..1750bb1 100644
--- a/drivers/hwmon/pc87427.c
+++ b/drivers/hwmon/pc87427.c
@@ -46,7 +46,7 @@ static struct platform_device *pdev;
    device is using banked registers) and the register cache (needed to keep
    the data in the registers and the cache in sync at any time). */
 struct pc87427_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 	int address[2];
 	const char *name;
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index a276806..78407df 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -163,7 +163,7 @@ static inline u8 DIV_TO_REG(int val)
 struct sis5595_data {
 	unsigned short addr;
 	const char *name;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 
 	struct mutex update_lock;
diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
index eb03544..7999e27 100644
--- a/drivers/hwmon/smsc47b397.c
+++ b/drivers/hwmon/smsc47b397.c
@@ -98,7 +98,7 @@ static u8 smsc47b397_reg_temp[] = {0x25, 0x26, 0x27, 0x80};
 struct smsc47b397_data {
 	unsigned short addr;
 	const char *name;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 
 	struct mutex update_lock;
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index d1b4985..f318065 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -120,7 +120,7 @@ struct smsc47m1_data {
 	unsigned short addr;
 	const char *name;
 	enum chips type;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	unsigned long last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
index 8bb5cb5..8206128 100644
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -96,7 +96,7 @@ static inline int TEMP_FROM_REG(s8 val)
 }
 
 struct smsc47m192_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
index 7d97431..901b337 100644
--- a/drivers/hwmon/thmc50.c
+++ b/drivers/hwmon/thmc50.c
@@ -63,7 +63,7 @@ static const u8 THMC50_REG_TEMP_DEFAULT[] = { 0x17, 0x18, 0x18 };
 
 /* Each client has this additional data */
 struct thmc50_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	enum chips type;
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index f1ee5e7..83f3a47 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -294,7 +294,7 @@ static inline long TEMP_FROM_REG10(u16 val)
 struct via686a_data {
 	unsigned short addr;
 	const char *name;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index 12b4359..da6574b 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -112,7 +112,7 @@ static const u8 bitalarmfan[]	= {6, 7};
 struct vt1211_data {
 	unsigned short addr;
 	const char *name;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index 5bc5727..3acf6c3 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -148,7 +148,7 @@ struct vt8231_data {
 	const char *name;
 
 	struct mutex update_lock;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 075164d..6811d3f 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -260,7 +260,7 @@ struct w83627ehf_data {
 	int addr;	/* IO base of hw monitor block */
 	const char *name;
 
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 
 	struct mutex update_lock;
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index b30e579..a795487 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -348,7 +348,7 @@ static inline u8 DIV_TO_REG(long val)
 struct w83627hf_data {
 	unsigned short addr;
 	const char *name;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 	enum chips type;
 
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index f942ecd..a76bc41 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -214,7 +214,7 @@ DIV_TO_REG(long val, enum chips type)
    the driver field to differentiate between I2C and ISA chips. */
 struct w83781d_data {
 	struct i2c_client client;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 	enum chips type;
 
diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index de21142..e4eca6f 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -245,7 +245,7 @@ static u8 div_to_reg(int nr, long val)
 }
 
 struct w83791d_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 
 	char valid;			/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index cf94c5b..b138e2a 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -267,7 +267,7 @@ DIV_TO_REG(long val)
 }
 
 struct w83792d_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 0a739f1..4c2fe62 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -180,7 +180,7 @@ static inline s8 TEMP_TO_REG(long val, s8 min, s8 max)
 
 struct w83793_data {
 	struct i2c_client *lm75[2];
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
index ea295b9..7d03fcb 100644
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -116,7 +116,7 @@ static struct i2c_driver w83l785ts_driver = {
  */
 
 struct w83l785ts_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
index badca76..5948c2e 100644
--- a/drivers/hwmon/w83l786ng.c
+++ b/drivers/hwmon/w83l786ng.c
@@ -121,7 +121,7 @@ DIV_TO_REG(long val)
 }
 
 struct w83l786ng_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 6b6ee70..c772588 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -16,9 +16,27 @@
 
 #include <linux/device.h>
 
-struct device *hwmon_device_register(struct device *dev);
+struct hwmon_device;
 
-void hwmon_device_unregister(struct device *dev);
+struct hwmon_device_ops {
+	int (*get_temp) (struct hwmon_device *, int, int *);
+	int (*set_temp) (struct hwmon_device *, int, int);
+};
+
+struct hwmon_device {
+	struct device *dev;
+	struct list_head node;
+	struct hwmon_device_ops ops;
+};
+
+struct hwmon_device *hwmon_device_register(struct device *dev);
+
+void hwmon_device_unregister(struct hwmon_device *dev);
+
+struct hwmon_device *hwmon_get_device(struct device *dev);
+
+int hwmon_get_temp(struct hwmon_device *, int, int *);
+int hwmon_set_temp(struct hwmon_device *, int, int);
 
 /* Scale user input to sensible values */
 static inline int SENSORS_LIMIT(long value, long low, long high)

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
