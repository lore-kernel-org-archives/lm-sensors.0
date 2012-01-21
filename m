From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sat, 21 Jan 2012 18:29:27 +0000
Subject: [lm-sensors] [PATCH] MAINTAINERS: Add hwmon entries for Wolfson
Message-Id: <1327170567-3728-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The actual driver code seems to have been lost in the shuffle.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 MAINTAINERS |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56818fe..6f148e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7384,6 +7384,7 @@ S:	Supported
 F:	Documentation/hwmon/wm83??
 F:	arch/arm/mach-s3c64xx/mach-crag6410*
 F:	drivers/leds/leds-wm83*.c
+F:	drivers/hwmon/wm83??-hwmon.c
 F:	drivers/input/misc/wm831x-on.c
 F:	drivers/input/touchscreen/wm831x-ts.c
 F:	drivers/input/touchscreen/wm97*.c
-- 
1.7.7.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
