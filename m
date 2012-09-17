From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Mon, 17 Sep 2012 20:14:36 +0000
Subject: Re: [lm-sensors] [PATCH] applesmc: Bump max wait and rearrange udelay
Message-Id: <20120917201436.GA320@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120915225841.GA3816@roeck-us.net>
 <alpine.DEB.2.02.1209151918210.2271@ubuntu>
 <alpine.DEB.2.02.1209152323490.2088@ubuntu>
 <20120916043116.GA4477@roeck-us.net>
 <20120916093520.GA5623@polaris.bitmath.org>
 <alpine.DEB.2.02.1209161712070.14838@ubuntu>
 <20120916223003.GA2160@polaris.bitmath.org>
 <alpine.DEB.2.02.1209161957490.2808@ubuntu>
 <20120917162705.GA2854@polaris.bitmath.org>
 <20120917163722.GA1925@roeck-us.net>
In-Reply-To: <20120917163722.GA1925@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Parag Warudkar <parag.lkml@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, khali@linux-fr.org

> Any better/other ideas ? Is the problem that we have to increase the wait time,
> or is something else going on ?

No, it makes sense now that I got the right number of zeroes. ;-)

So, to be explicit, this is the patch I would like to go in. It is
completely safe, back-portable, and a no-brainer. Parag, are you ok
with being the author on this one?

Thanks,
Henrik

From 868fc42edcb3a338ce0a0334e2dc50b01a7f6844 Mon Sep 17 00:00:00 2001
From: Parag Warudkar <parag.lkml@gmail.com>
Date: Mon, 17 Sep 2012 17:49:55 +0200
Subject: [PATCH] applesmc: Bump max wait

A heavy-load test on a MacBookPro6,1 is still showing a substantial
amount of read errors.  Increasing the maximum wait time to 128 ms
resolves the issue.

maybe-Signed-off-by: Parag Warudkar <parag.lkml@gmail.com>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 2827088..8f3f6f2 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -53,10 +53,10 @@
 
 #define APPLESMC_MAX_DATA_LENGTH 32
 
-/* wait up to 32 ms for a status change. */
+/* wait up to 128 ms for a status change. */
 #define APPLESMC_MIN_WAIT	0x0010
 #define APPLESMC_RETRY_WAIT	0x0100
-#define APPLESMC_MAX_WAIT	0x8000
+#define APPLESMC_MAX_WAIT	0x20000
 
 #define APPLESMC_READ_CMD	0x10
 #define APPLESMC_WRITE_CMD	0x11
-- 
1.7.12


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
