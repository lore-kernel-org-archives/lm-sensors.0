From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 30 Nov 2014 21:00:38 +0000
Subject: [lm-sensors] [PATCH 1/3] MAINTAINERS: Fix up entry for Dell laptop SMM driver
Message-Id: <1417381240-7641-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Mark driver as maintained.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ff630d..a67e223 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2918,6 +2918,7 @@ F:	drivers/platform/x86/dell-laptop.c
 
 DELL LAPTOP SMM DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
+S:	Maintained
 F:	drivers/char/i8k.c
 F:	include/uapi/linux/i8k.h
 
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
