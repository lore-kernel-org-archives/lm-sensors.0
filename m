From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Thu, 14 Aug 2008 01:36:35 +0000
Subject: [lm-sensors] [PATCH v2] coretemp: Recognize Nehalem CPUs
Message-Id: <20080814013635.GF28450@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080813225147.GE28450@tree.beaverton.ibm.com> <20080814011100.GB14828@wliu-linux.bj.intel.com>
In-Reply-To: <20080814011100.GB14828@wliu-linux.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kent Liu <kent.liu@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Add in the CPUID for Nehalem chips.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/coretemp.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 70239ac..93c1722 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -413,10 +413,11 @@ static int __init coretemp_init(void)
 	for_each_online_cpu(i) {
 		struct cpuinfo_x86 *c = &cpu_data(i);
 
-		/* check if family 6, models 0xe, 0xf, 0x16, 0x17 */
+		/* check if family 6, models 0xe, 0xf, 0x16, 0x17, 0x1A */
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
