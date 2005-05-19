From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: [PATCH 2/2] i2c: kill some sensors driver macro abuse
Message-Id: <20040923041719.GH4256@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch kills a specific kind of ugly and ultimately useless macro
abuse found in many sensors chip drivers.  Compile tested only.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

Index: linux-2.6.9-rc2-bk6/drivers/i2c/chips/adm1031.c
=================================--- linux-2.6.9-rc2-bk6.orig/drivers/i2c/chips/adm1031.c	2004-09-22 23:31:15.459022186 -0400
+++ linux-2.6.9-rc2-bk6/drivers/i2c/chips/adm1031.c	2004-09-22 23:58:02.327640577 -0400
@@ -298,12 +298,12 @@ set_fan_auto_channel(struct device *dev,
 #define fan_auto_channel_offset(offset)						\
 static ssize_t show_fan_auto_channel_##offset (struct device *dev, char *buf)	\
 {										\
-	return show_fan_auto_channel(dev, buf, 0x##offset - 1);			\
+	return show_fan_auto_channel(dev, buf, offset - 1);			\
 }										\
 static ssize_t set_fan_auto_channel_##offset (struct device *dev,		\
 	const char *buf, size_t count)						\
 {										\
-	return set_fan_auto_channel(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_auto_channel(dev, buf, count, offset - 1);		\
 }										\
 static DEVICE_ATTR(auto_fan##offset##_channel, S_IRUGO | S_IWUSR,		\
 		   show_fan_auto_channel_##offset,				\
@@ -365,25 +365,25 @@ set_auto_temp_max(struct device *dev, co
 #define auto_temp_reg(offset)							\
 static ssize_t show_auto_temp_##offset##_off (struct device *dev, char *buf)	\
 {										\
-	return show_auto_temp_off(dev, buf, 0x##offset - 1);			\
+	return show_auto_temp_off(dev, buf, offset - 1);			\
 }										\
 static ssize_t show_auto_temp_##offset##_min (struct device *dev, char *buf)	\
 {										\
-	return show_auto_temp_min(dev, buf, 0x##offset - 1);			\
+	return show_auto_temp_min(dev, buf, offset - 1);			\
 }										\
 static ssize_t show_auto_temp_##offset##_max (struct device *dev, char *buf)	\
 {										\
-	return show_auto_temp_max(dev, buf, 0x##offset - 1);			\
+	return show_auto_temp_max(dev, buf, offset - 1);			\
 }										\
 static ssize_t set_auto_temp_##offset##_min (struct device *dev,		\
 					     const char *buf, size_t count)	\
 {										\
-	return set_auto_temp_min(dev, buf, count, 0x##offset - 1);		\
+	return set_auto_temp_min(dev, buf, count, offset - 1);		\
 }										\
 static ssize_t set_auto_temp_##offset##_max (struct device *dev,		\
 					     const char *buf, size_t count)	\
 {										\
-	return set_auto_temp_max(dev, buf, count, 0x##offset - 1);		\
+	return set_auto_temp_max(dev, buf, count, offset - 1);		\
 }										\
 static DEVICE_ATTR(auto_temp##offset##_off, S_IRUGO,				\
 		   show_auto_temp_##offset##_off, NULL);			\
@@ -429,12 +429,12 @@ set_pwm(struct device *dev, const char *
 #define pwm_reg(offset)							\
 static ssize_t show_pwm_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_pwm(dev, buf, 0x##offset - 1);			\
+	return show_pwm(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_pwm_##offset (struct device *dev,			\
 				 const char *buf, size_t count)		\
 {									\
-	return set_pwm(dev, buf, count, 0x##offset - 1);		\
+	return set_pwm(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,			\
 		   show_pwm_##offset, set_pwm_##offset)
@@ -565,25 +565,25 @@ set_fan_div(struct device *dev, const ch
 #define fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_fan(dev, buf, 0x##offset - 1);			\
+	return show_fan(dev, buf, offset - 1);			\
 }									\
 static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return show_fan_min(dev, buf, 0x##offset - 1);			\
+	return show_fan_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
 {									\
-	return show_fan_div(dev, buf, 0x##offset - 1);			\
+	return show_fan_div(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan_##offset##_min (struct device *dev,		\
 	const char *buf, size_t count)					\
 {									\
-	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_fan_##offset##_div (struct device *dev,		\
 	const char *buf, size_t count)					\
 {									\
-	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_div(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset,	\
 		   NULL);						\
@@ -675,34 +675,34 @@ set_temp_crit(struct device *dev, const 
 #define temp_reg(offset)							\
 static ssize_t show_temp_##offset (struct device *dev, char *buf)		\
 {										\
-	return show_temp(dev, buf, 0x##offset - 1);				\
+	return show_temp(dev, buf, offset - 1);				\
 }										\
 static ssize_t show_temp_##offset##_min (struct device *dev, char *buf)		\
 {										\
-	return show_temp_min(dev, buf, 0x##offset - 1);				\
+	return show_temp_min(dev, buf, offset - 1);				\
 }										\
 static ssize_t show_temp_##offset##_max (struct device *dev, char *buf)		\
 {										\
-	return show_temp_max(dev, buf, 0x##offset - 1);				\
+	return show_temp_max(dev, buf, offset - 1);				\
 }										\
 static ssize_t show_temp_##offset##_crit (struct device *dev, char *buf)	\
 {										\
-	return show_temp_crit(dev, buf, 0x##offset - 1);			\
+	return show_temp_crit(dev, buf, offset - 1);			\
 }										\
 static ssize_t set_temp_##offset##_min (struct device *dev,			\
 					const char *buf, size_t count)		\
 {										\
-	return set_temp_min(dev, buf, count, 0x##offset - 1);			\
+	return set_temp_min(dev, buf, count, offset - 1);			\
 }										\
 static ssize_t set_temp_##offset##_max (struct device *dev,			\
 					const char *buf, size_t count)		\
 {										\
-	return set_temp_max(dev, buf, count, 0x##offset - 1);			\
+	return set_temp_max(dev, buf, count, offset - 1);			\
 }										\
 static ssize_t set_temp_##offset##_crit (struct device *dev,			\
 					 const char *buf, size_t count)		\
 {										\
-	return set_temp_crit(dev, buf, count, 0x##offset - 1);			\
+	return set_temp_crit(dev, buf, count, offset - 1);			\
 }										\
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset,		\
 		   NULL);							\
Index: linux-2.6.9-rc2-bk6/drivers/i2c/chips/asb100.c
=================================--- linux-2.6.9-rc2-bk6.orig/drivers/i2c/chips/asb100.c	2004-09-22 23:31:15.461021866 -0400
+++ linux-2.6.9-rc2-bk6/drivers/i2c/chips/asb100.c	2004-09-22 23:58:02.328640417 -0400
@@ -266,29 +266,29 @@ set_in_reg(MAX, max)
 static ssize_t \
 	show_in##offset (struct device *dev, char *buf) \
 { \
-	return show_in(dev, buf, 0x##offset); \
+	return show_in(dev, buf, offset); \
 } \
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, \
 		show_in##offset, NULL); \
 static ssize_t \
 	show_in##offset##_min (struct device *dev, char *buf) \
 { \
-	return show_in_min(dev, buf, 0x##offset); \
+	return show_in_min(dev, buf, offset); \
 } \
 static ssize_t \
 	show_in##offset##_max (struct device *dev, char *buf) \
 { \
-	return show_in_max(dev, buf, 0x##offset); \
+	return show_in_max(dev, buf, offset); \
 } \
 static ssize_t set_in##offset##_min (struct device *dev, \
 		const char *buf, size_t count) \
 { \
-	return set_in_min(dev, buf, count, 0x##offset); \
+	return set_in_min(dev, buf, count, offset); \
 } \
 static ssize_t set_in##offset##_max (struct device *dev, \
 		const char *buf, size_t count) \
 { \
-	return set_in_max(dev, buf, count, 0x##offset); \
+	return set_in_max(dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, \
 		show_in##offset##_min, set_in##offset##_min); \
Index: linux-2.6.9-rc2-bk6/drivers/i2c/chips/it87.c
=================================--- linux-2.6.9-rc2-bk6.orig/drivers/i2c/chips/it87.c	2004-09-20 23:09:38.000000000 -0400
+++ linux-2.6.9-rc2-bk6/drivers/i2c/chips/it87.c	2004-09-22 23:58:02.330640097 -0400
@@ -273,7 +273,7 @@ static ssize_t set_in_max(struct device 
 static ssize_t							\
 	show_in##offset (struct device *dev, char *buf)		\
 {								\
-	return show_in(dev, buf, 0x##offset);			\
+	return show_in(dev, buf, offset);			\
 }								\
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);
 
@@ -281,22 +281,22 @@ static DEVICE_ATTR(in##offset##_input, S
 static ssize_t							\
 	show_in##offset##_min (struct device *dev, char *buf)	\
 {								\
-	return show_in_min(dev, buf, 0x##offset);		\
+	return show_in_min(dev, buf, offset);			\
 }								\
 static ssize_t							\
 	show_in##offset##_max (struct device *dev, char *buf)	\
 {								\
-	return show_in_max(dev, buf, 0x##offset);		\
+	return show_in_max(dev, buf, offset);			\
 }								\
 static ssize_t set_in##offset##_min (struct device *dev, 	\
 		const char *buf, size_t count) 			\
 {								\
-	return set_in_min(dev, buf, count, 0x##offset);		\
+	return set_in_min(dev, buf, count, offset);		\
 }								\
 static ssize_t set_in##offset##_max (struct device *dev,	\
 			const char *buf, size_t count)		\
 {								\
-	return set_in_max(dev, buf, count, 0x##offset);		\
+	return set_in_max(dev, buf, count, offset);		\
 }								\
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 	\
 		show_in##offset##_min, set_in##offset##_min);	\
@@ -360,27 +360,27 @@ static ssize_t set_temp_min(struct devic
 #define show_temp_offset(offset)					\
 static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_temp(dev, buf, 0x##offset - 1);			\
+	return show_temp(dev, buf, offset - 1);				\
 }									\
 static ssize_t								\
 show_temp_##offset##_max (struct device *dev, char *buf)		\
 {									\
-	return show_temp_max(dev, buf, 0x##offset - 1);			\
+	return show_temp_max(dev, buf, offset - 1);			\
 }									\
 static ssize_t								\
 show_temp_##offset##_min (struct device *dev, char *buf)		\
 {									\
-	return show_temp_min(dev, buf, 0x##offset - 1);			\
+	return show_temp_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_temp_##offset##_max (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_temp_max(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_max(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_temp_##offset##_min (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_temp_min(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_min(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL); \
 static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
@@ -423,12 +423,12 @@ static ssize_t set_sensor(struct device 
 #define show_sensor_offset(offset)					\
 static ssize_t show_sensor_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_sensor(dev, buf, 0x##offset - 1);			\
+	return show_sensor(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_sensor_##offset (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_sensor(dev, buf, count, 0x##offset - 1);		\
+	return set_sensor(dev, buf, count, offset - 1);			\
 }									\
 static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, 		\
 		show_sensor_##offset, set_sensor_##offset);
@@ -505,25 +505,25 @@ static ssize_t set_fan_div(struct device
 #define show_fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_fan(dev, buf, 0x##offset - 1);			\
+	return show_fan(dev, buf, offset - 1);				\
 }									\
 static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return show_fan_min(dev, buf, 0x##offset - 1);			\
+	return show_fan_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
 {									\
-	return show_fan_div(dev, buf, 0x##offset - 1);			\
+	return show_fan_div(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan_##offset##_min (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_fan_##offset##_div (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_div(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL); \
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
Index: linux-2.6.9-rc2-bk6/drivers/i2c/chips/lm78.c
=================================--- linux-2.6.9-rc2-bk6.orig/drivers/i2c/chips/lm78.c	2004-09-21 21:41:24.036006891 -0400
+++ linux-2.6.9-rc2-bk6/drivers/i2c/chips/lm78.c	2004-09-22 23:58:02.332639778 -0400
@@ -229,29 +229,29 @@ static ssize_t set_in_max(struct device 
 static ssize_t							\
 	show_in##offset (struct device *dev, char *buf)		\
 {								\
-	return show_in(dev, buf, 0x##offset);			\
+	return show_in(dev, buf, offset);			\
 }								\
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, 		\
 		show_in##offset, NULL);				\
 static ssize_t							\
 	show_in##offset##_min (struct device *dev, char *buf)   \
 {								\
-	return show_in_min(dev, buf, 0x##offset);		\
+	return show_in_min(dev, buf, offset);			\
 }								\
 static ssize_t							\
 	show_in##offset##_max (struct device *dev, char *buf)   \
 {								\
-	return show_in_max(dev, buf, 0x##offset);		\
+	return show_in_max(dev, buf, offset);			\
 }								\
 static ssize_t set_in##offset##_min (struct device *dev,	\
 		const char *buf, size_t count)			\
 {								\
-	return set_in_min(dev, buf, count, 0x##offset);		\
+	return set_in_min(dev, buf, count, offset);		\
 }								\
 static ssize_t set_in##offset##_max (struct device *dev,	\
 		const char *buf, size_t count)			\
 {								\
-	return set_in_max(dev, buf, count, 0x##offset);		\
+	return set_in_max(dev, buf, count, offset);		\
 }								\
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,		\
 		show_in##offset##_min, set_in##offset##_min);	\
@@ -375,20 +375,20 @@ static ssize_t set_fan_div(struct device
 #define show_fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_fan(dev, buf, 0x##offset - 1);			\
+	return show_fan(dev, buf, offset - 1);				\
 }									\
 static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)  \
 {									\
-	return show_fan_min(dev, buf, 0x##offset - 1);			\
+	return show_fan_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)  \
 {									\
-	return show_fan_div(dev, buf, 0x##offset - 1);			\
+	return show_fan_div(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan_##offset##_min (struct device *dev,		\
 		const char *buf, size_t count)				\
 {									\
-	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL);\
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
Index: linux-2.6.9-rc2-bk6/drivers/i2c/chips/lm85.c
=================================--- linux-2.6.9-rc2-bk6.orig/drivers/i2c/chips/lm85.c	2004-09-22 23:31:15.463021545 -0400
+++ linux-2.6.9-rc2-bk6/drivers/i2c/chips/lm85.c	2004-09-22 23:58:02.334639458 -0400
@@ -437,16 +437,16 @@ static ssize_t set_fan_min(struct device
 #define show_fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_fan(dev, buf, 0x##offset - 1);			\
+	return show_fan(dev, buf, offset - 1);				\
 }									\
 static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return show_fan_min(dev, buf, 0x##offset - 1);			\
+	return show_fan_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan_##offset##_min (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL);\
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
@@ -527,16 +527,16 @@ static ssize_t show_pwm_enable(struct de
 #define show_pwm_reg(offset)						\
 static ssize_t show_pwm_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_pwm(dev, buf, 0x##offset - 1);			\
+	return show_pwm(dev, buf, offset - 1);				\
 }									\
 static ssize_t set_pwm_##offset (struct device *dev,			\
 				 const char *buf, size_t count)		\
 {									\
-	return set_pwm(dev, buf, count, 0x##offset - 1);		\
+	return set_pwm(dev, buf, count, offset - 1);			\
 }									\
 static ssize_t show_pwm_enable##offset (struct device *dev, char *buf)	\
 {									\
-	return show_pwm_enable(dev, buf, 0x##offset - 1);			\
+	return show_pwm_enable(dev, buf, offset - 1);			\
 }									\
 static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, 			\
 		show_pwm_##offset, set_pwm_##offset);			\
@@ -595,25 +595,25 @@ static ssize_t set_in_max(struct device 
 #define show_in_reg(offset)						\
 static ssize_t show_in_##offset (struct device *dev, char *buf)		\
 {									\
-	return show_in(dev, buf, 0x##offset);				\
+	return show_in(dev, buf, offset);				\
 }									\
 static ssize_t show_in_##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return show_in_min(dev, buf, 0x##offset);			\
+	return show_in_min(dev, buf, offset);				\
 }									\
 static ssize_t show_in_##offset##_max (struct device *dev, char *buf)	\
 {									\
-	return show_in_max(dev, buf, 0x##offset);			\
+	return show_in_max(dev, buf, offset);				\
 }									\
 static ssize_t set_in_##offset##_min (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_in_min(dev, buf, count, 0x##offset);			\
+	return set_in_min(dev, buf, count, offset);			\
 }									\
 static ssize_t set_in_##offset##_max (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_in_max(dev, buf, count, 0x##offset);			\
+	return set_in_max(dev, buf, count, offset);			\
 }									\
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in_##offset, NULL);	\
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 		\
@@ -675,25 +675,25 @@ static ssize_t set_temp_max(struct devic
 #define show_temp_reg(offset)						\
 static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_temp(dev, buf, 0x##offset - 1);			\
+	return show_temp(dev, buf, offset - 1);				\
 }									\
 static ssize_t show_temp_##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return show_temp_min(dev, buf, 0x##offset - 1);			\
+	return show_temp_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t show_temp_##offset##_max (struct device *dev, char *buf)	\
 {									\
-	return show_temp_max(dev, buf, 0x##offset - 1);			\
+	return show_temp_max(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_temp_##offset##_min (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_temp_min(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_min(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_temp_##offset##_max (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_temp_max(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_max(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL);	\
 static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, 		\
Index: linux-2.6.9-rc2-bk6/drivers/i2c/chips/smsc47m1.c
=================================--- linux-2.6.9-rc2-bk6.orig/drivers/i2c/chips/smsc47m1.c	2004-09-22 23:31:15.464021384 -0400
+++ linux-2.6.9-rc2-bk6/drivers/i2c/chips/smsc47m1.c	2004-09-22 23:58:02.335639298 -0400
@@ -298,43 +298,43 @@ static ssize_t set_pwm_en(struct device 
 #define fan_present(offset)						\
 static ssize_t get_fan##offset (struct device *dev, char *buf)		\
 {									\
-	return get_fan(dev, buf, 0x##offset - 1);			\
+	return get_fan(dev, buf, offset - 1);				\
 }									\
 static ssize_t get_fan##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return get_fan_min(dev, buf, 0x##offset - 1);			\
+	return get_fan_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan##offset##_min (struct device *dev,		\
 		const char *buf, size_t count)				\
 {									\
-	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t get_fan##offset##_div (struct device *dev, char *buf)	\
 {									\
-	return get_fan_div(dev, buf, 0x##offset - 1);			\
+	return get_fan_div(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan##offset##_div (struct device *dev,		\
 		const char *buf, size_t count)				\
 {									\
-	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_div(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t get_pwm##offset (struct device *dev, char *buf)		\
 {									\
-	return get_pwm(dev, buf, 0x##offset - 1);			\
+	return get_pwm(dev, buf, offset - 1);				\
 }									\
 static ssize_t set_pwm##offset (struct device *dev,			\
 		const char *buf, size_t count)				\
 {									\
-	return set_pwm(dev, buf, count, 0x##offset - 1);		\
+	return set_pwm(dev, buf, count, offset - 1);			\
 }									\
 static ssize_t get_pwm##offset##_en (struct device *dev, char *buf)	\
 {									\
-	return get_pwm_en(dev, buf, 0x##offset - 1);			\
+	return get_pwm_en(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_pwm##offset##_en (struct device *dev,		\
 		const char *buf, size_t count)				\
 {									\
-	return set_pwm_en(dev, buf, count, 0x##offset - 1);		\
+	return set_pwm_en(dev, buf, count, offset - 1);			\
 }									\
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, get_fan##offset,	\
 		NULL);							\
Index: linux-2.6.9-rc2-bk6/drivers/i2c/chips/via686a.c
=================================--- linux-2.6.9-rc2-bk6.orig/drivers/i2c/chips/via686a.c	2004-09-20 23:09:38.000000000 -0400
+++ linux-2.6.9-rc2-bk6/drivers/i2c/chips/via686a.c	2004-09-22 23:58:02.337638978 -0400
@@ -383,27 +383,27 @@ static ssize_t set_in_max(struct device 
 static ssize_t 							\
 	show_in##offset (struct device *dev, char *buf)		\
 {								\
-	return show_in(dev, buf, 0x##offset);			\
+	return show_in(dev, buf, offset);			\
 }								\
 static ssize_t 							\
 	show_in##offset##_min (struct device *dev, char *buf)	\
 {								\
-	return show_in_min(dev, buf, 0x##offset);		\
+	return show_in_min(dev, buf, offset);		\
 }								\
 static ssize_t 							\
 	show_in##offset##_max (struct device *dev, char *buf)	\
 {								\
-	return show_in_max(dev, buf, 0x##offset);		\
+	return show_in_max(dev, buf, offset);		\
 }								\
 static ssize_t set_in##offset##_min (struct device *dev, 	\
 		const char *buf, size_t count) 			\
 {								\
-	return set_in_min(dev, buf, count, 0x##offset);		\
+	return set_in_min(dev, buf, count, offset);		\
 }								\
 static ssize_t set_in##offset##_max (struct device *dev,	\
 			const char *buf, size_t count)		\
 {								\
-	return set_in_max(dev, buf, count, 0x##offset);		\
+	return set_in_max(dev, buf, count, offset);		\
 }								\
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);\
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 	\
@@ -451,27 +451,27 @@ static ssize_t set_temp_hyst(struct devi
 #define show_temp_offset(offset)					\
 static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_temp(dev, buf, 0x##offset - 1);			\
+	return show_temp(dev, buf, offset - 1);				\
 }									\
 static ssize_t								\
 show_temp_##offset##_over (struct device *dev, char *buf)		\
 {									\
-	return show_temp_over(dev, buf, 0x##offset - 1);			\
+	return show_temp_over(dev, buf, offset - 1);			\
 }									\
 static ssize_t								\
 show_temp_##offset##_hyst (struct device *dev, char *buf)		\
 {									\
-	return show_temp_hyst(dev, buf, 0x##offset - 1);			\
+	return show_temp_hyst(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_temp_##offset##_over (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_temp_over(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_over(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_temp_##offset##_hyst (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_temp_hyst(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_hyst(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL);\
 static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
@@ -522,25 +522,25 @@ static ssize_t set_fan_div(struct device
 #define show_fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_fan(dev, buf, 0x##offset - 1);			\
+	return show_fan(dev, buf, offset - 1);				\
 }									\
 static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return show_fan_min(dev, buf, 0x##offset - 1);			\
+	return show_fan_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
 {									\
-	return show_fan_div(dev, buf, 0x##offset - 1);			\
+	return show_fan_div(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan_##offset##_min (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_fan_##offset##_div (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_div(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL);\
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
Index: linux-2.6.9-rc2-bk6/drivers/i2c/chips/w83627hf.c
=================================--- linux-2.6.9-rc2-bk6.orig/drivers/i2c/chips/w83627hf.c	2004-09-22 23:31:15.466021064 -0400
+++ linux-2.6.9-rc2-bk6/drivers/i2c/chips/w83627hf.c	2004-09-22 23:58:02.339638658 -0400
@@ -369,20 +369,20 @@ store_in_reg(MAX, max)
 static ssize_t \
 show_regs_in_##offset (struct device *dev, char *buf) \
 { \
-        return show_in(dev, buf, 0x##offset); \
+        return show_in(dev, buf, offset); \
 } \
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
 
 #define sysfs_in_reg_offset(reg, offset) \
 static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) \
 { \
-	return show_in_##reg (dev, buf, 0x##offset); \
+	return show_in_##reg (dev, buf, offset); \
 } \
 static ssize_t \
 store_regs_in_##reg##offset (struct device *dev, \
 			    const char *buf, size_t count) \
 { \
-	return store_in_##reg (dev, buf, count, 0x##offset); \
+	return store_in_##reg (dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(in##offset##_##reg, S_IRUGO| S_IWUSR, \
 		  show_regs_in_##reg##offset, store_regs_in_##reg##offset);
@@ -521,19 +521,19 @@ store_fan_min(struct device *dev, const 
 #define sysfs_fan_offset(offset) \
 static ssize_t show_regs_fan_##offset (struct device *dev, char *buf) \
 { \
-	return show_fan(dev, buf, 0x##offset); \
+	return show_fan(dev, buf, offset); \
 } \
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL);
 
 #define sysfs_fan_min_offset(offset) \
 static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf) \
 { \
-	return show_fan_min(dev, buf, 0x##offset); \
+	return show_fan_min(dev, buf, offset); \
 } \
 static ssize_t \
 store_regs_fan_min##offset (struct device *dev, const char *buf, size_t count) \
 { \
-	return store_fan_min(dev, buf, count, 0x##offset); \
+	return store_fan_min(dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
 		  show_regs_fan_min##offset, store_regs_fan_min##offset);
@@ -595,20 +595,20 @@ store_temp_reg(HYST, max_hyst);
 static ssize_t \
 show_regs_temp_##offset (struct device *dev, char *buf) \
 { \
-	return show_temp(dev, buf, 0x##offset); \
+	return show_temp(dev, buf, offset); \
 } \
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL);
 
 #define sysfs_temp_reg_offset(reg, offset) \
 static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf) \
 { \
-	return show_temp_##reg (dev, buf, 0x##offset); \
+	return show_temp_##reg (dev, buf, offset); \
 } \
 static ssize_t \
 store_regs_temp_##reg##offset (struct device *dev, \
 			      const char *buf, size_t count) \
 { \
-	return store_temp_##reg (dev, buf, count, 0x##offset); \
+	return store_temp_##reg (dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(temp##offset##_##reg, S_IRUGO| S_IWUSR, \
 		  show_regs_temp_##reg##offset, store_regs_temp_##reg##offset);
Index: linux-2.6.9-rc2-bk6/drivers/i2c/chips/w83781d.c
=================================--- linux-2.6.9-rc2-bk6.orig/drivers/i2c/chips/w83781d.c	2004-09-22 23:31:15.469020582 -0400
+++ linux-2.6.9-rc2-bk6/drivers/i2c/chips/w83781d.c	2004-09-22 23:58:02.342638178 -0400
@@ -318,18 +318,18 @@ store_in_reg(MAX, max);
 static ssize_t \
 show_regs_in_##offset (struct device *dev, char *buf) \
 { \
-        return show_in(dev, buf, 0x##offset); \
+        return show_in(dev, buf, offset); \
 } \
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
 
 #define sysfs_in_reg_offset(reg, offset) \
 static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) \
 { \
-	return show_in_##reg (dev, buf, 0x##offset); \
+	return show_in_##reg (dev, buf, offset); \
 } \
 static ssize_t store_regs_in_##reg##offset (struct device *dev, const char *buf, size_t count) \
 { \
-	return store_in_##reg (dev, buf, count, 0x##offset); \
+	return store_in_##reg (dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(in##offset##_##reg, S_IRUGO| S_IWUSR, show_regs_in_##reg##offset, store_regs_in_##reg##offset);
 
@@ -384,18 +384,18 @@ store_fan_min(struct device *dev, const 
 #define sysfs_fan_offset(offset) \
 static ssize_t show_regs_fan_##offset (struct device *dev, char *buf) \
 { \
-	return show_fan(dev, buf, 0x##offset); \
+	return show_fan(dev, buf, offset); \
 } \
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL);
 
 #define sysfs_fan_min_offset(offset) \
 static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf) \
 { \
-	return show_fan_min(dev, buf, 0x##offset); \
+	return show_fan_min(dev, buf, offset); \
 } \
 static ssize_t store_regs_fan_min##offset (struct device *dev, const char *buf, size_t count) \
 { \
-	return store_fan_min(dev, buf, count, 0x##offset); \
+	return store_fan_min(dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, show_regs_fan_min##offset, store_regs_fan_min##offset);
 
@@ -464,18 +464,18 @@ store_temp_reg(HYST, max_hyst);
 static ssize_t \
 show_regs_temp_##offset (struct device *dev, char *buf) \
 { \
-	return show_temp(dev, buf, 0x##offset); \
+	return show_temp(dev, buf, offset); \
 } \
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL);
 
 #define sysfs_temp_reg_offset(reg, offset) \
 static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf) \
 { \
-	return show_temp_##reg (dev, buf, 0x##offset); \
+	return show_temp_##reg (dev, buf, offset); \
 } \
 static ssize_t store_regs_temp_##reg##offset (struct device *dev, const char *buf, size_t count) \
 { \
-	return store_temp_##reg (dev, buf, count, 0x##offset); \
+	return store_temp_##reg (dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(temp##offset##_##reg, S_IRUGO| S_IWUSR, show_regs_temp_##reg##offset, store_regs_temp_##reg##offset);
 
-- 
Mark M. Hoffman
mhoffman@lightlink.com
