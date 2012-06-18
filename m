From: "Jan Beulich" <JBeulich@suse.com>
Date: Mon, 18 Jun 2012 10:26:54 +0000
Subject: [lm-sensors] [PATCH] hwmon: struct x86_cpu_id arrays can be __initconst
Message-Id: <4FDF1E8E020000780008A655@nat28.tlf.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

... as being referenced from __init code only.

Signed-off-by: Jan Beulich <jbeulich@suse.com>

---
 drivers/hwmon/coretemp.c    |    2 +-
 drivers/hwmon/via-cputemp.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- 3.5-rc3/drivers/hwmon/coretemp.c
+++ 3.5-rc3-x86-hwmon-sections/drivers/hwmon/coretemp.c
@@ -764,7 +764,7 @@ static struct notifier_block coretemp_cp
 	.notifier_call = coretemp_cpu_callback,
 };
 
-static const struct x86_cpu_id coretemp_ids[] = {
+static const struct x86_cpu_id __initconst coretemp_ids[] = {
 	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_DTS },
 	{}
 };
--- 3.5-rc3/drivers/hwmon/via-cputemp.c
+++ 3.5-rc3-x86-hwmon-sections/drivers/hwmon/via-cputemp.c
@@ -309,7 +309,7 @@ static struct notifier_block via_cputemp
 	.notifier_call = via_cputemp_cpu_callback,
 };
 
-static const struct x86_cpu_id cputemp_ids[] = {
+static const struct x86_cpu_id __initconst cputemp_ids[] = {
 	{ X86_VENDOR_CENTAUR, 6, 0xa, }, /* C7 A */
 	{ X86_VENDOR_CENTAUR, 6, 0xd, }, /* C7 D */
 	{ X86_VENDOR_CENTAUR, 6, 0xf, }, /* Nano */




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
