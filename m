From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 05 Aug 2013 07:30:46 +0000
Subject: [lm-sensors] [PATCH] hwmon: (emc6w201) Staticize enum 'subfeature'
Message-Id: <001c01ce91ad$b3972580$1ac57080$@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The enum 'subfeature' is used only in this file.
Fix the following sparse warning:

drivers/hwmon/emc6w201.c:52:26: warning: symbol 'subfeature' was not declared. Should it be static?

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/emc6w201.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
index 936898f..2aa5bc3 100644
--- a/drivers/hwmon/emc6w201.c
+++ b/drivers/hwmon/emc6w201.c
@@ -49,7 +49,7 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 #define EMC6W201_REG_TEMP_HIGH(nr)	(0x57 + (nr) * 2)
 #define EMC6W201_REG_FAN_MIN(nr)	(0x62 + (nr) * 2)
 
-enum { input, min, max } subfeature;
+static enum { input, min, max } subfeature;
 
 /*
  * Per-device data
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
