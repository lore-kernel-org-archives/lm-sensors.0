From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 09 Sep 2007 15:35:34 +0000
Subject: [lm-sensors] [PATCH] thmc50: fixed alarms clearing
Message-Id: <20070909173534.844e24c7.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch make use the interrupt status register instead
of the interrupt status mirror register. Reading of the mirror
register does not clear alarms.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This is just register change (THMC50_REG_INTR_MIRROR
to THMC50_REG_INTR).

diff -urp linux-sparc/drivers/hwmon/thmc50.c linux-2.6.23/drivers/hwmon/thmc50.c
--- linux-sparc/drivers/hwmon/thmc50.c	2007-09-09 17:29:09.647462670 +0200
+++ linux-2.6.23/drivers/hwmon/thmc50.c	2007-09-09 17:25:51.996199166 +0200
@@ -47,10 +47,10 @@ I2C_CLIENT_MODULE_PARM(adm1022_temp3, "L
 #define THMC50_REG_DIE_CODE			0x3F
 #define THMC50_REG_ANALOG_OUT			0x19
 /*
- * We use mirror status register for reading alarms
- * so ACPI can use the primary status register.
+ * The mirror status register cannot be used as
+ * reading it does not clear alarms.
  */
-#define THMC50_REG_INTR_MIRROR			0x4C
+#define THMC50_REG_INTR				0x41
 
 const static u8 THMC50_REG_TEMP[] = { 0x27, 0x26, 0x20 };
 const static u8 THMC50_REG_TEMP_MIN[] = { 0x3A, 0x38, 0x2C };
@@ -459,7 +459,7 @@ static struct thmc50_data *thmc50_update
 		data->analog_out  		    i2c_smbus_read_byte_data(client, THMC50_REG_ANALOG_OUT);
 		data->alarms -		    i2c_smbus_read_byte_data(client, THMC50_REG_INTR_MIRROR);
+		    i2c_smbus_read_byte_data(client, THMC50_REG_INTR);
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
