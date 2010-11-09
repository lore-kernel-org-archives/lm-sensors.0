From: Keerthy <j-keerthy@ti.com>
Date: Tue, 09 Nov 2010 09:32:57 +0000
Subject: [lm-sensors] [PATCH V2] hwmon: twl4030: Driver for twl4030 madc
Message-Id: <1289294457-5330-1-git-send-email-j-keerthy@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, sameo@linux.intel.com, khali@linux-fr.org
Cc: mikko.k.ylinen@nokia.com, balbi@ti.com, amit.kucheria@canonical.com, linux-omap@vger.kernel.org, balajitk@ti.com, j-keerthy@ti.com

Introducing a driver for MADC on TWL4030 powerIC. MADC stands for monitoring
ADC. This driver monitors the real time conversion of analog signals like
battery temperature, battery type, battery level etc. User can also ask for
the conversion on a particular channel using the sysfs nodes.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Several people have contributed to this driver on the linux-omap list.

V2:

Error path correction in probe function.
Return checks added.
the_madc pointer could not be removed. The external drivers will not be knowing
device information of the madc.
Added another function which takes the channel number alone and returns
the channel reading if the caller wants TWL4030_MADC_SW2 method for ADC conversion.
IOCTL function is removed.
Work struct is completely removed since request_threaded_irq is used.

 drivers/hwmon/Kconfig            |    6 +
 drivers/hwmon/Makefile           |    1 +
 drivers/hwmon/twl4030-madc.c     |  573 ++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/twl4030-madc.h |  118 ++++++++
 4 files changed, 698 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/twl4030-madc.c
 create mode 100644 include/linux/i2c/twl4030-madc.h

V1:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34947.html

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a56f6ad..fef75f2 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1171,6 +1171,12 @@ config SENSORS_MC13783_ADC
         help
           Support for the A/D converter on MC13783 PMIC.
 
+config SENSORS_TWL4030_MADC
+	tristate
+	depends on TWL4030_CORE
+	help
+	  This driver provides support for TWL4030-MADC.
+
 if ACPI
 
 comment "ACPI drivers"
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 2479b3d..a54af22 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
 obj-$(CONFIG_SENSORS_TMP102)	+= tmp102.o
 obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
 obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
+obj-$(CONFIG_SENSORS_TWL4030_MADC)+= twl4030-madc.o
 obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o
