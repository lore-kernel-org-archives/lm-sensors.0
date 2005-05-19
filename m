From: jklaas@comcast.net (jklaas)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: smartbatt
Message-Id: <Pine.LNX.4.50.0309041421490.5758-100000@shenendoah.appalachian.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.50.0308211355310.11405-200000@shenendoah.appalachian.home>
In-Reply-To: <Pine.LNX.4.50.0308211355310.11405-200000@shenendoah.appalachian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here's my patch against the CVS from August 19.  I ran patch on this file 
agains the today's CVS (from about 10-15 minutes ago) and it didn't 
complain (aside from some offsets).  I would also welcome any comments 
about my coding capability and style.

===================================

diff -u2 -r lm_sensors2.old/kernel/chips/smartbatt.c lm_sensors2.new/kernel/chips/smartbatt.c
--- lm_sensors2.old/kernel/chips/smartbatt.c	2003-06-22 19:55:05.000000000 +0200
+++ lm_sensors2.new/kernel/chips/smartbatt.c	2003-08-22 16:20:03.000000000 +0200
@@ -34,6 +34,6 @@
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x0b, SENSORS_I2C_END };
-static unsigned short normal_i2c_range[] = { SENSORS_I2C_END };
+static unsigned short normal_i2c[] = { SENSORS_I2C_END };
+static unsigned short normal_i2c_range[] = { 0x0b, SENSORS_I2C_END };
 static unsigned int normal_isa[] = { SENSORS_ISA_END };
 static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
@@ -42,7 +42,4 @@
 SENSORS_INSMOD_1(smartbatt);
 
-/* Conversions */
-#define TEMP_FROM_REG(r) (r - 2732)  /* tenths of degree kelvin to celsius */
-
 /* The SMARTBATT registers */
 #define SMARTBATT_REG_MODE 0x03
@@ -53,8 +50,14 @@
 #define SMARTBATT_REG_RELCHG 0x0d
 #define SMARTBATT_REG_ABSCHG 0x0e
+#define SMARTBATT_REG_REMCAP 0x0f
+#define SMARTBATT_REG_CHGCAP 0x10
 #define SMARTBATT_REG_RUNTIME_E 0x11
 #define SMARTBATT_REG_AVGTIME_E 0x12
 #define SMARTBATT_REG_AVGTIME_F 0x13
+#define SMARTBATT_REG_CHGI 0x14
+#define SMARTBATT_REG_CHGV 0x15
 #define SMARTBATT_REG_STATUS 0x16
+#define SMARTBATT_REG_CYCLECT 0x17
+#define SMARTBATT_REG_DESCAP 0x18
 #define SMARTBATT_REG_DESV 0x19
 #define SMARTBATT_REG_DATE 0x1b
@@ -64,6 +67,7 @@
 #define SMARTBATT_REG_CHEM 0x22
 
+#define BATTERY_STRING_MAX	64
 #define COMM_TIMEOUT 16
-#define BATTERY_STRING_MAX	33
+
 
 /* Each client has this additional data */
@@ -78,4 +82,5 @@
 	char device[BATTERY_STRING_MAX];
 	char chemistry[BATTERY_STRING_MAX];
+#endif
 	int  serial;
 	struct {
@@ -84,8 +89,8 @@
 		unsigned int year:7;	/* Year (1980 + 0-127) */
 	} manufacture_date;
-#endif
-	u16 temp, v, desv, i, avgi;	/* Register values */
-	u16 rte, ate, atf, alarms;	/* Register values */
-	u16 relchg, abschg;		/* Register values */
+	u16 mode, temp, v, i, avgi;	/* Register values */
+	u16 relchg, abschg, remcap, chgcap;	/* Register values */
+	u16 rte, ate, atf, chgi, chgv;	/* Register values */
+	u16 status, cyclect, descap, desv;	/* Register values */
 };
 
@@ -96,7 +101,7 @@
 static int smartbatt_detach_client(struct i2c_client *client);
 
-static u16 swap_bytes(u16 val);
-static int sb_read(struct i2c_client *client, u8 reg);
+static int smartbatt_read(struct i2c_client *client, u8 reg);
 #if 0
