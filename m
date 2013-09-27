From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Fri, 27 Sep 2013 03:13:09 +0000
Subject: [lm-sensors] [PATCHv4 02/18] thermal: core: allow binding via .bind when tzp is present
Message-Id: <1380251605-3804-3-git-send-email-eduardo.valentin@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1380251605-3804-1-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1380251605-3804-1-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com
Cc: grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

This patch allows drivers register thermal zone devices
with thermal zone params and .bind callbacks. In this case,
it will use the .bind callback.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 8a94300..f7a9f4f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -247,7 +247,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
 		if (!pos->tzp && !pos->ops->bind)
 			continue;
 
-		if (!pos->tzp && pos->ops->bind) {
+		if (pos->ops->bind) {
 			ret = pos->ops->bind(pos, cdev);
 			if (ret)
 				print_bind_err_msg(pos, cdev, ret);
-- 
1.8.2.1.342.gfa7285d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
