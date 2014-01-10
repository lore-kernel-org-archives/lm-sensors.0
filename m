From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 10 Jan 2014 15:10:23 +0000
Subject: [lm-sensors] [PATCH-next] drivers/hwmon: remove new __cpuinit usage from coretemp.c
Message-Id: <1389366623-26552-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>

Commit da9e8c7a7b99b245c464ff45c7bde38a4b510019 ("hwmon: (coretemp)
Use PCI host bridge ID to identify CPU if necessary") added a new
instance of the __cpuinit macro usage.

We removed this a couple versions ago; we now want to remove
the compat no-op stubs.  Introducing new users is not what
we want to see at this point in time, as it will break once
the stubs are gone.

Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Patch based on today's linux-next tree, so if hwmon next content
 gets rebased, then the above commit ID will be invalidated; if it
 _does_ get rebased, then feel free to squash this fix into the orig.]

 drivers/hwmon/coretemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 6e0579e80538..f44549f7c445 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -197,7 +197,7 @@ struct tjmax_pci {
 	int tjmax;
 };
 
-static const struct tjmax_pci tjmax_pci_table[] __cpuinitconst = {
+static const struct tjmax_pci tjmax_pci_table[] = {
 	{ 0x0708, 110000 },	/* CE41x0 (Sodaville ) */
 	{ 0x0c72, 102000 },	/* Atom S1240 (Centerton) */
 	{ 0x0c73, 95000 },	/* Atom S1220 (Centerton) */
-- 
1.8.5.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
