From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 28 Sep 2010 01:32:32 +0000
Subject: [lm-sensors] [PATCH v3] hwmon (coretemp): Fix build breakage if SMP
Message-Id: <1285637552-1058-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@elte.hu>, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>

Commit e40cc4bdfd4b89813f072f72bd9c7055814d3f0f introduced
a build breakage if CONFIG_SMP is undefined. This commit
fixes the problem.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
v2: Fix compile warning due to unused variable i if SMP is undefined
v3: include asm/smp.h instead of using ifdef CONFIG_SMP

 drivers/hwmon/coretemp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index baa842a..a23b17a 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -36,6 +36,7 @@
 #include <linux/pci.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
+#include <asm/smp.h>
 
 #define DRVNAME	"coretemp"
 
-- 
1.7.0.87.g0901d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
