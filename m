From: Gioh Kim <gi-oh.kim@profitbricks.com>
Date: Mon, 25 Jan 2016 11:41:07 +0000
Subject: [lm-sensors] [RFC] hwmon: (fam15h_power) Add bit masking for tdp_limit
Message-Id: <1453722067-6747-1-git-send-email-gi-oh.kim@profitbricks.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ray.huang@amd.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: Gioh Kim <gi-oh.kim@profitbricks.com>

The bits [31:29] of D18F5xE8 TDP Limit3 are reserved.
I think it'd better to add masking to read ApmTdpLimit[28:16] precisely.

Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
---
 drivers/hwmon/fam15h_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index f77eb97..f9647c8 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -90,7 +90,7 @@ static ssize_t show_power(struct device *dev,
 	pci_bus_read_config_dword(f4->bus, PCI_DEVFN(PCI_SLOT(f4->devfn), 5),
 				  REG_TDP_LIMIT3, &val);
 
-	tdp_limit = val >> 16;
+	tdp_limit = (val >> 16) & 0x1fff;
 	curr_pwr_watts = ((u64)(tdp_limit +
 				data->base_tdp)) << running_avg_range;
 	curr_pwr_watts -= running_avg_capture;
-- 
2.5.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