+static u16 swap_bytes(u16 val);
 static int smartbatt_write_value(struct i2c_client *client, u8 reg, u16 value);
 #endif
@@ -113,4 +118,8 @@
 static void smartbatt_charge(struct i2c_client *client, int operation,
 		      int ctl_name, int *nrels_mag, long *results);
+static void smartbatt_status(struct i2c_client *client, int operation,
+		      int ctl_name, int *nrels_mag, long *results);
+static void smartbatt_error(struct i2c_client *client, int operation,
+		      int ctl_name, int *nrels_mag, long *results);
 static void smartbatt_update_client(struct i2c_client *client);
 
@@ -128,4 +137,43 @@
 
 /* -- SENSORS SYSCTL START -- */
+
+/* Status Register Bits */
+/* * * * * * Alarm Bits * * * * */ 
+#define SMARTBATT_OVER_CHARGED_ALARM 0x8000 
+#define SMARTBATT_TERMINATE_CHARGE_ALARM 0x4000 
+#define SMARTBATT_OVER_TEMP_ALARM 0x1000 
+#define SMARTBATT_TERMINATE_DISCHARGE_ALARM 0x0800 
+#define SMARTBATT_REMAINING_CAPACITY_ALARM  0x0200 
+#define SMARTBATT_REMAINING_TIME_ALARM 0x0100 
+/* * * * * * Status Bits * * * * */
+#define SMARTBATT_INITIALIZED 0x0080 
+#define SMARTBATT_DISCHARGING 0x0040 
+#define SMARTBATT_FULLY_CHARGED 0x0020 
+#define SMARTBATT_FULLY_DISCHARGED 0x0010 
+/* * * * * * Error Bits * * * * */ 
+#define SMARTBATT_OK 0x0000 
+#define SMARTBATT_BUSY 0x0001 
+#define SMARTBATT_RESERVED_COMMAND 0x0002 
+#define SMARTBATT_UNSUPPORTED_COMMAND 0x0003 
+#define SMARTBATT_ACCESS_DENIED 0x0004 
+#define SMARTBATT_OVER_UNDERFLOW 0x0005 
+#define SMARTBATT_BAD_SIZE 0x0006 
+#define SMARTBATT_UNKNOWN_ERROR 0x0007
+
+#define SMARTBATT_ALARM (SMARTBATT_OVER_CHARGED_ALARM \
+		| SMARTBATT_TERMINATE_CHARGE_ALARM | SMARTBATT_OVER_TEMP_ALARM \
+		| SMARTBATT_TERMINATE_DISCHARGE_ALARM \
+		| SMARTBATT_REMAINING_CAPACITY_ALARM \
+		| SMARTBATT_REMAINING_TIME_ALARM)
+
+#define SMARTBATT_STATUS (SMARTBATT_INITIALIZED | SMARTBATT_DISCHARGING \
+		| SMARTBATT_FULLY_CHARGED | SMARTBATT_FULLY_DISCHARGED )
+
+#define SMARTBATT_ERROR (SMARTBATT_BUSY | SMARTBATT_RESERVED_COMMAND \
+		| SMARTBATT_UNSUPPORTED_COMMAND | SMARTBATT_ACCESS_DENIED \
+		| SMARTBATT_OVER_UNDERFLOW | SMARTBATT_BAD_SIZE\
+		| SMARTBATT_UNKNOWN_ERROR)
+
+
 #define SMARTBATT_SYSCTL_I 1001
 #define SMARTBATT_SYSCTL_V 1002
@@ -133,5 +181,7 @@
 #define SMARTBATT_SYSCTL_TIME 1004
 #define SMARTBATT_SYSCTL_ALARMS 1005
-#define SMARTBATT_SYSCTL_CHARGE 1006
+#define SMARTBATT_SYSCTL_STATUS 1006
+#define SMARTBATT_SYSCTL_ERROR 1007
+#define SMARTBATT_SYSCTL_CHARGE 1008
 
 /* -- SENSORS SYSCTL END -- */
@@ -153,4 +203,8 @@
 	{SMARTBATT_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
 	 &i2c_sysctl_real, NULL, &smartbatt_alarms},
