From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:56:00 +0000
Subject: [lm-sensors] [PATCH 66/82] hwmon: (tmp102) Fix multi-line comments
Message-Id: <1327017376-20466-67-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/tmp102.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index c08eee2..f4985b7 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -1,4 +1,5 @@
-/* Texas Instruments TMP102 SMBus temperature sensor driver
+/*
+ * Texas Instruments TMP102 SMBus temperature sensor driver
  *
  * Copyright (C) 2010 Steven King <sfking@fdwdc.com>
  *
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
