From: jklaas@comcast.net (jklaas)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: smartbatt
Message-Id: <Pine.LNX.4.50.0308211355310.11405-200000@shenendoah.appalachian.home>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I recently upgraded my ProGear to use Knoppix.  In the process I wanted to 
be able to get information about the battery.  So, in looking at the 
i2c/lm_sensors drivers for that particular set of Debian packages, it 
seemed to be stuck at 2.6.(something).  I decided to see if I could write 
a chip driver for it and proceeded to hack at the adm1021 driver (since 
that is also on the ProGear and I could more easily see what I was doing).  

Fortunately, I didn't get very far before I decided to see if someone else 
had already done this and lo and behold, in 2.7 and above it exists.  I 
ended up getting the latest CVS of i2c and lm_sensors2.  I couldn't get 
the smartbatt stuff to load without forcing it.  I also updated some of 
the code to read stuff like manufacturer information (but left it inside
#if 0/#endif bracketing).  

I figured out, in this process, that I also needed to update lib/chip.c 
and lib/chip.h to recognize the smartbatt fields in order to display them 
using sensors.  I also started on getting the display properly formatted in 
sensors.conf, but I didn't get very far yet (I just got it working, yay!!!). 
I'll send a smartbatt-* section for sensors.conf in a bit.  It also looks 
like I'll need to add a print_smartbatt section too.

Has anyone started work on the Battery Charger stuff.  I have one more 
address on the ProGear that I don't know what it does (0x09) and looking 
at the list of addresses (from 
http://www2.lm-sensors.nu/~lm78/i2ctools.html), that seems likely.  

Should I ask for write access to CVS?

-- 
			James Klaas

Procrastinate NOW!!!! -- Don't put it off.
-------------- next part --------------
Only in lm_sensors2/kernel/busses: dmi_scan.d
Only in lm_sensors2/kernel/busses: dmi_scan.o
Only in lm_sensors2/kernel/busses: i2c-ali1535.d
Only in lm_sensors2/kernel/busses: i2c-ali1535.o
Only in lm_sensors2/kernel/busses: i2c-ali15x3.d
Only in lm_sensors2/kernel/busses: i2c-ali15x3.o
Only in lm_sensors2/kernel/busses: i2c-amd756.d
Only in lm_sensors2/kernel/busses: i2c-amd756.o
Only in lm_sensors2/kernel/busses: i2c-amd8111.d
Only in lm_sensors2/kernel/busses: i2c-amd8111.o
Only in lm_sensors2/kernel/busses: i2c-hydra.d
Only in lm_sensors2/kernel/busses: i2c-hydra.o
Only in lm_sensors2/kernel/busses: i2c-i801.d
Only in lm_sensors2/kernel/busses: i2c-i801.o
Only in lm_sensors2/kernel/busses: i2c-i810.d
Only in lm_sensors2/kernel/busses: i2c-i810.o
Only in lm_sensors2/kernel/busses: i2c-isa.d
Only in lm_sensors2/kernel/busses: i2c-isa.o
Only in lm_sensors2/kernel/busses: i2c-nforce2.d
Only in lm_sensors2/kernel/busses: i2c-nforce2.o
Only in lm_sensors2/kernel/busses: i2c-piix4.d
Only in lm_sensors2/kernel/busses: i2c-piix4.o
Only in lm_sensors2/kernel/busses: i2c-savage4.d
Only in lm_sensors2/kernel/busses: i2c-savage4.o
Only in lm_sensors2/kernel/busses: i2c-sis5595.d
Only in lm_sensors2/kernel/busses: i2c-sis5595.o
Only in lm_sensors2/kernel/busses: i2c-sis630.d
Only in lm_sensors2/kernel/busses: i2c-sis630.o
Only in lm_sensors2/kernel/busses: i2c-sis645.d
Only in lm_sensors2/kernel/busses: i2c-sis645.o
Only in lm_sensors2/kernel/busses: i2c-via.d
Only in lm_sensors2/kernel/busses: i2c-via.o
Only in lm_sensors2/kernel/busses: i2c-viapro.d
Only in lm_sensors2/kernel/busses: i2c-viapro.o
Only in lm_sensors2/kernel/busses: i2c-voodoo3.d
Only in lm_sensors2/kernel/busses: i2c-voodoo3.o
Only in lm_sensors2/kernel/chips: adm1021.d
Only in lm_sensors2/kernel/chips: adm1021.o
Only in lm_sensors2/kernel/chips: adm1024.d
Only in lm_sensors2/kernel/chips: adm1024.o
Only in lm_sensors2/kernel/chips: adm1025.d
Only in lm_sensors2/kernel/chips: adm1025.o
Only in lm_sensors2/kernel/chips: adm1026.d
Only in lm_sensors2/kernel/chips: adm1026.o
Only in lm_sensors2/kernel/chips: adm9240.d
Only in lm_sensors2/kernel/chips: adm9240.o
Only in lm_sensors2/kernel/chips: bt869.d
Only in lm_sensors2/kernel/chips: bt869.o
Only in lm_sensors2/kernel/chips: ddcmon.d
Only in lm_sensors2/kernel/chips: ddcmon.o
Only in lm_sensors2/kernel/chips: ds1307.d
Only in lm_sensors2/kernel/chips: ds1307.o
Only in lm_sensors2/kernel/chips: ds1621.d
Only in lm_sensors2/kernel/chips: ds1621.o
Only in lm_sensors2/kernel/chips: eeprom.d
Only in lm_sensors2/kernel/chips: eeprom.o
Only in lm_sensors2/kernel/chips: fscpos.d
Only in lm_sensors2/kernel/chips: fscpos.o
Only in lm_sensors2/kernel/chips: fscscy.d
Only in lm_sensors2/kernel/chips: fscscy.o
Only in lm_sensors2/kernel/chips: gl518sm.d
Only in lm_sensors2/kernel/chips: gl518sm.o
Only in lm_sensors2/kernel/chips: gl520sm.d
Only in lm_sensors2/kernel/chips: gl520sm.o
Only in lm_sensors2/kernel/chips: it87.d
Only in lm_sensors2/kernel/chips: it87.o
Only in lm_sensors2/kernel/chips: lm75.d
Only in lm_sensors2/kernel/chips: lm75.o
Only in lm_sensors2/kernel/chips: lm78.d
Only in lm_sensors2/kernel/chips: lm78.o
Only in lm_sensors2/kernel/chips: lm80.d
Only in lm_sensors2/kernel/chips: lm80.o
Only in lm_sensors2/kernel/chips: lm83.d
Only in lm_sensors2/kernel/chips: lm83.o
Only in lm_sensors2/kernel/chips: lm85.d
Only in lm_sensors2/kernel/chips: lm85.o
Only in lm_sensors2/kernel/chips: lm87.d
Only in lm_sensors2/kernel/chips: lm87.o
Only in lm_sensors2/kernel/chips: lm90.d
Only in lm_sensors2/kernel/chips: lm90.o
Only in lm_sensors2/kernel/chips: lm92.d
Only in lm_sensors2/kernel/chips: lm92.o
Only in lm_sensors2/kernel/chips: ltc1710.d
Only in lm_sensors2/kernel/chips: ltc1710.o
Only in lm_sensors2/kernel/chips: matorb.d
Only in lm_sensors2/kernel/chips: matorb.o
Only in lm_sensors2/kernel/chips: maxilife.d
Only in lm_sensors2/kernel/chips: maxilife.o
Only in lm_sensors2/kernel/chips: mtp008.d
Only in lm_sensors2/kernel/chips: mtp008.o
Only in lm_sensors2/kernel/chips: pcf8574.d
Only in lm_sensors2/kernel/chips: pcf8574.o
Only in lm_sensors2/kernel/chips: pcf8591.d
Only in lm_sensors2/kernel/chips: pcf8591.o
Only in lm_sensors2/kernel/chips: saa1064.d
Only in lm_sensors2/kernel/chips: saa1064.o
Only in lm_sensors2/kernel/chips: sis5595.d
Only in lm_sensors2/kernel/chips: sis5595.o
diff -u2 -r lm_sensors2.orig/kernel/chips/smartbatt.c lm_sensors2/kernel/chips/smartbatt.c
--- lm_sensors2.orig/kernel/chips/smartbatt.c	2003-06-22 19:55:05.000000000 +0200
+++ lm_sensors2/kernel/chips/smartbatt.c	2003-08-21 10:52:11.000000000 +0200
@@ -34,6 +34,6 @@
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x0b, SENSORS_I2C_END };
-static unsigned short normal_i2c_range[] = { SENSORS_I2C_END };
+static unsigned short normal_i2c[] = { SENSORS_I2C_END };
+static unsigned short normal_i2c_range[] = { 0x0b, SENSORS_I2C_END };
 static unsigned int normal_isa[] = { SENSORS_ISA_END };
 static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
@@ -57,4 +57,5 @@
 #define SMARTBATT_REG_AVGTIME_F 0x13
 #define SMARTBATT_REG_STATUS 0x16
+#define SMARTBATT_REG_CYCLECT 0x17
 #define SMARTBATT_REG_DESV 0x19
 #define SMARTBATT_REG_DATE 0x1b
@@ -64,6 +65,5 @@
 #define SMARTBATT_REG_CHEM 0x22
 
-#define COMM_TIMEOUT 16
-#define BATTERY_STRING_MAX	33
+#define BATTERY_STRING_MAX	64
 
 /* Each client has this additional data */
@@ -87,5 +87,5 @@
 	u16 temp, v, desv, i, avgi;	/* Register values */
 	u16 rte, ate, atf, alarms;	/* Register values */
-	u16 relchg, abschg;		/* Register values */
+	u16 cyclect, relchg, abschg;	/* Register values */
 };
 
