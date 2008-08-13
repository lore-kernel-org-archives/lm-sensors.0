From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Wed, 13 Aug 2008 22:51:48 +0000
Subject: [lm-sensors] [PATCH] coretemp: Recognize Nehalem CPUs
Message-Id: <20080813225147.GE28450@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Add in the CPUID for Nehalem chips.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/coretemp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 70239ac..9f2e423 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -416,7 +416,8 @@ static int __init coretemp_init(void)
 		/* check if family 6, models 0xe, 0xf, 0x16, 0x17 */
 		if ((c->cpuid_level < 0) || (c->x86 != 0x6) ||
 		    !((c->x86_model = 0xe) || (c->x86_model = 0xf) ||
-			(c->x86_model = 0x16) || (c->x86_model = 0x17))) {
+			(c->x86_model = 0x16) || (c->x86_model = 0x17) ||
+			(c->x86_model = 0x1A))) {
 
 			/* supported CPU not found, but report the unknown
 			   family 6 CPU */

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
