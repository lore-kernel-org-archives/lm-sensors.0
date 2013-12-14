From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Dec 2013 17:30:13 +0000
Subject: [lm-sensors] [PATCH 06/14] i8k: Remove obsolete link to out-of-tree driver
Message-Id: <1387042221-3671-7-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1387042221-3671-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1387042221-3671-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Accessing the link returns a page not found error.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/char/i8k.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/i8k.c b/drivers/char/i8k.c
index ef56bb0..5b3682c 100644
--- a/drivers/char/i8k.c
+++ b/drivers/char/i8k.c
@@ -1,7 +1,5 @@
 /*
  * i8k.c -- Linux driver for accessing the SMM BIOS on Dell laptops.
- *	    See http://www.debian.org/~dz/i8k/ for more information
- *	    and for latest version of this driver.
  *
  * Copyright (C) 2001  Massimo Dal Zotto <dz@debian.org>
  *
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