@@ -97,5 +97,5 @@
 
 static u16 swap_bytes(u16 val);
-static int sb_read(struct i2c_client *client, u8 reg);
+static int smartbatt_read(struct i2c_client *client, u8 reg);
 #if 0
 static int smartbatt_write_value(struct i2c_client *client, u8 reg, u16 value);
@@ -274,5 +274,5 @@
 }
 
-static int sb_read(struct i2c_client *client, u8 reg)
+static int smartbatt_read(struct i2c_client *client, u8 reg)
 {
 	return swap_bytes(i2c_smbus_read_word_data(client, reg));
@@ -287,44 +287,44 @@
 
 #if 0
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
 
+	down(&data->update_lock);
+	
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
+  data->serial = smartbatt_read(client, SMARTBATT_REG_SERIAL);
 
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
+
+	up(&data->update_lock);
 
-  return 0;
 }
 #endif
@@ -332,5 +332,7 @@
 static void smartbatt_init_client(struct i2c_client *client)
 {
-
+#if 0
+	get_battery_info( client );
+#endif
 }
 
@@ -343,15 +345,16 @@
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
+		data->temp = smartbatt_read(client, SMARTBATT_REG_TEMP);
+		data->i = smartbatt_read(client, SMARTBATT_REG_I);
+		data->avgi = smartbatt_read(client, SMARTBATT_REG_AVGI);
+		data->v = smartbatt_read(client, SMARTBATT_REG_V);
+		data->desv = smartbatt_read(client, SMARTBATT_REG_DESV);
+		data->ate = smartbatt_read(client, SMARTBATT_REG_AVGTIME_E);
+		data->atf = smartbatt_read(client, SMARTBATT_REG_AVGTIME_F);
+		data->rte = smartbatt_read(client, SMARTBATT_REG_RUNTIME_E);
+		data->alarms = smartbatt_read(client, SMARTBATT_REG_STATUS);
+		data->cyclect = smartbatt_read(client, SMARTBATT_REG_CYCLECT);
+		data->relchg = smartbatt_read(client, SMARTBATT_REG_RELCHG);
+		data->abschg = smartbatt_read(client, SMARTBATT_REG_ABSCHG);
 		data->last_updated = jiffies;
 		data->valid = 1;
