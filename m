From: Gioh Kim <gi-oh.kim@profitbricks.com>
Date: Wed, 27 Jan 2016 11:02:09 +0000
Subject: [lm-sensors] [PATCH] hwmon: (fam15h_power) Add bit masking for tdp_limit
Message-Id: <1453892529-17120-1-git-send-email-gi-oh.kim@profitbricks.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ray.huang@amd.com
Cc: linux@roeck-us.net, bp@alien8.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Gioh Kim <gi-oh.kim@profitbricks.com>

Add bit masking to read ApmTdpLimit precisely

Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
---
 drivers/hwmon/fam15h_power.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index f77eb97..4f695d8 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -90,7 +90,15 @@ static ssize_t show_power(struct device *dev,
 	pci_bus_read_config_dword(f4->bus, PCI_DEVFN(PCI_SLOT(f4->devfn), 5),
 				  REG_TDP_LIMIT3, &val);
 
-	tdp_limit = val >> 16;
+	/*
+	 * On Carrizo and later platforms, ApmTdpLimit bit field
+	 * is extended to 16:31 from 16:28.
+	 */
+	if (boot_cpu_data.x86 = 0x15 && boot_cpu_data.x86_model >= 0x60)
+		tdp_limit = val >> 16;
+	else
+		tdp_limit = (val >> 16) & 0x1fff;
+
 	curr_pwr_watts = ((u64)(tdp_limit +
 				data->base_tdp)) << running_avg_range;
 	curr_pwr_watts -= running_avg_capture;
-- 
2.5.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
