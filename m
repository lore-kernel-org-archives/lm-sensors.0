From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:22 +0000
Subject: [lm-sensors] [PATCH 28/82] hwmon: (hwmon-vid) Fix multi-line comments
Message-Id: <1327017376-20466-29-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/hwmon-vid.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
index 4fcb867..4029ac6 100644
--- a/drivers/hwmon/hwmon-vid.c
+++ b/drivers/hwmon/hwmon-vid.c
@@ -40,7 +40,7 @@
  * available at http://developer.intel.com/.
  *
  * AMD Athlon 64 and AMD Opteron Processors, AMD Publication 26094,
- * http://support.amd.com/us/Processor_TechDocs/26094.PDF 
+ * http://support.amd.com/us/Processor_TechDocs/26094.PDF
  * Table 74. VID Code Voltages
  * This corresponds to an arbitrary VRM code of 24 in the functions below.
  * These CPU models (K8 revision <= E) have 5 VID pins. See also:
@@ -185,10 +185,12 @@ struct vrm_model {
 static struct vrm_model vrm_models[] = {
 	{X86_VENDOR_AMD, 0x6, ANY, ANY, 90},		/* Athlon Duron etc */
 	{X86_VENDOR_AMD, 0xF, 0x3F, ANY, 24},		/* Athlon 64, Opteron */
-	/* In theory, all NPT family 0Fh processors have 6 VID pins and should
-	   thus use vrm 25, however in practice not all mainboards route the
-	   6th VID pin because it is never needed. So we use the 5 VID pin
-	   variant (vrm 24) for the models which exist today. */
+	/*
+	 * In theory, all NPT family 0Fh processors have 6 VID pins and should
+	 * thus use vrm 25, however in practice not all mainboards route the
+	 * 6th VID pin because it is never needed. So we use the 5 VID pin
+	 * variant (vrm 24) for the models which exist today.
+	 */
 	{X86_VENDOR_AMD, 0xF, 0x7F, ANY, 24},		/* NPT family 0Fh */
 	{X86_VENDOR_AMD, 0xF, ANY, ANY, 25},		/* future fam. 0Fh */
 	{X86_VENDOR_AMD, 0x10, ANY, ANY, 25},		/* NPT family 10h */
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
