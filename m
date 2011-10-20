From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 20 Oct 2011 07:08:27 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (w83627ehf) Uninline is_word_sized
Message-Id: <20111020090827.581b4ec7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Helper function is_word_sized has grown too much to be kept inline. It
was OK when there were only 6 word-sized registers but support for new
devices have made the list much longer. The function is also called
from more places than before.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/w83627ehf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.1-rc9.orig/drivers/hwmon/w83627ehf.c	2011-10-17 22:18:45.000000000 +0200
+++ linux-3.1-rc9/drivers/hwmon/w83627ehf.c	2011-10-17 22:25:22.000000000 +0200
@@ -316,7 +316,7 @@ static const char *const nct6776_temp_la
 
 #define NUM_REG_TEMP	ARRAY_SIZE(NCT6775_REG_TEMP)
 
-static inline int is_word_sized(u16 reg)
+static int is_word_sized(u16 reg)
 {
 	return ((((reg & 0xff00) = 0x100
 	      || (reg & 0xff00) = 0x200)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
