From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 May 2013 03:48:35 +0000
Subject: [lm-sensors] [PATCH] MAINTAINERS: Add myself as maintainer for LM95234 and TMP401 drivers
Message-Id: <1369021715-31502-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365023631-9279-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1365023631-9279-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors <lm-sensors@lm-sensors.org>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

I wrote the LM95234 driver and extended the TMP401 driver substantially,
and I have hardware to test both, so it makes sense to explicitly
maintain them.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 MAINTAINERS |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d7782b..f0f3d20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4976,6 +4976,13 @@ S:	Maintained
 F:	Documentation/hwmon/lm90
 F:	drivers/hwmon/lm90.c
 
+LM95234 HARDWARE MONITOR DRIVER
+M:	Guenter Roeck <linux@roeck-us.net>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	Documentation/hwmon/lm95234
+F:	drivers/hwmon/lm95234.c
+
 LME2510 MEDIA DRIVER
 M:	Malcolm Priestley <tvboxspy@gmail.com>
 L:	linux-media@vger.kernel.org
@@ -8182,6 +8189,13 @@ F:	drivers/mmc/host/sh_mobile_sdhi.c
 F:	include/linux/mmc/tmio.h
 F:	include/linux/mmc/sh_mobile_sdhi.h
 
+TMP401 HARDWARE MONITOR DRIVER
+M:	Guenter Roeck <linux@roeck-us.net>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	Documentation/hwmon/tmp401
+F:	drivers/hwmon/tmp401.c
+
 TMPFS (SHMEM FILESYSTEM)
 M:	Hugh Dickins <hughd@google.com>
 L:	linux-mm@kvack.org
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
