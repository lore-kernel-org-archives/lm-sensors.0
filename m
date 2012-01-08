From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 16:23:32 +0000
Subject: [lm-sensors] [PATCH 09/17] drivers/hwmon/adt7411.c: fix checkpatch
Message-Id: <1326039820-11147-9-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

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
