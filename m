From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Fri, 13 Jul 2007 01:48:14 +0000
Subject: [lm-sensors] [PATCH] v1 Intel FB-DIMM AMB temperature sensor
Message-Id: <20070713014814.GS3435@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6652419918116498837=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============6652419918116498837==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s6WJ5R58009U+S7n"
Content-Disposition: inline


--s6WJ5R58009U+S7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Here's a first draft of a driver to report FB-DIMM temperatures via the AMB
chips on systems with the Intel 5000 series chipset.  I've tested this
on an IBM IntelliStation Z30, an IBM x3650 and an IBM x3550, and haven't se=
en
any problems so far.  Please let me know about any problems that you
notice with this driver, and please cc me because I'm not subscribed to
the list.

---
i5k_amb: hwmon driver for FB-DIMM AMB thermal sensors on Intel 5000 series =
chipsets

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/Kconfig   |   10 +
 drivers/hwmon/Makefile  |    1=20
 drivers/hwmon/i5k_amb.c |  528 +++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 539 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index bb57beb..48f4332 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -138,6 +138,16 @@ config SENSORS_K8TEMP
 	  This driver can also be built as a module.  If so, the module
 	  will be called k8temp.
=20
+config SENSORS_I5K_AMB
+	tristate "FB-DIMM AMB temperature sensor on Intel 5000 series chipsets"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for FB-DIMM AMB temperature
+	  monitoring chips on systems with the Intel 5000 series chipset.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called i5k_amb.
+
 config SENSORS_AMS
 	tristate "Apple Motion Sensor driver"
 	depends on PPC_PMAC && !PPC64 && INPUT && ((ADB_PMU && I2C =3D y) || (ADB=
_PMU && !I2C) || I2C) && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index e5fc251..ab0cbb6 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_SENSORS_ADM1026)	+=3D adm1026.o
 obj-$(CONFIG_SENSORS_ADM1029)	+=3D adm1029.o
 obj-$(CONFIG_SENSORS_ADM1031)	+=3D adm1031.o
 obj-$(CONFIG_SENSORS_ADM9240)	+=3D adm9240.o
+obj-$(CONFIG_SENSORS_I5K_AMB)	+=3D i5k_amb.o
 obj-$(CONFIG_SENSORS_APPLESMC)	+=3D applesmc.o
 obj-$(CONFIG_SENSORS_AMS)	+=3D ams/
 obj-$(CONFIG_SENSORS_ATXP1)	+=3D atxp1.o
diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
new file mode 100644
index 0000000..b7d91ef
--- /dev/null
+++ b/drivers/hwmon/i5k_amb.c
@@ -0,0 +1,528 @@
+/*
+ * A hwmon driver for the Intel 5000 series chipset FB-DIMM AMB
+ * temperature sensors
+ * Copyright (C) 2007 IBM
+ *
+ * Author: Darrick J. Wong <djwong@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
+ */
+
+#include <linux/module.h>
+#include <linux/jiffies.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/log2.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+
+#define DRVNAME "i5k_amb"
+
+#define PCI_VENDOR_INTEL		0x8086
+#define PCI_DEVICE_INTEL_5K_MEM		0x25F0
+#define PCI_DEVICE_INTEL_5K_FBD0	0x25F5
+#define PCI_DEVICE_INTEL_5K_FBD1	0x25F6
+
+#define I5K_REG_AMB_BASE_ADDR		0x48
+#define I5K_REG_AMB_LEN_ADDR		0x50
+#define I5K_REG_CHAN0_PRESENCE_ADDR	0x64
+#define I5K_REG_CHAN1_PRESENCE_ADDR	0x66
+
+#define AMB_REG_TEMP_MIN_ADDR		0x80
+#define AMB_REG_TEMP_MID_ADDR		0x81
+#define AMB_REG_TEMP_MAX_ADDR		0x82
+#define AMB_REG_TEMP_STATUS_ADDR	0x84
+#define AMB_REG_TEMP_ADDR		0x85
+
+#define AMB_CONFIG_SIZE			2048
+#define AMB_FUNC_3_OFFSET		768
+
+#define AMB_REG_TEMP_STATUS(amb)	((amb) * AMB_CONFIG_SIZE + \
+			AMB_FUNC_3_OFFSET + AMB_REG_TEMP_STATUS_ADDR)
+#define AMB_REG_TEMP_MIN(amb)		((amb) * AMB_CONFIG_SIZE + \
+			AMB_FUNC_3_OFFSET + AMB_REG_TEMP_MIN_ADDR)
+#define AMB_REG_TEMP_MID(amb)		((amb) * AMB_CONFIG_SIZE + \
+			AMB_FUNC_3_OFFSET + AMB_REG_TEMP_MID_ADDR)
+#define AMB_REG_TEMP_MAX(amb)		((amb) * AMB_CONFIG_SIZE + \
+			AMB_FUNC_3_OFFSET + AMB_REG_TEMP_MAX_ADDR)
+#define AMB_REG_TEMP(amb)		((amb) * AMB_CONFIG_SIZE + \
+			AMB_FUNC_3_OFFSET + AMB_REG_TEMP_ADDR)
+
+#define MAX_MEM_CHANNELS		4
+#define MAX_AMBS_PER_CHANNEL		16
+#define MAX_AMBS			(MAX_MEM_CHANNELS * \
+					 MAX_AMBS_PER_CHANNEL)
+/*
+ * Ugly hack: For some reason the highest bit is set if there
+ * are _any_ DIMMs in the channel.  Attempting to read from
+ * this "high-order" AMB results in a memory bus error, so
+ * for now we'll just ignore that top bit, even though that
+ * might prevent us from seeing the 16th DIMM in the channel.
+ */
+#define REAL_MAX_AMBS_PER_CHANNEL	15
+#define KNOBS_PER_AMB			5
+
+#define AMB_NUM_FROM_REG(byte_num, bit_num)	((byte_num) * \
+			MAX_AMBS_PER_CHANNEL) + (bit_num)
+
+struct i5k_amb_data {
+	struct class_device *class_dev;
+	struct resource *resource;
+
+	unsigned long amb_base;
+	unsigned long amb_len;
+	u16 amb_present[MAX_MEM_CHANNELS];
+	void __iomem *amb_mmio;
+	struct sensor_device_attribute *attrs;
+	unsigned int num_attrs;
+};
+
+static ssize_t show_name(struct device *dev, struct device_attribute *deva=
ttr,
+			 char *buf)
+{
+	return sprintf(buf, "%s\n", DRVNAME);
+}
+
+
+static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, 0);
+
+static struct platform_device *amb_pdev =3D NULL;
+
+static u8 amb_read_byte(struct i5k_amb_data *data, unsigned long offset)
+{
+	return (*(u8*)(data->amb_mmio + offset));
+}
+
+static void amb_write_byte(struct i5k_amb_data *data, unsigned long offset,
+			   u8 val)
+{
+	(*(u8*)(data->amb_mmio + offset)) =3D val;
+}
+
+static ssize_t show_amb_alarm(struct device *dev,
+			     struct device_attribute *devattr,
+			     char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct i5k_amb_data *data =3D dev_get_drvdata(dev);
+
+	if ( !(amb_read_byte(data, AMB_REG_TEMP_STATUS(attr->index)) & 0x20) &&
+	      (amb_read_byte(data, AMB_REG_TEMP_STATUS(attr->index)) & 0x8) )
+		return sprintf(buf, "1\n");
+	else
+		return sprintf(buf, "0\n");
+}
+
+static ssize_t store_amb_min(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf,
+			     size_t count)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct i5k_amb_data *data =3D dev_get_drvdata(dev);
+	int temp =3D simple_strtol(buf, NULL, 10) / 500;
+
+	if (temp > 255)
+		temp =3D 255;
+
+	amb_write_byte(data, AMB_REG_TEMP_MIN(attr->index), temp);
+	return count;
+}
+
+static ssize_t store_amb_mid(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf,
+			     size_t count)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct i5k_amb_data *data =3D dev_get_drvdata(dev);
+	int temp =3D simple_strtol(buf, NULL, 10) / 500;
+
+	if (temp > 255)
+		temp =3D 255;
+
+	amb_write_byte(data, AMB_REG_TEMP_MID(attr->index), temp);
+	return count;
+}
+
+static ssize_t store_amb_max(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf,
+			     size_t count)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct i5k_amb_data *data =3D dev_get_drvdata(dev);
+	int temp =3D simple_strtol(buf, NULL, 10) / 500;
+
+	if (temp > 255)
+		temp =3D 255;
+
+	amb_write_byte(data, AMB_REG_TEMP_MAX(attr->index), temp);
+	return count;
+}
+
+static ssize_t show_amb_min(struct device *dev,
+			     struct device_attribute *devattr,
+			     char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct i5k_amb_data *data =3D dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n",
+		500 * amb_read_byte(data, AMB_REG_TEMP_MIN(attr->index)));
+}
+
+static ssize_t show_amb_mid(struct device *dev,
+			     struct device_attribute *devattr,
+			     char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct i5k_amb_data *data =3D dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n",
+		500 * amb_read_byte(data, AMB_REG_TEMP_MID(attr->index)));
+}
+
+static ssize_t show_amb_max(struct device *dev,
+			     struct device_attribute *devattr,
+			     char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct i5k_amb_data *data =3D dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n",
+		500 * amb_read_byte(data, AMB_REG_TEMP_MAX(attr->index)));
+}
+
+static ssize_t show_amb_temp(struct device *dev,
+			     struct device_attribute *devattr,
+			     char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct i5k_amb_data *data =3D dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n",
+		500 * amb_read_byte(data, AMB_REG_TEMP(attr->index)));
+}
+
+static int __devinit i5k_amb_hwmon_init(struct platform_device *pdev)
+{
+	int i, j, k;
+	u16 c;
+	char *n;
+	int res =3D 0;
+	int num_ambs =3D 0;
+	struct i5k_amb_data *data =3D platform_get_drvdata(pdev);
+
+	/* Count the number of AMBs found */
+	for (i =3D 0; i < MAX_MEM_CHANNELS; i++) {
+		c =3D data->amb_present[i];
+		for (j =3D 0; j < REAL_MAX_AMBS_PER_CHANNEL; j++) {
+			if (c & 0x1)
+				num_ambs++;
+			c >>=3D 1;
+		}
+	}
+
+	/* Set up sysfs stuff */
+	data->attrs =3D kzalloc(sizeof(*data->attrs) * num_ambs * KNOBS_PER_AMB,
+				GFP_KERNEL);
+	if (!data->attrs)
+		return -ENOMEM;
+	data->num_attrs =3D 0;
+
+	for (i =3D 0; i < MAX_MEM_CHANNELS; i++) {
+		c =3D data->amb_present[i];
+		for (j =3D 0; j < REAL_MAX_AMBS_PER_CHANNEL; j++, c >>=3D 1) {
+			k =3D AMB_NUM_FROM_REG(i, j);
+			if (!(c & 0x1))
+				continue;
+
+			/* Temperature sysfs knob */
+			n =3D kmalloc(13, GFP_KERNEL);
+			sprintf(n, "temp%d_input", k);
+			data->attrs[data->num_attrs].dev_attr.attr.name =3D n;
+			data->attrs[data->num_attrs].dev_attr.attr.mode =3D
+					S_IRUGO;
+			data->attrs[data->num_attrs].dev_attr.show =3D
+					show_amb_temp;
+			data->attrs[data->num_attrs].index =3D k;
+			res =3D device_create_file(&pdev->dev,
+					&data->attrs[data->num_attrs].dev_attr);
+			if (res)
+				goto exit_remove;
+			data->num_attrs++;
+
+			/* Temperature min sysfs knob */
+			n =3D kmalloc(13, GFP_KERNEL);
+			sprintf(n, "temp%d_min", k);
+			data->attrs[data->num_attrs].dev_attr.attr.name =3D n;
+			data->attrs[data->num_attrs].dev_attr.attr.mode =3D
+					S_IWUSR | S_IRUGO;
+			data->attrs[data->num_attrs].dev_attr.show =3D
+					show_amb_min;
+			data->attrs[data->num_attrs].dev_attr.store =3D
+					store_amb_min;
+			data->attrs[data->num_attrs].index =3D k;
+			res =3D device_create_file(&pdev->dev,
+					&data->attrs[data->num_attrs].dev_attr);
+			if (res)
+				goto exit_remove;
+			data->num_attrs++;
+
+			/* Temperature mid sysfs knob */
+			n =3D kmalloc(13, GFP_KERNEL);
+			sprintf(n, "temp%d_mid", k);
+			data->attrs[data->num_attrs].dev_attr.attr.name =3D n;
+			data->attrs[data->num_attrs].dev_attr.attr.mode =3D
+					S_IWUSR | S_IRUGO;
+			data->attrs[data->num_attrs].dev_attr.show =3D
+					show_amb_mid;
+			data->attrs[data->num_attrs].dev_attr.store =3D
+					store_amb_mid;
+			data->attrs[data->num_attrs].index =3D k;
+			res =3D device_create_file(&pdev->dev,
+					&data->attrs[data->num_attrs].dev_attr);
+			if (res)
+				goto exit_remove;
+			data->num_attrs++;
+
+			/* Temperature max sysfs knob */
+			n =3D kmalloc(13, GFP_KERNEL);
+			sprintf(n, "temp%d_max", k);
+			data->attrs[data->num_attrs].dev_attr.attr.name =3D n;
+			data->attrs[data->num_attrs].dev_attr.attr.mode =3D
+					S_IWUSR | S_IRUGO;
+			data->attrs[data->num_attrs].dev_attr.show =3D
+					show_amb_max;
+			data->attrs[data->num_attrs].dev_attr.store =3D
+					store_amb_max;
+			data->attrs[data->num_attrs].index =3D k;
+			res =3D device_create_file(&pdev->dev,
+					&data->attrs[data->num_attrs].dev_attr);
+			if (res)
+				goto exit_remove;
+			data->num_attrs++;
+
+			/* Temperature alarm sysfs knob */
+			n =3D kmalloc(13, GFP_KERNEL);
+			sprintf(n, "temp%d_alarm", k);
+			data->attrs[data->num_attrs].dev_attr.attr.name =3D n;
+			data->attrs[data->num_attrs].dev_attr.attr.mode =3D
+					S_IRUGO;
+			data->attrs[data->num_attrs].dev_attr.show =3D
+					show_amb_alarm;
+			data->attrs[data->num_attrs].index =3D k;
+			res =3D device_create_file(&pdev->dev,
+					&data->attrs[data->num_attrs].dev_attr);
+			if (res)
+				goto exit_remove;
+			data->num_attrs++;
+		}
+	}
+
+	res =3D device_create_file(&pdev->dev, &sensor_dev_attr_name.dev_attr);
+	if (res)
+		goto exit_remove;
+
+	data->class_dev =3D hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->class_dev)) {
+		res =3D PTR_ERR(data->class_dev);
+		goto exit_remove;
+	}
+
+	return res;
+
+exit_remove:
+	device_remove_file(&pdev->dev, &sensor_dev_attr_name.dev_attr);
+	for (i =3D 0; i < data->num_attrs; i++) {
+		device_remove_file(&pdev->dev, &data->attrs[i].dev_attr);
+		kfree(data->attrs[i].dev_attr.attr.name);
+	}
+	kfree(data->attrs);
+
+	return res;
+}
+
+static int __devinit i5k_amb_add(void)
+{
+	int res =3D -ENODEV;
+
+	/* only ever going to be one of these */
+	amb_pdev =3D platform_device_alloc(DRVNAME, 0);
+	if (!amb_pdev)
+		return -ENOMEM;
+
+	res =3D platform_device_add(amb_pdev);
+	if (res)
+		goto err;
+	return 0;
+
+err:
+	platform_device_put(amb_pdev);
+	return res;
+}
+
+static int __devinit i5k_amb_probe(struct platform_device *pdev)
+{
+	struct pci_dev *pcidev;
+	struct i5k_amb_data *data;
+	struct resource *reso;
+	u32 val32;
+	u16 val16;
+	int res =3D -ENOMEM;
+
+	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	/* Figure out where the AMB registers live */
+	pcidev =3D pci_get_device(PCI_VENDOR_INTEL, PCI_DEVICE_INTEL_5K_MEM,
+				NULL);
+	if (!pcidev)
+		goto out;
+
+	if (pci_read_config_dword(pcidev, I5K_REG_AMB_BASE_ADDR, &val32))
+		goto err_free_dev;
+	data->amb_base =3D val32;
+
+	if (pci_read_config_dword(pcidev, I5K_REG_AMB_LEN_ADDR, &val32))
+		goto err_free_dev;
+	data->amb_len =3D val32;
+
+	pci_dev_put(pcidev);
+
+	if (data->amb_len < AMB_CONFIG_SIZE * MAX_AMBS) {
+		printk(KERN_ERR DRVNAME "AMB region too small!\n");
+		goto out;
+	}
+
+
+	/* Copy the DIMM presence map for the first two channels */
+	pcidev =3D pci_get_device(PCI_VENDOR_INTEL, PCI_DEVICE_INTEL_5K_FBD0,
+				NULL);
+	if (!pcidev)
+		goto out;
+
+	if (pci_read_config_word(pcidev, I5K_REG_CHAN0_PRESENCE_ADDR, &val16))
+		goto err_free_dev;
+	data->amb_present[0] =3D val16;
+	if (pci_read_config_word(pcidev, I5K_REG_CHAN1_PRESENCE_ADDR, &val16))
+		goto err_free_dev;
+	data->amb_present[1] =3D val16;
+
+	pci_dev_put(pcidev);
+
+	/* Copy the DIMM presence map for the optional second two channels */
+	pcidev =3D pci_get_device(PCI_VENDOR_INTEL, PCI_DEVICE_INTEL_5K_FBD1,
+				NULL);
+	if (!pcidev)
+		goto setup_resources;
+
+	if (pci_read_config_word(pcidev, I5K_REG_CHAN0_PRESENCE_ADDR, &val16))
+		goto err_free_dev;
+	data->amb_present[2] =3D val16;
+	if (pci_read_config_word(pcidev, I5K_REG_CHAN1_PRESENCE_ADDR, &val16))
+		goto err_free_dev;
+	data->amb_present[3] =3D val16;
+
+	pci_dev_put(pcidev);
+
+setup_resources:
+	/* Set up resource regions */
+	reso =3D request_mem_region(data->amb_base, data->amb_len, DRVNAME);
+	if (!reso) {
+		res =3D -EBUSY;
+		goto out;
+	}
+=09
+	data->amb_mmio =3D ioremap_nocache(data->amb_base, data->amb_len);
+	if (!data->amb_mmio)
+		goto err2;
+
+	platform_set_drvdata(pdev, data);
+
+	res =3D i5k_amb_hwmon_init(pdev);
+	if (res)
+		goto err;
+	=09
+	return res;
+
+err:
+	iounmap(data->amb_mmio);
+	platform_set_drvdata(pdev, NULL);
+err2:
+	release_mem_region(data->amb_base, data->amb_len);
+	goto out;
+err_free_dev:
+	pci_dev_put(pcidev);
+out:
+	kfree(data);
+	return res;
+}
+
+static int __devexit i5k_amb_remove(struct platform_device *pdev)
+{
+	int i;
+	struct i5k_amb_data *data =3D platform_get_drvdata(pdev);
+
+	hwmon_device_unregister(data->class_dev);
+	device_remove_file(&pdev->dev, &sensor_dev_attr_name.dev_attr);
+	for (i =3D 0; i < data->num_attrs; i++) {
+		device_remove_file(&pdev->dev, &data->attrs[i].dev_attr);
+		kfree(data->attrs[i].dev_attr.attr.name);
+	}
+	iounmap(data->amb_mmio);
+	release_mem_region(data->amb_base, data->amb_len);
+	platform_set_drvdata(pdev, NULL);
+	kfree(data);
+	return 0;
+}
+
+static struct platform_driver i5k_amb_driver =3D {
+	.driver =3D {
+		.owner =3D THIS_MODULE,
+		.name =3D DRVNAME,
+	},
+	.probe =3D i5k_amb_probe,
+	.remove =3D __devexit_p(i5k_amb_remove),
+};
+
+static int __init i5k_amb_init(void)
+{
+	int res;
+
+	res =3D platform_driver_register(&i5k_amb_driver);
+	if (res)
+		return res;
+
+	res =3D i5k_amb_add();
+	if (res)
+		platform_driver_unregister(&i5k_amb_driver);
+
+	return res;
+}
+
+static void __exit i5k_amb_exit(void)
+{
+	platform_device_unregister(amb_pdev);
+	platform_driver_unregister(&i5k_amb_driver);
+}
+
+MODULE_AUTHOR("Darrick J. Wong <djwong@us.ibm.com>");
+MODULE_DESCRIPTION("Intel 5000 chipset FB-DIMM AMB temperature sensor");
+MODULE_LICENSE("GPL");
+
+module_init(i5k_amb_init);
+module_exit(i5k_amb_exit);

--s6WJ5R58009U+S7n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGltnea6vRYYgWQuURAl9tAKCioTt8G+WRuiRBSpa8qYq7YPWSHgCfT0GF
fTo3o6st0t5JWHfYdMMmoao=
=XhA9
-----END PGP SIGNATURE-----

--s6WJ5R58009U+S7n--


--===============6652419918116498837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6652419918116498837==--
