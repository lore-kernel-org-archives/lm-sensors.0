From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 18:34:12 +0000
Subject: [lm-sensors] [PATCH 09/17 v2] hwmon: (adt7411) fix checkpatch issues
Message-Id: <1326047660-20539-9-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fixed:
WARNING: please, no space before tabs
#11: FILE: adt7411.c:11:
+ * ^I  use power-down mode for suspend?, interrupt handling?$

not fixed as all other macros around it are the same structure and this one is only 2 chars longer:
WARNING: line over 80 characters
#229: FILE: adt7411.c:229:
+static ADT7411_BIT_ATTR(fast_sampling, ADT7411_REG_CFG3, ADT7411_CFG3_ADC_CLK_225);

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/adt7411.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index 5cc3e37..dae6d8c 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -8,7 +8,7 @@
  *  published by the Free Software Foundation.
  *
  *  TODO: SPI, support for external temperature sensor
- * 	  use power-down mode for suspend?, interrupt handling?
+ *	  use power-down mode for suspend?, interrupt handling?
  */
 
 #include <linux/kernel.h>
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
