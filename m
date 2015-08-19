From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Aug 2015 16:06:12 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (pmbus) Use BIT macro
Message-Id: <1440000375-3036-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Using the BIT macro makes the code a little easier to read.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/lm25066.c  |   7 +-
 drivers/hwmon/pmbus/max34440.c |   9 ++-
 drivers/hwmon/pmbus/max8688.c  |  19 ++---
 drivers/hwmon/pmbus/pmbus.h    | 163 +++++++++++++++++++++--------------------
 drivers/hwmon/pmbus/zl6100.c   |  11 +--
 5 files changed, 107 insertions(+), 102 deletions(-)

diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index a26b1d1d9514..a3d912cd3b8d 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -19,6 +19,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -42,15 +43,15 @@ enum chips { lm25056, lm25063, lm25066, lm5064, lm5066 };
 #define LM25066_READ_AVG_IIN		0xde
 #define LM25066_READ_AVG_PIN		0xdf
 
-#define LM25066_DEV_SETUP_CL		(1 << 4)	/* Current limit */
+#define LM25066_DEV_SETUP_CL		BIT(4)	/* Current limit */
 
 /* LM25056 only */
 
 #define LM25056_VAUX_OV_WARN_LIMIT	0xe3
 #define LM25056_VAUX_UV_WARN_LIMIT	0xe4
 
-#define LM25056_MFR_STS_VAUX_OV_WARN	(1 << 1)
-#define LM25056_MFR_STS_VAUX_UV_WARN	(1 << 0)
+#define LM25056_MFR_STS_VAUX_OV_WARN	BIT(1)
+#define LM25056_MFR_STS_VAUX_UV_WARN	BIT(0)
 
 /* LM25063 only */
 
diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
index 7e930c3ce1ab..74a1f6f68fb3 100644
--- a/drivers/hwmon/pmbus/max34440.c
+++ b/drivers/hwmon/pmbus/max34440.c
@@ -19,6 +19,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -38,10 +39,10 @@ enum chips { max34440, max34441, max34446, max34460, max34461 };
 #define MAX34446_MFR_IOUT_AVG		0xe2
 #define MAX34446_MFR_TEMPERATURE_AVG	0xe3
 
