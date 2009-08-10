From: Justin Chudgar <justin@justinzane.com>
Date: Mon, 10 Aug 2009 21:16:38 +0000
Subject: [lm-sensors] VIA C7 driver module
Message-Id: <200908101416.39509.justin@justinzane.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1805643588766656985=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============1805643588766656985==
Content-Type: multipart/alternative; boundary="Boundary-01=_34IgKhX8/0ET9Ig"
Content-Transfer-Encoding: 7bit

--Boundary-01=_34IgKhX8/0ET9Ig
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Has any progress been made in getting a module selected for the VIA C7 
processors? I had attempted to use Juerg's c7temp, however, due to HP's 
thermal monitoring BIOS settings, I did not get data. 

I would be interesting in testing Harald's module, if it has been selected. 
Could someone help direct me in this?
-- 

Justin Chudgar
Information Technology Consultant
5040 Saddlehorn Rd, Weed, CA 96084
530-938-9692 (Home Office)

On Friday 10 July 2009 03:00:02 am lm-sensors-request@lm-sensors.org wrote:
> Send lm-sensors mailing list submissions to
> 	lm-sensors@lm-sensors.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> 	http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> or, via email, send a message with subject or body 'help' to
> 	lm-sensors-request@lm-sensors.org
>
> You can reach the person managing the list at
> 	lm-sensors-owner@lm-sensors.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of lm-sensors digest..."
>
>
> Today's Topics:
>
>    1. [PATCH 2.6.31-rc2] hwmon: add support for GM/GME965	IGP
>       temperature report. (lu zhihe)
>    2. Re: sensors-detect and c7temp (Juerg Haefliger)
>    3. Re: [PATCH 2.6.31-rc2] hwmon: add support for GM/GME965 IGP
>       temperature report. (Jean Delvare)
>    4. lm-sensors, RHEL 5.3, 32bit (Bill Nackers)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Thu, 9 Jul 2009 13:41:38 +0000
> From: lu zhihe <tombowfly@gmail.com>
> Subject: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for
> 	GM/GME965	IGP temperature report.
> To: lm-sensors@lm-sensors.org
> Message-ID:
> 	<73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
> From: Lu Zhihe <tombowfly@gmail.com>
>
> Subject: [PATCH] hwmon: add support for GM/GME965 IGP temperature report.
>
> Exported the graphics hot spot temperature report via sysfs.
>
> Signed-off-by: Lu Zhihe <tombowfly@gmail.com>
> ---
>
>
> Add GM/GME965 IGP temperature report for hwmon.
>
> The GM/GME965 datasheet can get from:
> http://www.intel.com/Assets/PDF/datasheet/316273.pdf
>
> The Calibration Fomula comes from a earlier version:
> http://www.intel.com/design/chipsets/datashts/313053.htm
> Page 358.
>
>
> diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/Kconfig
> linux-2.6.31-rc2/drivers/hwmon/Kconfig
> --- linux-2.6.31-rc2.orig/drivers/hwmon/Kconfig	2009-07-08
> 23:26:56.000000000 +0000
> +++ linux-2.6.31-rc2/drivers/hwmon/Kconfig	2009-07-08 22:49:37.000000000
> +0000 @@ -401,6 +401,16 @@ config SENSORS_GL520SM
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called gl520sm.
>
> +config SENSORS_GM965
> +        tristate "Intel GM965 temperature sensor"
> +        depends on PCI
> +        help
> +          If you say yes here you get support for GM965 IGP temperatue
> +          sensor.
> +
> +          This driver can also be built as a module.  If so, the module
> +          will be called gm965temp.
> +
>  config SENSORS_CORETEMP
>  	tristate "Intel Core (2) Duo/Solo temperature sensor"
>  	depends on X86 && EXPERIMENTAL
> diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/Makefile
> linux-2.6.31-rc2/drivers/hwmon/Makefile
> --- linux-2.6.31-rc2.orig/drivers/hwmon/Makefile	2009-07-08
> 23:27:07.000000000 +0000
> +++ linux-2.6.31-rc2/drivers/hwmon/Makefile	2009-07-08 22:48:02.000000000
> +0000 @@ -46,6 +46,7 @@ obj-$(CONFIG_SENSORS_FSCPOS)	+= fscpos.o
>  obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
>  obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
>  obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
> +obj-$(CONFIG_SENSORS_GM965)	+= gm965temp.o
>  obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
>  obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
>  obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
> diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/gm965temp.c
> linux-2.6.31-rc2/drivers/hwmon/gm965temp.c
> --- linux-2.6.31-rc2.orig/drivers/hwmon/gm965temp.c	1970-01-01
> 00:00:00.000000000 +0000
> +++ linux-2.6.31-rc2/drivers/hwmon/gm965temp.c	2009-07-09
> 20:25:12.000000000 +0000
> @@ -0,0 +1,348 @@
> +/*
> + * A hwmon driver for the Intel GM/GME965 chipset IGP
> + * temperature sensors
> + *
> + * Copyright (C) 2009 Lu Zhihe <tombowfly at gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
> USA + */
> +
> +#include <linux/module.h>
> +#include <linux/jiffies.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +
> +#define DRVNAME "gm965temp"
> +
> +enum { SHOW_TEMP, SHOW_LABEL } SHOW;
> +
> +#define PCI_DEVICE_ID_INTEL_82965GM       0x2a00
> +#define PCI_DEVICE_ID_INTEL_82965GME      0x2a10
> +#define GM965_SYSFS_NAME_LEN              16
> +
> +#define MCHBAR_I965 0x48      /* MCH Memory Mapped Register BAR */
> +#define MCHBAR_MASK 0xfffffc000ULL  /* bits 35:14 */
> +
> +static ssize_t show_label(struct device *dev,
> +		struct device_attribute *devattr,
> +		char *buf);
> +
> +static ssize_t show_igp_temp(struct device *dev,
> +				struct device_attribute *devattr,
> +				char *buf);
> +
> +struct gm965temp_data {
> +	struct device *hwmon_dev;
> +	struct mutex update_lock;
> +
> +	u64 igp_base;
> +	unsigned long igp_len;
> +	void __iomem *igp_mmio;
> +	unsigned long chipset_id;
> +};
> +
> +static ssize_t show_name(struct device *dev, struct device_attribute
> *devattr, +			 char *buf)
> +{
> +	return sprintf(buf, "%s\n", DRVNAME);
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_igp_temp, NULL,
> SHOW_TEMP);
> +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL,
> SHOW_LABEL); +static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
> +
> +static struct attribute *gm965temp_attributes[] = {
> +	&sensor_dev_attr_temp1_label.dev_attr.attr,
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group gm965temp_group = {
> +	.attrs = gm965temp_attributes,
> +};
> +
> +static struct platform_device *igp_pdev;
> +
> +static u8 igp_read_byte(struct gm965temp_data *data, unsigned long offset)
> +{
> +	return ioread8(data->igp_mmio + offset);
> +}
> +
> +static u16 igp_read_short(struct gm965temp_data *data, unsigned long
> offset) +{
> +	return ioread16(data->igp_mmio + offset);
> +}
> +
> +static void igp_write_short(struct gm965temp_data *data, unsigned long
> offset, +				u16 val)
> +{
> +	iowrite16(val, data->igp_mmio + offset);
> +}
> +
> +static ssize_t show_label(struct device *dev,
> +		struct device_attribute *devattr,
> +		char *buf)
> +{
> +	return sprintf(buf, "GM965 IGP temperature report\n");
> +}
> +
> +#define TSC1	0x1001
> +#define TSS1	0x1004
> +#define TR1	0x1006
> +
> +#define TSE	0x8000
> +#define TMOV	(0x01 << 10)
> +
> +#define MAX_RETRIS  3
> +
> +static ssize_t show_igp_temp(struct device *dev,
> +				struct device_attribute *devattr,
> +				char *buf)
> +{
> +	struct gm965temp_data *data = dev_get_drvdata(dev);
> +	unsigned short tsc1_val = 0;
> +	unsigned char  tr1_val = 0;
> +	unsigned short tss1_val = 0;
> +	unsigned long temp = 0;
> +	int i = 0;
> +	i = MAX_RETRIS;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	tsc1_val = igp_read_short(data, TSC1);
> +
> +	if (!(tsc1_val & TSE)) {
> +		igp_write_short(data, TSC1, tsc1_val|TSE);
> +		tsc1_val = igp_read_short(data, TSC1);
> +	} else {
> +try_againt:
> +		tss1_val = igp_read_short(data, TSS1);
> +
> +		if (tss1_val & TMOV) {
> +			tr1_val = igp_read_byte(data, TR1);
> +		if ((tr1_val != 0xFF) && (tr1_val != 0x0))
> +			temp = (16*tr1_val*tr1_val - 11071*tr1_val + 1610500)
> +				/10;
> +		} else {
> +			do {
> +				mdelay(1);
> +				udelay(300);
> +				goto try_againt;
> +			} while (i--);
> +		}
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +	return sprintf(buf, "%d\n", (unsigned int)temp);
> +}
> +
> +static int __devinit gm965temp_hwmon_init(struct platform_device *pdev)
> +{
> +	int res = 0;
> +	struct gm965temp_data *data = platform_get_drvdata(pdev);
> +
> +	res = device_create_file(&pdev->dev, &dev_attr_name);
> +	if (res)
> +		goto exit_remove;
> +
> +	res = sysfs_create_group(&pdev->dev.kobj, &gm965temp_group);
> +	if (res)
> +		goto exit_dev;
> +
> +	data->hwmon_dev = hwmon_device_register(&pdev->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		res = PTR_ERR(data->hwmon_dev);
> +		goto exit_remove;
> +	}
> +
> +	return res;
> +
> +exit_remove:
> +	sysfs_remove_group(&pdev->dev.kobj, &gm965temp_group);
> +exit_dev:
> +	device_remove_file(&pdev->dev, &dev_attr_name);
> +
> +	return res;
> +}
> +
> +static int __devinit gm965temp_add(void)
> +{
> +	int res = -ENODEV;
> +
> +	/* only ever going to be one of these */
> +	igp_pdev = platform_device_alloc(DRVNAME, 0);
> +	if (!igp_pdev)
> +		return -ENOMEM;
> +
> +	res = platform_device_add(igp_pdev);
> +	if (res)
> +		goto err;
> +	return 0;
> +
> +err:
> +	platform_device_put(igp_pdev);
> +	return res;
> +}
> +
> +static int __devinit gm965_find_igp_registers(struct gm965temp_data *data,
> +					    unsigned long devid)
> +{
> +	struct pci_dev *pcidev;
> +	u32 val32;
> +	u64 val64 = 0x0ULL;
> +	int res = -ENODEV;
> +
> +	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
> +				devid,
> +				NULL);
> +	if (!pcidev) {
> +		printk(KERN_ERR "pci_get_device failed\n");
> +		return -ENODEV;
> +	}
> +
> +	if (pci_read_config_dword(pcidev, MCHBAR_I965 + 4, &val32))
> +		goto out;
> +	val64 = (u64)val32;
> +	val64 <<= 32;
> +	if (pci_read_config_dword(pcidev, MCHBAR_I965, &val32))
> +		goto out;
> +
> +	val64 |= val32;
> +	data->igp_base = val64 & MCHBAR_MASK;
> +	data->igp_len = 16*1024;
> +
> +	data->chipset_id = devid;
> +
> +	res = 0;
> +out:
> +	pci_dev_put(pcidev);
> +	return res;
> +}
> +
> +static unsigned long chipset_ids[] = {
> +	PCI_DEVICE_ID_INTEL_82965GM,
> +	PCI_DEVICE_ID_INTEL_82965GME,
> +	0
> +};
> +
> +static int __devinit gm965temp_probe(struct platform_device *pdev)
> +{
> +	struct gm965temp_data *data;
> +	struct resource *reso;
> +	int i;
> +	int res = -ENODEV;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	i = 0;
> +	do {
> +		res = gm965_find_igp_registers(data, chipset_ids[i]);
> +		i++;
> +	} while (res && chipset_ids[i]);
> +
> +	if (res)
> +		goto err;
> +	/* Set up resource regions */
> +	reso = request_mem_region(data->igp_base, data->igp_len, DRVNAME);
> +	if (!reso) {
> +		printk(KERN_ERR "request_mem_region failed\n");
> +		res = -EBUSY;
> +		goto err;
> +	}
> +
> +	data->igp_mmio = ioremap_nocache(data->igp_base, data->igp_len);
> +	if (!data->igp_mmio) {
> +		printk(KERN_ERR "ioremap_nocache failed\n");
> +		res = -EBUSY;
> +		goto err_map_failed;
> +	}
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	mutex_init(&data->update_lock);
> +
> +	res = gm965temp_hwmon_init(pdev);
> +	if (res)
> +		goto err_init_failed;
> +
> +	return res;
> +
> +err_init_failed:
> +	iounmap(data->igp_mmio);
> +	platform_set_drvdata(pdev, NULL);
> +err_map_failed:
> +	release_mem_region(data->igp_base, data->igp_len);
> +err:
> +	kfree(data);
> +	return res;
> +}
> +
> +static int __devexit gm965temp_remove(struct platform_device *pdev)
> +{
> +	struct gm965temp_data *data = platform_get_drvdata(pdev);
> +	hwmon_device_unregister(data->hwmon_dev);
> +	device_remove_file(&pdev->dev, &dev_attr_name);
> +
> +	iounmap(data->igp_mmio);
> +	release_mem_region(data->igp_base, data->igp_len);
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(data);
> +	return 0;
> +}
> +
> +static struct platform_driver gm965temp_driver = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name = DRVNAME,
> +	},
> +	.probe = gm965temp_probe,
> +	.remove = __devexit_p(gm965temp_remove),
> +};
> +
> +static int __init gm965temp_init(void)
> +{
> +	int res;
> +
> +	res = platform_driver_register(&gm965temp_driver);
> +	if (res)
> +		return res;
> +
> +	res = gm965temp_add();
> +	if (res)
> +		platform_driver_unregister(&gm965temp_driver);
> +
> +	return res;
> +}
> +
> +static void __exit gm965temp_exit(void)
> +{
> +	platform_device_unregister(igp_pdev);
> +	platform_driver_unregister(&gm965temp_driver);
> +}
> +
> +MODULE_AUTHOR("Lu Zhihe");
> +MODULE_DESCRIPTION("Intel GM965 chipset IGP temperature sensor");
> +MODULE_LICENSE("GPL");
> +
> +module_init(gm965temp_init);
> +module_exit(gm965temp_exit);
> +
>
>
>
> ------------------------------
>
> Message: 2
> Date: Thu, 9 Jul 2009 07:19:09 -0700
> From: Juerg Haefliger <juergh@gmail.com>
> Subject: Re: [lm-sensors] sensors-detect and c7temp
> To: Hans de Goede <hdegoede@redhat.com>, Nicolas Chauvet
> 	<kwizart@gmail.com>
> Cc: LM Sensors <lm-sensors@lm-sensors.org>
> Message-ID:
> 	<191fb4ca0907090719u4b4994b6x33a12874b83aaf04@mail.gmail.com>
> Content-Type: text/plain; charset=UTF-8
>
> Hans, Nicholas,
>
> Hans, you reviewed it already a long time ago :-)
> (http://article.gmane.org/gmane.linux.drivers.sensors/17029/match=c7temp)
> I personally don't have a C7 and the driver did never make it into
> mainline I guess mainly because there were quite a few testers that
> reported 0 C temp readings. Some C7 don't seem to have the SW readable
> temp sensor enabled and I couldn't/never had the time to figure out
> what is going on. On top of that, Harald from VIA posted a patch for a
> different driver for the C7.
> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-June/026037.html
>
> Jean was asking which one he should pick to include and I replied with
> a few questions for Harald and we are waiting on a response. The ball
> is in Harald's court.
> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-June/026167.html
>
> Nicholas, feel free to test either or both drivers.
>
> It's time to get either one of them into the kernel. If we don't hear
> from Harald I suggest to pick mine :-)
>
> ...juerg
>
> On Thu, Jul 9, 2009 at 6:13 AM, Hans de Goede<hdegoede@redhat.com> wrote:
> > Hi,
> >
> > On 06/25/2009 09:48 PM, Nicolas Chauvet wrote:
> >> Hello Hans!
> >>
> >> ?From http://www.lm-sensors.org/wiki/Device and about C7 (Esther)
> >>
> >> I own such device, and it seems still requesting testers for the c7temp
> >> driver ?
> >
> > I'm not sure what the status of this driver is, it seems it never made it
> > into
> > the mainline kernel, which is a petty. I hope the author of the driver
> > (Juerg Haefliger <juergh@gmail.com>, in the CC) can answer this.
> >
> > Juerg, what ever happened to the c7temp driver ? Are you still interested
> > in getting it into the mainline? If so Nicolas can test it and I can
> > review it.
> >
> > Thanks & Regards,
> >
> > Hans
>
> ------------------------------
>
> Message: 3
> Date: Thu, 9 Jul 2009 17:33:48 +0200
> From: Jean Delvare <khali@linux-fr.org>
> Subject: Re: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for
> 	GM/GME965 IGP temperature report.
> To: lu zhihe <tombowfly@gmail.com>
> Cc: lm-sensors@lm-sensors.org
> Message-ID: <20090709173348.5bec7f14@hyperion.delvare>
> Content-Type: text/plain; charset=US-ASCII
>
> Hi Lu,
>
> On Thu, 9 Jul 2009 13:41:38 +0000, lu zhihe wrote:
> > From: Lu Zhihe <tombowfly@gmail.com>
> >
> > Subject: [PATCH] hwmon: add support for GM/GME965 IGP temperature report.
> >
> > Exported the graphics hot spot temperature report via sysfs.
> >
> > Signed-off-by: Lu Zhihe <tombowfly@gmail.com>
> > ---
> > (...)
> > +static unsigned long chipset_ids[] = {
> > +	PCI_DEVICE_ID_INTEL_82965GM,
> > +	PCI_DEVICE_ID_INTEL_82965GME,
> > +	0
> > +};
>
> These defines do not exist in the current kernel tree. I presume you
> forgot to includes changes to include/linux/pci_ids.h?
>
> I am also curious what these PCI devices are. We do not want to have
> driver conflicts, so it might make more sense to add hardware
> monitoring functionality to an existing driver than writing a brand new
> driver.