+	{SMARTBATT_SYSCTL_STATUS, "status", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &smartbatt_status},
+	{SMARTBATT_SYSCTL_ERROR, "error", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &smartbatt_error},
 	{SMARTBATT_SYSCTL_CHARGE, "charge", NULL, 0, 0444, NULL, &i2c_proc_real,
 	 &i2c_sysctl_real, NULL, &smartbatt_charge},
@@ -268,13 +322,20 @@
 }
 
-
+#if 0
+/*   Why swap bytes?  */
 static u16 swap_bytes(u16 val)
 {
 	return (val >> 8) | (val << 8);
 }
+#endif
 
-static int sb_read(struct i2c_client *client, u8 reg)
-{
-	return swap_bytes(i2c_smbus_read_word_data(client, reg));
+static int smartbatt_read(struct i2c_client *client, u8 reg)
+{ 
+	int n = COMM_TIMEOUT;
+	int val;
+	do { 
+		val = i2c_smbus_read_word_data(client, reg);
+	} while ((val = -1) && (n-- > 0));
+	return val;
 }
 
@@ -286,51 +347,51 @@
 #endif
 
-#if 0
-/* this is code from battery.c. No strings support yet in i2c-proc.c so
-   all we could do is print this out at startup if we wanted.
-*/
-int
-static battery_info(int fd, struct battery_info *info)
+#define COMM_TIMEOUT 16
+static void get_battery_info(struct i2c_client *client)
 {
-  int n;
+  struct smartbatt_data *data = client->data;
   int val;
 
+  down(&data->update_lock);
+  data->chgcap = smartbatt_read(client, SMARTBATT_REG_CHGCAP);
+  data->descap = smartbatt_read(client, SMARTBATT_REG_DESCAP);
+  data->desv = smartbatt_read(client, SMARTBATT_REG_DESV);
   /* ManufactureDate */
-  val = sb_read(SMARTBATT_REG_DATE);
-  info->manufacture_date.day=val & 0x1F;
-  info->manufacture_date.month=(val >> 5) & 0x0F;
-  info->manufacture_date.year=(val >> 9) & 0x7F;
+  val = smartbatt_read(client, SMARTBATT_REG_DATE);
+  data->manufacture_date.day=val & 0x1F;
+  data->manufacture_date.month=(val >> 5) & 0x0F;
+  data->manufacture_date.year=(val >> 9) & 0x7F;
 
   /* SerialNumber */
-  info->serial = sb_read(SMARTBATT_REG_SERIAL
-
+  data->serial = smartbatt_read(client, SMARTBATT_REG_SERIAL);
+#if 0
   /* ManufacturerName */
-  n = COMM_TIMEOUT;
+  n=COMM_TIMEOUT;
   do {
-    val = i2c_smbus_read_block_data(fd, 0x20, info->manufacturer);
+    val = i2c_smbus_read_block_data(client, 0x20, data->manufacturer);
   } while ((val = -1) && (n-- > 0));
-  info->manufacturer[val]=0;	
+  data->manufacturer[val]=0;	
 
   /* DeviceName */
-  n = COMM_TIMEOUT;
+  n=COMM_TIMEOUT;
   do {
-    val = i2c_smbus_read_block_data(fd, 0x21, info->device);
+    val = i2c_smbus_read_block_data(client, 0x21, data->device);
   } while ((val = -1) && (n-- > 0));
-  info->device[val]=0;	
+  data->device[val]=0;	
 
   /* DeviceChemistry */
-  n = COMM_TIMEOUT;
+  n=COMM_TIMEOUT;
   do {
-    val = i2c_smbus_read_block_data(fd, 0x22, info->chemistry);
+    val = i2c_smbus_read_block_data(client, 0x22, data->chemistry);
   } while ((val = -1) && (n-- > 0));
-  info->chemistry[val]=0;	
+  data->chemistry[val]=0;	
+#endif
+  up(&data->update_lock);
 
-  return 0;
 }
-#endif
 
 static void smartbatt_init_client(struct i2c_client *client)
 {
-
+	get_battery_info( client );
 }
 
@@ -343,15 +404,19 @@
 	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
 	    (jiffies < data->last_updated) || !data->valid) {
-		data->temp = sb_read(client, SMARTBATT_REG_TEMP);
-		data->i = sb_read(client, SMARTBATT_REG_I);
-		data->avgi = sb_read(client, SMARTBATT_REG_AVGI);
-		data->v = sb_read(client, SMARTBATT_REG_V);
-		data->desv = sb_read(client, SMARTBATT_REG_DESV);
-		data->ate = sb_read(client, SMARTBATT_REG_AVGTIME_E);
-		data->atf = sb_read(client, SMARTBATT_REG_AVGTIME_F);
-		data->rte = sb_read(client, SMARTBATT_REG_RUNTIME_E);
-		data->alarms = sb_read(client, SMARTBATT_REG_STATUS);
-		data->relchg = sb_read(client, SMARTBATT_REG_RELCHG);
-		data->abschg = sb_read(client, SMARTBATT_REG_ABSCHG);
+		data->mode = smartbatt_read(client, SMARTBATT_REG_MODE);
+		data->temp = smartbatt_read(client, SMARTBATT_REG_TEMP);
+		data->i = smartbatt_read(client, SMARTBATT_REG_I);
+		data->avgi = smartbatt_read(client, SMARTBATT_REG_AVGI);
+		data->v = smartbatt_read(client, SMARTBATT_REG_V);
+		data->chgi = smartbatt_read(client, SMARTBATT_REG_CHGI);
+		data->chgv = smartbatt_read(client, SMARTBATT_REG_CHGV);
+		data->ate = smartbatt_read(client, SMARTBATT_REG_AVGTIME_E);
+		data->atf = smartbatt_read(client, SMARTBATT_REG_AVGTIME_F);
+		data->rte = smartbatt_read(client, SMARTBATT_REG_RUNTIME_E);
+		data->status = smartbatt_read(client, SMARTBATT_REG_STATUS);
+		data->cyclect = smartbatt_read(client, SMARTBATT_REG_CYCLECT);
+		data->relchg = smartbatt_read(client, SMARTBATT_REG_RELCHG);
+		data->abschg = smartbatt_read(client, SMARTBATT_REG_ABSCHG);
+		data->remcap = smartbatt_read(client, SMARTBATT_REG_REMCAP);
 		data->last_updated = jiffies;
 		data->valid = 1;
@@ -367,8 +432,8 @@
 	struct smartbatt_data *data = client->data;
 	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 1;
+		*nrels_mag = 0;
 	else if (operation = SENSORS_PROC_REAL_READ) {
 		smartbatt_update_client(client);
-		results[0] = TEMP_FROM_REG(data->temp);
+		results[0] = data->temp;
 		*nrels_mag = 1;
 	}
@@ -380,10 +445,11 @@
 	struct smartbatt_data *data = client->data;
 	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 3;
+		*nrels_mag = 0;
 	else if (operation = SENSORS_PROC_REAL_READ) {
 		smartbatt_update_client(client);
-		results[0] = data->avgi;
-		results[1] = data->i;
-		*nrels_mag = 2;
+		results[0] = data->chgi;
+		results[1] = data->avgi;
+		results[2] = data->i;
+		*nrels_mag = 3;
 	}
 }
@@ -394,8 +460,8 @@
 	struct smartbatt_data *data = client->data;
 	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 3;
+		*nrels_mag = 0;
 	else if (operation = SENSORS_PROC_REAL_READ) {
 		smartbatt_update_client(client);
-		results[0] = data->desv;
+		results[0] = data->chgv;
 		results[1] = data->v;
 		*nrels_mag = 2;
@@ -426,5 +492,31 @@
 	else if (operation = SENSORS_PROC_REAL_READ) {
 		smartbatt_update_client(client);
-		results[0] = data->alarms;
+		results[0] = data->status & SMARTBATT_ALARM;
+		*nrels_mag = 1;
+	}
+}
+
+void smartbatt_status(struct i2c_client *client, int operation, int ctl_name,
+		 int *nrels_mag, long *results)
+{
+	struct smartbatt_data *data = client->data;
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		smartbatt_update_client(client);
+		results[0] = data->status & SMARTBATT_STATUS;
+		*nrels_mag = 1;
+	}
+}
+
+void smartbatt_error(struct i2c_client *client, int operation, int ctl_name,
+		 int *nrels_mag, long *results)
+{
+	struct smartbatt_data *data = client->data;
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		smartbatt_update_client(client);
+		results[0] = data->status & SMARTBATT_ERROR;
 		*nrels_mag = 1;
 	}
