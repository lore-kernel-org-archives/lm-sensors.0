From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 06 Jun 2012 04:48:36 +0000
Subject: [lm-sensors] [PATCH v3 3/3] hwmon: (coretemp) Improve support for TjMax detection on Atom CPUs
Message-Id: <1338958116-6205-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Atom CPUs don't have a register to retrieve TjMax. Detection so far was
incomplete. Use the X86 model ID to improve it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Dropped PCI dependencies
    Fixed 330 and 230 detection (2 spaces between CPU and 330/230)
    Added support for Cedar Creek CPUs
    Declared atom_tjmax as __cpuinitconst

v3: Reverted PCI code to avoid possible regressions. Run PCI code first,
    then override resulting value with table entry if one exists.
    Dropped entries for N2000 and D2000 CPUs as those all have a Tjmax of 100 C
    which we can detect separately based on the CPU model number.
    Dropped table entries for E6xx series, since the E6xx can not be
    distinguished from E6xxT using the model ID string (nor by any other means).

 drivers/hwmon/coretemp.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 928a3ec..6bd8d23 100644
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
@@ -215,6 +233,8 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
 		tjmax = 100000;
 	} else if (c->x86_model = 0x1c || c->x86_model = 0x26
 		   || c->x86_model = 0x27) {
+		int i;
+
 		usemsr_ee = 0;
 		host_bridge = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
 
@@ -226,6 +246,14 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
 			tjmax = 90000;
 
 		pci_dev_put(host_bridge);
+
+		/* explicit table entries override heuristics */
+		for (i = 0; i < ARRAY_SIZE(tjmax_table); i++) {
+			if (strstr(c->x86_model_id, tjmax_table[i].id)) {
+				tjmax = tjmax_table[i].tjmax;
+				break;
+			}
+		}
 	}
 
 	if (c->x86_model > 0xe && usemsr_ee) {
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
