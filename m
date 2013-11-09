From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 09 Nov 2013 17:51:08 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (coretemp) Add PCI device ID for CE41x0 CPUs
Message-Id: <1384019469-18666-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1384019469-18666-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1384019469-18666-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Fenghua Yu <fenghua.yu@intel.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Since we now have to use PCI IDs to detect CPU types anyway, use this mechanism
to detect CE41x0 CPUs. Advantage is that it only requires a single entry and
covers all variants of CE41x0, including those unknown to us.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/coretemp.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5c8ab25..cde4e47 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -197,6 +197,7 @@ struct tjmax_pci {
 };
 
 static const struct tjmax_pci tjmax_pci_table[] __cpuinitconst = {
+	{ 0x0708, 110000 },	/* CE41x0 (Sodaville ) */
 	{ 0x0c72, 102000 },	/* Atom S1240 (Centerton) */
 	{ 0x0c73, 95000 },	/* Atom S1220 (Centerton) */
 	{ 0x0c75, 95000 },	/* Atom S1260 (Centerton) */
@@ -210,9 +211,6 @@ struct tjmax {
 static const struct tjmax tjmax_table[] = {
 	{ "CPU  230", 100000 },		/* Model 0x1c, stepping 2	*/
 	{ "CPU  330", 125000 },		/* Model 0x1c, stepping 2	*/
-	{ "CPU CE4110", 110000 },	/* Model 0x1c, stepping 10 Sodaville */
-	{ "CPU CE4150", 110000 },	/* Model 0x1c, stepping 10	*/
-	{ "CPU CE4170", 110000 },	/* Model 0x1c, stepping 10	*/
 };
 
 struct tjmax_model {
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