@@ -441,5 +533,7 @@
 		results[0] = data->relchg;
 		results[1] = data->abschg;
-		*nrels_mag = 2;
+		results[2] = data->chgi;
+		results[3] = data->chgv;
+		*nrels_mag = 4;
 	}
 }
diff -u2 -r lm_sensors2.old/lib/chips.c lm_sensors2.new/lib/chips.c
--- lm_sensors2.old/lib/chips.c	2003-08-15 00:10:32.000000000 +0200
+++ lm_sensors2.new/lib/chips.c	2003-08-22 16:11:46.000000000 +0200
@@ -4421,4 +4421,57 @@
   };
 
+static sensors_chip_feature smartbatt_features[] +  {
+    { SENSORS_SMARTBATT_AMP, "amp", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                              SENSORS_MODE_R, SMARTBATT_SYSCTL_I, VALUE(3), 
+                              0 },
+    { SENSORS_SMARTBATT_AVG_AMP, "avg_amp", SENSORS_SMARTBATT_AMP, 
+	                      SENSORS_SMARTBATT_AMP, SENSORS_MODE_RW, 
+			      SMARTBATT_SYSCTL_I, VALUE(2), 0 },
+    { SENSORS_SMARTBATT_CHG_AMP, "chg_amp", SENSORS_SMARTBATT_AMP, 
+	    	              SENSORS_SMARTBATT_AMP, SENSORS_MODE_RW, 
+			      SMARTBATT_SYSCTL_I, VALUE(1), 0 },
+    { SENSORS_SMARTBATT_VOLT, "volt", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                              SENSORS_MODE_R, SMARTBATT_SYSCTL_V, VALUE(2), 
+                              0 },
+    { SENSORS_SMARTBATT_CHG_VOLT, "chg_volt", SENSORS_SMARTBATT_VOLT, 
+	                      SENSORS_SMARTBATT_VOLT, SENSORS_MODE_RW, 
+			      SMARTBATT_SYSCTL_V, VALUE(1), 0 },
+    { SENSORS_SMARTBATT_TEMP, "temp", SENSORS_NO_MAPPING, 
+                              SENSORS_NO_MAPPING, SENSORS_MODE_R, 
+                              SMARTBATT_SYSCTL_TEMP, VALUE(1), 0 },
+    { SENSORS_SMARTBATT_TIME, "run_time_e", SENSORS_NO_MAPPING, 
+                              SENSORS_NO_MAPPING, SENSORS_MODE_R, 
+                              SMARTBATT_SYSCTL_TIME, VALUE(3), 0 },
+    { SENSORS_SMARTBATT_AVG_TIME_F, "avg_time_f", SENSORS_SMARTBATT_TIME, 
+	                      SENSORS_SMARTBATT_TIME, SENSORS_MODE_RW, 
+			      SMARTBATT_SYSCTL_TIME, VALUE(2), 0 },
+    { SENSORS_SMARTBATT_AVG_TIME_E, "avg_time_e", SENSORS_SMARTBATT_TIME, 
+	                      SENSORS_SMARTBATT_TIME, SENSORS_MODE_RW, 
+			      SMARTBATT_SYSCTL_TIME, VALUE(1), 0 },
+    { SENSORS_SMARTBATT_ALARMS, "alarms", SENSORS_NO_MAPPING,
+                              SENSORS_NO_MAPPING, SENSORS_MODE_R,
+                              SMARTBATT_SYSCTL_ALARMS, VALUE(1), 0 },
+    { SENSORS_SMARTBATT_STATUS, "status", SENSORS_NO_MAPPING,
+                              SENSORS_NO_MAPPING, SENSORS_MODE_R,
+                              SMARTBATT_SYSCTL_STATUS, VALUE(1), 0 },
+    { SENSORS_SMARTBATT_ERROR, "error", SENSORS_NO_MAPPING,
+                              SENSORS_NO_MAPPING, SENSORS_MODE_R,
+                              SMARTBATT_SYSCTL_ERROR, VALUE(1), 0 },
+    { SENSORS_SMARTBATT_CHARGE, "charge_volt", SENSORS_NO_MAPPING, 
+	                      SENSORS_NO_MAPPING, SENSORS_MODE_R, 
+			      SMARTBATT_SYSCTL_CHARGE, VALUE(4), 0 },
+    { SENSORS_SMARTBATT_CHARGE_AMP, "charge_amp", SENSORS_SMARTBATT_CHARGE, 
+	                      SENSORS_SMARTBATT_CHARGE, SENSORS_MODE_RW, 
+			      SMARTBATT_SYSCTL_CHARGE, VALUE(3), 0 },
+    { SENSORS_SMARTBATT_ABS_CHARGE, "abs_charge", SENSORS_SMARTBATT_CHARGE, 
+	                      SENSORS_SMARTBATT_CHARGE, SENSORS_MODE_RW, 
+			      SMARTBATT_SYSCTL_CHARGE, VALUE(2), 0 },
+    { SENSORS_SMARTBATT_REL_CHARGE, "rel_charge", SENSORS_SMARTBATT_CHARGE, 
+	                      SENSORS_SMARTBATT_CHARGE, SENSORS_MODE_RW, 
+			      SMARTBATT_SYSCTL_CHARGE, VALUE(1), 0 },
+    { 0 }
+  };
+
 sensors_chip_features sensors_chip_features_list[]  {
@@ -4488,4 +4541,5 @@
  { SENSORS_LM83_PREFIX, lm83_features },
  { SENSORS_LM90_PREFIX, lm90_features },
+ { SENSORS_SMARTBATT_PREFIX, smartbatt_features },
  { 0 }
 };
