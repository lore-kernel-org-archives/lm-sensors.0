From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 04 Jun 2012 23:32:28 +0000
Subject: [lm-sensors] [RFC PATCH 1/2] hwmon: (coretemp) Add support for Atom D2000 and N2000 series CPU model
Message-Id: <1338852749-5564-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Document the Atom series D2000 and N2000 (Cedar Trail) as being supported,
and list TjMax for those series.

Also enable the Atom tjmax heuristic for these Atom CPU models.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This patch applies on top of Jean's patch to add Tunnel Creek and Medfield
support.

Found references to Cedar Trail while verifying the Atom detection patch.
No idea if the detection code is really needed, or if those CPUs support
the TjMax register. Does anyone know ?

 Documentation/hwmon/coretemp |    5 ++++-
 drivers/hwmon/coretemp.c     |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
index 3d7f2d7..015dfd4 100644
--- a/Documentation/hwmon/coretemp
+++ b/Documentation/hwmon/coretemp
@@ -7,7 +7,8 @@ Supported chips:
     CPUID: family 0x6, models 0xe (Pentium M DC), 0xf (Core 2 DC 65nm),
                               0x16 (Core 2 SC 65nm), 0x17 (Penryn 45nm),
                               0x1a (Nehalem), 0x1c (Atom), 0x1e (Lynnfield),
-                              0x26 (Tunnel Creek Atom), 0x27 (Medfield Atom)
+                              0x26 (Tunnel Creek Atom), 0x27 (Medfield Atom),
+			      0x36 (Cedar Trail)
     Datasheet: Intel 64 and IA-32 Architectures Software Developer's Manual
                Volume 3A: System Programming Guide
                http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
@@ -88,6 +89,8 @@ Process		Processor					TjMax(C)
 		330/230						125
 		E680/660/640/620				90
 		E680T/660T/640T/620T				110
+		D2500/2550/2700					100
+		N2600/2650/2800/2850				100
 
 45nm		Core2 Processors
 		Solo ULV SU3500/3300				100
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 495add5..07160126 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -211,7 +211,7 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
 	/* Atom CPUs */
 
 	if (c->x86_model = 0x1c || c->x86_model = 0x26
-	    || c->x86_model = 0x27) {
+	    || c->x86_model = 0x27 || c->x86_model = 0x36) {
 		usemsr_ee = 0;
 
 		host_bridge = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
