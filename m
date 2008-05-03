From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Sat, 03 May 2008 04:55:59 +0000
Subject: [lm-sensors] [PATCH] i5k_amb: Support Intel 5400 chipset
Message-Id: <20080503045558.GJ16078@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>

Minor rework to support the Intel 5400 chipset.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/i5k_amb.c |   39 ++++++++++++++++++++++++++++++++++-----
 include/linux/pci_ids.h |    3 +++
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index 6ac5c6f..f9e2ed6 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -111,6 +111,7 @@ struct i5k_amb_data {
 	void __iomem *amb_mmio;
 	struct i5k_device_attribute *attrs;
 	unsigned int num_attrs;
+	unsigned long chipset_id;
 };
 
 static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
@@ -382,7 +383,8 @@ err:
 	return res;
 }
 
-static int __devinit i5k_find_amb_registers(struct i5k_amb_data *data)
+static int __devinit i5k_find_amb_registers(struct i5k_amb_data *data,
+					    unsigned long devid)
 {
 	struct pci_dev *pcidev;
 	u32 val32;
@@ -390,7 +392,7 @@ static int __devinit i5k_find_amb_registers(struct i5k_amb_data *data)
 
 	/* Find AMB register memory space */
 	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
-				PCI_DEVICE_ID_INTEL_5000_ERR,
+				devid,
 				NULL);
 	if (!pcidev)
 		return -ENODEV;
@@ -409,6 +411,8 @@ static int __devinit i5k_find_amb_registers(struct i5k_amb_data *data)
 		goto out;
 	}
 
+	data->chipset_id = devid;
+
 	res = 0;
 out:
 	pci_dev_put(pcidev);
@@ -441,10 +445,30 @@ out:
 	return res;
 }
 
+static unsigned long i5k_channel_pci_id(struct i5k_amb_data *data,
+					unsigned long channel)
+{
+	switch (data->chipset_id) {
+	case PCI_DEVICE_ID_INTEL_5000_ERR:
+		return PCI_DEVICE_ID_INTEL_5000_FBD0 + channel;
+	case PCI_DEVICE_ID_INTEL_5400_ERR:
+		return PCI_DEVICE_ID_INTEL_5400_FBD0 + channel;
+	default:
+		BUG();
+	}
+}
+
+static unsigned long chipset_ids[] = {
+	PCI_DEVICE_ID_INTEL_5000_ERR,
+	PCI_DEVICE_ID_INTEL_5400_ERR,
+	0
+};
+
 static int __devinit i5k_amb_probe(struct platform_device *pdev)
 {
 	struct i5k_amb_data *data;
 	struct resource *reso;
+	int i;
 	int res = -ENODEV;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
@@ -452,19 +476,24 @@ static int __devinit i5k_amb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Figure out where the AMB registers live */
-	res = i5k_find_amb_registers(data);
+	i = 0;
+	do {
+		res = i5k_find_amb_registers(data, chipset_ids[i]);
+		i++;
+	} while (res && chipset_ids[i]);
+
 	if (res)
 		goto err;
 
 	/* Copy the DIMM presence map for the first two channels */
 	res = i5k_channel_probe(&data->amb_present[0],
-				PCI_DEVICE_ID_INTEL_5000_FBD0);
+				i5k_channel_pci_id(data, 0));
 	if (res)
 		goto err;
 
 	/* Copy the DIMM presence map for the optional second two channels */
 	i5k_channel_probe(&data->amb_present[2],
-			  PCI_DEVICE_ID_INTEL_5000_FBD1);
+			  i5k_channel_pci_id(data, 1));
 
 	/* Set up resource regions */
 	reso = request_mem_region(data->amb_base, data->amb_len, DRVNAME);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 70eb3c8..bb6e5e2 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2382,6 +2382,9 @@
 #define PCI_DEVICE_ID_INTEL_ICH10_4	0x3a30
 #define PCI_DEVICE_ID_INTEL_ICH10_5	0x3a60
 #define PCI_DEVICE_ID_INTEL_IOAT_SNB	0x402f
+#define PCI_DEVICE_ID_INTEL_5400_ERR	0x4030
+#define PCI_DEVICE_ID_INTEL_5400_FBD0	0x4035
+#define PCI_DEVICE_ID_INTEL_5400_FBD1	0x4036
 #define PCI_DEVICE_ID_INTEL_IOAT_SCNB	0x65ff
 #define PCI_DEVICE_ID_INTEL_TOLAPAI_0	0x5031
 #define PCI_DEVICE_ID_INTEL_TOLAPAI_1	0x5032

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
