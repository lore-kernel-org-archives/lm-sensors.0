From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Fri, 20 Jan 2012 18:00:07 +0000
Subject: [lm-sensors] [PATCH 1/2] fam15h_power: Correct sign extension of running_avg_capture
Message-Id: <20120120180007.GH24508@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fam15h_power: Correct sign extension of running_avg_capture

Wrong bit was used for sign extension which caused wrong end results.
Thanks to Andre for spotting this bug.

Reported-by: Andre Przywara <andre.przywara@amd.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---

Hi Jean,

Here are two patches for the fam15h power driver.

Please apply.


Thanks,
Andreas


 drivers/hwmon/fam15h_power.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 523f8fb..930370d 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -60,7 +60,7 @@ static ssize_t show_power(struct device *dev,
 	pci_bus_read_config_dword(f4->bus, PCI_DEVFN(PCI_SLOT(f4->devfn), 5),
 				  REG_TDP_RUNNING_AVERAGE, &val);
 	running_avg_capture = (val >> 4) & 0x3fffff;
-	running_avg_capture = sign_extend32(running_avg_capture, 22);
+	running_avg_capture = sign_extend32(running_avg_capture, 21);
 	running_avg_range = val & 0xf;
 
 	pci_bus_read_config_dword(f4->bus, PCI_DEVFN(PCI_SLOT(f4->devfn), 5),
-- 
1.7.8.rc3




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