Only in lm_sensors2/kernel/chips: smartbatt.d
Only in lm_sensors2/kernel/chips: smartbatt.o
Only in lm_sensors2/kernel/chips: smbus-arp.d
Only in lm_sensors2/kernel/chips: smbus-arp.o
Only in lm_sensors2/kernel/chips: smsc47m1.d
Only in lm_sensors2/kernel/chips: smsc47m1.o
Only in lm_sensors2/kernel/chips: thmc50.d
Only in lm_sensors2/kernel/chips: thmc50.o
Only in lm_sensors2/kernel/chips: via686a.d
Only in lm_sensors2/kernel/chips: via686a.o
Only in lm_sensors2/kernel/chips: vt1211.d
Only in lm_sensors2/kernel/chips: vt1211.o
Only in lm_sensors2/kernel/chips: vt8231.d
Only in lm_sensors2/kernel/chips: vt8231.o
Only in lm_sensors2/kernel/chips: w83627hf.d
Only in lm_sensors2/kernel/chips: w83627hf.o
Only in lm_sensors2/kernel/chips: w83781d.d
Only in lm_sensors2/kernel/chips: w83781d.o
Only in lm_sensors2/kernel/include: sensors.h
Only in lm_sensors2/kernel/include: sensors.hd
Only in lm_sensors2/lib: access.ad
Only in lm_sensors2/lib: access.ao
Only in lm_sensors2/lib: access.ld
Only in lm_sensors2/lib: access.lo
Only in lm_sensors2/lib: chips.ad
Only in lm_sensors2/lib: chips.ao
diff -u2 -r lm_sensors2.orig/lib/chips.c lm_sensors2/lib/chips.c
--- lm_sensors2.orig/lib/chips.c	2003-08-15 00:10:32.000000000 +0200
+++ lm_sensors2/lib/chips.c	2003-08-21 10:21:39.000000000 +0200
@@ -4421,4 +4421,42 @@
   };
 