diff -u2 -r lm_sensors2.old/lib/chips.h lm_sensors2.new/lib/chips.h
--- lm_sensors2.old/lib/chips.h	2003-08-15 00:10:32.000000000 +0200
+++ lm_sensors2.new/lib/chips.h	2003-08-22 15:57:38.000000000 +0200
@@ -1646,3 +1646,24 @@
 #define SENSORS_BMC_CURR1_MAX 3201 /* RW */
 
+/* SMARTBATT chips. */
+
+#define SENSORS_SMARTBATT_PREFIX "smartbatt"
+
+#define SENSORS_SMARTBATT_AMP 1 /* R */
+#define SENSORS_SMARTBATT_AVG_AMP 2 /* RW */
+#define SENSORS_SMARTBATT_CHG_AMP 3 /* RW */
+#define SENSORS_SMARTBATT_VOLT 4 /* R */
+#define SENSORS_SMARTBATT_CHG_VOLT 5 /* RW */
+#define SENSORS_SMARTBATT_TEMP 6 /* R */
+#define SENSORS_SMARTBATT_TIME 7 /* R */
+#define SENSORS_SMARTBATT_AVG_TIME_F 8 /* RW */
+#define SENSORS_SMARTBATT_AVG_TIME_E 9 /* RW */
+#define SENSORS_SMARTBATT_ALARMS 10 /* R */
+#define SENSORS_SMARTBATT_STATUS 11 /* R */
+#define SENSORS_SMARTBATT_ERROR 12 /* R */
+#define SENSORS_SMARTBATT_CHARGE 13 /* R */
+#define SENSORS_SMARTBATT_CHARGE_AMP 14 /* RW */
+#define SENSORS_SMARTBATT_ABS_CHARGE 15 /* RW */
+#define SENSORS_SMARTBATT_REL_CHARGE 16 /* RW */
+
 #endif /* def LIB_SENSORS_CHIPS_H */