--Boundary-01=_34IgKhX8/0ET9Ig
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd"><html><head><meta name="qrichtext" content="1" /><style type="text/css">p, li { white-space: pre-wrap; }</style></head><body style=" font-family:'DejaVu Serif'; font-size:8pt; font-weight:400; font-style:normal;">Has any progress been made in getting a module selected for the VIA C7 processors? I had attempted to use Juerg's c7temp, however, due to HP's thermal monitoring BIOS settings, I did not get data. <br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>I would be interesting in testing Harald's module, if it has been selected. Could someone help direct me in this?<br />-- <br /><br>
<span style=" font-family:'betecknalowercasebold';">Justin Chudgar</span><br>
Information Technology Consultant<br>
5040 Saddlehorn Rd, Weed, CA 96084<br>
530-938-9692 (Home Office)<br>
<br />On Friday 10 July 2009 03:00:02 am lm-sensors-request@lm-sensors.org wrote:<br>
&gt; Send lm-sensors mailing list submissions to<br>
&gt; 	lm-sensors@lm-sensors.org<br>
&gt;<br>
&gt; To subscribe or unsubscribe via the World Wide Web, visit<br>
&gt; 	http://lists.lm-sensors.org/mailman/listinfo/lm-sensors<br>
&gt; or, via email, send a message with subject or body 'help' to<br>
&gt; 	lm-sensors-request@lm-sensors.org<br>
&gt;<br>
&gt; You can reach the person managing the list at<br>
&gt; 	lm-sensors-owner@lm-sensors.org<br>
&gt;<br>
&gt; When replying, please edit your Subject line so it is more specific<br>
&gt; than "Re: Contents of lm-sensors digest..."<br>
&gt;<br>
&gt;<br>
&gt; Today's Topics:<br>
&gt;<br>
&gt;    1. [PATCH 2.6.31-rc2] hwmon: add support for GM/GME965	IGP<br>
&gt;       temperature report. (lu zhihe)<br>
&gt;    2. Re: sensors-detect and c7temp (Juerg Haefliger)<br>
&gt;    3. Re: [PATCH 2.6.31-rc2] hwmon: add support for GM/GME965 IGP<br>
&gt;       temperature report. (Jean Delvare)<br>
&gt;    4. lm-sensors, RHEL 5.3, 32bit (Bill Nackers)<br>
&gt;<br>
&gt;<br>
&gt; ----------------------------------------------------------------------<br>
&gt;<br>
&gt; Message: 1<br>
&gt; Date: Thu, 9 Jul 2009 13:41:38 +0000<br>
&gt; From: lu zhihe &lt;tombowfly@gmail.com&gt;<br>
&gt; Subject: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for<br>
&gt; 	GM/GME965	IGP temperature report.<br>
&gt; To: lm-sensors@lm-sensors.org<br>
&gt; Message-ID:<br>
&gt; 	&lt;73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com&gt;<br>
&gt; Content-Type: text/plain; charset=ISO-8859-1<br>
&gt;<br>
&gt; From: Lu Zhihe &lt;tombowfly@gmail.com&gt;<br>
&gt;<br>
&gt; Subject: [PATCH] hwmon: add support for GM/GME965 IGP temperature report.<br>
&gt;<br>
&gt; Exported the graphics hot spot temperature report via sysfs.<br>
&gt;<br>
&gt; Signed-off-by: Lu Zhihe &lt;tombowfly@gmail.com&gt;<br>
&gt; ---<br>
&gt;<br>
&gt;<br>
&gt; Add GM/GME965 IGP temperature report for hwmon.<br>
&gt;<br>
&gt; The GM/GME965 datasheet can get from:<br>
&gt; http://www.intel.com/Assets/PDF/datasheet/316273.pdf<br>
&gt;<br>
&gt; The Calibration Fomula comes from a earlier version:<br>
&gt; http://www.intel.com/design/chipsets/datashts/313053.htm<br>
&gt; Page 358.<br>
&gt;<br>
&gt;<br>
&gt; diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/Kconfig<br>
&gt; linux-2.6.31-rc2/drivers/hwmon/Kconfig<br>
&gt; --- linux-2.6.31-rc2.orig/drivers/hwmon/Kconfig	2009-07-08<br>
&gt; 23:26:56.000000000 +0000<br>
&gt; +++ linux-2.6.31-rc2/drivers/hwmon/Kconfig	2009-07-08 22:49:37.000000000<br>
&gt; +0000 @@ -401,6 +401,16 @@ config SENSORS_GL520SM<br>
&gt;  	  This driver can also be built as a module.  If so, the module<br>
&gt;  	  will be called gl520sm.<br>
&gt;<br>
&gt; +config SENSORS_GM965<br>
&gt; +        tristate "Intel GM965 temperature sensor"<br>
&gt; +        depends on PCI<br>
&gt; +        help<br>
&gt; +          If you say yes here you get support for GM965 IGP temperatue<br>
&gt; +          sensor.<br>
&gt; +<br>
&gt; +          This driver can also be built as a module.  If so, the module<br>
&gt; +          will be called gm965temp.<br>
&gt; +<br>
&gt;  config SENSORS_CORETEMP<br>
&gt;  	tristate "Intel Core (2) Duo/Solo temperature sensor"<br>
&gt;  	depends on X86 &amp;&amp; EXPERIMENTAL<br>
&gt; diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/Makefile<br>
&gt; linux-2.6.31-rc2/drivers/hwmon/Makefile<br>
&gt; --- linux-2.6.31-rc2.orig/drivers/hwmon/Makefile	2009-07-08<br>
&gt; 23:27:07.000000000 +0000<br>
&gt; +++ linux-2.6.31-rc2/drivers/hwmon/Makefile	2009-07-08 22:48:02.000000000<br>
&gt; +0000 @@ -46,6 +46,7 @@ obj-$(CONFIG_SENSORS_FSCPOS)	+= fscpos.o<br>
&gt;  obj-$(CONFIG_SENSORS_G760A)	+= g760a.o<br>
&gt;  obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o<br>
&gt;  obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o<br>
&gt; +obj-$(CONFIG_SENSORS_GM965)	+= gm965temp.o<br>
&gt;  obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o<br>
&gt;  obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o<br>
&gt;  obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o<br>
&gt; diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/gm965temp.c<br>
&gt; linux-2.6.31-rc2/drivers/hwmon/gm965temp.c<br>
&gt; --- linux-2.6.31-rc2.orig/drivers/hwmon/gm965temp.c	1970-01-01<br>
&gt; 00:00:00.000000000 +0000<br>
&gt; +++ linux-2.6.31-rc2/drivers/hwmon/gm965temp.c	2009-07-09<br>
&gt; 20:25:12.000000000 +0000<br>
&gt; @@ -0,0 +1,348 @@<br>
&gt; +/*<br>
&gt; + * A hwmon driver for the Intel GM/GME965 chipset IGP<br>
&gt; + * temperature sensors<br>
&gt; + *<br>
&gt; + * Copyright (C) 2009 Lu Zhihe &lt;tombowfly at gmail.com&gt;<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modify<br>
&gt; + * it under the terms of the GNU General Public License as published by<br>
&gt; + * the Free Software Foundation; either version 2 of the License, or<br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License<br>
&gt; + * along with this program; if not, write to the Free Software<br>
&gt; + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 <br>
&gt; USA + */<br>
&gt; +<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/jiffies.h&gt;<br>
&gt; +#include &lt;linux/hwmon.h&gt;<br>
&gt; +#include &lt;linux/hwmon-sysfs.h&gt;<br>
&gt; +#include &lt;linux/err.h&gt;<br>
&gt; +#include &lt;linux/mutex.h&gt;<br>
&gt; +#include &lt;linux/delay.h&gt;<br>
&gt; +#include &lt;linux/pci.h&gt;<br>
&gt; +#include &lt;linux/platform_device.h&gt;<br>
&gt; +<br>
&gt; +#define DRVNAME "gm965temp"<br>
&gt; +<br>
&gt; +enum { SHOW_TEMP, SHOW_LABEL } SHOW;<br>
&gt; +<br>
&gt; +#define PCI_DEVICE_ID_INTEL_82965GM       0x2a00<br>
&gt; +#define PCI_DEVICE_ID_INTEL_82965GME      0x2a10<br>
&gt; +#define GM965_SYSFS_NAME_LEN              16<br>
&gt; +<br>
&gt; +#define MCHBAR_I965 0x48      /* MCH Memory Mapped Register BAR */<br>
&gt; +#define MCHBAR_MASK 0xfffffc000ULL  /* bits 35:14 */<br>
&gt; +<br>
&gt; +static ssize_t show_label(struct device *dev,<br>
&gt; +		struct device_attribute *devattr,<br>
&gt; +		char *buf);<br>
&gt; +<br>
&gt; +static ssize_t show_igp_temp(struct device *dev,<br>
&gt; +				struct device_attribute *devattr,<br>
&gt; +				char *buf);<br>
&gt; +<br>
&gt; +struct gm965temp_data {<br>
&gt; +	struct device *hwmon_dev;<br>
&gt; +	struct mutex update_lock;<br>
&gt; +<br>
&gt; +	u64 igp_base;<br>
&gt; +	unsigned long igp_len;<br>
&gt; +	void __iomem *igp_mmio;<br>
&gt; +	unsigned long chipset_id;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static ssize_t show_name(struct device *dev, struct device_attribute<br>
&gt; *devattr, +			 char *buf)<br>
&gt; +{<br>
&gt; +	return sprintf(buf, "%s\n", DRVNAME);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_igp_temp, NULL,<br>
&gt; SHOW_TEMP);<br>
&gt; +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL,<br>
&gt; SHOW_LABEL); +static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);<br>
&gt; +<br>
&gt; +static struct attribute *gm965temp_attributes[] = {<br>
&gt; +	&amp;sensor_dev_attr_temp1_label.dev_attr.attr,<br>
&gt; +	&amp;sensor_dev_attr_temp1_input.dev_attr.attr,<br>
&gt; +	NULL<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct attribute_group gm965temp_group = {<br>
&gt; +	.attrs = gm965temp_attributes,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static struct platform_device *igp_pdev;<br>
&gt; +<br>
&gt; +static u8 igp_read_byte(struct gm965temp_data *data, unsigned long offset)<br>
&gt; +{<br>
&gt; +	return ioread8(data-&gt;igp_mmio + offset);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static u16 igp_read_short(struct gm965temp_data *data, unsigned long<br>
&gt; offset) +{<br>
&gt; +	return ioread16(data-&gt;igp_mmio + offset);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void igp_write_short(struct gm965temp_data *data, unsigned long<br>
&gt; offset, +				u16 val)<br>
&gt; +{<br>
&gt; +	iowrite16(val, data-&gt;igp_mmio + offset);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t show_label(struct device *dev,<br>
&gt; +		struct device_attribute *devattr,<br>
&gt; +		char *buf)<br>
&gt; +{<br>
&gt; +	return sprintf(buf, "GM965 IGP temperature report\n");<br>
&gt; +}<br>
&gt; +<br>
&gt; +#define TSC1	0x1001<br>
&gt; +#define TSS1	0x1004<br>
&gt; +#define TR1	0x1006<br>
&gt; +<br>
&gt; +#define TSE	0x8000<br>
&gt; +#define TMOV	(0x01 &lt;&lt; 10)<br>
&gt; +<br>
&gt; +#define MAX_RETRIS  3<br>
&gt; +<br>
&gt; +static ssize_t show_igp_temp(struct device *dev,<br>
&gt; +				struct device_attribute *devattr,<br>
&gt; +				char *buf)<br>
&gt; +{<br>
&gt; +	struct gm965temp_data *data = dev_get_drvdata(dev);<br>
&gt; +	unsigned short tsc1_val = 0;<br>
&gt; +	unsigned char  tr1_val = 0;<br>
&gt; +	unsigned short tss1_val = 0;<br>
&gt; +	unsigned long temp = 0;<br>
&gt; +	int i = 0;<br>
&gt; +	i = MAX_RETRIS;<br>
&gt; +<br>
&gt; +	mutex_lock(&amp;data-&gt;update_lock);<br>
&gt; +<br>
&gt; +	tsc1_val = igp_read_short(data, TSC1);<br>
&gt; +<br>
&gt; +	if (!(tsc1_val &amp; TSE)) {<br>
&gt; +		igp_write_short(data, TSC1, tsc1_val|TSE);<br>
&gt; +		tsc1_val = igp_read_short(data, TSC1);<br>
&gt; +	} else {<br>
&gt; +try_againt:<br>
&gt; +		tss1_val = igp_read_short(data, TSS1);<br>
&gt; +<br>
&gt; +		if (tss1_val &amp; TMOV) {<br>
&gt; +			tr1_val = igp_read_byte(data, TR1);<br>
&gt; +		if ((tr1_val != 0xFF) &amp;&amp; (tr1_val != 0x0))<br>
&gt; +			temp = (16*tr1_val*tr1_val - 11071*tr1_val + 1610500)<br>
&gt; +				/10;<br>
&gt; +		} else {<br>
&gt; +			do {<br>
&gt; +				mdelay(1);<br>
&gt; +				udelay(300);<br>
&gt; +				goto try_againt;<br>
&gt; +			} while (i--);<br>
&gt; +		}<br>
&gt; +	}<br>
&gt; +<br>
&gt; +	mutex_unlock(&amp;data-&gt;update_lock);<br>
&gt; +	return sprintf(buf, "%d\n", (unsigned int)temp);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int __devinit gm965temp_hwmon_init(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +	int res = 0;<br>
&gt; +	struct gm965temp_data *data = platform_get_drvdata(pdev);<br>
&gt; +<br>
&gt; +	res = device_create_file(&amp;pdev-&gt;dev, &amp;dev_attr_name);<br>
&gt; +	if (res)<br>
&gt; +		goto exit_remove;<br>
&gt; +<br>
&gt; +	res = sysfs_create_group(&amp;pdev-&gt;dev.kobj, &amp;gm965temp_group);<br>
&gt; +	if (res)<br>
&gt; +		goto exit_dev;<br>
&gt; +<br>
&gt; +	data-&gt;hwmon_dev = hwmon_device_register(&amp;pdev-&gt;dev);<br>
&gt; +	if (IS_ERR(data-&gt;hwmon_dev)) {<br>
&gt; +		res = PTR_ERR(data-&gt;hwmon_dev);<br>
&gt; +		goto exit_remove;<br>
&gt; +	}<br>
&gt; +<br>
&gt; +	return res;<br>
&gt; +<br>
&gt; +exit_remove:<br>
&gt; +	sysfs_remove_group(&amp;pdev-&gt;dev.kobj, &amp;gm965temp_group);<br>
&gt; +exit_dev:<br>
&gt; +	device_remove_file(&amp;pdev-&gt;dev, &amp;dev_attr_name);<br>
&gt; +<br>
&gt; +	return res;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int __devinit gm965temp_add(void)<br>
&gt; +{<br>
&gt; +	int res = -ENODEV;<br>
&gt; +<br>
&gt; +	/* only ever going to be one of these */<br>
&gt; +	igp_pdev = platform_device_alloc(DRVNAME, 0);<br>
&gt; +	if (!igp_pdev)<br>
&gt; +		return -ENOMEM;<br>
&gt; +<br>
&gt; +	res = platform_device_add(igp_pdev);<br>
&gt; +	if (res)<br>
&gt; +		goto err;<br>
&gt; +	return 0;<br>
&gt; +<br>
&gt; +err:<br>
&gt; +	platform_device_put(igp_pdev);<br>
&gt; +	return res;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int __devinit gm965_find_igp_registers(struct gm965temp_data *data,<br>
&gt; +					    unsigned long devid)<br>
&gt; +{<br>
&gt; +	struct pci_dev *pcidev;<br>
&gt; +	u32 val32;<br>
&gt; +	u64 val64 = 0x0ULL;<br>
&gt; +	int res = -ENODEV;<br>
&gt; +<br>
&gt; +	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,<br>
&gt; +				devid,<br>
&gt; +				NULL);<br>
&gt; +	if (!pcidev) {<br>
&gt; +		printk(KERN_ERR "pci_get_device failed\n");<br>
&gt; +		return -ENODEV;<br>
&gt; +	}<br>
&gt; +<br>
&gt; +	if (pci_read_config_dword(pcidev, MCHBAR_I965 + 4, &amp;val32))<br>
&gt; +		goto out;<br>
&gt; +	val64 = (u64)val32;<br>
&gt; +	val64 &lt;&lt;= 32;<br>
&gt; +	if (pci_read_config_dword(pcidev, MCHBAR_I965, &amp;val32))<br>
&gt; +		goto out;<br>
&gt; +<br>
&gt; +	val64 |= val32;<br>
&gt; +	data-&gt;igp_base = val64 &amp; MCHBAR_MASK;<br>
&gt; +	data-&gt;igp_len = 16*1024;<br>
&gt; +<br>
&gt; +	data-&gt;chipset_id = devid;<br>
&gt; +<br>
&gt; +	res = 0;<br>
&gt; +out:<br>
&gt; +	pci_dev_put(pcidev);<br>
&gt; +	return res;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static unsigned long chipset_ids[] = {<br>
&gt; +	PCI_DEVICE_ID_INTEL_82965GM,<br>
&gt; +	PCI_DEVICE_ID_INTEL_82965GME,<br>
&gt; +	0<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int __devinit gm965temp_probe(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +	struct gm965temp_data *data;<br>
&gt; +	struct resource *reso;<br>
&gt; +	int i;<br>
&gt; +	int res = -ENODEV;<br>
&gt; +<br>
&gt; +	data = kzalloc(sizeof(*data), GFP_KERNEL);<br>
&gt; +	if (!data)<br>
&gt; +		return -ENOMEM;<br>
&gt; +<br>
&gt; +	i = 0;<br>
&gt; +	do {<br>
&gt; +		res = gm965_find_igp_registers(data, chipset_ids[i]);<br>
&gt; +		i++;<br>
&gt; +	} while (res &amp;&amp; chipset_ids[i]);<br>
&gt; +<br>
&gt; +	if (res)<br>
&gt; +		goto err;<br>
&gt; +	/* Set up resource regions */<br>
&gt; +	reso = request_mem_region(data-&gt;igp_base, data-&gt;igp_len, DRVNAME);<br>
&gt; +	if (!reso) {<br>
&gt; +		printk(KERN_ERR "request_mem_region failed\n");<br>
&gt; +		res = -EBUSY;<br>
&gt; +		goto err;<br>
&gt; +	}<br>
&gt; +<br>
&gt; +	data-&gt;igp_mmio = ioremap_nocache(data-&gt;igp_base, data-&gt;igp_len);<br>
&gt; +	if (!data-&gt;igp_mmio) {<br>
&gt; +		printk(KERN_ERR "ioremap_nocache failed\n");<br>
&gt; +		res = -EBUSY;<br>
&gt; +		goto err_map_failed;<br>
&gt; +	}<br>
&gt; +<br>
&gt; +	platform_set_drvdata(pdev, data);<br>
&gt; +<br>
&gt; +	mutex_init(&amp;data-&gt;update_lock);<br>
&gt; +<br>
&gt; +	res = gm965temp_hwmon_init(pdev);<br>
&gt; +	if (res)<br>
&gt; +		goto err_init_failed;<br>
&gt; +<br>
&gt; +	return res;<br>
&gt; +<br>
&gt; +err_init_failed:<br>
&gt; +	iounmap(data-&gt;igp_mmio);<br>
&gt; +	platform_set_drvdata(pdev, NULL);<br>
&gt; +err_map_failed:<br>
&gt; +	release_mem_region(data-&gt;igp_base, data-&gt;igp_len);<br>
&gt; +err:<br>
&gt; +	kfree(data);<br>
&gt; +	return res;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int __devexit gm965temp_remove(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +	struct gm965temp_data *data = platform_get_drvdata(pdev);<br>
&gt; +	hwmon_device_unregister(data-&gt;hwmon_dev);<br>
&gt; +	device_remove_file(&amp;pdev-&gt;dev, &amp;dev_attr_name);<br>
&gt; +<br>
&gt; +	iounmap(data-&gt;igp_mmio);<br>
&gt; +	release_mem_region(data-&gt;igp_base, data-&gt;igp_len);<br>
&gt; +	platform_set_drvdata(pdev, NULL);<br>
&gt; +	kfree(data);<br>
&gt; +	return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct platform_driver gm965temp_driver = {<br>
&gt; +	.driver = {<br>
&gt; +		.owner = THIS_MODULE,<br>
&gt; +		.name = DRVNAME,<br>
&gt; +	},<br>
&gt; +	.probe = gm965temp_probe,<br>
&gt; +	.remove = __devexit_p(gm965temp_remove),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int __init gm965temp_init(void)<br>
&gt; +{<br>
&gt; +	int res;<br>
&gt; +<br>
&gt; +	res = platform_driver_register(&amp;gm965temp_driver);<br>
&gt; +	if (res)<br>
&gt; +		return res;<br>
&gt; +<br>
&gt; +	res = gm965temp_add();<br>
&gt; +	if (res)<br>
&gt; +		platform_driver_unregister(&amp;gm965temp_driver);<br>
&gt; +<br>
&gt; +	return res;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void __exit gm965temp_exit(void)<br>
&gt; +{<br>
&gt; +	platform_device_unregister(igp_pdev);<br>
&gt; +	platform_driver_unregister(&amp;gm965temp_driver);<br>
&gt; +}<br>
&gt; +<br>
&gt; +MODULE_AUTHOR("Lu Zhihe");<br>
&gt; +MODULE_DESCRIPTION("Intel GM965 chipset IGP temperature sensor");<br>
&gt; +MODULE_LICENSE("GPL");<br>
&gt; +<br>
&gt; +module_init(gm965temp_init);<br>
&gt; +module_exit(gm965temp_exit);<br>
&gt; +<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ------------------------------<br>
&gt;<br>
&gt; Message: 2<br>
&gt; Date: Thu, 9 Jul 2009 07:19:09 -0700<br>
&gt; From: Juerg Haefliger &lt;juergh@gmail.com&gt;<br>
&gt; Subject: Re: [lm-sensors] sensors-detect and c7temp<br>
&gt; To: Hans de Goede &lt;hdegoede@redhat.com&gt;, Nicolas Chauvet<br>
&gt; 	&lt;kwizart@gmail.com&gt;<br>
&gt; Cc: LM Sensors &lt;lm-sensors@lm-sensors.org&gt;<br>
&gt; Message-ID:<br>
&gt; 	&lt;191fb4ca0907090719u4b4994b6x33a12874b83aaf04@mail.gmail.com&gt;<br>
&gt; Content-Type: text/plain; charset=UTF-8<br>
&gt;<br>
&gt; Hans, Nicholas,<br>
&gt;<br>
&gt; Hans, you reviewed it already a long time ago :-)<br>
&gt; (http://article.gmane.org/gmane.linux.drivers.sensors/17029/match=c7temp)<br>
&gt; I personally don't have a C7 and the driver did never make it into<br>
&gt; mainline I guess mainly because there were quite a few testers that<br>
&gt; reported 0 C temp readings. Some C7 don't seem to have the SW readable<br>
&gt; temp sensor enabled and I couldn't/never had the time to figure out<br>
&gt; what is going on. On top of that, Harald from VIA posted a patch for a<br>
&gt; different driver for the C7.<br>
&gt; http://lists.lm-sensors.org/pipermail/lm-sensors/2009-June/026037.html<br>
&gt;<br>
&gt; Jean was asking which one he should pick to include and I replied with<br>
&gt; a few questions for Harald and we are waiting on a response. The ball<br>
&gt; is in Harald's court.<br>
&gt; http://lists.lm-sensors.org/pipermail/lm-sensors/2009-June/026167.html<br>
&gt;<br>
&gt; Nicholas, feel free to test either or both drivers.<br>
&gt;<br>
&gt; It's time to get either one of them into the kernel. If we don't hear<br>
&gt; from Harald I suggest to pick mine :-)<br>
&gt;<br>
&gt; ...juerg<br>
&gt;<br>
&gt; On Thu, Jul 9, 2009 at 6:13 AM, Hans de Goede&lt;hdegoede@redhat.com&gt; wrote:<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; On 06/25/2009 09:48 PM, Nicolas Chauvet wrote:<br>
&gt; &gt;&gt; Hello Hans!<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; ?From http://www.lm-sensors.org/wiki/Device and about C7 (Esther)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I own such device, and it seems still requesting testers for the c7temp<br>
&gt; &gt;&gt; driver ?<br>
&gt; &gt;<br>
&gt; &gt; I'm not sure what the status of this driver is, it seems it never made it<br>
&gt; &gt; into<br>
&gt; &gt; the mainline kernel, which is a petty. I hope the author of the driver<br>
&gt; &gt; (Juerg Haefliger &lt;juergh@gmail.com&gt;, in the CC) can answer this.<br>
&gt; &gt;<br>
&gt; &gt; Juerg, what ever happened to the c7temp driver ? Are you still interested<br>
&gt; &gt; in getting it into the mainline? If so Nicolas can test it and I can<br>
&gt; &gt; review it.<br>
&gt; &gt;<br>
&gt; &gt; Thanks &amp; Regards,<br>
&gt; &gt;<br>
&gt; &gt; Hans<br>
&gt;<br>
&gt; ------------------------------<br>
&gt;<br>
&gt; Message: 3<br>
&gt; Date: Thu, 9 Jul 2009 17:33:48 +0200<br>
&gt; From: Jean Delvare &lt;khali@linux-fr.org&gt;<br>
&gt; Subject: Re: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for<br>
&gt; 	GM/GME965 IGP temperature report.<br>
&gt; To: lu zhihe &lt;tombowfly@gmail.com&gt;<br>
&gt; Cc: lm-sensors@lm-sensors.org<br>
&gt; Message-ID: &lt;20090709173348.5bec7f14@hyperion.delvare&gt;<br>
&gt; Content-Type: text/plain; charset=US-ASCII<br>
&gt;<br>
&gt; Hi Lu,<br>
&gt;<br>
&gt; On Thu, 9 Jul 2009 13:41:38 +0000, lu zhihe wrote:<br>
&gt; &gt; From: Lu Zhihe &lt;tombowfly@gmail.com&gt;<br>
&gt; &gt;<br>
&gt; &gt; Subject: [PATCH] hwmon: add support for GM/GME965 IGP temperature report.<br>
&gt; &gt;<br>
&gt; &gt; Exported the graphics hot spot temperature report via sysfs.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Lu Zhihe &lt;tombowfly@gmail.com&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; (...)<br>
&gt; &gt; +static unsigned long chipset_ids[] = {<br>
&gt; &gt; +	PCI_DEVICE_ID_INTEL_82965GM,<br>
&gt; &gt; +	PCI_DEVICE_ID_INTEL_82965GME,<br>
&gt; &gt; +	0<br>
&gt; &gt; +};<br>
&gt;<br>
&gt; These defines do not exist in the current kernel tree. I presume you<br>
&gt; forgot to includes changes to include/linux/pci_ids.h?<br>
&gt;<br>
&gt; I am also curious what these PCI devices are. We do not want to have<br>
&gt; driver conflicts, so it might make more sense to add hardware<br>
&gt; monitoring functionality to an existing driver than writing a brand new<br>
&gt; driver.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p></body></html>
--Boundary-01=_34IgKhX8/0ET9Ig--


--===============1805643588766656985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1805643588766656985==--
