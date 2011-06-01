From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 01 Jun 2011 15:50:46 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (coretemp) Fix TjMax detection for
Message-Id: <1306943446-6107-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Commit a321cedb12904114e2ba5041a3673ca24deb09c9 excludes CPU models 0xe, 0xf,
0x16, and 0x1a from TjMax temperature adjustment, even though several of those
CPUs are known to have TiMax other than 100 degrees C, and even though the code
in adjust_tjmax() explicitly handles those CPUs and points to a Web document
listing several of the affected CPU IDs.

Reinstate original TjMax adjustment if TjMax can not be determined using the
IA32_TEMPERATURE_TARGET register.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Huaxu Wan <huaxu.wan@linux.intel.com>
Cc: Carsten Emde <C.Emde@osadl.org>
Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Yong Wang <yong.y.wang@linux.intel.com>
Cc: Rudolf Marek <r.marek@assembler.cz>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
v2: Call adjust_tjmax() unconditionally if reading IA32_TEMPERATURE_TARGET
    failed or did not return a reasonable value for TjMax. 

Note: This patch is a candidate for -stable [ .35 to .39]

 drivers/hwmon/coretemp.c |   19 ++-----------------
 1 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 0eeff46..1680977 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -304,24 +304,9 @@ static int get_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 
 	/*
 	 * An assumption is made for early CPUs and unreadable MSR.
-	 * NOTE: the given value may not be correct.
+	 * NOTE: the calculated value may not be correct.
 	 */
-
-	switch (c->x86_model) {
-	case 0xe:
-	case 0xf:
-	case 0x16:
-	case 0x1a:
-		dev_warn(dev, "TjMax is assumed as 100 C!\n");
-		return 100000;
-	case 0x17:
-	case 0x1c:		/* Atom CPUs */
-		return adjust_tjmax(c, id, dev);
-	default:
-		dev_warn(dev, "CPU (model=0x%x) is not supported yet,"
-			" using default TjMax of 100C.\n", c->x86_model);
-		return 100000;
-	}
+	return adjust_tjmax(c, id, dev);
 }
 
 static void __devinit get_ucode_rev_on_cpu(void *edx)
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
