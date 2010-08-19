From: "Fenghua Yu" <fenghua.yu@intel.com>
Date: Thu, 19 Aug 2010 17:28:16 +0000
Subject: [lm-sensors] [PATCH] MAINTAINERS: hwmon/coretemp: Change coretemp
Message-Id: <1282238896-23026-1-git-send-email-fenghua.yu@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, Rudolf Marek <r.marek@assembler.cz>, Huaxu Wan <huaxu.wan@intel.com>, H Peter Anvin <hpa@zytor.com>, Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Fenghua Yu <fenghua.yu@intel.com>

From: Fenghua Yu <fenghua.yu@intel.com>

Huaxu and Rudolf want me to be the hwmon coretemp driver maintainer and remove
their names from the coretemp maintainer entry.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Rudolf Marek <r.marek@assembler.cz>
Acked-by: Huaxu Wan <huaxu.wan@intel.com>
---
 MAINTAINERS |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5b8baa..ff0cd1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1665,8 +1665,7 @@ F:	kernel/cgroup*
 F:	mm/*cgroup*
 
 CORETEMP HARDWARE MONITORING DRIVER
-M:	Rudolf Marek <r.marek@assembler.cz>
-M:	Huaxu Wan <huaxu.wan@intel.com>
+M:	Fenghua Yu <fenghua.yu@intel.com>
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
 F:	Documentation/hwmon/coretemp
-- 
1.6.0.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
