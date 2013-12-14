From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Dec 2013 17:30:12 +0000
Subject: [lm-sensors] [PATCH 05/14] MAINTAINERS: Add myself as i8k maintainer
Message-Id: <1387042221-3671-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1387042221-3671-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1387042221-3671-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

I have a couple of Dell laptops running Linux, so I have a vested
interest to keep this driver supported.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 13c15c8..7bc4772 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2618,7 +2618,7 @@ S:	Maintained
 F:	drivers/platform/x86/dell-laptop.c
 
 DELL LAPTOP SMM DRIVER
-S:	Orphan
+M:	Guenter Roeck <linux@roeck-us.net>
 F:	drivers/char/i8k.c
 F:	include/uapi/linux/i8k.h
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
