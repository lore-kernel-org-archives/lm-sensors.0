From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 26 Apr 2008 14:28:27 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adt7473) Remove unused defines
Message-Id: <20080426162827.5694c65a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All the *_MAX_ADDR defines are never used, so remove them. The number
of registers of each type is already expressed by the *_COUNT defines.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Darrick J. Wong <djwong@us.ibm.com>
---
 drivers/hwmon/adt7473.c |   13 -------------
 1 file changed, 13 deletions(-)

--- linux-2.6.26-rc0.orig/drivers/hwmon/adt7473.c	2008-04-26 15:34:04.000000000 +0200
+++ linux-2.6.26-rc0/drivers/hwmon/adt7473.c	2008-04-26 15:36:41.000000000 +0200
@@ -39,32 +39,20 @@ I2C_CLIENT_INSMOD_1(adt7473);
 #define ADT7473_REG_BASE_ADDR			0x20
 
 #define ADT7473_REG_VOLT_BASE_ADDR		0x21
-#define ADT7473_REG_VOLT_MAX_ADDR		0x22
 #define ADT7473_REG_VOLT_MIN_BASE_ADDR		0x46
-#define ADT7473_REG_VOLT_MIN_MAX_ADDR		0x49
 
 #define ADT7473_REG_TEMP_BASE_ADDR		0x25
-#define ADT7473_REG_TEMP_MAX_ADDR		0x27
 #define ADT7473_REG_TEMP_LIMITS_BASE_ADDR	0x4E
-#define ADT7473_REG_TEMP_LIMITS_MAX_ADDR	0x53
 #define ADT7473_REG_TEMP_TMIN_BASE_ADDR		0x67
-#define ADT7473_REG_TEMP_TMIN_MAX_ADDR		0x69
 #define ADT7473_REG_TEMP_TMAX_BASE_ADDR		0x6A
-#define ADT7473_REG_TEMP_TMAX_MAX_ADDR		0x6C
 
 #define ADT7473_REG_FAN_BASE_ADDR		0x28
-#define ADT7473_REG_FAN_MAX_ADDR		0x2F
 #define ADT7473_REG_FAN_MIN_BASE_ADDR		0x54
-#define ADT7473_REG_FAN_MIN_MAX_ADDR		0x5B
 
 #define ADT7473_REG_PWM_BASE_ADDR		0x30
-#define ADT7473_REG_PWM_MAX_ADDR		0x32
 #define	ADT7473_REG_PWM_MIN_BASE_ADDR		0x64
-#define ADT7473_REG_PWM_MIN_MAX_ADDR		0x66
 #define ADT7473_REG_PWM_MAX_BASE_ADDR		0x38
-#define ADT7473_REG_PWM_MAX_MAX_ADDR		0x3A
 #define ADT7473_REG_PWM_BHVR_BASE_ADDR		0x5C
-#define ADT7473_REG_PWM_BHVR_MAX_ADDR		0x5E
 #define		ADT7473_PWM_BHVR_MASK		0xE0
 #define		ADT7473_PWM_BHVR_SHIFT		5
 
@@ -102,7 +90,6 @@ I2C_CLIENT_INSMOD_1(adt7473);
 #define		ADT7473_FAN4_ALARM		0x20
 #define		ADT7473_R1T_SHORT		0x40
 #define		ADT7473_R2T_SHORT		0x80
-#define ADT7473_REG_MAX_ADDR			0x80
 
 #define ALARM2(x)	((x) << 8)
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
