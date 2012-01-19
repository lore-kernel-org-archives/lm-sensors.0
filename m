From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:56:12 +0000
Subject: [lm-sensors] [PATCH 78/82] hwmon: (w83793) Fix multi-line comments
Message-Id: <1327017376-20466-79-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Rudolf Marek <r.marek@assembler.cz>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83793.c |  233 ++++++++++++++++++++++++++---------------------
 1 files changed, 129 insertions(+), 104 deletions(-)

diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 5929d44..a24bcee 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -1,33 +1,34 @@
-/* w83793.c - Linux kernel driver for hardware monitoring
-    Copyright (C) 2006 Winbond Electronics Corp.
-		  Yuan Mu
-		  Rudolf Marek <r.marek@assembler.cz>
-    Copyright (C) 2009-2010 Sven Anders <anders@anduras.de>, ANDURAS AG.
-		  Watchdog driver part
-		  (Based partially on fschmd driver,
-		   Copyright 2007-2008 by Hans de Goede)
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation - version 2.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-    02110-1301 USA.
-*/
-
 /*
-    Supports following chips:
+ * w83793.c - Linux kernel driver for hardware monitoring
+ * Copyright (C) 2006 Winbond Electronics Corp.
+ *	      Yuan Mu
+ *	      Rudolf Marek <r.marek@assembler.cz>
+ * Copyright (C) 2009-2010 Sven Anders <anders@anduras.de>, ANDURAS AG.
+ *		Watchdog driver part
+ *		(Based partially on fschmd driver,
+ *		 Copyright 2007-2008 by Hans de Goede)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation - version 2.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301 USA.
+ */
 
-    Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    w83793	10	12	8	6	0x7b	0x5ca3	yes	no
-*/
+/*
+ * Supports following chips:
+ *
+ * Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+ * w83793	10	12	8	6	0x7b	0x5ca3	yes	no
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -77,9 +78,9 @@ MODULE_PARM_DESC(nowayout,
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
 /*
-   Address 0x00, 0x0d, 0x0e, 0x0f in all three banks are reserved
-   as ID, Bank Select registers
-*/
+ * Address 0x00, 0x0d, 0x0e, 0x0f in all three banks are reserved
+ * as ID, Bank Select registers
+ */
 #define W83793_REG_BANKSEL		0x00
 #define W83793_REG_VENDORID		0x0d
 #define W83793_REG_CHIPID		0x0e
@@ -109,8 +110,10 @@ static u16 W83793_REG_TEMP_MODE[2] = { 0x5e, 0x5f };
 #define TEMP_CRIT_HYST	2
 #define TEMP_WARN	3
 #define TEMP_WARN_HYST	4
