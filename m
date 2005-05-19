From: aurelien@aurel32.net (=?iso-8859-15?Q?Aur=E9lien?= Jarno)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: [PATCH 2.4] sis5595 and lm78 drivers improvements
Message-Id: <20050126175741.GA16224@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Please find attached a patch that improve sis5595 and lm78 drivers for
2.4 kernels. It is based on the 2.6 patches that have been sent on the
mailing list.

Bye,
Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: kernel/chips/lm78.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/lm78.c,v
retrieving revision 1.70
diff -u -1 -b -p -r1.70 lm78.c
--- kernel/chips/lm78.c	23 Jan 2005 18:02:43 -0000	1.70
+++ kernel/chips/lm78.c	26 Jan 2005 15:10:48 -0000
@@ -80,5 +80,4 @@ static inline u8 FAN_TO_REG(long rpm, in
 {
-	if (rpm = 0)
+	if (rpm <= 0)
 		return 255;
-	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
 	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1,
@@ -95,3 +94,2 @@ static inline u8 FAN_TO_REG(long rpm, in
                            205-(val)*5)
-#define ALARMS_FROM_REG(val) (val)
 
@@ -657,3 +655,3 @@ void lm78_alarms(struct i2c_client *clie
 		lm78_update_client(client);
-		results[0] = ALARMS_FROM_REG(data->alarms);
+		results[0] = data->alarms;
 		*nrels_mag = 1;
Index: kernel/chips/sis5595.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/sis5595.c,v
retrieving revision 1.53
diff -u -1 -b -p -r1.53 sis5595.c
--- kernel/chips/sis5595.c	23 Jan 2005 18:02:43 -0000	1.53
+++ kernel/chips/sis5595.c	26 Jan 2005 15:10:48 -0000
@@ -24,2 +24,5 @@
 /* 
+   SiS southbridge has a LM78-like chip integrated on the same IC.
+   This driver is a customized copy of lm78.c
+
     Supports following revisions:
@@ -81,3 +84,5 @@ static int blacklist[] = {
 			PCI_DEVICE_ID_SI_630,
+			PCI_DEVICE_ID_SI_645,
 			PCI_DEVICE_ID_SI_730,
+			PCI_DEVICE_ID_SI_735,
 			PCI_DEVICE_ID_SI_5511, /* 5513 chip has the 0008 device but
@@ -86,11 +91,4 @@ static int blacklist[] = {
 			PCI_DEVICE_ID_SI_5597,
-			PCI_DEVICE_ID_SI_5598,
-			0x645,
-			0x735,
-                          0 };
-/*
-   SiS southbridge has a LM78-like chip integrated on the same IC.
-   This driver is a customized copy of lm78.c
-*/
-
+			PCI_DEVICE_ID_SI_5598
+                          };
 /* Many SIS5595 constants specified below */
@@ -146,5 +144,4 @@ static inline u8 FAN_TO_REG(long rpm, in
 {
-	if (rpm = 0)
+	if (rpm <= 0)
 		return 255;
-	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
 	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1,
@@ -162,4 +159,2 @@ static inline u8 FAN_TO_REG(long rpm, in
 
-#define ALARMS_FROM_REG(val) (val)
-
 #define DIV_FROM_REG(val) (1 << (val))
@@ -188,4 +183,4 @@ struct sis5595_data {
 	u8 temp;		/* Register value */
-	u8 temp_over;		/* Register value  - really max */
-	u8 temp_hyst;		/* Register value  - really min */
+	u8 temp_over;		/* Register value */
+	u8 temp_hyst;		/* Register value */
 	u8 fan_div[2];		/* Register encoding, shifted right */
@@ -401,13 +396,10 @@ int sis5595_detect(struct i2c_adapter *a
 
-	/* Check revision and pin registers to determine whether 3 or 4 voltages */
+	/* Check revision and pin registers to determine whether 4 or 5 voltages */
 	pci_read_config_byte(s_bridge, SIS5595_REVISION_REG, &(data->revision));
-	if(data->revision < REV2MIN) {
+	/* 4 voltages, 1 temp */
 		data->maxins = 3;
-	} else {
+	if(data->revision >= REV2MIN) {
 		pci_read_config_byte(s_bridge, SIS5595_PIN_REG, &val);
-		if(val & 0x80)
-			/* 3 voltages, 1 temp */
-			data->maxins = 3;
-		else
-			/* 4 voltages, no temps */
+		if(!(val & 0x80))
+			/* 5 voltages, no temps */
 			data->maxins = 4;
@@ -671,3 +663,3 @@ void sis5595_alarms(struct i2c_client *c
 		sis5595_update_client(client);
-		results[0] = ALARMS_FROM_REG(data->alarms);
+		results[0] = data->alarms;
 		*nrels_mag = 1;
