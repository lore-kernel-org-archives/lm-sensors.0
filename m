From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 11 Jun 2012 19:41:07 +0000
Subject: [lm-sensors] [PATCH v4] hwmon: (coretemp) Improve support for TjMax detection on Atom CPUs
Message-Id: <1339443667-12377-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Atom CPUs don't have a register to retrieve TjMax. Detection so far was
incomplete. Use the X86 model ID to improve it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: Rearranged code to check tjmax table entries first.

v3: Reverted PCI code to avoid possible regressions. Run PCI code first,
    then override resulting value with table entry if one exists.
    Dropped entries for N2000 and D2000 CPUs as those all have a Tjmax of 100 C
    which we can detect separately based on the CPU model number.
    Dropped table entries for E6xx series, since the E6xx can not be
    distinguished from E6xxT using the model ID string (nor by any other means).

v2: Dropped PCI dependencies
    Fixed 330 and 230 detection (2 spaces between CPU and 330/230)
    Added support for Cedar Creek CPUs
    Declared atom_tjmax as __cpuinitconst


 drivers/hwmon/coretemp.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 928a3ec..3509b23 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -191,6 +191,24 @@ static ssize_t show_temp(struct device *dev,
 	return tdata->valid ? sprintf(buf, "%d\n", tdata->temp) : -EAGAIN;
 }
 
+struct tjmax {
+	char const *id;
+	int tjmax;
+};
+
+static struct tjmax __cpuinitconst tjmax_table[] = {
+	{ "CPU D410", 100000 },
+	{ "CPU D425", 100000 },
+	{ "CPU D510", 100000 },
+	{ "CPU D525", 100000 },
+	{ "CPU N450", 100000 },
+	{ "CPU N455", 100000 },
+	{ "CPU N470", 100000 },
+	{ "CPU N475", 100000 },
+	{ "CPU  230", 100000 },
+	{ "CPU  330", 125000 },
+};
+
 static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
 				  struct device *dev)
 {
@@ -202,6 +220,13 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
 	int err;
 	u32 eax, edx;
 	struct pci_dev *host_bridge;
+	int i;
+
+	/* explicit tjmax table entries override heuristics */
+	for (i = 0; i < ARRAY_SIZE(tjmax_table); i++) {
+		if (strstr(c->x86_model_id, tjmax_table[i].id))
+			return tjmax_table[i].tjmax;
+	}
 
 	/* Early chips have no MSR for TjMax */
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
