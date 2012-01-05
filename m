From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Thu, 05 Jan 2012 18:50:18 +0000
Subject: [lm-sensors] [PATCH 4/4] drivers/hwmon: remove@used with return
Message-Id: <1325789418-11276-4-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fix checkpatch ERROR:
return is not a function, parentheses are not required

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/atxp1.c     |    2 +-
 drivers/hwmon/f71805f.c   |   16 ++++++++--------
 drivers/hwmon/hwmon-vid.c |   24 ++++++++++++------------
 drivers/hwmon/pcf8591.c   |    4 ++--
 drivers/hwmon/w83627hf.c  |    8 ++++----
 drivers/hwmon/w83792d.c   |    4 ++--
 drivers/hwmon/w83793.c    |    6 +++---
 drivers/hwmon/w83l786ng.c |    2 +-
 8 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index 33cc143..805e3b1 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -106,7 +106,7 @@ static struct atxp1_data * atxp1_update_device(struct device *dev)
 
 	mutex_unlock(&data->update_lock);
 
-	return(data);
+	return data;
 }
 
 /* sys file functions for cpu0_vid */
diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index 92f9497..f67b33d 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -202,7 +202,7 @@ struct f71805f_sio_data {
 
 static inline long in_from_reg(u8 reg)
 {
-	return (reg * 8);
+	return reg * 8;
 }
 
 /* The 2 least significant bits are not used */
@@ -212,13 +212,13 @@ static inline u8 in_to_reg(long val)
 		return 0;
 	if (val >= 2016)
 		return 0xfc;
-	return (((val + 16) / 32) << 2);
+	return ((val + 16) / 32) << 2;
 }
 
 /* in0 is downscaled by a factor 2 internally */
 static inline long in0_from_reg(u8 reg)
 {
-	return (reg * 16);
+	return reg * 16;
 }
 
 static inline u8 in0_to_reg(long val)
@@ -227,7 +227,7 @@ static inline u8 in0_to_reg(long val)
 		return 0;
 	if (val >= 4032)
 		return 0xfc;
-	return (((val + 32) / 64) << 2);
+	return ((val + 32) / 64) << 2;
 }
 
 /* The 4 most significant bits are not used */
@@ -236,7 +236,7 @@ static inline long fan_from_reg(u16 reg)
 	reg &= 0xfff;
 	if (!reg || reg = 0xfff)
 		return 0;
-	return (1500000 / reg);
+	return 1500000 / reg;
 }
 
 static inline u16 fan_to_reg(long rpm)
@@ -246,7 +246,7 @@ static inline u16 fan_to_reg(long rpm)
 	   so that no alarm will ever trigger. */
 	if (rpm < 367)
 		return 0xfff;
-	return (1500000 / rpm);
+	return 1500000 / rpm;
 }
 
 static inline unsigned long pwm_freq_from_reg(u8 reg)
@@ -278,7 +278,7 @@ static inline int pwm_mode_from_reg(u8 reg)
 
 static inline long temp_from_reg(u8 reg)
 {
-	return (reg * 1000);
+	return reg * 1000;
 }
 
 static inline u8 temp_to_reg(long val)
@@ -287,7 +287,7 @@ static inline u8 temp_to_reg(long val)
 		val = 0;
 	else if (val > 1000 * 0xff)
 		val = 0xff;
-	return ((val + 500) / 1000);
+	return (val + 500) / 1000;
 }
 
 /*
diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
index 932da8a..4fcb867 100644
--- a/drivers/hwmon/hwmon-vid.c
+++ b/drivers/hwmon/hwmon-vid.c
@@ -96,14 +96,14 @@ int vid_from_reg(int val, u8 vrm)
 			vid = 1862500 - (val & 0x1f) * 25000;
 		if(val & 0x20)
 			vid -= 12500;
-		return((vid + 500) / 1000);
+		return (vid + 500) / 1000;
 
 	case 110:		/* Intel Conroe */
 				/* compute in uV, round to mV */
 		val &= 0xff;
 		if (val < 0x02 || val > 0xb2)
 			return 0;
-		return((1600000 - (val - 2) * 6250 + 500) / 1000);
+		return (1600000 - (val - 2) * 6250 + 500) / 1000;
 
 	case 24:		/* Athlon64 & Opteron */
 		val &= 0x1f;
@@ -118,38 +118,38 @@ int vid_from_reg(int val, u8 vrm)
 	case 91:		/* VRM 9.1 */
 	case 90:		/* VRM 9.0 */
 		val &= 0x1f;
-		return(val = 0x1f ? 0 :
-		                       1850 - val * 25);
+		return val = 0x1f ? 0 :
+		                       1850 - val * 25;
 
 	case 85:		/* VRM 8.5 */
 		val &= 0x1f;
-		return((val & 0x10  ? 25 : 0) +
+		return (val & 0x10  ? 25 : 0) +
 		       ((val & 0x0f) > 0x04 ? 2050 : 1250) -
-		       ((val & 0x0f) * 50));
+		       ((val & 0x0f) * 50);
 
 	case 84:		/* VRM 8.4 */
 		val &= 0x0f;
 				/* fall through */
 	case 82:		/* VRM 8.2 */
 		val &= 0x1f;
