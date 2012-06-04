From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 04 Jun 2012 16:37:31 +0000
Subject: [lm-sensors] [PATCH RFC] hwmon: (coretemp) Improve support for TjMax detection on Atom CPUs
Message-Id: <1338827851-702-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Atom CPUs don't have a register to retrieve TjMax. Detection so far is
incomplete. Use the X86 model ID to improve it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Wonder if we can improve TjMax detection for Atom CPUs with this code.
Anyone with Atom CPUs out there for some testing ?

 drivers/hwmon/coretemp.c |   44 ++++++++++++++++++++++++++++++++------------
 1 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index b9d5123..9689a0d 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -191,6 +191,29 @@ static ssize_t show_temp(struct device *dev,
 	return tdata->valid ? sprintf(buf, "%d\n", tdata->temp) : -EAGAIN;
 }
 
+struct tjmax {
+    	char const *id;
+	int tjmax;
+};
+
+static struct tjmax atom_tjmax[] = {
+	{ "CPU D410", 100000 },
+	{ "CPU D425", 100000 },
+	{ "CPU D510", 100000 },
+	{ "CPU D525", 100000 },
+	{ "CPU N450", 100000 },
+	{ "CPU N455", 100000 },
+	{ "CPU N470", 100000 },
+	{ "CPU N475", 100000 },
+	{ "CPU 230", 100000 },
+	{ "CPU 330", 125000 },
+	{ "CPU E620T", 110000 },
+	{ "CPU E640T", 110000 },
+	{ "CPU E660T", 110000 },
+	{ "CPU E680T", 110000 },
+	{ },
+};
+
 static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
 				  struct device *dev)
 {
@@ -201,7 +224,6 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
 	int usemsr_ee = 1;
 	int err;
 	u32 eax, edx;
-	struct pci_dev *host_bridge;
 
 	/* Early chips have no MSR for TjMax */
 
@@ -211,18 +233,16 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
 	/* Atom CPUs */
 
 	if (c->x86_model = 0x1c) {
-		usemsr_ee = 0;
+		struct tjmax *tj;
 
-		host_bridge = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
-
-		if (host_bridge && host_bridge->vendor = PCI_VENDOR_ID_INTEL
-		    && (host_bridge->device = 0xa000	/* NM10 based nettop */
-		    || host_bridge->device = 0xa010))	/* NM10 based netbook */
-			tjmax = 100000;
-		else
-			tjmax = 90000;
-
-		pci_dev_put(host_bridge);
+		usemsr_ee = 0;
+		tjmax = 90000;
+		for (tj = atom_tjmax; tj->tjmax; tj++) {
+			if (strstr(c->x86_model_id, tj->id)) {
+				tjmax = tj->tjmax;
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
