From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 01 Jul 2013 16:16:29 +0000
Subject: [lm-sensors] [PATCH] hwmon: (coretemp) Atom CPUs don't support TjMax; no warning needed
Message-Id: <1372695389-691-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Display warning "Unable to read TjMax from CPU x" only if the CPU
is supposed to support it. This is not the case for the various Atom CPUs.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/coretemp.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index ade35cf..be58da1 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -317,6 +317,18 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
 	return tjmax;
 }
 
+static bool cpu_has_tjmax(struct cpuinfo_x86 *c)
+{
+	u8 model = c->x86_model;
+
+	return model > 0xe &&
+	       model != 0x1c &&
+	       model != 0x26 &&
+	       model != 0x27 &&
+	       model != 0x35 &&
+	       model != 0x36;
+}
+
 static int __cpuinit get_tjmax(struct cpuinfo_x86 *c, u32 id,
 			       struct device *dev)
 {
@@ -330,7 +342,7 @@ static int __cpuinit get_tjmax(struct cpuinfo_x86 *c, u32 id,
 	 */
 	err = rdmsr_safe_on_cpu(id, MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
 	if (err) {
-		if (c->x86_model > 0xe && c->x86_model != 0x1c)
+		if (cpu_has_tjmax(c))
 			dev_warn(dev, "Unable to read TjMax from CPU %u\n", id);
 	} else {
 		val = (eax >> 16) & 0xff;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