+static sensors_chip_feature smartbatt_features[] +  {
+    { SENSORS_SMARTBATT_I, "i", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                              SENSORS_MODE_R, SMARTBATT_SYSCTL_I, VALUE(2), 
+                              0 },
+    { SENSORS_SMARTBATT_I_AVG, "i_avg", SENSORS_SMARTBATT_I, SENSORS_SMARTBATT_I,
+                              SENSORS_MODE_RW, SMARTBATT_SYSCTL_I, VALUE(1), 
+                              0 },
+    { SENSORS_SMARTBATT_V, "v", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                              SENSORS_MODE_R, SMARTBATT_SYSCTL_V, VALUE(2), 
+                              0 },
+    { SENSORS_SMARTBATT_DES_V, "des_v", SENSORS_SMARTBATT_V, SENSORS_SMARTBATT_V,
+                              SENSORS_MODE_RW, SMARTBATT_SYSCTL_V, VALUE(1), 
+                              0 },
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
+    { SENSORS_SMARTBATT_CHARGE, "abs_charge", SENSORS_NO_MAPPING, 
+	                      SENSORS_NO_MAPPING, SENSORS_MODE_R, 
+			      SMARTBATT_SYSCTL_CHARGE, VALUE(2), 0 },
+    { SENSORS_SMARTBATT_REL_CHARGE, "rel_charge", SENSORS_SMARTBATT_CHARGE, 
+	                      SENSORS_SMARTBATT_V, SENSORS_MODE_RW, 
+			      SMARTBATT_SYSCTL_V, VALUE(1), 0 },
+    { 0 }
+  };
+
 sensors_chip_features sensors_chip_features_list[]  {
@@ -4488,4 +4526,5 @@
  { SENSORS_LM83_PREFIX, lm83_features },
  { SENSORS_LM90_PREFIX, lm90_features },
+ { SENSORS_SMARTBATT_PREFIX, smartbatt_features },
  { 0 }
 };
diff -u2 -r lm_sensors2.orig/lib/chips.h lm_sensors2/lib/chips.h
--- lm_sensors2.orig/lib/chips.h	2003-08-15 00:10:32.000000000 +0200
+++ lm_sensors2/lib/chips.h	2003-08-21 10:22:37.000000000 +0200
@@ -1646,3 +1646,19 @@
 #define SENSORS_BMC_CURR1_MAX 3201 /* RW */
 
