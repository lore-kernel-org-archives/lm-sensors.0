From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 23:09:25 +0000
Subject: [lm-sensors] [PATCH 11/14] i2c: kzalloc conversion, other drivers
Message-Id: <20051017230943.3d0085e1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Deepak Saxena <dsaxena@plexity.net>
Content-Disposition: inline; filename=kzalloc-03-i2c-other.patch

Use kzalloc instead of kmalloc+memset in all remaining i2c bus and
chip drivers.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/i2c/busses/i2c-amd8111.c   |    3 +--
 drivers/i2c/busses/i2c-ibm_iic.c   |    3 +--
 drivers/i2c/busses/i2c-iop3xx.c    |    6 ++----
 drivers/i2c/busses/i2c-keywest.c   |    3 +--
 drivers/i2c/busses/i2c-mpc.c       |    3 +--
 drivers/i2c/busses/i2c-mv64xxx.c   |    5 +----
 drivers/i2c/busses/i2c-nforce2.c   |    3 +--
 drivers/i2c/busses/i2c-parport.c   |    5 ++---
 drivers/i2c/busses/i2c-pmac-smu.c  |    3 +--
 drivers/i2c/busses/i2c-prosavage.c |    4 +---
 drivers/i2c/busses/scx200_acb.c    |    3 +--
 drivers/i2c/chips/ds1337.c         |    3 +--
 drivers/i2c/chips/ds1374.c         |    3 +--
 drivers/i2c/chips/eeprom.c         |    3 +--
 drivers/i2c/chips/m41t00.c         |    3 +--
 drivers/i2c/chips/max6875.c        |    6 ++----
 drivers/i2c/chips/pca9539.c        |    3 +--
 drivers/i2c/chips/pcf8574.c        |    3 +--
 drivers/i2c/chips/pcf8591.c        |    3 +--
 drivers/i2c/chips/rtc8564.c        |    3 +--
 drivers/i2c/chips/tps65010.c       |    3 +--
 drivers/i2c/i2c-dev.c              |    3 +--
 22 files changed, 25 insertions(+), 52 deletions(-)

--- linux-2.6.14-rc4.orig/drivers/i2c/busses/i2c-amd8111.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-amd8111.c	2005-10-13 22:59:00.000000000 +0200
@@ -344,10 +344,9 @@
 	if (~pci_resource_flags(dev, 0) & IORESOURCE_IO)
 		return -ENODEV;
 
-	smbus = kmalloc(sizeof(struct amd_smbus), GFP_KERNEL);
+	smbus = kzalloc(sizeof(struct amd_smbus), GFP_KERNEL);
 	if (!smbus)
 		return -ENOMEM;
-	memset(smbus, 0, sizeof(struct amd_smbus));
 
 	smbus->dev = dev;
 	smbus->base = pci_resource_start(dev, 0);
--- linux-2.6.14-rc4.orig/drivers/i2c/busses/i2c-ibm_iic.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-ibm_iic.c	2005-10-13 23:00:23.000000000 +0200
@@ -672,13 +672,12 @@
 		printk(KERN_WARNING"ibm-iic%d: missing additional data!\n",
 			ocp->def->index);
 
