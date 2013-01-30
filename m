From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Wed, 30 Jan 2013 10:21:27 +0000
Subject: [lm-sensors] [PATCH 1/2] ARM: ux500: rename ab8500 to abx500 for hwmon driver
Message-Id: <1359541288-6657-2-git-send-email-hongbo.zhang@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1359541288-6657-1-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1359541288-6657-1-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, khali@linux-fr.org, lm-sensors@lm-sensors.org, sameo@linux.intel.com
Cc: linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linaro-dev@lists.linaro.org, patches@linaro.org, linus.walleij@linaro.org, lee.jones@linaro.org, Hongbo Zhang <hongbo.zhang@linaro.org>

We are using a generic abx500 hwmon layer, so rename specific ab8500 to generic
abx500 for hwmon device and driver matching.

Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
---
 drivers/mfd/ab8500-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index e1650ba..579753f 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -922,7 +922,7 @@ static struct resource ab8505_iddet_resources[] = {
 
 static struct resource ab8500_temp_resources[] = {
 	{
-		.name  = "AB8500_TEMP_WARM",
+		.name  = "ABX500_TEMP_WARM",
 		.start = AB8500_INT_TEMP_WARM,
 		.end   = AB8500_INT_TEMP_WARM,
 		.flags = IORESOURCE_IRQ,
@@ -998,8 +998,8 @@ static struct mfd_cell abx500_common_devs[] = {
 		.of_compatible = "stericsson,ab8500-denc",
 	},
 	{
-		.name = "ab8500-temp",
-		.of_compatible = "stericsson,ab8500-temp",
+		.name = "abx500-temp",
+		.of_compatible = "stericsson,abx500-temp",
 		.num_resources = ARRAY_SIZE(ab8500_temp_resources),
 		.resources = ab8500_temp_resources,
 	},
-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