-		return(val = 0x1f ? 0 :
+		return val = 0x1f ? 0 :
 		       val & 0x10  ? 5100 - (val) * 100 :
-		                     2050 - (val) * 50);
+		                     2050 - (val) * 50;
 	case 17:		/* Intel IMVP-II */
 		val &= 0x1f;
-		return(val & 0x10 ? 975 - (val & 0xF) * 25 :
-				    1750 - val * 50);
+		return val & 0x10 ? 975 - (val & 0xF) * 25 :
+				    1750 - val * 50;
 	case 13:
 	case 131:
 		val &= 0x3f;
 		/* Exception for Eden ULV 500 MHz */
 		if (vrm = 131 && val = 0x3f)
 			val++;
-		return(1708 - val * 16);
+		return 1708 - val * 16;
 	case 14:		/* Intel Core */
 				/* compute in uV, round to mV */
 		val &= 0x7f;
-		return(val > 0x77 ? 0 : (1500000 - (val * 12500) + 500) / 1000);
+		return val > 0x77 ? 0 : (1500000 - (val * 12500) + 500) / 1000;
 	default:		/* report 0 for unknown */
 		if (vrm)
 			pr_warn("Requested unsupported VRM version (%u)\n",
diff --git a/drivers/hwmon/pcf8591.c b/drivers/hwmon/pcf8591.c
index 731b09a..2041155 100644
--- a/drivers/hwmon/pcf8591.c
+++ b/drivers/hwmon/pcf8591.c
@@ -269,9 +269,9 @@ static int pcf8591_read_channel(struct device *dev, int channel)
 
 	if ((channel = 2 && input_mode = 2) ||
 	    (channel != 3 && (input_mode = 1 || input_mode = 3)))
-		return (10 * REG_TO_SIGNED(value));
+		return 10 * REG_TO_SIGNED(value);
 	else
-		return (10 * value);
+		return 10 * value;
 }
 
 static const struct i2c_device_id pcf8591_id[] = {
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index bde50e3..2192662 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -313,7 +313,7 @@ static inline unsigned long pwm_freq_from_reg(u8 reg)
 	/* This should not happen but anyway... */
 	if (reg = 0)
 		reg++;
-	return (clock / (reg << 8));
+	return clock / (reg << 8);
 }
 static inline u8 pwm_freq_to_reg(unsigned long val)
 {
@@ -321,11 +321,11 @@ static inline u8 pwm_freq_to_reg(unsigned long val)
 	if (val >= 93750)	/* The highest we can do */
 		return 0x01;
 	if (val >= 720)	/* Use 24 MHz clock */
-		return (24000000UL / (val << 8));
+		return 24000000UL / (val << 8);
 	if (val < 6)		/* The lowest we can do */
 		return 0xFF;
 	else			/* Use 180 kHz clock */
-		return (0x80 | (180000UL / (val << 8)));
+		return 0x80 | (180000UL / (val << 8));
 }
 
 #define BEEP_MASK_FROM_REG(val)		((val) & 0xff7fff)
@@ -342,7 +342,7 @@ static inline u8 DIV_TO_REG(long val)
 			break;
 		val >>= 1;
 	}
-	return ((u8) i);
+	return (u8)i;
 }
 
 /* For each registered chip, we need to keep some data in memory.
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index f3e7130..2071a4b 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -265,7 +265,7 @@ DIV_TO_REG(long val)
 			break;
 		val >>= 1;
 	}
-	return ((u8) i);
+	return (u8)i;
 }
 
 struct w83792d_data {
@@ -333,7 +333,7 @@ static struct i2c_driver w83792d_driver = {
 static inline long in_count_from_reg(int nr, struct w83792d_data *data)
 {
 	/* in7 and in8 do not have low bits, but the formula still works */
-	return ((data->in[nr] << 2) | ((data->low_bits >> (2 * nr)) & 0x03));
+	return (data->in[nr] << 2) | ((data->low_bits >> (2 * nr)) & 0x03);
 }
 
 /* The SMBus locks itself. The Winbond W83792D chip has a bank register,
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 854f911..3e7f330 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -181,7 +181,7 @@ static inline unsigned long FAN_FROM_REG(u16 val)
 {
 	if ((val >= 0xfff) || (val = 0))
 		return	0;
-	return (1350000UL / val);
+	return 1350000UL / val;
 }
 
 static inline u16 FAN_TO_REG(long rpm)
@@ -193,7 +193,7 @@ static inline u16 FAN_TO_REG(long rpm)
 
 static inline unsigned long TIME_FROM_REG(u8 reg)
 {
-	return (reg * 100);
+	return reg * 100;
 }
 
 static inline u8 TIME_TO_REG(unsigned long val)
@@ -203,7 +203,7 @@ static inline u8 TIME_TO_REG(unsigned long val)
 
 static inline long TEMP_FROM_REG(s8 reg)
 {
-	return (reg * 1000);
+	return reg * 1000;
 }
 
 static inline s8 TEMP_TO_REG(long val, s8 min, s8 max)
diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
index 0254e18..900abb9 100644
--- a/drivers/hwmon/w83l786ng.c
+++ b/drivers/hwmon/w83l786ng.c
@@ -116,7 +116,7 @@ DIV_TO_REG(long val)
 			break;
 		val >>= 1;
 	}
-	return ((u8) i);
+	return (u8)i;
 }
 
 struct w83l786ng_data {
-- 
1.7.8.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
