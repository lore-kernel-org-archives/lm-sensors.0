From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 18 Aug 2011 17:49:31 +0000
Subject: [lm-sensors] [PATCH] hwmon: (i5k_amb) Replace BUG with WARN
Message-Id: <1313689771-31221-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Executing BUG as a result of an internal driver error seems to be a bit harsh.
Replace it with WARN and return -ENODEV if the condition is seen.

This also resolves the following compile warning seen with some random
configurations.

drivers/hwmon/i5k_amb.c: In function 'i5k_channel_pci_id':
drivers/hwmon/i5k_amb.c:492: warning: control reaches end of non-void function

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/i5k_amb.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index c4c40be..24e37e2 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -478,8 +478,7 @@ out:
 	return res;
 }
 
-static unsigned long i5k_channel_pci_id(struct i5k_amb_data *data,
-					unsigned long channel)
+static long i5k_channel_pci_id(struct i5k_amb_data *data, unsigned long channel)
 {
 	switch (data->chipset_id) {
 	case PCI_DEVICE_ID_INTEL_5000_ERR:
@@ -487,7 +486,8 @@ static unsigned long i5k_channel_pci_id(struct i5k_amb_data *data,
 	case PCI_DEVICE_ID_INTEL_5400_ERR:
 		return PCI_DEVICE_ID_INTEL_5400_FBD0 + channel;
 	default:
-		BUG();
+		WARN(1, "Unexpected chipset ID 0x%lx\n", data->chipset_id);
+		return -ENODEV;
 	}
 }
 
@@ -528,14 +528,18 @@ static int __devinit i5k_amb_probe(struct platform_device *pdev)
 		goto err;
 
 	/* Copy the DIMM presence map for the first two channels */
-	res = i5k_channel_probe(&data->amb_present[0],
-				i5k_channel_pci_id(data, 0));
+	res = i5k_channel_pci_id(data, 0);
+	if (res < 0)
+		goto err;
+	res = i5k_channel_probe(&data->amb_present[0], res);
 	if (res)
 		goto err;
 
 	/* Copy the DIMM presence map for the optional second two channels */
-	i5k_channel_probe(&data->amb_present[2],
-			  i5k_channel_pci_id(data, 1));
+	res = i5k_channel_pci_id(data, 1);
+	if (res < 0)
+		goto err;
+	i5k_channel_probe(&data->amb_present[2], res);
 
 	/* Set up resource regions */
 	reso = request_mem_region(data->amb_base, data->amb_len, DRVNAME);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