Only in lm_sensors2.new/prog/sensord: args.rd
Only in lm_sensors2.new/prog/sensord: chips.rd
Only in lm_sensors2.new/prog/sensord: lib.rd
Only in lm_sensors2.new/prog/sensord: rrd.rd
Only in lm_sensors2.new/prog/sensord: sense.rd
Only in lm_sensors2.new/prog/sensord: sensord.rd
diff -u2 -r lm_sensors2.old/prog/sensors/chips.c lm_sensors2.new/prog/sensors/chips.c
--- lm_sensors2.old/prog/sensors/chips.c	2003-08-15 11:23:48.000000000 +0200
+++ lm_sensors2.new/prog/sensors/chips.c	2003-08-27 15:23:50.000000000 +0200
@@ -4497,2 +4497,54 @@
 }
 
+#if 0
+void print_smartbatt(const sensors_chip_name *name)
+{
+  char *label;
+  double cur,hyst,over;
+  int alarms,i,valid;
+   char deA
+	 :q!gv[5];
+  if (!sensors_get_feature(*name,SENSORS_SMARTBATT_ALARMS,&cur)) 
+	  
+    alarms = cur + 0.5;
+  else {
+    printf("ERROR: Can't get alarm data!\n");
+    alarms = 0;
+  }
+/*  First Label */
+  if (!sensors_get_label_and_valid(*name,SENSORS_SMARTBATT_TEMP,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_SMARTBATT_TEMP,&cur))  {
+    if (valid) {
+      print_label(label,10);
+      print_temp_info( cur, MINMAX, 0, 0);
+      if (alarms & SMARTBATT_OVER_TEMP_ALARM ) {
+        printf("ALARM (OVER)");
+      }
+      printf("\n");
+    }
+  } else
+    printf("ERROR: Can't get temperature data!\n");
+  free_the_label(&label);
+/*  End First Label */
+  
+/*  Next Label */
+  if (!sensors_get_label_and_valid(*name,SENSORS_SMARTBATT_VOLT,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_SMARTBATT_VOLT,&cur))  {
+    if (valid) {
+      print_label(label,10);
+      print_temp_info( cur, MINMAX, 0, 0);
+      if (alarms & SMARTBATT_OVER_CHARGED_ALARM ) {
+        printf("ALARM (OVERCHARGE)");
+        if (alarms & SMARTBATT_ALARM_TEMP_HIGH)
+          printf("%sHIGH",i?",":"");
+        printf(")");
+      }
+      printf("\n");
+    }
+  } else
+    printf("ERROR: Can't get temperature data!\n");
+  free_the_label(&label);
+/*  End Next Label */
+  
+}
+#endif
diff -u2 -r lm_sensors2.old/prog/sensors/chips.h lm_sensors2.new/prog/sensors/chips.h
--- lm_sensors2.old/prog/sensors/chips.h	2003-08-15 00:10:32.000000000 +0200
+++ lm_sensors2.new/prog/sensors/chips.h	2003-08-22 11:11:39.000000000 +0200
@@ -55,4 +55,5 @@
 extern void print_lm83(const sensors_chip_name *name);
 extern void print_lm90(const sensors_chip_name *name);
