From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Fri, 09 May 2008 04:55:27 +0000
Subject: [lm-sensors] [PATCH] ibmaem: Fix 64-bit division on 32-bit platforms
Message-Id: <20080509045527.GI16404@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080508180858.GM16078@tree.beaverton.ibm.com> <20080508163443.a1e9ffe7.akpm@linux-foundation.org>
In-Reply-To: <20080508163443.a1e9ffe7.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Thu, May 08, 2008 at 04:34:43PM -0700, Andrew Morton wrote:

> This driver is littered with 64-bit divides and doesn't link on i386.
> I'll make it depend on CONFIG_64BIT for now.

Oops, sorry, I didn't remember that one can't do 64-bit division on
i386.  The patch below fixes that.
---
ibmaem: Fix 64-bit division on 32-bit platforms

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/ibmaem.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index 22fa7d6..f808ca3 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -31,6 +31,7 @@
 #include <linux/idr.h>
 #include <linux/sched.h>
 #include <linux/platform_device.h>
+#include <linux/math64.h>
 
 #define REFRESH_INTERVAL	(HZ)
 #define IPMI_TIMEOUT		(30 * HZ)
@@ -864,9 +865,10 @@ static ssize_t aem_show_power(struct device *dev,
 	mutex_unlock(&data->lock);
 
 	time = timespec_to_ns(&a) - timespec_to_ns(&b);
-	time /= 1000;
+	time = div_u64(time, 1000);
 
-	return sprintf(buf, "%llu\n", (after - before) * 1000000000 / time);
+	return sprintf(buf, "%llu\n",
+		       div64_u64((after - before) * 1000000000, time));
 }
 
 /* Display energy use */

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
