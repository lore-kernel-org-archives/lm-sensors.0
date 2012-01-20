From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Fri, 20 Jan 2012 18:04:37 +0000
Subject: [lm-sensors] [PATCH 2/2] fam15h_power: Increase output resolution
Message-Id: <20120120180437.GI24508@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


From: Andre Przywara <andre.przywara@amd.com>

On high CPU load the accumulating values in the running_avg_cap
register are very low (below 10), so averaging them too early leads
to unnecessary poor output resolution. Since we pretend to output
micro-Watt we better keep all the bits we have as long as possible.

Signed-off-by: Andre Przywara <andre.przywara@amd.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/hwmon/fam15h_power.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 930370d..b7494af 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -61,14 +61,14 @@ static ssize_t show_power(struct device *dev,
 				  REG_TDP_RUNNING_AVERAGE, &val);
 	running_avg_capture = (val >> 4) & 0x3fffff;
 	running_avg_capture = sign_extend32(running_avg_capture, 21);
-	running_avg_range = val & 0xf;
+	running_avg_range = (val & 0xf) + 1;
 
 	pci_bus_read_config_dword(f4->bus, PCI_DEVFN(PCI_SLOT(f4->devfn), 5),
 				  REG_TDP_LIMIT3, &val);
 
 	tdp_limit = val >> 16;
-	curr_pwr_watts = tdp_limit + data->base_tdp -
-		(s32)(running_avg_capture >> (running_avg_range + 1));
+	curr_pwr_watts = (tdp_limit + data->base_tdp) << running_avg_range;
+	curr_pwr_watts -= running_avg_capture;
 	curr_pwr_watts *= data->tdp_to_watts;
 
 	/*
@@ -78,7 +78,7 @@ static ssize_t show_power(struct device *dev,
 	 * scaling factor 1/(2^16).  For conversion we use
 	 * (10^6)/(2^16) = 15625/(2^10)
 	 */
-	curr_pwr_watts = (curr_pwr_watts * 15625) >> 10;
+	curr_pwr_watts = (curr_pwr_watts * 15625) >> (10 + running_avg_range);
 	return sprintf(buf, "%u\n", (unsigned int) curr_pwr_watts);
 }
 static DEVICE_ATTR(power1_input, S_IRUGO, show_power, NULL);
-- 
1.7.8.rc3




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