+extern void print_smartbatt(const sensors_chip_name *name);
 
 #endif /* def PROG_SENSORS_CHIPS_H */




====================================
On Thu, 4 Sep 2003, Mark Studebaker wrote:

> ok. I misunderstood.
> I thought
> 
> great. please send us your patch, especially if you are stalled :)
> 
> If you start the battery charger let us know and we will update
> the new drivers page.
> 
> jklaas wrote:
> > 
> > Yeah, I checked out the CVS on August 19.  That's the one I was working
> > from.
> > 
> > On Thu, 4 Sep 2003, Mark Studebaker wrote:
> > 
> > > I wrote and checked in a smartbatt driver a couple of months ago,
> > > please look in CVS, see if you can contribute any patches to improve it.
> > > thanks
> > > mds
> > >
> > > jklaas wrote:
> > > >
> > > > I sent some mail last month about wanting to join the lm_sensors group.
> > > > I've actually gotten my smartbatt driver working great.  I've even
> > > > modified lib/chips.[ch] so that I can read the data.  I've kind of
> > > > started on prog/sensors/chips.[ch] but that's kind of stalled at the
> > > > moment.
> > > >
> > > > Should I submit a patch for what I've done?  I was also looking at the
> > > > built-in battery charger at 0x09 and I am considering starting a chip
> > > > driver for that.
> > > >
> > > > --
> > > >                         James Klaas
> > > >
> > > > Procrastinate NOW!!!! -- Don't put it off.
> > >
> > 
> > --
> >                         James Klaas
> > 
> > Procrastinate NOW!!!! -- Don't put it off.
> 

-- 
			James Klaas

Procrastinate NOW!!!! -- Don't put it off.