+/* SMARTBATT chips. */
+
+#define SENSORS_SMARTBATT_PREFIX "smartbatt"
+
+#define SENSORS_SMARTBATT_I 1 /* R */
+#define SENSORS_SMARTBATT_I_AVG 2 /* RW */
+#define SENSORS_SMARTBATT_V 3 /* R */
+#define SENSORS_SMARTBATT_DES_V 4 /* RW */
+#define SENSORS_SMARTBATT_TEMP 5 /* R */
+#define SENSORS_SMARTBATT_TIME 6 /* R */
+#define SENSORS_SMARTBATT_AVG_TIME_F 7 /* RW */
+#define SENSORS_SMARTBATT_AVG_TIME_E 8 /* RW */
+#define SENSORS_SMARTBATT_ALARMS 9 /* R */
+#define SENSORS_SMARTBATT_CHARGE 10 /* R */
+#define SENSORS_SMARTBATT_REL_CHARGE 11 /* RW */
+
 #endif /* def LIB_SENSORS_CHIPS_H */
Only in lm_sensors2/lib: chips.ld
Only in lm_sensors2/lib: chips.lo
Only in lm_sensors2/lib: conf-lex.ao
Only in lm_sensors2/lib: conf-lex.c
Only in lm_sensors2/lib: conf-lex.lo
Only in lm_sensors2/lib: conf-parse.ao
Only in lm_sensors2/lib: conf-parse.c
Only in lm_sensors2/lib: conf-parse.h
Only in lm_sensors2/lib: conf-parse.lo
Only in lm_sensors2/lib: data.ad
Only in lm_sensors2/lib: data.ao
Only in lm_sensors2/lib: data.ld
Only in lm_sensors2/lib: data.lo
Only in lm_sensors2/lib: error.ad
Only in lm_sensors2/lib: error.ao
Only in lm_sensors2/lib: error.ld
Only in lm_sensors2/lib: error.lo
Only in lm_sensors2/lib: general.ad
Only in lm_sensors2/lib: general.ao
Only in lm_sensors2/lib: general.ld
Only in lm_sensors2/lib: general.lo
Only in lm_sensors2/lib: init.ad
Only in lm_sensors2/lib: init.ao
Only in lm_sensors2/lib: init.ld
Only in lm_sensors2/lib: init.lo
Only in lm_sensors2/lib: libsensors.a
Only in lm_sensors2/lib: libsensors.so
Only in lm_sensors2/lib: libsensors.so.2
Only in lm_sensors2/lib: libsensors.so.2.0.1
Only in lm_sensors2/lib: proc.ad
Only in lm_sensors2/lib: proc.ao
Only in lm_sensors2/lib: proc.ld
Only in lm_sensors2/lib: proc.lo
Only in lm_sensors2/prog/detect: dmidecode
Only in lm_sensors2/prog/detect: dmidecode.rd
Only in lm_sensors2/prog/detect: dmidecode.ro
Only in lm_sensors2/prog/detect: i2cdetect
Only in lm_sensors2/prog/detect: i2cdetect.rd
Only in lm_sensors2/prog/detect: i2cdetect.ro
Only in lm_sensors2/prog/dump: i2cdump
Only in lm_sensors2/prog/dump: i2cdump.rd
Only in lm_sensors2/prog/dump: i2cdump.ro
Only in lm_sensors2/prog/dump: i2cset
Only in lm_sensors2/prog/dump: i2cset.rd
Only in lm_sensors2/prog/dump: i2cset.ro
Only in lm_sensors2/prog/dump: isadump
Only in lm_sensors2/prog/dump: isadump.rd
Only in lm_sensors2/prog/dump: isadump.ro
Only in lm_sensors2/prog/sensord: args.rd
Only in lm_sensors2/prog/sensord: chips.rd
Only in lm_sensors2/prog/sensord: lib.rd
Only in lm_sensors2/prog/sensord: rrd.rd
Only in lm_sensors2/prog/sensord: sense.rd
Only in lm_sensors2/prog/sensord: sensord.rd
Only in lm_sensors2/prog/sensors: chips.rd
Only in lm_sensors2/prog/sensors: chips.ro
Only in lm_sensors2/prog/sensors: main.rd
Only in lm_sensors2/prog/sensors: main.ro
Only in lm_sensors2/prog/sensors: sensors