-#define MAX34440_STATUS_OC_WARN		(1 << 0)
-#define MAX34440_STATUS_OC_FAULT	(1 << 1)
-#define MAX34440_STATUS_OT_FAULT	(1 << 5)
-#define MAX34440_STATUS_OT_WARN		(1 << 6)
+#define MAX34440_STATUS_OC_WARN		BIT(0)
+#define MAX34440_STATUS_OC_FAULT	BIT(1)
+#define MAX34440_STATUS_OT_FAULT	BIT(5)
+#define MAX34440_STATUS_OT_WARN		BIT(6)
 
 struct max34440_data {
 	int id;
diff --git a/drivers/hwmon/pmbus/max8688.c b/drivers/hwmon/pmbus/max8688.c
index f04454a42fdd..dd4883a19045 100644
--- a/drivers/hwmon/pmbus/max8688.c
+++ b/drivers/hwmon/pmbus/max8688.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -30,15 +31,15 @@
 #define MAX8688_MFR_TEMPERATURE_PEAK	0xd6
 #define MAX8688_MFG_STATUS		0xd8
 
-#define MAX8688_STATUS_OC_FAULT		(1 << 4)
-#define MAX8688_STATUS_OV_FAULT		(1 << 5)
-#define MAX8688_STATUS_OV_WARNING	(1 << 8)
-#define MAX8688_STATUS_UV_FAULT		(1 << 9)
-#define MAX8688_STATUS_UV_WARNING	(1 << 10)
-#define MAX8688_STATUS_UC_FAULT		(1 << 11)
-#define MAX8688_STATUS_OC_WARNING	(1 << 12)
-#define MAX8688_STATUS_OT_FAULT		(1 << 13)
-#define MAX8688_STATUS_OT_WARNING	(1 << 14)
+#define MAX8688_STATUS_OC_FAULT		BIT(4)
+#define MAX8688_STATUS_OV_FAULT		BIT(5)
+#define MAX8688_STATUS_OV_WARNING	BIT(8)
+#define MAX8688_STATUS_UV_FAULT		BIT(9)
+#define MAX8688_STATUS_UV_WARNING	BIT(10)
+#define MAX8688_STATUS_UC_FAULT		BIT(11)
+#define MAX8688_STATUS_OC_WARNING	BIT(12)
+#define MAX8688_STATUS_OT_FAULT		BIT(13)
+#define MAX8688_STATUS_OT_WARNING	BIT(14)
 
 static int max8688_read_word_data(struct i2c_client *client, int page, int reg)
 {
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index f1cb15cfc1c0..bfcb13bae34b 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -19,11 +19,12 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/regulator/driver.h>
-
 #ifndef PMBUS_H
 #define PMBUS_H
 
+#include <linux/bitops.h>
+#include <linux/regulator/driver.h>
+
 /*
  * Registers
  */
@@ -194,13 +195,13 @@ enum pmbus_regs {
 /*
  * OPERATION
  */
-#define PB_OPERATION_CONTROL_ON		(1<<7)
+#define PB_OPERATION_CONTROL_ON		BIT(7)
 
 /*
  * CAPABILITY
  */
-#define PB_CAPABILITY_SMBALERT		(1<<4)
-#define PB_CAPABILITY_ERROR_CHECK	(1<<7)
+#define PB_CAPABILITY_SMBALERT		BIT(4)
+#define PB_CAPABILITY_ERROR_CHECK	BIT(7)
 
 /*
  * VOUT_MODE
@@ -215,94 +216,94 @@ enum pmbus_regs {
 /*
  * Fan configuration
  */
-#define PB_FAN_2_PULSE_MASK		((1 << 0) | (1 << 1))
-#define PB_FAN_2_RPM			(1 << 2)
-#define PB_FAN_2_INSTALLED		(1 << 3)
-#define PB_FAN_1_PULSE_MASK		((1 << 4) | (1 << 5))
-#define PB_FAN_1_RPM			(1 << 6)
-#define PB_FAN_1_INSTALLED		(1 << 7)
+#define PB_FAN_2_PULSE_MASK		(BIT(0) | BIT(1))
+#define PB_FAN_2_RPM			BIT(2)
+#define PB_FAN_2_INSTALLED		BIT(3)
+#define PB_FAN_1_PULSE_MASK		(BIT(4) | BIT(5))
+#define PB_FAN_1_RPM			BIT(6)
+#define PB_FAN_1_INSTALLED		BIT(7)
 
 /*
  * STATUS_BYTE, STATUS_WORD (lower)
  */
-#define PB_STATUS_NONE_ABOVE		(1<<0)
-#define PB_STATUS_CML			(1<<1)
-#define PB_STATUS_TEMPERATURE		(1<<2)
-#define PB_STATUS_VIN_UV		(1<<3)
-#define PB_STATUS_IOUT_OC		(1<<4)
-#define PB_STATUS_VOUT_OV		(1<<5)
-#define PB_STATUS_OFF			(1<<6)
-#define PB_STATUS_BUSY			(1<<7)
+#define PB_STATUS_NONE_ABOVE		BIT(0)
+#define PB_STATUS_CML			BIT(1)
+#define PB_STATUS_TEMPERATURE		BIT(2)
+#define PB_STATUS_VIN_UV		BIT(3)
+#define PB_STATUS_IOUT_OC		BIT(4)
+#define PB_STATUS_VOUT_OV		BIT(5)
+#define PB_STATUS_OFF			BIT(6)
+#define PB_STATUS_BUSY			BIT(7)
 
 /*
  * STATUS_WORD (upper)
  */
-#define PB_STATUS_UNKNOWN		(1<<8)
-#define PB_STATUS_OTHER			(1<<9)
-#define PB_STATUS_FANS			(1<<10)
-#define PB_STATUS_POWER_GOOD_N		(1<<11)
-#define PB_STATUS_WORD_MFR		(1<<12)
-#define PB_STATUS_INPUT			(1<<13)
-#define PB_STATUS_IOUT_POUT		(1<<14)
-#define PB_STATUS_VOUT			(1<<15)
+#define PB_STATUS_UNKNOWN		BIT(8)
+#define PB_STATUS_OTHER			BIT(9)
+#define PB_STATUS_FANS			BIT(10)
+#define PB_STATUS_POWER_GOOD_N		BIT(11)
+#define PB_STATUS_WORD_MFR		BIT(12)
+#define PB_STATUS_INPUT			BIT(13)
+#define PB_STATUS_IOUT_POUT		BIT(14)
+#define PB_STATUS_VOUT			BIT(15)
 
 /*
  * STATUS_IOUT
  */
-#define PB_POUT_OP_WARNING		(1<<0)
-#define PB_POUT_OP_FAULT		(1<<1)
-#define PB_POWER_LIMITING		(1<<2)
-#define PB_CURRENT_SHARE_FAULT		(1<<3)
-#define PB_IOUT_UC_FAULT		(1<<4)
-#define PB_IOUT_OC_WARNING		(1<<5)
-#define PB_IOUT_OC_LV_FAULT		(1<<6)
-#define PB_IOUT_OC_FAULT		(1<<7)
+#define PB_POUT_OP_WARNING		BIT(0)
+#define PB_POUT_OP_FAULT		BIT(1)
+#define PB_POWER_LIMITING		BIT(2)
+#define PB_CURRENT_SHARE_FAULT		BIT(3)
+#define PB_IOUT_UC_FAULT		BIT(4)
+#define PB_IOUT_OC_WARNING		BIT(5)
+#define PB_IOUT_OC_LV_FAULT		BIT(6)
+#define PB_IOUT_OC_FAULT		BIT(7)
 
 /*
  * STATUS_VOUT, STATUS_INPUT
  */
-#define PB_VOLTAGE_UV_FAULT		(1<<4)
-#define PB_VOLTAGE_UV_WARNING		(1<<5)
-#define PB_VOLTAGE_OV_WARNING		(1<<6)
-#define PB_VOLTAGE_OV_FAULT		(1<<7)
+#define PB_VOLTAGE_UV_FAULT		BIT(4)
+#define PB_VOLTAGE_UV_WARNING		BIT(5)
+#define PB_VOLTAGE_OV_WARNING		BIT(6)
+#define PB_VOLTAGE_OV_FAULT		BIT(7)
 
 /*
  * STATUS_INPUT
  */
-#define PB_PIN_OP_WARNING		(1<<0)
-#define PB_IIN_OC_WARNING		(1<<1)
-#define PB_IIN_OC_FAULT			(1<<2)
+#define PB_PIN_OP_WARNING		BIT(0)
+#define PB_IIN_OC_WARNING		BIT(1)
+#define PB_IIN_OC_FAULT			BIT(2)
 
 /*
  * STATUS_TEMPERATURE
  */
-#define PB_TEMP_UT_FAULT		(1<<4)
-#define PB_TEMP_UT_WARNING		(1<<5)
-#define PB_TEMP_OT_WARNING		(1<<6)
-#define PB_TEMP_OT_FAULT		(1<<7)
+#define PB_TEMP_UT_FAULT		BIT(4)
+#define PB_TEMP_UT_WARNING		BIT(5)
+#define PB_TEMP_OT_WARNING		BIT(6)
+#define PB_TEMP_OT_FAULT		BIT(7)
 
 /*
  * STATUS_FAN
  */
-#define PB_FAN_AIRFLOW_WARNING		(1<<0)
-#define PB_FAN_AIRFLOW_FAULT		(1<<1)
-#define PB_FAN_FAN2_SPEED_OVERRIDE	(1<<2)
-#define PB_FAN_FAN1_SPEED_OVERRIDE	(1<<3)
-#define PB_FAN_FAN2_WARNING		(1<<4)
-#define PB_FAN_FAN1_WARNING		(1<<5)
-#define PB_FAN_FAN2_FAULT		(1<<6)
-#define PB_FAN_FAN1_FAULT		(1<<7)
+#define PB_FAN_AIRFLOW_WARNING		BIT(0)
+#define PB_FAN_AIRFLOW_FAULT		BIT(1)
+#define PB_FAN_FAN2_SPEED_OVERRIDE	BIT(2)
+#define PB_FAN_FAN1_SPEED_OVERRIDE	BIT(3)
+#define PB_FAN_FAN2_WARNING		BIT(4)
+#define PB_FAN_FAN1_WARNING		BIT(5)
+#define PB_FAN_FAN2_FAULT		BIT(6)
+#define PB_FAN_FAN1_FAULT		BIT(7)
 
 /*
  * CML_FAULT_STATUS
  */
-#define PB_CML_FAULT_OTHER_MEM_LOGIC	(1<<0)
-#define PB_CML_FAULT_OTHER_COMM		(1<<1)
-#define PB_CML_FAULT_PROCESSOR		(1<<3)
-#define PB_CML_FAULT_MEMORY		(1<<4)
-#define PB_CML_FAULT_PACKET_ERROR	(1<<5)
-#define PB_CML_FAULT_INVALID_DATA	(1<<6)
-#define PB_CML_FAULT_INVALID_COMMAND	(1<<7)
+#define PB_CML_FAULT_OTHER_MEM_LOGIC	BIT(0)
+#define PB_CML_FAULT_OTHER_COMM		BIT(1)
+#define PB_CML_FAULT_PROCESSOR		BIT(3)
+#define PB_CML_FAULT_MEMORY		BIT(4)
+#define PB_CML_FAULT_PACKET_ERROR	BIT(5)
+#define PB_CML_FAULT_INVALID_DATA	BIT(6)
+#define PB_CML_FAULT_INVALID_COMMAND	BIT(7)
 
 enum pmbus_sensor_classes {
 	PSC_VOLTAGE_IN = 0,
@@ -318,26 +319,26 @@ enum pmbus_sensor_classes {
 #define PMBUS_PAGES	32	/* Per PMBus specification */
 
 /* Functionality bit mask */
-#define PMBUS_HAVE_VIN		(1 << 0)
-#define PMBUS_HAVE_VCAP		(1 << 1)
-#define PMBUS_HAVE_VOUT		(1 << 2)
-#define PMBUS_HAVE_IIN		(1 << 3)
-#define PMBUS_HAVE_IOUT		(1 << 4)
-#define PMBUS_HAVE_PIN		(1 << 5)
-#define PMBUS_HAVE_POUT		(1 << 6)
-#define PMBUS_HAVE_FAN12	(1 << 7)
-#define PMBUS_HAVE_FAN34	(1 << 8)
-#define PMBUS_HAVE_TEMP		(1 << 9)
-#define PMBUS_HAVE_TEMP2	(1 << 10)
-#define PMBUS_HAVE_TEMP3	(1 << 11)
-#define PMBUS_HAVE_STATUS_VOUT	(1 << 12)
-#define PMBUS_HAVE_STATUS_IOUT	(1 << 13)
-#define PMBUS_HAVE_STATUS_INPUT	(1 << 14)
-#define PMBUS_HAVE_STATUS_TEMP	(1 << 15)
-#define PMBUS_HAVE_STATUS_FAN12	(1 << 16)
-#define PMBUS_HAVE_STATUS_FAN34	(1 << 17)
-#define PMBUS_HAVE_VMON		(1 << 18)
-#define PMBUS_HAVE_STATUS_VMON	(1 << 19)
+#define PMBUS_HAVE_VIN		BIT(0)
+#define PMBUS_HAVE_VCAP		BIT(1)
+#define PMBUS_HAVE_VOUT		BIT(2)
+#define PMBUS_HAVE_IIN		BIT(3)
+#define PMBUS_HAVE_IOUT		BIT(4)
+#define PMBUS_HAVE_PIN		BIT(5)
+#define PMBUS_HAVE_POUT		BIT(6)
+#define PMBUS_HAVE_FAN12	BIT(7)
+#define PMBUS_HAVE_FAN34	BIT(8)
+#define PMBUS_HAVE_TEMP		BIT(9)
+#define PMBUS_HAVE_TEMP2	BIT(10)
+#define PMBUS_HAVE_TEMP3	BIT(11)
+#define PMBUS_HAVE_STATUS_VOUT	BIT(12)
+#define PMBUS_HAVE_STATUS_IOUT	BIT(13)
+#define PMBUS_HAVE_STATUS_INPUT	BIT(14)
+#define PMBUS_HAVE_STATUS_TEMP	BIT(15)
+#define PMBUS_HAVE_STATUS_FAN12	BIT(16)
+#define PMBUS_HAVE_STATUS_FAN34	BIT(17)
+#define PMBUS_HAVE_VMON		BIT(18)
+#define PMBUS_HAVE_STATUS_VMON	BIT(19)
 
 enum pmbus_data_format { linear = 0, direct, vid };
 enum vrm_version { vr11 = 0, vr12 };
diff --git a/drivers/hwmon/pmbus/zl6100.c b/drivers/hwmon/pmbus/zl6100.c
index 819644121259..771802d7e20d 100644
--- a/drivers/hwmon/pmbus/zl6100.c
+++ b/drivers/hwmon/pmbus/zl6100.c
@@ -19,6 +19,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -44,16 +45,16 @@ struct zl6100_data {
 #define ZL6100_MFR_CONFIG		0xd0
 #define ZL6100_DEVICE_ID		0xe4
 
-#define ZL6100_MFR_XTEMP_ENABLE		(1 << 7)
+#define ZL6100_MFR_XTEMP_ENABLE		BIT(7)
 
 #define MFR_VMON_OV_FAULT_LIMIT		0xf5
 #define MFR_VMON_UV_FAULT_LIMIT		0xf6
 #define MFR_READ_VMON			0xf7
 
-#define VMON_UV_WARNING			(1 << 5)
-#define VMON_OV_WARNING			(1 << 4)
-#define VMON_UV_FAULT			(1 << 1)
-#define VMON_OV_FAULT			(1 << 0)
+#define VMON_UV_WARNING			BIT(5)
+#define VMON_OV_WARNING			BIT(4)
+#define VMON_UV_FAULT			BIT(1)
+#define VMON_OV_FAULT			BIT(0)
 
 #define ZL6100_WAIT_TIME		1000	/* uS	*/
 
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