diff --git a/drivers/hwmon/twl4030-madc.c b/drivers/hwmon/twl4030-madc.c
new file mode 100644
index 0000000..42f7d4a
--- /dev/null
+++ b/drivers/hwmon/twl4030-madc.c
@@ -0,0 +1,573 @@
+/*
+ *
+ * TWL4030 MADC module driver-This driver monitors the real time
+ * conversion of analog signals like battery temperature,
+ * battery type, battery level etc. User can also ask for the conversion on a
+ * particular channel using the sysfs nodes.
+ *
+ * Copyright (C) 2010 Texas Instruments Inc.
+ * J Keerthy <j-keerthy@ti.com>
+ *
+ * Based on twl4030-madc.c
+ * Copyright (C) 2008 Nokia Corporation
+ * Mikko Ylinen <mikko.k.ylinen@nokia.com>
+ *
+ * Amit Kucheria <amit.kucheria@canonical.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/i2c/twl.h>
+#include <linux/i2c/twl4030-madc.h>
+#include <linux/sysfs.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/uaccess.h>
+
+struct twl4030_madc_data {
+	struct device *hwmon_dev;
+	struct mutex lock;
+	struct twl4030_madc_request requests[TWL4030_MADC_NUM_METHODS];
+	int imr;
+	int isr;
+};
+
+static struct twl4030_madc_data *the_madc;
+
+static ssize_t madc_read(struct device *dev,
+			 struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct twl4030_madc_request req;
+	int status;
+	long val;
+
+	req.channels = (1 << attr->index);
+	req.method = TWL4030_MADC_SW2;
+	req.func_cb = NULL;
+
+	val = twl4030_madc_conversion(&req);
+	if (likely(val >= 0))
+		val = req.rbuf[attr->index];
+	else
+		return val;
+	status = sprintf(buf, "%ld\n", val);
+	return status;
+}
+
+static
+const struct twl4030_madc_conversion_method twl4030_conversion_methods[] = {
+	[TWL4030_MADC_RT] = {
+			     .sel = TWL4030_MADC_RTSELECT_LSB,
+			     .avg = TWL4030_MADC_RTAVERAGE_LSB,
+			     .rbase = TWL4030_MADC_RTCH0_LSB,
+			     },
+	[TWL4030_MADC_SW1] = {
+			      .sel = TWL4030_MADC_SW1SELECT_LSB,
+			      .avg = TWL4030_MADC_SW1AVERAGE_LSB,
+			      .rbase = TWL4030_MADC_GPCH0_LSB,
+			      .ctrl = TWL4030_MADC_CTRL_SW1,
+			      },
+	[TWL4030_MADC_SW2] = {
+			      .sel = TWL4030_MADC_SW2SELECT_LSB,
+			      .avg = TWL4030_MADC_SW2AVERAGE_LSB,
+			      .rbase = TWL4030_MADC_GPCH0_LSB,
+			      .ctrl = TWL4030_MADC_CTRL_SW2,
+			      },
+};
+
+static int twl4030_madc_read(struct twl4030_madc_data *madc, u8 reg)
+{
+	int ret;
+	u8 val;
+
+	ret = twl_i2c_read_u8(TWL4030_MODULE_MADC, &val, reg);
+	if (ret) {
+		dev_dbg(madc->hwmon_dev, "unable to read register 0x%X\n", reg);
+		return ret;
+	}
+
+	return val;
+}
+
+static void twl4030_madc_write(struct twl4030_madc_data *madc, u8 reg, u8 val)
+{
+	int ret;
+
+	ret = twl_i2c_write_u8(TWL4030_MODULE_MADC, val, reg);
+	if (ret)
+		dev_err(madc->hwmon_dev,
+			"unable to write register 0x%X\n", reg);
+}
+
+static int twl4030_madc_channel_raw_read(struct twl4030_madc_data *madc, u8 reg)
+{
+	u8 msb, lsb;
+
+	/*
+	 * For each ADC channel, we have MSB and LSB register pair. MSB address
+	 * is always LSB address+1. reg parameter is the addr of LSB register
+	 */
+	msb = twl4030_madc_read(madc, reg + 1);
+	lsb = twl4030_madc_read(madc, reg);
+
+	return (int)(((msb << 8) | lsb) >> 6);
+}
+
+static int twl4030_madc_read_channels(struct twl4030_madc_data *madc,
+				      u8 reg_base, u16 channels, int *buf)
+{
+	int count = 0;
+	u8 reg, i;
+
+	if (unlikely(!buf))
+		return 0;
+
+	for (i = 0; i < TWL4030_MADC_MAX_CHANNELS; i++) {
+		if (channels & (1 << i)) {
+			reg = reg_base + 2 * i;
+			buf[i] = twl4030_madc_channel_raw_read(madc, reg);
+			count++;
+		}
+	}
+	return count;
+}
+
+static void twl4030_madc_enable_irq(struct twl4030_madc_data *madc, int id)
+{
+	u8 val;
+
+	val = twl4030_madc_read(madc, madc->imr);
+	val &= ~(1 << id);
+	twl4030_madc_write(madc, madc->imr, val);
+}
+
+static void twl4030_madc_disable_irq(struct twl4030_madc_data *madc, int id)
+{
+	u8 val;
+
+	val = twl4030_madc_read(madc, madc->imr);
+	val |= (1 << id);
+	twl4030_madc_write(madc, madc->imr, val);
+}
+
+static irqreturn_t twl4030_madc_irq_handler(int irq, void *_madc)
+{
+	struct twl4030_madc_data *madc = _madc;
+	const struct twl4030_madc_conversion_method *method;
+	u8 isr_val, imr_val;
+	int i, len;
+	struct twl4030_madc_request *r;
+
+	isr_val = twl4030_madc_read(madc, madc->isr);
+	imr_val = twl4030_madc_read(madc, madc->imr);
+
+	isr_val &= ~imr_val;
+
+	for (i = 0; i < TWL4030_MADC_NUM_METHODS; i++) {
+
+		if (!(isr_val & (1 << i)))
+			continue;
+
+		twl4030_madc_disable_irq(madc, i);
+		madc->requests[i].result_pending = 1;
+	}
+	mutex_lock(&madc->lock);
+	for (i = 0; i < TWL4030_MADC_NUM_METHODS; i++) {
+
+		r = &madc->requests[i];
+
+		/* No pending results for this method, move to next one */
+		if (!r->result_pending)
+			continue;
+
+		method = &twl4030_conversion_methods[r->method];
+
+		/* Read results */
+		len = twl4030_madc_read_channels(madc, method->rbase,
+						 r->channels, r->rbuf);
+		/* Return results to caller */
+		if (r->func_cb != NULL) {
+			r->func_cb(len, r->channels, r->rbuf);
+			r->func_cb = NULL;
+		}
+
+		/* Free request */
+		r->result_pending = 0;
+		r->active = 0;
+	}
+
+	mutex_unlock(&madc->lock);
+
+	return IRQ_HANDLED;
+}
+
+static int twl4030_madc_set_irq(struct twl4030_madc_data *madc,
+				struct twl4030_madc_request *req)
+{
+	struct twl4030_madc_request *p;
+
+	p = &madc->requests[req->method];
+
+	memcpy(p, req, sizeof *req);
+
+	twl4030_madc_enable_irq(madc, req->method);
+
+	return 0;
+}
+
+static inline void twl4030_madc_start_conversion(struct twl4030_madc_data *madc,
+						 int conv_method)
+{
+	const struct twl4030_madc_conversion_method *method;
+
+	method = &twl4030_conversion_methods[conv_method];
+
+	switch (conv_method) {
+	case TWL4030_MADC_SW1:
+	case TWL4030_MADC_SW2:
+		twl4030_madc_write(madc, method->ctrl, TWL4030_MADC_SW_START);
+		break;
+	case TWL4030_MADC_RT:
+	default:
+		break;
+	}
+}
+
+static int twl4030_madc_wait_conversion_ready(struct twl4030_madc_data *madc,
+					      unsigned int timeout_ms,
+					      u8 status_reg)
+{
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	do {
+		u8 reg;
+
+		reg = twl4030_madc_read(madc, status_reg);
+		if (!(reg & TWL4030_MADC_BUSY) && (reg & TWL4030_MADC_EOC_SW))
+			return 0;
+	} while (!time_after(jiffies, timeout));
+
+	return -EAGAIN;
+}
+
+int twl4030_madc_conversion(struct twl4030_madc_request *req)
+{
+	const struct twl4030_madc_conversion_method *method;
+	u8 ch_msb, ch_lsb;
+	int ret;
+
+	if (unlikely(!req))
+		return -EINVAL;
+
+	mutex_lock(&the_madc->lock);
+
+	if (req->method < TWL4030_MADC_RT || req->method > TWL4030_MADC_SW2) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Do we have a conversion request ongoing */
+	if (the_madc->requests[req->method].active) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ch_msb = (req->channels >> 8) & 0xff;
+	ch_lsb = req->channels & 0xff;
+
+	method = &twl4030_conversion_methods[req->method];
+
+	/* Select channels to be converted */
+	twl4030_madc_write(the_madc, method->sel + 1, ch_msb);
+	twl4030_madc_write(the_madc, method->sel, ch_lsb);
+
+	/* Select averaging for all channels if do_avg is set */
+	if (req->do_avg) {
+		twl4030_madc_write(the_madc, method->avg + 1, ch_msb);
+		twl4030_madc_write(the_madc, method->avg, ch_lsb);
+	}
+
+	if (req->type = TWL4030_MADC_IRQ_ONESHOT && req->func_cb != NULL) {
+		twl4030_madc_set_irq(the_madc, req);
+		twl4030_madc_start_conversion(the_madc, req->method);
+		the_madc->requests[req->method].active = 1;
+		ret = 0;
+		goto out;
+	}
+
+	/* With RT method we should not be here anymore */
+	if (req->method = TWL4030_MADC_RT) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	twl4030_madc_start_conversion(the_madc, req->method);
+	the_madc->requests[req->method].active = 1;
+
+	/* Wait until conversion is ready (ctrl register returns EOC) */
+	ret = twl4030_madc_wait_conversion_ready(the_madc, 5, method->ctrl);
+	if (ret) {
+		dev_dbg(the_madc->hwmon_dev, "conversion timeout!\n");
+		the_madc->requests[req->method].active = 0;
+		goto out;
+	}
+
+	ret = twl4030_madc_read_channels(the_madc, method->rbase, req->channels,
+					 req->rbuf);
+
+	the_madc->requests[req->method].active = 0;
+
+out:
+	mutex_unlock(&the_madc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(twl4030_madc_conversion);
+
+/*
+ * Return channel value
+ * Or < 0 on failure.
+ */
+static int twl4030_get_madc_conversion(int channel_no)
+{
+	struct twl4030_madc_request req;
+	int temp = 0;
+	int ret;
+
+	req.channels = (1 << channel_no);
+	req.method = TWL4030_MADC_SW2;
+	req.active = 0;
+	req.func_cb = NULL;
+	ret = twl4030_madc_conversion(&req);
+	if (ret < 0)
+		return ret;
+
+	if (req.rbuf[channel_no] > 0)
+		temp = req.rbuf[channel_no];
+
+	return temp;
+}
+EXPORT_SYMBOL(twl4030_get_madc_conversion);
+
+static void twl4030_madc_set_current_generator(struct twl4030_madc_data *madc,
+					       int chan, int on)
+{
+	int ret;
+	u8 regval;
+
+	ret = twl_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE,
+			      &regval, TWL4030_BCI_BCICTL1);
+	if (ret) {
+		dev_dbg(madc->hwmon_dev,
+			"unable to read register 0x%X\n", TWL4030_BCI_BCICTL1);
+	}
+	if (on)
+		regval |= chan ? TWL4030_BCI_ITHEN : TWL4030_BCI_TYPEN;
+	else
+		regval &= chan ? ~TWL4030_BCI_ITHEN : ~TWL4030_BCI_TYPEN;
+	ret = twl_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE,
+			       regval, TWL4030_BCI_BCICTL1);
+	if (ret)
+		dev_err(madc->hwmon_dev,
+			"unable to write register 0x%X\n", TWL4030_BCI_BCICTL1);
+
+}
+
+static void twl4030_madc_set_power(struct twl4030_madc_data *madc, int on)
+{
+	u8 regval;
+
+	regval = twl4030_madc_read(madc, TWL4030_MADC_CTRL1);
+	if (on)
+		regval |= TWL4030_MADC_MADCON;
+	else
+		regval &= ~TWL4030_MADC_MADCON;
+	twl4030_madc_write(madc, TWL4030_MADC_CTRL1, regval);
+}
+
+static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, madc_read, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, madc_read, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, madc_read, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, madc_read, NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, madc_read, NULL, 4);
+static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, madc_read, NULL, 5);
+static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, madc_read, NULL, 6);
+static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, madc_read, NULL, 7);
+static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, madc_read, NULL, 8);
+static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, madc_read, NULL, 9);
+static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, madc_read, NULL, 10);
+static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, madc_read, NULL, 11);
+static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, madc_read, NULL, 12);
+static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, madc_read, NULL, 13);
+static SENSOR_DEVICE_ATTR(in14_input, S_IRUGO, madc_read, NULL, 14);
+static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, madc_read, NULL, 15);
+
+static struct attribute *twl4030_madc_attributes[] = {
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_in7_input.dev_attr.attr,
+	&sensor_dev_attr_in8_input.dev_attr.attr,
+	&sensor_dev_attr_in9_input.dev_attr.attr,
+	&sensor_dev_attr_in10_input.dev_attr.attr,
+	&sensor_dev_attr_in11_input.dev_attr.attr,
+	&sensor_dev_attr_in12_input.dev_attr.attr,
+	&sensor_dev_attr_in13_input.dev_attr.attr,
+	&sensor_dev_attr_in14_input.dev_attr.attr,
+	&sensor_dev_attr_in15_input.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group twl4030_madc_group = {
+	.attrs = twl4030_madc_attributes,
+};
+
+static int __devinit twl4030_madc_probe(struct platform_device *pdev)
+{
+	struct twl4030_madc_data *madc;
+	struct twl4030_madc_platform_data *pdata = pdev->dev.platform_data;
+	int ret;
+	int status;
+	u8 regval;
+
+	madc = kzalloc(sizeof *madc, GFP_KERNEL);
+	if (!madc)
+		return -ENOMEM;
+
+	if (!pdata) {
+		dev_dbg(&pdev->dev, "platform_data not available\n");
+		ret = -EINVAL;
+		goto err_misc;
+	}
+	madc->imr = (pdata->irq_line = 1) ?
+	    TWL4030_MADC_IMR1 : TWL4030_MADC_IMR2;
+	madc->isr = (pdata->irq_line = 1) ?
+	    TWL4030_MADC_ISR1 : TWL4030_MADC_ISR2;
+	twl4030_madc_set_power(madc, 1);
+
+	twl4030_madc_set_current_generator(madc, 0, 1);
+
+	ret = twl_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE,
+			      &regval, TWL4030_BCI_BCICTL1);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"unable to read register 0x%X\n", TWL4030_BCI_BCICTL1);
+	}
+	regval |= TWL4030_BCI_MESBAT;
+
+	ret = twl_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE,
+			       regval, TWL4030_BCI_BCICTL1);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"unable to write register 0x%X\n", TWL4030_BCI_BCICTL1);
+	}
+
+	platform_set_drvdata(pdev, madc);
+	mutex_init(&madc->lock);
+
+	ret = request_threaded_irq(platform_get_irq(pdev, 0), NULL,
+				   twl4030_madc_irq_handler,
+				   IRQF_TRIGGER_RISING, "twl4030_madc", madc);
+	if (ret) {
+		dev_dbg(&pdev->dev, "could not request irq\n");
+		goto err_irq;
+	}
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &twl4030_madc_group);
+	if (ret)
+		goto err_sysfs;
+
+	madc->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(madc->hwmon_dev)) {
+		dev_err(&pdev->dev, "hwmon_device_register failed.\n");
+		status = PTR_ERR(madc->hwmon_dev);
+		goto err_reg;
+	}
+
+	the_madc = madc;
+	return 0;
+
+err_reg:
+	hwmon_device_unregister(&pdev->dev);
+err_sysfs:
+	sysfs_remove_group(&pdev->dev.kobj, &twl4030_madc_group);
+err_irq:
+	free_irq(platform_get_irq(pdev, 0), madc);
+	platform_set_drvdata(pdev, NULL);
+	twl4030_madc_set_power(madc, 0);
+	twl4030_madc_set_current_generator(madc, 0, 0);
+err_misc:
+	kfree(madc);
+
+	return ret;
+}
+
+static int __devexit twl4030_madc_remove(struct platform_device *pdev)
+{
+	struct twl4030_madc_data *madc = platform_get_drvdata(pdev);
+
+	hwmon_device_unregister(&pdev->dev);
+	sysfs_remove_group(&pdev->dev.kobj, &twl4030_madc_group);
+	free_irq(platform_get_irq(pdev, 0), madc);
+	platform_set_drvdata(pdev, NULL);
+	twl4030_madc_set_current_generator(madc, 0, 0);
+	twl4030_madc_set_power(madc, 0);
+	kfree(madc);
+
+	return 0;
+}
+
+static struct platform_driver twl4030_madc_driver = {
+	.probe = twl4030_madc_probe,
+	.remove = __exit_p(twl4030_madc_remove),
+	.driver = {
+		   .name = "twl4030_madc",
+		   .owner = THIS_MODULE,
+		   },
+};
+
+static int __init twl4030_madc_init(void)
+{
+	return platform_driver_register(&twl4030_madc_driver);
+}
+
+module_init(twl4030_madc_init);
+
+static void __exit twl4030_madc_exit(void)
+{
+	platform_driver_unregister(&twl4030_madc_driver);
+}
+
+module_exit(twl4030_madc_exit);
+
+MODULE_DESCRIPTION("TWL4030 ADC driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("J Keerthy");
diff --git a/include/linux/i2c/twl4030-madc.h b/include/linux/i2c/twl4030-madc.h
new file mode 100644
index 0000000..0e4e227
--- /dev/null
+++ b/include/linux/i2c/twl4030-madc.h
@@ -0,0 +1,118 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef _TWL4030_MADC_H
+#define _TWL4030_MADC_H
+
+struct twl4030_madc_conversion_method {
+	u8 sel;
+	u8 avg;
+	u8 rbase;
+	u8 ctrl;
+};
+
+#define TWL4030_MADC_MAX_CHANNELS 16
+
+struct twl4030_madc_request {
+	u16 channels;
+	u16 do_avg;
+	u16 method;
+	u16 type;
+	bool active;
+	bool result_pending;
+	int rbuf[TWL4030_MADC_MAX_CHANNELS];
+	void (*func_cb)(int len, int channels, int *buf);
+};
+
+enum conversion_methods {
+	TWL4030_MADC_RT,
+	TWL4030_MADC_SW1,
+	TWL4030_MADC_SW2,
+	TWL4030_MADC_NUM_METHODS
+};
+
+enum sample_type {
+	TWL4030_MADC_WAIT,
+	TWL4030_MADC_IRQ_ONESHOT,
+	TWL4030_MADC_IRQ_REARM
+};
+
+#define TWL4030_MADC_CTRL1		0x00
+#define TWL4030_MADC_CTRL2		0x01
+
+#define TWL4030_MADC_RTSELECT_LSB	0x02
+#define TWL4030_MADC_SW1SELECT_LSB	0x06
+#define TWL4030_MADC_SW2SELECT_LSB	0x0A
+
+#define TWL4030_MADC_RTAVERAGE_LSB	0x04
+#define TWL4030_MADC_SW1AVERAGE_LSB	0x08
+#define TWL4030_MADC_SW2AVERAGE_LSB	0x0C
+
+#define TWL4030_MADC_CTRL_SW1		0x12
+#define TWL4030_MADC_CTRL_SW2		0x13
+
+#define TWL4030_MADC_RTCH0_LSB		0x17
+#define TWL4030_MADC_GPCH0_LSB		0x37
+
+#define TWL4030_MADC_MADCON		(1 << 0)	/* MADC power on */
+#define TWL4030_MADC_BUSY		(1 << 0)	/* MADC busy */
+#define TWL4030_MADC_EOC_SW		(1 << 1)	/* MADC conversion completion */
+#define TWL4030_MADC_SW_START		(1 << 5)  /* MADC SWx start conversion */
+
+#define	TWL4030_MADC_ADCIN0		(1 << 0)
+#define	TWL4030_MADC_ADCIN1		(1 << 1)
+#define	TWL4030_MADC_ADCIN2		(1 << 2)
+#define	TWL4030_MADC_ADCIN3		(1 << 3)
+#define	TWL4030_MADC_ADCIN4		(1 << 4)
+#define	TWL4030_MADC_ADCIN5		(1 << 5)
+#define	TWL4030_MADC_ADCIN6		(1 << 6)
+#define	TWL4030_MADC_ADCIN7		(1 << 7)
+#define	TWL4030_MADC_ADCIN8		(1 << 8)
+#define	TWL4030_MADC_ADCIN9		(1 << 9)
+#define	TWL4030_MADC_ADCIN10		(1 << 10)
+#define	TWL4030_MADC_ADCIN11		(1 << 11)
+#define	TWL4030_MADC_ADCIN12		(1 << 12)
+#define	TWL4030_MADC_ADCIN13		(1 << 13)
+#define	TWL4030_MADC_ADCIN14		(1 << 14)
+#define	TWL4030_MADC_ADCIN15		(1 << 15)
+
+/* Fixed channels */
+#define TWL4030_MADC_BTEMP		TWL4030_MADC_ADCIN1
+#define TWL4030_MADC_VBUS		TWL4030_MADC_ADCIN8
+#define TWL4030_MADC_VBKB		TWL4030_MADC_ADCIN9
+#define	TWL4030_MADC_ICHG		TWL4030_MADC_ADCIN10
+#define TWL4030_MADC_VCHG		TWL4030_MADC_ADCIN11
+#define	TWL4030_MADC_VBAT		TWL4030_MADC_ADCIN12
+
+#define TWL4030_BCI_BCICTL1		0x23
+#define	TWL4030_BCI_MESBAT		(1 << 1)
+#define	TWL4030_BCI_TYPEN		(1 << 4)
+#define	TWL4030_BCI_ITHEN		(1 << 3)
+
+#define TWL4030_MADC_IOC_MAGIC '`'
+#define TWL4030_MADC_IOCX_ADC_RAW_READ		_IO(TWL4030_MADC_IOC_MAGIC, 0)
+
+struct twl4030_madc_user_parms {
+	int channel;
+	int average;
+	int status;
+	u16 result;
+};
+
+int twl4030_madc_conversion(struct twl4030_madc_request *conv);
+
+#endif
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