-/* only crit and crit_hyst affect real-time alarm status
-   current crit crit_hyst warn warn_hyst */
+/*
+ * only crit and crit_hyst affect real-time alarm status
+ * current crit crit_hyst warn warn_hyst
+ */
 static u16 W83793_REG_TEMP[][5] = {
 	{0x1c, 0x78, 0x79, 0x7a, 0x7b},
 	{0x1d, 0x7c, 0x7d, 0x7e, 0x7f},
@@ -216,8 +219,10 @@ struct w83793_data {
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
-	unsigned long last_nonvolatile;	/* In jiffies, last time we update the
-					   nonvolatile registers */
+	unsigned long last_nonvolatile;	/*
+					 * In jiffies, last time we update the
+					 * nonvolatile registers
+					 */
 
 	u8 bank;
 	u8 vrm;
@@ -231,8 +236,10 @@ struct w83793_data {
 
 	s8 temp[6][5];		/* current, crit, crit_hyst,warn, warn_hyst */
 	u8 temp_low_bits;	/* Additional resolution TD1-TD4 */
-	u8 temp_mode[2];	/* byte 0: Temp D1-D4 mode each has 2 bits
-				   byte 1: Temp R1,R2 mode, each has 1 bit */
+	u8 temp_mode[2];	/*
+				 * byte 0: Temp D1-D4 mode each has 2 bits
+				 * byte 1: Temp R1,R2 mode, each has 1 bit
+				 */
 	u8 temp_critical;	/* If reached all fan will be at full speed */
 	u8 temp_fan_map[6];	/* Temp controls which pwm fan, bit field */
 
@@ -267,17 +274,21 @@ struct w83793_data {
 	int watchdog_timeout; /* watchdog timeout in minutes */
 };
 
-/* Somewhat ugly :( global data pointer list with all devices, so that
-   we can find our device data as when using misc_register. There is no
-   other method to get to one's device data from the open file-op and
-   for usage in the reboot notifier callback. */
+/*
+ * Somewhat ugly :( global data pointer list with all devices, so that
+ * we can find our device data as when using misc_register. There is no
+ * other method to get to one's device data from the open file-op and
+ * for usage in the reboot notifier callback.
+ */
 static LIST_HEAD(watchdog_data_list);
 
 /* Note this lock not only protect list access, but also data.kref access */
 static DEFINE_MUTEX(watchdog_data_mutex);
 
-/* Release our data struct when we're detached from the i2c client *and* all
-   references to our watchdog device are released */
+/*
+ * Release our data struct when we're detached from the i2c client *and* all
+ * references to our watchdog device are released
+ */
 static void w83793_release_resources(struct kref *ref)
 {
 	struct w83793_data *data = container_of(ref, struct w83793_data, kref);
@@ -624,18 +635,18 @@ store_temp(struct device *dev, struct device_attribute *attr,
 }
 
 /*
-	TD1-TD4
-	each has 4 mode:(2 bits)
-	0:	Stop monitor
-	1:	Use internal temp sensor(default)
-	2:	Reserved
-	3:	Use sensor in Intel CPU and get result by PECI
-
-	TR1-TR2
-	each has 2 mode:(1 bit)
-	0:	Disable temp sensor monitor
-	1:	To enable temp sensors monitor
-*/
+ * TD1-TD4
+ * each has 4 mode:(2 bits)
+ * 0:	Stop monitor
+ * 1:	Use internal temp sensor(default)
+ * 2:	Reserved
+ * 3:	Use sensor in Intel CPU and get result by PECI
+ *
+ * TR1-TR2
+ * each has 2 mode:(1 bit)
+ * 0:	Disable temp sensor monitor
+ * 1:	To enable temp sensors monitor
+ */
 
 /* 0 disable, 6 PECI */
 static u8 TO_TEMP_MODE[] = { 0, 0, 0, 6 };
@@ -776,31 +787,31 @@ store_sf_setup(struct device *dev, struct device_attribute *attr,
 }
 
 /*
-	Temp SmartFan control
-	TEMP_FAN_MAP
-	Temp channel control which pwm fan, bitfield, bit 0 indicate pwm1...
-	It's possible two or more temp channels control the same fan, w83793
-	always prefers to pick the most critical request and applies it to
-	the related Fan.
-	It's possible one fan is not in any mapping of 6 temp channels, this
-	means the fan is manual mode
-
-	TEMP_PWM_ENABLE
-	Each temp channel has its own SmartFan mode, and temp channel
-	control	fans that are set by TEMP_FAN_MAP
-	0:	SmartFanII mode
-	1:	Thermal Cruise Mode
-
-	TEMP_CRUISE
-	Target temperature in thermal cruise mode, w83793 will try to turn
-	fan speed to keep the temperature of target device around this
-	temperature.
-
-	TEMP_TOLERANCE
-	If Temp higher or lower than target with this tolerance, w83793
-	will take actions to speed up or slow down the fan to keep the
-	temperature within the tolerance range.
-*/
+ * Temp SmartFan control
+ * TEMP_FAN_MAP
+ * Temp channel control which pwm fan, bitfield, bit 0 indicate pwm1...
+ * It's possible two or more temp channels control the same fan, w83793
+ * always prefers to pick the most critical request and applies it to
+ * the related Fan.
+ * It's possible one fan is not in any mapping of 6 temp channels, this
+ * means the fan is manual mode
+ *
+ * TEMP_PWM_ENABLE
+ * Each temp channel has its own SmartFan mode, and temp channel
+ * control fans that are set by TEMP_FAN_MAP
+ * 0:	SmartFanII mode
+ * 1:	Thermal Cruise Mode
+ *
+ * TEMP_CRUISE
+ * Target temperature in thermal cruise mode, w83793 will try to turn
+ * fan speed to keep the temperature of target device around this
+ * temperature.
+ *
+ * TEMP_TOLERANCE
+ * If Temp higher or lower than target with this tolerance, w83793
+ * will take actions to speed up or slow down the fan to keep the
+ * temperature within the tolerance range.
+ */
 
 #define TEMP_FAN_MAP			0
 #define TEMP_PWM_ENABLE			1
@@ -1313,10 +1324,12 @@ static int watchdog_open(struct inode *inode, struct file *filp)
 	struct w83793_data *pos, *data = NULL;
 	int watchdog_is_open;
 
-	/* We get called from drivers/char/misc.c with misc_mtx hold, and we
-	   call misc_register() from  w83793_probe() with watchdog_data_mutex
-	   hold, as misc_register() takes the misc_mtx lock, this is a possible
-	   deadlock, so we use mutex_trylock here. */
+	/*
+	 * We get called from drivers/char/misc.c with misc_mtx hold, and we
+	 * call misc_register() from  w83793_probe() with watchdog_data_mutex
+	 * hold, as misc_register() takes the misc_mtx lock, this is a possible
+	 * deadlock, so we use mutex_trylock here.
+	 */
 	if (!mutex_trylock(&watchdog_data_mutex))
 		return -ERESTARTSYS;
 	list_for_each_entry(pos, &watchdog_data_list, list) {
@@ -1329,8 +1342,10 @@ static int watchdog_open(struct inode *inode, struct file *filp)
 	/* Check, if device is already open */
 	watchdog_is_open = test_and_set_bit(0, &data->watchdog_is_open);
 
-	/* Increase data reference counter (if not already done).
-	   Note we can never not have found data, so we don't check for this */
+	/*
+	 * Increase data reference counter (if not already done).
+	 * Note we can never not have found data, so we don't check for this
+	 */
 	if (!watchdog_is_open)
 		kref_get(&data->kref);
 
@@ -1656,8 +1671,10 @@ static int w83793_detect(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	/* If Winbond chip, address of chip and W83793_REG_I2C_ADDR
-	   should match */
+	/*
+	 * If Winbond chip, address of chip and W83793_REG_I2C_ADDR
+	 * should match
+	 */
 	if ((bank & 0x07) = 0
 	 && i2c_smbus_read_byte_data(client, W83793_REG_I2C_ADDR) ! 	    (address << 1)) {
@@ -1699,9 +1716,11 @@ static int w83793_probe(struct i2c_client *client,
 	INIT_LIST_HEAD(&data->list);
 	kref_init(&data->kref);
 
-	/* Store client pointer in our data struct for watchdog usage
-	   (where the client is found through a data ptr instead of the
-	   otherway around) */
+	/*
+	 * Store client pointer in our data struct for watchdog usage
+	 * (where the client is found through a data ptr instead of the
+	 * otherway around)
+	 */
 	data->client = client;
 
 	err = w83793_detect_subclients(client);
@@ -1712,8 +1731,8 @@ static int w83793_probe(struct i2c_client *client,
 	w83793_init_client(client);
 
 	/*
-	   Only fan 1-5 has their own input pins,
-	   Pwm 1-3 has their own pins
+	 * Only fan 1-5 has their own input pins,
+	 * Pwm 1-3 has their own pins
 	 */
 	data->has_fan = 0x1f;
 	data->has_pwm = 0x07;
@@ -1875,9 +1894,11 @@ static int w83793_probe(struct i2c_client *client,
 		goto exit_devunreg;
 	}
 
-	/* Enable Watchdog registers.
-	   Set Configuration Register to Enable Watch Dog Registers
-	   (Bit 2) = XXXX, X1XX. */
+	/*
+	 * Enable Watchdog registers.
+	 * Set Configuration Register to Enable Watch Dog Registers
+	 * (Bit 2) = XXXX, X1XX.
+	 */
 	tmp = w83793_read_value(client, W83793_REG_CONFIG);
 	w83793_write_value(client, W83793_REG_CONFIG, tmp | 0x04);
 
@@ -1891,9 +1912,11 @@ static int w83793_probe(struct i2c_client *client,
 	/* Disable Soft Watchdog during initialiation */
 	watchdog_disable(data);
 
-	/* We take the data_mutex lock early so that watchdog_open() cannot
-	   run when misc_register() has completed, but we've not yet added
-	   our data to the watchdog_data_list (and set the default timeout) */
+	/*
+	 * We take the data_mutex lock early so that watchdog_open() cannot
+	 * run when misc_register() has completed, but we've not yet added
+	 * our data to the watchdog_data_list (and set the default timeout)
+	 */
 	mutex_lock(&watchdog_data_mutex);
 	for (i = 0; i < ARRAY_SIZE(watchdog_minors); i++) {
 		/* Register our watchdog part */
@@ -1973,9 +1996,9 @@ static void w83793_update_nonvolatile(struct device *dev)
 	struct w83793_data *data = i2c_get_clientdata(client);
 	int i, j;
 	/*
-	   They are somewhat "stable" registers, and to update them every time
-	   takes so much time, it's just not worthy. Update them in a long
-	   interval to avoid exception.
+	 * They are somewhat "stable" registers, and to update them every time
+	 * takes so much time, it's just not worthy. Update them in a long
+	 * interval to avoid exception.
 	 */
 	if (!(time_after(jiffies, data->last_nonvolatile + HZ * 300)
 	      || !data->valid))
@@ -2116,8 +2139,10 @@ END:
 	return data;
 }
 
-/* Ignore the possibility that somebody change bank outside the driver
-   Must be called with data->update_lock held, except during initialization */
+/*
+ * Ignore the possibility that somebody change bank outside the driver
+ * Must be called with data->update_lock held, except during initialization
+ */
 static u8 w83793_read_value(struct i2c_client *client, u16 reg)
 {
 	struct w83793_data *data = i2c_get_clientdata(client);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
