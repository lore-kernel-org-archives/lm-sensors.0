From: Juerg Haefliger <juergh@gmail.com>
Date: Mon, 10 Aug 2009 21:30:29 +0000
Subject: Re: [lm-sensors] VIA C7 driver module
Message-Id: <191fb4ca0908101430i496088fj3a98baa87ebdb731@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200908101416.39509.justin@justinzane.com>
In-Reply-To: <200908101416.39509.justin@justinzane.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Justin,

No progress. I'm waiting for some answers from Harald. In fact I was
about to suggest to Jean to push my driver upstream since Harald is
not very responsive (or just too busy).

But please give Harald's driver a try. I'd be curious to know if you
get anything with his driver.
The patch for his driver is here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2009-June/026037.html

...juerg



On Mon, Aug 10, 2009 at 2:16 PM, Justin Chudgar<justin@justinzane.com> wrot=
e:
> Has any progress been made in getting a module selected for the VIA C7
> processors? I had attempted to use Juerg's c7temp, however, due to HP's
> thermal monitoring BIOS settings, I did not get data.
>
> I would be interesting in testing Harald's module, if it has been selecte=
d.
> Could someone help direct me in this?
> --
>
> Justin Chudgar
> Information Technology Consultant
> 5040 Saddlehorn Rd, Weed, CA 96084
> 530-938-9692 (Home Office)
>
> On Friday 10 July 2009 03:00:02 am lm-sensors-request@lm-sensors.org wrot=
e:
>> Send lm-sensors mailing list submissions to
>> lm-sensors@lm-sensors.org
>>
>> To subscribe or unsubscribe via the World Wide Web, visit
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>> or, via email, send a message with subject or body 'help' to
>> lm-sensors-request@lm-sensors.org
>>
>> You can reach the person managing the list at
>> lm-sensors-owner@lm-sensors.org
>>
>> When replying, please edit your Subject line so it is more specific
>> than "Re: Contents of lm-sensors digest..."
>>
>>
>> Today's Topics:
>>
>> 1. [PATCH 2.6.31-rc2] hwmon: add support for GM/GME965 IGP
>> temperature report. (lu zhihe)
>> 2. Re: sensors-detect and c7temp (Juerg Haefliger)
>> 3. Re: [PATCH 2.6.31-rc2] hwmon: add support for GM/GME965 IGP
>> temperature report. (Jean Delvare)
>> 4. lm-sensors, RHEL 5.3, 32bit (Bill Nackers)
>>
>>
>> ----------------------------------------------------------------------
>>
>> Message: 1
>> Date: Thu, 9 Jul 2009 13:41:38 +0000
>> From: lu zhihe <tombowfly@gmail.com>
>> Subject: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for
>> GM/GME965 IGP temperature report.
>> To: lm-sensors@lm-sensors.org
>> Message-ID:
>> <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
>> Content-Type: text/plain; charset=3DISO-8859-1
>>
>> From: Lu Zhihe <tombowfly@gmail.com>
>>
>> Subject: [PATCH] hwmon: add support for GM/GME965 IGP temperature report.
>>
>> Exported the graphics hot spot temperature report via sysfs.
>>
>> Signed-off-by: Lu Zhihe <tombowfly@gmail.com>
>> ---
>>
>>
>> Add GM/GME965 IGP temperature report for hwmon.
>>
>> The GM/GME965 datasheet can get from:
>> http://www.intel.com/Assets/PDF/datasheet/316273.pdf
>>
>> The Calibration Fomula comes from a earlier version:
>> http://www.intel.com/design/chipsets/datashts/313053.htm
>> Page 358.
>>
>>
>> diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/Kconfig
>> linux-2.6.31-rc2/drivers/hwmon/Kconfig
>> --- linux-2.6.31-rc2.orig/drivers/hwmon/Kconfig 2009-07-08
>> 23:26:56.000000000 +0000
>> +++ linux-2.6.31-rc2/drivers/hwmon/Kconfig 2009-07-08 22:49:37.000000000
>> +0000 @@ -401,6 +401,16 @@ config SENSORS_GL520SM
>> This driver can also be built as a module. If so, the module
>> will be called gl520sm.
>>
>> +config SENSORS_GM965
>> + tristate "Intel GM965 temperature sensor"
>> + depends on PCI
>> + help
>> + If you say yes here you get support for GM965 IGP temperatue
>> + sensor.
>> +
>> + This driver can also be built as a module. If so, the module
>> + will be called gm965temp.
>> +
>> config SENSORS_CORETEMP
>> tristate "Intel Core (2) Duo/Solo temperature sensor"
>> depends on X86 && EXPERIMENTAL
>> diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/Makefile
>> linux-2.6.31-rc2/drivers/hwmon/Makefile
>> --- linux-2.6.31-rc2.orig/drivers/hwmon/Makefile 2009-07-08
>> 23:27:07.000000000 +0000
>> +++ linux-2.6.31-rc2/drivers/hwmon/Makefile 2009-07-08 22:48:02.000000000
>> +0000 @@ -46,6 +46,7 @@ obj-$(CONFIG_SENSORS_FSCPOS) +=3D fscpos.o
>> obj-$(CONFIG_SENSORS_G760A) +=3D g760a.o
>> obj-$(CONFIG_SENSORS_GL518SM) +=3D gl518sm.o
>> obj-$(CONFIG_SENSORS_GL520SM) +=3D gl520sm.o
>> +obj-$(CONFIG_SENSORS_GM965) +=3D gm965temp.o
>> obj-$(CONFIG_SENSORS_ULTRA45) +=3D ultra45_env.o
>> obj-$(CONFIG_SENSORS_HDAPS) +=3D hdaps.o
>> obj-$(CONFIG_SENSORS_I5K_AMB) +=3D i5k_amb.o
>> diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/gm965temp.c
>> linux-2.6.31-rc2/drivers/hwmon/gm965temp.c
>> --- linux-2.6.31-rc2.orig/drivers/hwmon/gm965temp.c 1970-01-01
>> 00:00:00.000000000 +0000
>> +++ linux-2.6.31-rc2/drivers/hwmon/gm965temp.c 2009-07-09
>> 20:25:12.000000000 +0000
>> @@ -0,0 +1,348 @@
>> +/*
>> + * A hwmon driver for the Intel GM/GME965 chipset IGP
>> + * temperature sensors
>> + *
>> + * Copyright (C) 2009 Lu Zhihe <tombowfly at gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
>> USA + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +#include <linux/err.h>
>> +#include <linux/mutex.h>
>> +#include <linux/delay.h>
>> +#include <linux/pci.h>
>> +#include <linux/platform_device.h>
>> +
>> +#define DRVNAME "gm965temp"
>> +
>> +enum { SHOW_TEMP, SHOW_LABEL } SHOW;
>> +
>> +#define PCI_DEVICE_ID_INTEL_82965GM 0x2a00
>> +#define PCI_DEVICE_ID_INTEL_82965GME 0x2a10
>> +#define GM965_SYSFS_NAME_LEN 16
>> +
>> +#define MCHBAR_I965 0x48 /* MCH Memory Mapped Register BAR */
>> +#define MCHBAR_MASK 0xfffffc000ULL /* bits 35:14 */
>> +
>> +static ssize_t show_label(struct device *dev,
>> + struct device_attribute *devattr,
>> + char *buf);
>> +
>> +static ssize_t show_igp_temp(struct device *dev,
>> + struct device_attribute *devattr,
>> + char *buf);
>> +
>> +struct gm965temp_data {
>> + struct device *hwmon_dev;
>> + struct mutex update_lock;
>> +
>> + u64 igp_base;
>> + unsigned long igp_len;
>> + void __iomem *igp_mmio;
>> + unsigned long chipset_id;
>> +};
>> +
>> +static ssize_t show_name(struct device *dev, struct device_attribute
>> *devattr, + char *buf)
>> +{
>> + return sprintf(buf, "%s\n", DRVNAME);
>> +}
>> +
>> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_igp_temp, NULL,
>> SHOW_TEMP);
>> +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL,
>> SHOW_LABEL); +static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
>> +
>> +static struct attribute *gm965temp_attributes[] =3D {
>> + &sensor_dev_attr_temp1_label.dev_attr.attr,
>> + &sensor_dev_attr_temp1_input.dev_attr.attr,
>> + NULL
>> +};
>> +
>> +static const struct attribute_group gm965temp_group =3D {
>> + .attrs =3D gm965temp_attributes,
>> +};
>> +
>> +static struct platform_device *igp_pdev;
>> +
>> +static u8 igp_read_byte(struct gm965temp_data *data, unsigned long
>> offset)
>> +{
>> + return ioread8(data->igp_mmio + offset);
>> +}
>> +
>> +static u16 igp_read_short(struct gm965temp_data *data, unsigned long
>> offset) +{
>> + return ioread16(data->igp_mmio + offset);
>> +}
>> +
>> +static void igp_write_short(struct gm965temp_data *data, unsigned long
>> offset, + u16 val)
>> +{
>> + iowrite16(val, data->igp_mmio + offset);
>> +}
>> +
>> +static ssize_t show_label(struct device *dev,
>> + struct device_attribute *devattr,
>> + char *buf)
>> +{
>> + return sprintf(buf, "GM965 IGP temperature report\n");
>> +}
>> +
>> +#define TSC1 0x1001
>> +#define TSS1 0x1004
>> +#define TR1 0x1006
>> +
>> +#define TSE 0x8000
>> +#define TMOV (0x01 << 10)
>> +
>> +#define MAX_RETRIS 3
>> +
>> +static ssize_t show_igp_temp(struct device *dev,
>> + struct device_attribute *devattr,
>> + char *buf)
>> +{
>> + struct gm965temp_data *data =3D dev_get_drvdata(dev);
>> + unsigned short tsc1_val =3D 0;
>> + unsigned char tr1_val =3D 0;
>> + unsigned short tss1_val =3D 0;
>> + unsigned long temp =3D 0;
>> + int i =3D 0;
>> + i =3D MAX_RETRIS;
>> +
>> + mutex_lock(&data->update_lock);
>> +
>> + tsc1_val =3D igp_read_short(data, TSC1);
>> +
>> + if (!(tsc1_val & TSE)) {
>> + igp_write_short(data, TSC1, tsc1_val|TSE);
>> + tsc1_val =3D igp_read_short(data, TSC1);
>> + } else {
>> +try_againt:
>> + tss1_val =3D igp_read_short(data, TSS1);
>> +
>> + if (tss1_val & TMOV) {
>> + tr1_val =3D igp_read_byte(data, TR1);
>> + if ((tr1_val !=3D 0xFF) && (tr1_val !=3D 0x0))
>> + temp =3D (16*tr1_val*tr1_val - 11071*tr1_val + 1610500)
>> + /10;
>> + } else {
>> + do {
>> + mdelay(1);
>> + udelay(300);
>> + goto try_againt;
>> + } while (i--);
>> + }
>> + }
>> +
>> + mutex_unlock(&data->update_lock);
>> + return sprintf(buf, "%d\n", (unsigned int)temp);
>> +}
>> +
>> +static int __devinit gm965temp_hwmon_init(struct platform_device *pdev)
>> +{
>> + int res =3D 0;
>> + struct gm965temp_data *data =3D platform_get_drvdata(pdev);
>> +
>> + res =3D device_create_file(&pdev->dev, &dev_attr_name);
>> + if (res)
>> + goto exit_remove;
>> +
>> + res =3D sysfs_create_group(&pdev->dev.kobj, &gm965temp_group);
>> + if (res)
>> + goto exit_dev;
>> +
>> + data->hwmon_dev =3D hwmon_device_register(&pdev->dev);
>> + if (IS_ERR(data->hwmon_dev)) {
>> + res =3D PTR_ERR(data->hwmon_dev);
>> + goto exit_remove;
>> + }
>> +
>> + return res;
>> +
>> +exit_remove:
>> + sysfs_remove_group(&pdev->dev.kobj, &gm965temp_group);
>> +exit_dev:
>> + device_remove_file(&pdev->dev, &dev_attr_name);
>> +
>> + return res;
>> +}
>> +
>> +static int __devinit gm965temp_add(void)
>> +{
>> + int res =3D -ENODEV;
>> +
>> + /* only ever going to be one of these */
>> + igp_pdev =3D platform_device_alloc(DRVNAME, 0);
>> + if (!igp_pdev)
>> + return -ENOMEM;
>> +
>> + res =3D platform_device_add(igp_pdev);
>> + if (res)
>> + goto err;
>> + return 0;
>> +
>> +err:
>> + platform_device_put(igp_pdev);
>> + return res;
>> +}
>> +
>> +static int __devinit gm965_find_igp_registers(struct gm965temp_data
>> *data,
>> + unsigned long devid)
>> +{
>> + struct pci_dev *pcidev;
>> + u32 val32;
>> + u64 val64 =3D 0x0ULL;
>> + int res =3D -ENODEV;
>> +
>> + pcidev =3D pci_get_device(PCI_VENDOR_ID_INTEL,
>> + devid,
>> + NULL);
>> + if (!pcidev) {
>> + printk(KERN_ERR "pci_get_device failed\n");
>> + return -ENODEV;
>> + }
>> +
>> + if (pci_read_config_dword(pcidev, MCHBAR_I965 + 4, &val32))
>> + goto out;
>> + val64 =3D (u64)val32;
>> + val64 <<=3D 32;
>> + if (pci_read_config_dword(pcidev, MCHBAR_I965, &val32))
>> + goto out;
>> +
>> + val64 |=3D val32;
>> + data->igp_base =3D val64 & MCHBAR_MASK;
>> + data->igp_len =3D 16*1024;
>> +
>> + data->chipset_id =3D devid;
>> +
>> + res =3D 0;
>> +out:
>> + pci_dev_put(pcidev);
>> + return res;
>> +}
>> +
>> +static unsigned long chipset_ids[] =3D {
>> + PCI_DEVICE_ID_INTEL_82965GM,
>> + PCI_DEVICE_ID_INTEL_82965GME,
>> + 0
>> +};
>> +
>> +static int __devinit gm965temp_probe(struct platform_device *pdev)
>> +{
>> + struct gm965temp_data *data;
>> + struct resource *reso;
>> + int i;
>> + int res =3D -ENODEV;
>> +
>> + data =3D kzalloc(sizeof(*data), GFP_KERNEL);
>> + if (!data)
>> + return -ENOMEM;
>> +
>> + i =3D 0;
>> + do {
>> + res =3D gm965_find_igp_registers(data, chipset_ids[i]);
>> + i++;
>> + } while (res && chipset_ids[i]);
>> +
>> + if (res)
>> + goto err;
>> + /* Set up resource regions */
>> + reso =3D request_mem_region(data->igp_base, data->igp_len, DRVNAME);
>> + if (!reso) {
>> + printk(KERN_ERR "request_mem_region failed\n");
>> + res =3D -EBUSY;
>> + goto err;
>> + }
>> +
>> + data->igp_mmio =3D ioremap_nocache(data->igp_base, data->igp_len);
>> + if (!data->igp_mmio) {
>> + printk(KERN_ERR "ioremap_nocache failed\n");
>> + res =3D -EBUSY;
>> + goto err_map_failed;
>> + }
>> +
>> + platform_set_drvdata(pdev, data);
>> +
>> + mutex_init(&data->update_lock);
>> +
>> + res =3D gm965temp_hwmon_init(pdev);
>> + if (res)
>> + goto err_init_failed;
>> +
>> + return res;
>> +
>> +err_init_failed:
>> + iounmap(data->igp_mmio);
>> + platform_set_drvdata(pdev, NULL);
>> +err_map_failed:
>> + release_mem_region(data->igp_base, data->igp_len);
>> +err:
>> + kfree(data);
>> + return res;
>> +}
>> +
>> +static int __devexit gm965temp_remove(struct platform_device *pdev)
>> +{
>> + struct gm965temp_data *data =3D platform_get_drvdata(pdev);
>> + hwmon_device_unregister(data->hwmon_dev);
>> + device_remove_file(&pdev->dev, &dev_attr_name);
>> +
>> + iounmap(data->igp_mmio);
>> + release_mem_region(data->igp_base, data->igp_len);
>> + platform_set_drvdata(pdev, NULL);
>> + kfree(data);
>> + return 0;
>> +}
>> +
>> +static struct platform_driver gm965temp_driver =3D {
>> + .driver =3D {
>> + .owner =3D THIS_MODULE,
>> + .name =3D DRVNAME,
>> + },
>> + .probe =3D gm965temp_probe,
>> + .remove =3D __devexit_p(gm965temp_remove),
>> +};
>> +
>> +static int __init gm965temp_init(void)
>> +{
>> + int res;
>> +
>> + res =3D platform_driver_register(&gm965temp_driver);
>> + if (res)
>> + return res;
>> +
>> + res =3D gm965temp_add();
>> + if (res)
>> + platform_driver_unregister(&gm965temp_driver);
>> +
>> + return res;
>> +}
>> +
>> +static void __exit gm965temp_exit(void)
>> +{
>> + platform_device_unregister(igp_pdev);
>> + platform_driver_unregister(&gm965temp_driver);
>> +}
>> +
>> +MODULE_AUTHOR("Lu Zhihe");
>> +MODULE_DESCRIPTION("Intel GM965 chipset IGP temperature sensor");
>> +MODULE_LICENSE("GPL");
>> +
>> +module_init(gm965temp_init);
>> +module_exit(gm965temp_exit);
>> +
>>
>>
>>
>> ------------------------------
>>
>> Message: 2
>> Date: Thu, 9 Jul 2009 07:19:09 -0700
>> From: Juerg Haefliger <juergh@gmail.com>
>> Subject: Re: [lm-sensors] sensors-detect and c7temp
>> To: Hans de Goede <hdegoede@redhat.com>, Nicolas Chauvet
>> <kwizart@gmail.com>
>> Cc: LM Sensors <lm-sensors@lm-sensors.org>
>> Message-ID:
>> <191fb4ca0907090719u4b4994b6x33a12874b83aaf04@mail.gmail.com>
>> Content-Type: text/plain; charset=3DUTF-8
>>
>> Hans, Nicholas,
>>
>> Hans, you reviewed it already a long time ago :-)
>> (http://article.gmane.org/gmane.linux.drivers.sensors/17029/match=C7temp)
>> I personally don't have a C7 and the driver did never make it into
>> mainline I guess mainly because there were quite a few testers that
>> reported 0 C temp readings. Some C7 don't seem to have the SW readable
>> temp sensor enabled and I couldn't/never had the time to figure out
>> what is going on. On top of that, Harald from VIA posted a patch for a
>> different driver for the C7.
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-June/026037.html
>>
>> Jean was asking which one he should pick to include and I replied with
>> a few questions for Harald and we are waiting on a response. The ball
>> is in Harald's court.
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-June/026167.html
>>
>> Nicholas, feel free to test either or both drivers.
>>
>> It's time to get either one of them into the kernel. If we don't hear
>> from Harald I suggest to pick mine :-)
>>
>> ...juerg
>>
>> On Thu, Jul 9, 2009 at 6:13 AM, Hans de Goede<hdegoede@redhat.com> wrote:
>> > Hi,
>> >
>> > On 06/25/2009 09:48 PM, Nicolas Chauvet wrote:
>> >> Hello Hans!
>> >>
>> >> ?From http://www.lm-sensors.org/wiki/Device and about C7 (Esther)
>> >>
>> >> I own such device, and it seems still requesting testers for the c7te=
mp
>> >> driver ?
>> >
>> > I'm not sure what the status of this driver is, it seems it never made
>> > it
>> > into
>> > the mainline kernel, which is a petty. I hope the author of the driver
>> > (Juerg Haefliger <juergh@gmail.com>, in the CC) can answer this.
>> >
>> > Juerg, what ever happened to the c7temp driver ? Are you still
>> > interested
>> > in getting it into the mainline? If so Nicolas can test it and I can
>> > review it.
>> >
>> > Thanks & Regards,
>> >
>> > Hans
>>
>> ------------------------------
>>
>> Message: 3
>> Date: Thu, 9 Jul 2009 17:33:48 +0200
>> From: Jean Delvare <khali@linux-fr.org>
>> Subject: Re: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for
>> GM/GME965 IGP temperature report.
>> To: lu zhihe <tombowfly@gmail.com>
>> Cc: lm-sensors@lm-sensors.org
>> Message-ID: <20090709173348.5bec7f14@hyperion.delvare>
>> Content-Type: text/plain; charset=3DUS-ASCII
>>
>> Hi Lu,
>>
>> On Thu, 9 Jul 2009 13:41:38 +0000, lu zhihe wrote:
>> > From: Lu Zhihe <tombowfly@gmail.com>
>> >
>> > Subject: [PATCH] hwmon: add support for GM/GME965 IGP temperature
>> > report.
>> >
>> > Exported the graphics hot spot temperature report via sysfs.
>> >
>> > Signed-off-by: Lu Zhihe <tombowfly@gmail.com>
>> > ---
>> > (...)
>> > +static unsigned long chipset_ids[] =3D {
>> > + PCI_DEVICE_ID_INTEL_82965GM,
>> > + PCI_DEVICE_ID_INTEL_82965GME,
>> > + 0
>> > +};
>>
>> These defines do not exist in the current kernel tree. I presume you
>> forgot to includes changes to include/linux/pci_ids.h?
>>
>> I am also curious what these PCI devices are. We do not want to have
>> driver conflicts, so it might make more sense to add hardware
>> monitoring functionality to an existing driver than writing a brand new
>> driver.
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
