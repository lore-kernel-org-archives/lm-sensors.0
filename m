From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 31 May 2011 14:15:20 +0000
Subject: [lm-sensors] [PATCH RFC] hwmon: (coretemp) Fix TjMax detection for
Message-Id: <1306851320-7851-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Commit a321cedb12904114e2ba5041a3673ca24deb09c9 excludes CPU models 0xe, 0xf,
and 0x16 from TjMax temperature adjustment, even though several of those CPUs
are known to have TiMax other than 100 degrees C, and even though the code in
adjust_tjmax() explicitly handles those CPUs and points to a Web document
listing several of the affected CPU IDs.

Reinstate TjMax adjustment for CPUs with model ID 0xe, 0xf, and 0x16.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Huaxu Wan <huaxu.wan@linux.intel.com>
Cc: Carsten Emde <C.Emde@osadl.org>
Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Yong Wang <yong.y.wang@linux.intel.com>
Cc: Rudolf Marek <r.marek@assembler.cz>
---
Reason for sending this as RFC is that I don't know if the original change to
exclude the affected CPU IDs from adjustment was made on purpose or not. Please
let me know if you recall the reasons for this exclusion.

 drivers/hwmon/coretemp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index de3d246..897a257 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -308,12 +308,12 @@ static int get_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 	 */
 
 	switch (c->x86_model) {
-	case 0xe:
-	case 0xf:
-	case 0x16:
 	case 0x1a:
 		dev_warn(dev, "TjMax is assumed as 100 C!\n");
 		return 100000;
+	case 0xe:
+	case 0xf:
+	case 0x16:		/* Core 2 CPUs */
 	case 0x17:
 	case 0x1c:		/* Atom CPUs */
 		return adjust_tjmax(c, id, dev);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