-	if (!(dev = kmalloc(sizeof(*dev), GFP_KERNEL))){
+	if (!(dev = kzalloc(sizeof(*dev), GFP_KERNEL))) {
 		printk(KERN_CRIT "ibm-iic%d: failed to allocate device data\n",
 			ocp->def->index);
 		return -ENOMEM;
 	}
 
-	memset(dev, 0, sizeof(*dev));
 	dev->idx = ocp->def->index;
 	ocp_set_drvdata(ocp, dev);
 	
--- linux-2.6.14-rc4.orig/drivers/i2c/busses/i2c-iop3xx.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-iop3xx.c	2005-10-13 22:59:00.000000000 +0200
@@ -440,19 +440,17 @@
 	struct i2c_adapter *new_adapter;
 	struct i2c_algo_iop3xx_data *adapter_data;
 
-	new_adapter = kmalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
+	new_adapter = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
 	if (!new_adapter) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	memset((void*)new_adapter, 0, sizeof(*new_adapter));
 
-	adapter_data = kmalloc(sizeof(struct i2c_algo_iop3xx_data), GFP_KERNEL);
+	adapter_data = kzalloc(sizeof(struct i2c_algo_iop3xx_data), GFP_KERNEL);
 	if (!adapter_data) {
 		ret = -ENOMEM;
 		goto free_adapter;
 	}
-	memset((void*)adapter_data, 0, sizeof(*adapter_data));
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
--- linux-2.6.14-rc4.orig/drivers/i2c/busses/i2c-keywest.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-keywest.c	2005-10-13 22:59:00.000000000 +0200
@@ -535,13 +535,12 @@
 
 	tsize = sizeof(struct keywest_iface) +
 		(sizeof(struct keywest_chan) + 4) * nchan;
-	iface = (struct keywest_iface *) kmalloc(tsize, GFP_KERNEL);
+	iface = (struct keywest_iface *) kzalloc(tsize, GFP_KERNEL);
 	if (iface = NULL) {
 		printk(KERN_ERR "i2c-keywest: can't allocate inteface !\n");
 		pmac_low_i2c_unlock(np);
 		return -ENOMEM;
 	}
-	memset(iface, 0, tsize);
 	spin_lock_init(&iface->lock);
 	init_completion(&iface->complete);
 	iface->node = of_node_get(np);
--- linux-2.6.14-rc4.orig/drivers/i2c/busses/i2c-mpc.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-mpc.c	2005-10-13 22:59:00.000000000 +0200
@@ -296,10 +296,9 @@
 
 	pdata = (struct fsl_i2c_platform_data *) pdev->dev.platform_data;
 
-	if (!(i2c = kmalloc(sizeof(*i2c), GFP_KERNEL))) {
+	if (!(i2c = kzalloc(sizeof(*i2c), GFP_KERNEL))) {
 		return -ENOMEM;
 	}
-	memset(i2c, 0, sizeof(*i2c));
 
 	i2c->irq = platform_get_irq(pdev, 0);
 	i2c->flags = pdata->device_flags;
--- linux-2.6.14-rc4.orig/drivers/i2c/busses/i2c-mv64xxx.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-mv64xxx.c	2005-10-13 23:01:07.000000000 +0200
@@ -500,13 +500,10 @@
 	if ((pd->id != 0) || !pdata)
 		return -ENODEV;
 
-	drv_data = kmalloc(sizeof(struct mv64xxx_i2c_data), GFP_KERNEL);
-
+	drv_data = kzalloc(sizeof(struct mv64xxx_i2c_data), GFP_KERNEL);
 	if (!drv_data)
 		return -ENOMEM;
 
-	memset(drv_data, 0, sizeof(struct mv64xxx_i2c_data));
-
 	if (mv64xxx_i2c_map_regs(pd, drv_data)) {
 		rc = -ENODEV;
 		goto exit_kfree;
--- linux-2.6.14-rc4.orig/drivers/i2c/busses/i2c-nforce2.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-nforce2.c	2005-10-13 22:59:00.000000000 +0200
@@ -313,10 +313,9 @@
 	int res1, res2;
 
 	/* we support 2 SMBus adapters */
-	if (!(smbuses = (void *)kmalloc(2*sizeof(struct nforce2_smbus),
+	if (!(smbuses = (void *)kzalloc(2*sizeof(struct nforce2_smbus),
 				       	GFP_KERNEL)))
 		return -ENOMEM;
-	memset (smbuses, 0, 2*sizeof(struct nforce2_smbus));
 	pci_set_drvdata(dev, smbuses);
 
 	/* SMBus adapter 1 */
--- linux-2.6.14-rc4.orig/drivers/i2c/busses/i2c-parport.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-parport.c	2005-10-13 22:59:00.000000000 +0200
@@ -155,12 +155,11 @@
 {
 	struct i2c_par *adapter;
 	
-	adapter = kmalloc(sizeof(struct i2c_par), GFP_KERNEL);
+	adapter = kzalloc(sizeof(struct i2c_par), GFP_KERNEL);
 	if (adapter = NULL) {
-		printk(KERN_ERR "i2c-parport: Failed to kmalloc\n");
+		printk(KERN_ERR "i2c-parport: Failed to kzalloc\n");
 		return;
 	}
-	memset(adapter, 0x00, sizeof(struct i2c_par));
 
 	pr_debug("i2c-parport: attaching to %s\n", port->name);
 	adapter->pdev = parport_register_device(port, "i2c-parport",
--- linux-2.6.14-rc4.orig/drivers/i2c/busses/i2c-pmac-smu.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-pmac-smu.c	2005-10-13 22:59:00.000000000 +0200
@@ -211,12 +211,11 @@
 	}
 	busid = *reg;
 
-	iface = kmalloc(sizeof(struct smu_iface), GFP_KERNEL);
+	iface = kzalloc(sizeof(struct smu_iface), GFP_KERNEL);
 	if (iface = NULL) {
 		printk(KERN_ERR "i2c-pmac-smu: can't allocate inteface !\n");
 		return -ENOMEM;
 	}
-	memset(iface, 0, sizeof(struct smu_iface));
 	init_completion(&iface->complete);
 	iface->busid = busid;
 
--- linux-2.6.14-rc4.orig/drivers/i2c/busses/i2c-prosavage.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-prosavage.c	2005-10-13 23:01:41.000000000 +0200
@@ -241,14 +241,12 @@
 	struct s_i2c_chip *chip;
 	struct s_i2c_bus  *bus;
 
-        pci_set_drvdata(dev, kmalloc(sizeof(struct s_i2c_chip), GFP_KERNEL)); 
+	pci_set_drvdata(dev, kzalloc(sizeof(struct s_i2c_chip), GFP_KERNEL));
 	chip = (struct s_i2c_chip *)pci_get_drvdata(dev);
 	if (chip = NULL) {
 		return -ENOMEM;
 	}
 
-	memset(chip, 0, sizeof(struct s_i2c_chip));
-
 	base = dev->resource[0].start & PCI_BASE_ADDRESS_MEM_MASK;
 	len  = dev->resource[0].end - base + 1;
 	chip->mmio = ioremap_nocache(base, len);
--- linux-2.6.14-rc4.orig/drivers/i2c/busses/scx200_acb.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/scx200_acb.c	2005-10-13 22:59:00.000000000 +0200
@@ -442,14 +442,13 @@
 	int rc = 0;
 	char description[64];
 
-	iface = kmalloc(sizeof(*iface), GFP_KERNEL);
+	iface = kzalloc(sizeof(*iface), GFP_KERNEL);
 	if (!iface) {
 		printk(KERN_ERR NAME ": can't allocate memory\n");
 		rc = -ENOMEM;
 		goto errout;
 	}
 
-	memset(iface, 0, sizeof(*iface));
 	adapter = &iface->adapter;
 	i2c_set_adapdata(adapter, iface);
 	snprintf(adapter->name, I2C_NAME_SIZE, "SCx200 ACB%d", index);
--- linux-2.6.14-rc4.orig/drivers/i2c/chips/ds1337.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/chips/ds1337.c	2005-10-13 22:59:00.000000000 +0200
@@ -243,11 +243,10 @@
 				     I2C_FUNC_I2C))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct ds1337_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct ds1337_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct ds1337_data));
 	INIT_LIST_HEAD(&data->list);
 
 	/* The common I2C client data is placed right before the
--- linux-2.6.14-rc4.orig/drivers/i2c/chips/ds1374.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/chips/ds1374.c	2005-10-13 22:59:00.000000000 +0200
@@ -193,11 +193,10 @@
 	struct i2c_client *client;
 	int rc;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (!client)
 		return -ENOMEM;
 
-	memset(client, 0, sizeof(struct i2c_client));
 	strncpy(client->name, DS1374_DRV_NAME, I2C_NAME_SIZE);
 	client->addr = addr;
 	client->adapter = adap;
--- linux-2.6.14-rc4.orig/drivers/i2c/chips/eeprom.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/chips/eeprom.c	2005-10-13 22:59:00.000000000 +0200
@@ -171,11 +171,10 @@
 					    | I2C_FUNC_SMBUS_BYTE))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct eeprom_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct eeprom_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct eeprom_data));
 
 	new_client = &data->client;
 	memset(data->data, 0xff, EEPROM_SIZE);
--- linux-2.6.14-rc4.orig/drivers/i2c/chips/m41t00.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/chips/m41t00.c	2005-10-13 22:59:00.000000000 +0200
@@ -174,11 +174,10 @@
 	struct i2c_client *client;
 	int rc;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (!client)
 		return -ENOMEM;
 
-	memset(client, 0, sizeof(struct i2c_client));
 	strncpy(client->name, M41T00_DRV_NAME, I2C_NAME_SIZE);
 	client->addr = addr;
 	client->adapter = adap;
--- linux-2.6.14-rc4.orig/drivers/i2c/chips/max6875.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/chips/max6875.c	2005-10-13 22:59:00.000000000 +0200
@@ -179,16 +179,14 @@
 	if (address & 1)
 		return 0;
 
-	if (!(data = kmalloc(sizeof(struct max6875_data), GFP_KERNEL)))
+	if (!(data = kzalloc(sizeof(struct max6875_data), GFP_KERNEL)))
 		return -ENOMEM;
-	memset(data, 0, sizeof(struct max6875_data));
 
 	/* A fake client is created on the odd address */
-	if (!(fake_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
+	if (!(fake_client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit_kfree1;
 	}
-	memset(fake_client, 0, sizeof(struct i2c_client));
 
 	/* Init real i2c_client */
 	real_client = &data->client;
--- linux-2.6.14-rc4.orig/drivers/i2c/chips/pca9539.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/chips/pca9539.c	2005-10-13 22:59:00.000000000 +0200
@@ -122,11 +122,10 @@
 
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet. */
-	if (!(data = kmalloc(sizeof(struct pca9539_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct pca9539_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct pca9539_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/i2c/chips/pcf8574.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/chips/pcf8574.c	2005-10-13 22:59:00.000000000 +0200
@@ -127,11 +127,10 @@
 
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet. */
-	if (!(data = kmalloc(sizeof(struct pcf8574_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct pcf8574_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct pcf8574_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/i2c/chips/pcf8591.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/chips/pcf8591.c	2005-10-13 22:59:00.000000000 +0200
@@ -178,11 +178,10 @@
 
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet. */
-	if (!(data = kmalloc(sizeof(struct pcf8591_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct pcf8591_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct pcf8591_data));
 	
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/i2c/chips/rtc8564.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/chips/rtc8564.c	2005-10-13 22:59:00.000000000 +0200
@@ -148,12 +148,11 @@
 		{addr, I2C_M_RD, 2, data}
 	};
 
-	d = kmalloc(sizeof(struct rtc8564_data), GFP_KERNEL);
+	d = kzalloc(sizeof(struct rtc8564_data), GFP_KERNEL);
 	if (!d) {
 		ret = -ENOMEM;
 		goto done;
 	}
-	memset(d, 0, sizeof(struct rtc8564_data));
 	new_client = &d->client;
 
 	strlcpy(new_client->name, "RTC8564", I2C_NAME_SIZE);
--- linux-2.6.14-rc4.orig/drivers/i2c/chips/tps65010.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/chips/tps65010.c	2005-10-13 22:59:00.000000000 +0200
@@ -500,11 +500,10 @@
 		return 0;
 	}
 
-	tps = kmalloc(sizeof *tps, GFP_KERNEL);
+	tps = kzalloc(sizeof *tps, GFP_KERNEL);
 	if (!tps)
 		return 0;
 
-	memset(tps, 0, sizeof *tps);
 	init_MUTEX(&tps->lock);
 	INIT_WORK(&tps->work, tps65010_work, tps);
 	tps->irq = -1;
--- linux-2.6.14-rc4.orig/drivers/i2c/i2c-dev.c	2005-10-13 22:56:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/i2c-dev.c	2005-10-13 22:59:00.000000000 +0200
@@ -80,10 +80,9 @@
 {
 	struct i2c_dev *i2c_dev;
 
-	i2c_dev = kmalloc(sizeof(*i2c_dev), GFP_KERNEL);
+	i2c_dev = kzalloc(sizeof(*i2c_dev), GFP_KERNEL);
 	if (!i2c_dev)
 		return ERR_PTR(-ENOMEM);
-	memset(i2c_dev, 0x00, sizeof(*i2c_dev));
 
 	spin_lock(&i2c_dev_array_lock);
 	if (i2c_dev_array[adap->nr]) {

-- 
Jean Delvare
