From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 09 Sep 2007 14:50:36 +0000
Subject: [lm-sensors] [GIT PATCH] hwmon update against v2.6.23-rc5-git1
Message-Id: <20070909145036.GC31992@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Linus:

Please pull from:
	git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git release

You will get one patch (below), which fixes a potential regression from v2.6.22
(although AFAIK there have been no reports about this one.)

commit 15bde2f1a8e819213f54314505a5a0509673109b
Author: Jean Delvare <khali@linux-fr.org>
Date:   Wed Aug 29 10:39:57 2007 +0200

    hwmon: End of I/O region off-by-one
    
    Fix an off-by-one error in the I/O region declaration of two
    hardware monitoring drivers (lm78 and w83781d.) We were requesting
    one extra port at the end of the region.
    
    Signed-off-by: Jean Delvare <khali@linux-fr.org>
    Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 565c4e6..6eea347 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -882,7 +882,7 @@ static int __init lm78_isa_device_add(unsigned short address)
 {
        struct resource res = {
                .start  = address,
-               .end    = address + LM78_EXTENT,
+               .end    = address + LM78_EXTENT - 1,
                .name   = "lm78",
                .flags  = IORESOURCE_IO,
        };
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index c95909c..dcc941a 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -1746,7 +1746,7 @@ w83781d_isa_device_add(unsigned short address)
 {
        struct resource res = {
                .start  = address,
-               .end    = address + W83781D_EXTENT,
+               .end    = address + W83781D_EXTENT - 1,
                .name   = "w83781d",
                .flags  = IORESOURCE_IO,
        };

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
