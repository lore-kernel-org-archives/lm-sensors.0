From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 27 Oct 2012 16:41:00 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (w83627ehf) Detect current and voltage mode for thermal diodes
Message-Id: <1351356061-30514-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83627ehf.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 9c4af42..a30eb52 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -192,6 +192,7 @@ static const u16 W83627EHF_REG_TEMP_CONFIG[] = { 0, 0x152, 0x252, 0 };
 #define W83627EHF_REG_FANDIV2		0x4B
 #define W83627EHF_REG_VBAT		0x5D
 #define W83627EHF_REG_DIODE		0x59
+#define W83627EHF_REG_DIODE_2		0x5E
 #define W83627EHF_REG_SMI_OVT		0x4C
 
 /* NCT6775F has its own fan divider registers */
@@ -1912,6 +1913,11 @@ static inline void __devinit w83627ehf_init_device(struct w83627ehf_data *data,
 	case w83627uhg:
 		diode = 0x00;
 		break;
+	case nct6775:
+	case nct6776:
+		/* Select current vs. voltage mode */
+		diode = w83627ehf_read_value(data, W83627EHF_REG_DIODE_2) << 3;
+		break;
 	default:
 		diode = 0x70;
 	}
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
