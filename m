From: Justin Chudgar <justin@justinzane.com>
Date: Sat, 22 Aug 2009 00:37:24 +0000
Subject: Re: [lm-sensors] VIA C7 driver module -- No results on Mini-note
Message-Id: <200908211737.24720.justin@justinzane.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3559272783554798856=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3559272783554798856==
Content-Type: multipart/alternative; boundary="Boundary-01=_E3zjKKInpbDgBHx"
Content-Transfer-Encoding: 7bit

--Boundary-01=_E3zjKKInpbDgBHx
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Well, I compiled both your c7temp driver and Harald's via_cputemp driver an=
d=20
neither one gives useful CPU temp data on my system. I'm going to add some=
=20
debug printk's to both to see if I can see any difference on this particula=
r=20
system; but, I am not hopeful.

My thought right now is that the only significant difference is that=20
via_cputemp.ko checks to see which CPU family we are on since there are=20
differences in the thermal monitoring mechanisms between C7-A, C7-D and Nan=
o if=20
I recall the Via documentation correctly.

Since neither works on my particular platform at this time; and, since Hara=
ld=20
is apparently difficult to find; I think that Juerg's c7temp driver would b=
e the=20
one to push into the kernel.

via_cputemp.ko
  acpitz-virtual-0              =20
  Adapter: Virtual device       =20
  temp1:       +52.0=C2=B0C  (crit =3D +105.0=C2=B0C)                 =20
 =20
  via_cputemp-isa-0000
  Adapter: ISA adapter
  Core 0:       +0.1=C2=B0C                                   =20

c7temp.ko
  acpitz-virtual-0
  Adapter: Virtual device
  temp1:       +52.0=C2=B0C  (crit =3D +105.0=C2=B0C)

  c7temp-isa-0000
  Adapter: ISA adapter
  in0:         +0.80 V
  temp1:        +0.0=C2=B0C

Thanks,

=2D-=20

Justin Chudgar
Information Technology Consultant
5040 Saddlehorn Rd, Weed, CA 96084
530-938-9692 (Home Office)

On Monday 10 August 2009 02:30:29 pm you wrote:
> Justin,
>
> No progress. I'm waiting for some answers from Harald. In fact I was
> about to suggest to Jean to push my driver upstream since Harald is
> not very responsive (or just too busy).
>
> But please give Harald's driver a try. I'd be curious to know if you
> get anything with his driver.
> The patch for his driver is here:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-June/026037.html
>
> ...juerg
>
> On Mon, Aug 10, 2009 at 2:16 PM, Justin Chudgar<justin@justinzane.com>=20
wrote:
> > Has any progress been made in getting a module selected for the VIA C7
> > processors? I had attempted to use Juerg's c7temp, however, due to HP's
> > thermal monitoring BIOS settings, I did not get data.
> >
> > I would be interesting in testing Harald's module, if it has been
> > selected. Could someone help direct me in this?
> > --
> >
> > Justin Chudgar
> > Information Technology Consultant
> > 5040 Saddlehorn Rd, Weed, CA 96084
> > 530-938-9692 (Home Office)
> >
> > On Friday 10 July 2009 03:00:02 am lm-sensors-request@lm-sensors.org=20
wrote:
> >> Send lm-sensors mailing list submissions to
> >> l
> >>
> >> To subscribe or unsubscribe via the World Wide Web, visit
> >> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >> or, via email, send a message with subject or body 'help' to
> >> lm-sensors-request@lm-sensors.org
> >>
> >> You can reach the person managing the list at
> >> lm-sensors-owner@lm-sensors.org
> >>
> >> When replying, please edit your Subject line so it is more specific
> >> than "Re: Contents of lm-sensors digest..."
> >>
> >>
> >> Today's Topics:
> >>
> >> 1. [PATCH 2.6.31-rc2] hwmon: add support for GM/GME965 IGP
> >> temperature report. (lu zhihe)
> >> 2. Re: sensors-detect and c7temp (Juerg Haefliger)
> >> 3. Re: [PATCH 2.6.31-rc2] hwmon: add support for GM/GME965 IGP
> >> temperature report. (Jean Delvare)
> >> 4. lm-sensors, RHEL 5.3, 32bit (Bill Nackers)
> >>
> >>
> >> ----------------------------------------------------------------------
> >>
> >> Message: 1
> >> Date: Thu, 9 Jul 2009 13:41:38 +0000
> >> From: lu zhihe <tombowfly@gmail.com>
> >> Subject: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for
> >> GM/GME965 IGP temperature report.
> >> To: lm-sensors@lm-sensors.org
> >> Message-ID:
> >> <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
> >> Content-Type: text/plain; charset=3DISO-8859-1
> >>
> >> From: Lu Zhihe <tombowfly@gmail.com>
> >>
> >> Subject: [PATCH] hwmon: add support for GM/GME965 IGP temperature
> >> report.
> >>
> >> Exported the graphics hot spot temperature report via sysfs.
> >>
> >> Signed-off-by: Lu Zhihe <tombowfly@gmail.com>
> >> ---
> >>
> >>
> >> Add GM/GME965 IGP temperature report for hwmon.
> >>
> >> The GM/GME965 datasheet can get from:
> >> http://www.intel.com/Assets/PDF/datasheet/316273.pdf
> >>
> >> The Calibration Fomula comes from a earlier version:
> >> http://www.intel.com/design/chipsets/datashts/313053.htm
> >> Page 358.
> >>
> >>
> >> diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/Kconfig
> >> linux-2.6.31-rc2/drivers/hwmon/Kconfig
> >> --- linux-2.6.31-rc2.orig/drivers/hwmon/Kconfig 2009-07-08
> >> 23:26:56.000000000 +0000
> >> +++ linux-2.6.31-rc2/drivers/hwmon/Kconfig 2009-07-08 22:49:37.0000000=
00
> >> +0000 @@ -401,6 +401,16 @@ config SENSORS_GL520SM
> >> This driver can also be built as a module. If so, the module
> >> will be called gl520sm.
> >>
> >> +config SENSORS_GM965
> >> + tristate "Intel GM965 temperature sensor"
> >> + depends on PCI
> >> + help
> >> + If you say yes here you get support for GM965 IGP temperatue
> >> + sensor.
> >> +
> >> + This driver can also be built as a module. If so, the module
> >> + will be called gm965temp.
> >> +
> >> config SENSORS_CORETEMP
> >> tristate "Intel Core (2) Duo/Solo temperature sensor"
> >> depends on X86 && EXPERIMENTAL
> >> diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/Makefile
> >> linux-2.6.31-rc2/drivers/hwmon/Makefile
> >> --- linux-2.6.31-rc2.orig/drivers/hwmon/Makefile 2009-07-08
> >> 23:27:07.000000000 +0000
> >> +++ linux-2.6.31-rc2/drivers/hwmon/Makefile 2009-07-08
> >> 22:48:02.000000000 +0000 @@ -46,6 +46,7 @@ obj-$(CONFIG_SENSORS_FSCPOS)
> >> +=3D fscpos.o obj-$(CONFIG_SENSORS_G760A) +=3D g760a.o
> >> obj-$(CONFIG_SENSORS_GL518SM) +=3D gl518sm.o
> >> obj-$(CONFIG_SENSORS_GL520SM) +=3D gl520sm.o
> >> +obj-$(CONFIG_SENSORS_GM965) +=3D gm965temp.o
> >> obj-$(CONFIG_SENSORS_ULTRA45) +=3D ultra45_env.o
> >> obj-$(CONFIG_SENSORS_HDAPS) +=3D hdaps.o
> >> obj-$(CONFIG_SENSORS_I5K_AMB) +=3D i5k_amb.o
> >> diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/gm965temp.c
> >> linux-2.6.31-rc2/drivers/hwmon/gm965temp.c
> >> --- linux-2.6.31-rc2.orig/drivers/hwmon/gm965temp.c 1970-01-01
> >> 00:00:00.000000000 +0000
> >> +++ linux-2.6.31-rc2/drivers/hwmon/gm965temp.c 2009-07-09
> >> 20:25:12.000000000 +0000
> >> @@ -0,0 +1,348 @@
> >> +/*
> >> + * A hwmon driver for the Intel GM/GME965 chipset IGP
> >> + * temperature sensors
> >> + *
> >> + * Copyright (C) 2009 Lu Zhihe <tombowfly at gmail.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modi=
fy
> >> + * it under the terms of the GNU General Public License as published =
by
> >> + * the Free Software Foundation; either version 2 of the License, or
> >> + * (at your option) any later version.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program; if not, write to the Free Software
> >> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
> >> USA + */
> >> +
> >> +#include <linux/module.h>
> >> +#include <linux/jiffies.h>
> >> +#include <linux/hwmon.h>
> >> +#include <linux/hwmon-sysfs.h>
> >> +#include <linux/err.h>
> >> +#include <linux/mutex.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/pci.h>
> >> +#include <linux/platform_device.h>
> >> +
> >> +#define DRVNAME "gm965temp"
> >> +
> >> +enum { SHOW_TEMP, SHOW_LABEL } SHOW;
> >> +
> >> +#define PCI_DEVICE_ID_INTEL_82965GM 0x2a00
> >> +#define PCI_DEVICE_ID_INTEL_82965GME 0x2a10
> >> +#define GM965_SYSFS_NAME_LEN 16
> >> +
> >> +#define MCHBAR_I965 0x48 /* MCH Memory Mapped Register BAR */
> >> +#define MCHBAR_MASK 0xfffffc000ULL /* bits 35:14 */
> >> +
> >> +static ssize_t show_label(struct device *dev,
> >> + struct device_attribute *devattr,
> >> + char *buf);
> >> +
> >> +static ssize_t show_igp_temp(struct device *dev,
> >> + struct device_attribute *devattr,
> >> + char *buf);
> >> +
> >> +struct gm965temp_data {
> >> + struct device *hwmon_dev;
> >> + struct mutex update_lock;
> >> +
> >> + u64 igp_base;
> >> + unsigned long igp_len;
> >> + void __iomem *igp_mmio;
> >> + unsigned long chipset_id;
> >> +};
> >> +
> >> +static ssize_t show_name(struct device *dev, struct device_attribute
> >> *devattr, + char *buf)
> >> +{
> >> + return sprintf(buf, "%s\n", DRVNAME);
> >> +}
> >> +
> >> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_igp_temp, NULL,
> >> SHOW_TEMP);
> >> +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL,
> >> SHOW_LABEL); +static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
> >> +
> >> +static struct attribute *gm965temp_attributes[] =3D {
> >> + &sensor_dev_attr_temp1_label.dev_attr.attr,
> >> + &sensor_dev_attr_temp1_input.dev_attr.attr,
> >> + NULL
> >> +};
> >> +
> >> +static const struct attribute_group gm965temp_group =3D {
> >> + .attrs =3D gm965temp_attributes,
> >> +};
> >> +
> >> +static struct platform_device *igp_pdev;
> >> +
> >> +static u8 igp_read_byte(struct gm965temp_data *data, unsigned long
> >> offset)
> >> +{
> >> + return ioread8(data->igp_mmio + offset);
> >> +}
> >> +
> >> +static u16 igp_read_short(struct gm965temp_data *data, unsigned long
> >> offset) +{
> >> + return ioread16(data->igp_mmio + offset);
> >> +}
> >> +
> >> +static void igp_write_short(struct gm965temp_data *data, unsigned long
> >> offset, + u16 val)
> >> +{
> >> + iowrite16(val, data->igp_mmio + offset);
> >> +}
> >> +
> >> +static ssize_t show_label(struct device *dev,
> >> + struct device_attribute *devattr,
> >> + char *buf)
> >> +{
> >> + return sprintf(buf, "GM965 IGP temperature report\n");
> >> +}
> >> +
> >> +#define TSC1 0x1001
> >> +#define TSS1 0x1004
> >> +#define TR1 0x1006
> >> +
> >> +#define TSE 0x8000
> >> +#define TMOV (0x01 << 10)
> >> +
> >> +#define MAX_RETRIS 3
> >> +
> >> +static ssize_t show_igp_temp(struct device *dev,
> >> + struct device_attribute *devattr,
> >> + char *buf)
> >> +{
> >> + struct gm965temp_data *data =3D dev_get_drvdata(dev);
> >> + unsigned short tsc1_val =3D 0;
> >> + unsigned char tr1_val =3D 0;
> >> + unsigned short tss1_val =3D 0;
> >> + unsigned long temp =3D 0;
> >> + int i =3D 0;
> >> + i =3D MAX_RETRIS;
> >> +
> >> + mutex_lock(&data->update_lock);
> >> +
> >> + tsc1_val =3D igp_read_short(data, TSC1);
> >> +
> >> + if (!(tsc1_val & TSE)) {
> >> + igp_write_short(data, TSC1, tsc1_val|TSE);
> >> + tsc1_val =3D igp_read_short(data, TSC1);
> >> + } else {
> >> +try_againt:
> >> + tss1_val =3D igp_read_short(data, TSS1);
> >> +
> >> + if (tss1_val & TMOV) {
> >> + tr1_val =3D igp_read_byte(data, TR1);
> >> + if ((tr1_val !=3D 0xFF) && (tr1_val !=3D 0x0))
> >> + temp =3D (16*tr1_val*tr1_val - 11071*tr1_val + 1610500)
> >> + /10;
> >> + } else {
> >> + do {
> >> + mdelay(1);
> >> + udelay(300);
> >> + goto try_againt;
> >> + } while (i--);
> >> + }
> >> + }
> >> +
> >> + mutex_unlock(&data->update_lock);
> >> + return sprintf(buf, "%d\n", (unsigned int)temp);
> >> +}
> >> +
> >> +static int __devinit gm965temp_hwmon_init(struct platform_device *pde=
v)
> >> +{
> >> + int res =3D 0;
> >> + struct gm965temp_data *data =3D platform_get_drvdata(pdev);
> >> +
> >> + res =3D device_create_file(&pdev->dev, &dev_attr_name);
> >> + if (res)
> >> + goto exit_remove;
> >> +
> >> + res =3D sysfs_create_group(&pdev->dev.kobj, &gm965temp_group);
> >> + if (res)
> >> + goto exit_dev;
> >> +
> >> + data->hwmon_dev =3D hwmon_device_register(&pdev->dev);
> >> + if (IS_ERR(data->hwmon_dev)) {
> >> + res =3D PTR_ERR(data->hwmon_dev);
> >> + goto exit_remove;
> >> + }
> >> +
> >> + return res;
> >> +
> >> +exit_remove:
> >> + sysfs_remove_group(&pdev->dev.kobj, &gm965temp_group);
> >> +exit_dev:
> >> + device_remove_file(&pdev->dev, &dev_attr_name);
> >> +
> >> + return res;
> >> +}
> >> +
> >> +static int __devinit gm965temp_add(void)
> >> +{
> >> + int res =3D -ENODEV;
> >> +
> >> + /* only ever going to be one of these */
> >> + igp_pdev =3D platform_device_alloc(DRVNAME, 0);
> >> + if (!igp_pdev)
> >> + return -ENOMEM;
> >> +
> >> + res =3D platform_device_add(igp_pdev);
> >> + if (res)
> >> + goto err;
> >> + return 0;
> >> +
> >> +err:
> >> + platform_device_put(igp_pdev);
> >> + return res;
> >> +}
> >> +
> >> +static int __devinit gm965_find_igp_registers(struct gm965temp_data
> >> *data,
> >> + unsigned long devid)
> >> +{
> >> + struct pci_dev *pcidev;
> >> + u32 val32;
> >> + u64 val64 =3D 0x0ULL;
> >> + int res =3D -ENODEV;
> >> +
> >> + pcidev =3D pci_get_device(PCI_VENDOR_ID_INTEL,
> >> + devid,
> >> + NULL);
> >> + if (!pcidev) {
> >> + printk(KERN_ERR "pci_get_device failed\n");
> >> + return -ENODEV;
> >> + }
> >> +
> >> + if (pci_read_config_dword(pcidev, MCHBAR_I965 + 4, &val32))
> >> + goto out;
> >> + val64 =3D (u64)val32;
> >> + val64 <<=3D 32;
> >> + if (pci_read_config_dword(pcidev, MCHBAR_I965, &val32))
> >> + goto out;
> >> +
> >> + val64 |=3D val32;
> >> + data->igp_base =3D val64 & MCHBAR_MASK;
> >> + data->igp_len =3D 16*1024;
> >> +
> >> + data->chipset_id =3D devid;
> >> +
> >> + res =3D 0;
> >> +out:
> >> + pci_dev_put(pcidev);
> >> + return res;
> >> +}
> >> +
> >> +static unsigned long chipset_ids[] =3D {
> >> + PCI_DEVICE_ID_INTEL_82965GM,
> >> + PCI_DEVICE_ID_INTEL_82965GME,
> >> + 0
> >> +};
> >> +
> >> +static int __devinit gm965temp_probe(struct platform_device *pdev)
> >> +{
> >> + struct gm965temp_data *data;
> >> + struct resource *reso;
> >> + int i;
> >> + int res =3D -ENODEV;
> >> +
> >> + data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> >> + if (!data)
> >> + return -ENOMEM;
> >> +
> >> + i =3D 0;
> >> + do {
> >> + res =3D gm965_find_igp_registers(data, chipset_ids[i]);
> >> + i++;
> >> + } while (res && chipset_ids[i]);
> >> +
> >> + if (res)
> >> + goto err;
> >> + /* Set up resource regions */
> >> + reso =3D request_mem_region(data->igp_base, data->igp_len, DRVNAME);
> >> + if (!reso) {
> >> + printk(KERN_ERR "request_mem_region failed\n");
> >> + res =3D -EBUSY;
> >> + goto err;
> >> + }
> >> +
> >> + data->igp_mmio =3D ioremap_nocache(data->igp_base, data->igp_len);
> >> + if (!data->igp_mmio) {
> >> + printk(KERN_ERR "ioremap_nocache failed\n");
> >> + res =3D -EBUSY;
> >> + goto err_map_failed;
> >> + }
> >> +
> >> + platform_set_drvdata(pdev, data);
> >> +
> >> + mutex_init(&data->update_lock);
> >> +
> >> + res =3D gm965temp_hwmon_init(pdev);
> >> + if (res)
> >> + goto err_init_failed;
> >> +
> >> + return res;
> >> +
> >> +err_init_failed:
> >> + iounmap(data->igp_mmio);
> >> + platform_set_drvdata(pdev, NULL);
> >> +err_map_failed:
> >> + release_mem_region(data->igp_base, data->igp_len);
> >> +err:
> >> + kfree(data);
> >> + return res;
> >> +}
> >> +
> >> +static int __devexit gm965temp_remove(struct platform_device *pdev)
> >> +{
> >> + struct gm965temp_data *data =3D platform_get_drvdata(pdev);
> >> + hwmon_device_unregister(data->hwmon_dev);
> >> + device_remove_file(&pdev->dev, &dev_attr_name);
> >> +
> >> + iounmap(data->igp_mmio);
> >> + release_mem_region(data->igp_base, data->igp_len);
> >> + platform_set_drvdata(pdev, NULL);
> >> + kfree(data);
> >> + return 0;
> >> +}
> >> +
> >> +static struct platform_driver gm965temp_driver =3D {
> >> + .driver =3D {
> >> + .owner =3D THIS_MODULE,
> >> + .name =3D DRVNAME,
> >> + },
> >> + .probe =3D gm965temp_probe,
> >> + .remove =3D __devexit_p(gm965temp_remove),
> >> +};
> >> +
> >> +static int __init gm965temp_init(void)
> >> +{
> >> + int res;
> >> +
> >> + res =3D platform_driver_register(&gm965temp_driver);
> >> + if (res)
> >> + return res;
> >> +
> >> + res =3D gm965temp_add();
> >> + if (res)
> >> + platform_driver_unregister(&gm965temp_driver);
> >> +
> >> + return res;
> >> +}
> >> +
> >> +static void __exit gm965temp_exit(void)
> >> +{
> >> + platform_device_unregister(igp_pdev);
> >> + platform_driver_unregister(&gm965temp_driver);
> >> +}
> >> +
> >> +MODULE_AUTHOR("Lu Zhihe");
> >> +MODULE_DESCRIPTION("Intel GM965 chipset IGP temperature sensor");
> >> +MODULE_LICENSE("GPL");
> >> +
> >> +module_init(gm965temp_init);
> >> +module_exit(gm965temp_exit);
> >> +
> >>
> >>
> >>
> >> ------------------------------
> >>
> >> Message: 2
> >> Date: Thu, 9 Jul 2009 07:19:09 -0700
> >> From: Juerg Haefliger <juergh@gmail.com>
> >> Subject: Re: [lm-sensors] sensors-detect and c7temp
> >> To: Hans de Goede <hdegoede@redhat.com>, Nicolas Chauvet
> >> <kwizart@gmail.com>
> >> Cc: LM Sensors <lm-sensors@lm-sensors.org>
> >> Message-ID:
> >> <191fb4ca0907090719u4b4994b6x33a12874b83aaf04@mail.gmail.com>
> >> Content-Type: text/plain; charset=3DUTF-8
> >>
> >> Hans, Nicholas,
> >>
> >> Hans, you reviewed it already a long time ago :-)
> >> (http://article.gmane.org/gmane.linux.drivers.sensors/17029/match=3Dc7=
temp
> >>) I personally don't have a C7 and the driver did never make it into
> >> mainline I guess mainly because there were quite a few testers that
> >> reported 0 C temp readings. Some C7 don't seem to have the SW readable
> >> temp sensor enabled and I couldn't/never had the time to figure out wh=
at
> >> is going on. On top of that, Harald from VIA posted a patch for a
> >> different driver for the C7.
> >> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-June/026037.html
> >>
> >> Jean was asking which one he should pick to include and I replied with
> >> a few questions for Harald and we are waiting on a response. The ball
> >> is in Harald's court.
> >> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-June/026167.html
> >>
> >> Nicholas, feel free to test either or both drivers.
> >>
> >> It's time to get either one of them into the kernel. If we don't hear
> >> from Harald I suggest to pick mine :-)
> >>
> >> ...juerg
> >>
> >> On Thu, Jul 9, 2009 at 6:13 AM, Hans de Goede<hdegoede@redhat.com> wro=
te:
> >> > Hi,
> >> >
> >> > On 06/25/2009 09:48 PM, Nicolas Chauvet wrote:
> >> >> Hello Hans!
> >> >>
> >> >> ?From http://www.lm-sensors.org/wiki/Device and about C7 (Esther)
> >> >>
> >> >> I own such device, and it seems still requesting testers for the
> >> >> c7temp driver ?
> >> >
> >> > I'm not sure what the status of this driver is, it seems it never ma=
de
> >> > it
> >> > into
> >> > the mainline kernel, which is a petty. I hope the author of the driv=
er
> >> > (Juerg Haefliger <juergh@gmail.com>, in the CC) can answer this.
> >> >
> >> > Juerg, what ever happened to the c7temp driver ? Are you still
> >> > interested
> >> > in getting it into the mainline? If so Nicolas can test it and I can
> >> > review it.
> >> >
> >> > Thanks & Regards,
> >> >
> >> > Hans
> >>
> >> ------------------------------
> >>
> >> Message: 3
> >> Date: Thu, 9 Jul 2009 17:33:48 +0200
> >> From: Jean Delvare <khali@linux-fr.org>
> >> Subject: Re: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for
> >> GM/GME965 IGP temperature report.
> >> To: lu zhihe <tombowfly@gmail.com>
> >> Cc: lm-sensors@lm-sensors.org
> >> Message-ID: <20090709173348.5bec7f14@hyperion.delvare>
> >> Content-Type: text/plain; charset=3DUS-ASCII
> >>
> >> Hi Lu,
> >>
> >> On Thu, 9 Jul 2009 13:41:38 +0000, lu zhihe wrote:
> >> > From: Lu Zhihe <tombowfly@gmail.com>
> >> >
> >> > Subject: [PATCH] hwmon: add support for GM/GME965 IGP temperature
> >> > report.
> >> >
> >> > Exported the graphics hot spot temperature report via sysfs.
> >> >
> >> > Signed-off-by: Lu Zhihe <tombowfly@gmail.com>
> >> > ---
> >> > (...)
> >> > +static unsigned long chipset_ids[] =3D {
> >> > + PCI_DEVICE_ID_INTEL_82965GM,
> >> > + PCI_DEVICE_ID_INTEL_82965GME,
> >> > + 0
> >> > +};
> >>
> >> These defines do not exist in the current kernel tree. I presume you
> >> forgot to includes changes to include/linux/pci_ids.h?
> >>
> >> I am also curious what these PCI devices are. We do not want to have
> >> driver conflicts, so it might make more sense to add hardware
> >> monitoring functionality to an existing driver than writing a brand new
> >> driver.
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

--Boundary-01=_E3zjKKInpbDgBHx
Content-Type: text/html;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-=
html40/strict.dtd"><html><head><meta name=3D"qrichtext" content=3D"1" /><st=
yle type=3D"text/css">p, li { white-space: pre-wrap; }</style></head><body =
style=3D" font-family:'DejaVu Serif'; font-size:8pt; font-weight:400; font-=
style:normal;">Well, I compiled both your c7temp driver and Harald's via_cp=
utemp driver and neither one gives useful CPU temp data on my system. I'm g=
oing to add some debug printk's to both to see if I can see any difference =
on this particular system; but, I am not hopeful.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>My thought right now is that the only significant dif=
ference is that via_cputemp.ko checks to see which CPU family we are on sin=
ce there are differences in the thermal monitoring mechanisms between C7-A,=
 C7-D and Nano if I recall the Via documentation correctly.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>Since neither works on my particular platform at this=
 time; and, since Harald is apparently difficult to find; I think that Juer=
g's c7temp driver would be the one to push into the kernel.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p><span style=3D" font-family:'dejavu sans mono';">via_=
cputemp.ko</span><br>
<span style=3D" font-family:'dejavu sans mono';">  acpitz-virtual-0        =
       </span><br>
<span style=3D" font-family:'dejavu sans mono';">  Adapter: Virtual device =
       </span><br>
<span style=3D" font-family:'dejavu sans mono';">  temp1:       +52.0=C2=B0=
C  (crit =3D +105.0=C2=B0C)                  </span><br>
<span style=3D" font-family:'dejavu sans mono';">  </span><br>
<span style=3D" font-family:'dejavu sans mono';">  via_cputemp-isa-0000</sp=
an><br>
<span style=3D" font-family:'dejavu sans mono';">  Adapter: ISA adapter</sp=
an><br>
<span style=3D" font-family:'dejavu sans mono';">  Core 0:       +0.1=C2=B0=
C  </span>                                  <br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p><span style=3D" font-family:'dejavu sans mono';">c7te=
mp.ko</span><br>
<span style=3D" font-family:'dejavu sans mono';">  acpitz-virtual-0</span><=
br>
<span style=3D" font-family:'dejavu sans mono';">  Adapter: Virtual device<=
/span><br>
<span style=3D" font-family:'dejavu sans mono';">  temp1:       +52.0=C2=B0=
C  (crit =3D +105.0=C2=B0C)</span><br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0; font-family:'dejavu sans mono';"><br></p><span style=3D" font-=
family:'dejavu sans mono';">  c7temp-isa-0000</span><br>
<span style=3D" font-family:'dejavu sans mono';">  Adapter: ISA adapter</sp=
an><br>
<span style=3D" font-family:'dejavu sans mono';">  in0:         +0.80 V</sp=
an><br>
<span style=3D" font-family:'dejavu sans mono';">  temp1:        +0.0=C2=B0=
C</span><br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>Thanks,<br>
<br />-- <br /><br>
<span style=3D" font-family:'betecknalowercasebold';">Justin Chudgar</span>=
<br>
Information Technology Consultant<br>
5040 Saddlehorn Rd, Weed, CA 96084<br>
530-938-9692 (Home Office)<br>
<br />On Monday 10 August 2009 02:30:29 pm you wrote:<br>
&gt; Justin,<br>
&gt;<br>
&gt; No progress. I'm waiting for some answers from Harald. In fact I was<b=
r>
&gt; about to suggest to Jean to push my driver upstream since Harald is<br>
&gt; not very responsive (or just too busy).<br>
&gt;<br>
&gt; But please give Harald's driver a try. I'd be curious to know if you<b=
r>
&gt; get anything with his driver.<br>
&gt; The patch for his driver is here:<br>
&gt; http://lists.lm-sensors.org/pipermail/lm-sensors/2009-June/026037.html=
<br>
&gt;<br>
&gt; ...juerg<br>
&gt;<br>
&gt; On Mon, Aug 10, 2009 at 2:16 PM, Justin Chudgar&lt;justin@justinzane.c=
om&gt; wrote:<br>
&gt; &gt; Has any progress been made in getting a module selected for the V=
IA C7<br>
&gt; &gt; processors? I had attempted to use Juerg's c7temp, however, due t=
o HP's<br>
&gt; &gt; thermal monitoring BIOS settings, I did not get data.<br>
&gt; &gt;<br>
&gt; &gt; I would be interesting in testing Harald's module, if it has been=
<br>
&gt; &gt; selected. Could someone help direct me in this?<br>
&gt; &gt; --<br>
&gt; &gt;<br>
&gt; &gt; Justin Chudgar<br>
&gt; &gt; Information Technology Consultant<br>
&gt; &gt; 5040 Saddlehorn Rd, Weed, CA 96084<br>
&gt; &gt; 530-938-9692 (Home Office)<br>
&gt; &gt;<br>
&gt; &gt; On Friday 10 July 2009 03:00:02 am lm-sensors-request@lm-sensors.=
org wrote:<br>
&gt; &gt;&gt; Send lm-sensors mailing list submissions to<br>
&gt; &gt;&gt; l<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; To subscribe or unsubscribe via the World Wide Web, visit<br>
&gt; &gt;&gt; http://lists.lm-sensors.org/mailman/listinfo/lm-sensors<br>
&gt; &gt;&gt; or, via email, send a message with subject or body 'help' to<=
br>
&gt; &gt;&gt; lm-sensors-request@lm-sensors.org<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; You can reach the person managing the list at<br>
&gt; &gt;&gt; lm-sensors-owner@lm-sensors.org<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; When replying, please edit your Subject line so it is more sp=
ecific<br>
&gt; &gt;&gt; than "Re: Contents of lm-sensors digest..."<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Today's Topics:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; 1. [PATCH 2.6.31-rc2] hwmon: add support for GM/GME965 IGP<br>
&gt; &gt;&gt; temperature report. (lu zhihe)<br>
&gt; &gt;&gt; 2. Re: sensors-detect and c7temp (Juerg Haefliger)<br>
&gt; &gt;&gt; 3. Re: [PATCH 2.6.31-rc2] hwmon: add support for GM/GME965 IG=
P<br>
&gt; &gt;&gt; temperature report. (Jean Delvare)<br>
&gt; &gt;&gt; 4. lm-sensors, RHEL 5.3, 32bit (Bill Nackers)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; -------------------------------------------------------------=
=2D--------<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Message: 1<br>
&gt; &gt;&gt; Date: Thu, 9 Jul 2009 13:41:38 +0000<br>
&gt; &gt;&gt; From: lu zhihe &lt;tombowfly@gmail.com&gt;<br>
&gt; &gt;&gt; Subject: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support f=
or<br>
&gt; &gt;&gt; GM/GME965 IGP temperature report.<br>
&gt; &gt;&gt; To: lm-sensors@lm-sensors.org<br>
&gt; &gt;&gt; Message-ID:<br>
&gt; &gt;&gt; &lt;73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.c=
om&gt;<br>
&gt; &gt;&gt; Content-Type: text/plain; charset=3DISO-8859-1<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; From: Lu Zhihe &lt;tombowfly@gmail.com&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Subject: [PATCH] hwmon: add support for GM/GME965 IGP tempera=
ture<br>
&gt; &gt;&gt; report.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Exported the graphics hot spot temperature report via sysfs.<=
br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Lu Zhihe &lt;tombowfly@gmail.com&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Add GM/GME965 IGP temperature report for hwmon.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The GM/GME965 datasheet can get from:<br>
&gt; &gt;&gt; http://www.intel.com/Assets/PDF/datasheet/316273.pdf<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The Calibration Fomula comes from a earlier version:<br>
&gt; &gt;&gt; http://www.intel.com/design/chipsets/datashts/313053.htm<br>
&gt; &gt;&gt; Page 358.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/Kconfig<br>
&gt; &gt;&gt; linux-2.6.31-rc2/drivers/hwmon/Kconfig<br>
&gt; &gt;&gt; --- linux-2.6.31-rc2.orig/drivers/hwmon/Kconfig 2009-07-08<br>
&gt; &gt;&gt; 23:26:56.000000000 +0000<br>
&gt; &gt;&gt; +++ linux-2.6.31-rc2/drivers/hwmon/Kconfig 2009-07-08 22:49:3=
7.000000000<br>
&gt; &gt;&gt; +0000 @@ -401,6 +401,16 @@ config SENSORS_GL520SM<br>
&gt; &gt;&gt; This driver can also be built as a module. If so, the module<=
br>
&gt; &gt;&gt; will be called gl520sm.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; +config SENSORS_GM965<br>
&gt; &gt;&gt; + tristate "Intel GM965 temperature sensor"<br>
&gt; &gt;&gt; + depends on PCI<br>
&gt; &gt;&gt; + help<br>
&gt; &gt;&gt; + If you say yes here you get support for GM965 IGP temperatu=
e<br>
&gt; &gt;&gt; + sensor.<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + This driver can also be built as a module. If so, the modul=
e<br>
&gt; &gt;&gt; + will be called gm965temp.<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; config SENSORS_CORETEMP<br>
&gt; &gt;&gt; tristate "Intel Core (2) Duo/Solo temperature sensor"<br>
&gt; &gt;&gt; depends on X86 &amp;&amp; EXPERIMENTAL<br>
&gt; &gt;&gt; diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/Makefile<br>
&gt; &gt;&gt; linux-2.6.31-rc2/drivers/hwmon/Makefile<br>
&gt; &gt;&gt; --- linux-2.6.31-rc2.orig/drivers/hwmon/Makefile 2009-07-08<b=
r>
&gt; &gt;&gt; 23:27:07.000000000 +0000<br>
&gt; &gt;&gt; +++ linux-2.6.31-rc2/drivers/hwmon/Makefile 2009-07-08<br>
&gt; &gt;&gt; 22:48:02.000000000 +0000 @@ -46,6 +46,7 @@ obj-$(CONFIG_SENSO=
RS_FSCPOS)<br>
&gt; &gt;&gt; +=3D fscpos.o obj-$(CONFIG_SENSORS_G760A) +=3D g760a.o<br>
&gt; &gt;&gt; obj-$(CONFIG_SENSORS_GL518SM) +=3D gl518sm.o<br>
&gt; &gt;&gt; obj-$(CONFIG_SENSORS_GL520SM) +=3D gl520sm.o<br>
&gt; &gt;&gt; +obj-$(CONFIG_SENSORS_GM965) +=3D gm965temp.o<br>
&gt; &gt;&gt; obj-$(CONFIG_SENSORS_ULTRA45) +=3D ultra45_env.o<br>
&gt; &gt;&gt; obj-$(CONFIG_SENSORS_HDAPS) +=3D hdaps.o<br>
&gt; &gt;&gt; obj-$(CONFIG_SENSORS_I5K_AMB) +=3D i5k_amb.o<br>
&gt; &gt;&gt; diff -uprN linux-2.6.31-rc2.orig/drivers/hwmon/gm965temp.c<br>
&gt; &gt;&gt; linux-2.6.31-rc2/drivers/hwmon/gm965temp.c<br>
&gt; &gt;&gt; --- linux-2.6.31-rc2.orig/drivers/hwmon/gm965temp.c 1970-01-0=
1<br>
&gt; &gt;&gt; 00:00:00.000000000 +0000<br>
&gt; &gt;&gt; +++ linux-2.6.31-rc2/drivers/hwmon/gm965temp.c 2009-07-09<br>
&gt; &gt;&gt; 20:25:12.000000000 +0000<br>
&gt; &gt;&gt; @@ -0,0 +1,348 @@<br>
&gt; &gt;&gt; +/*<br>
&gt; &gt;&gt; + * A hwmon driver for the Intel GM/GME965 chipset IGP<br>
&gt; &gt;&gt; + * temperature sensors<br>
&gt; &gt;&gt; + *<br>
&gt; &gt;&gt; + * Copyright (C) 2009 Lu Zhihe &lt;tombowfly at gmail.com&gt=
;<br>
&gt; &gt;&gt; + *<br>
&gt; &gt;&gt; + * This program is free software; you can redistribute it an=
d/or modify<br>
&gt; &gt;&gt; + * it under the terms of the GNU General Public License as p=
ublished by<br>
&gt; &gt;&gt; + * the Free Software Foundation; either version 2 of the Lic=
ense, or<br>
&gt; &gt;&gt; + * (at your option) any later version.<br>
&gt; &gt;&gt; + *<br>
&gt; &gt;&gt; + * This program is distributed in the hope that it will be u=
seful,<br>
&gt; &gt;&gt; + * but WITHOUT ANY WARRANTY; without even the implied warran=
ty of<br>
&gt; &gt;&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See =
the<br>
&gt; &gt;&gt; + * GNU General Public License for more details.<br>
&gt; &gt;&gt; + *<br>
&gt; &gt;&gt; + * You should have received a copy of the GNU General Public=
 License<br>
&gt; &gt;&gt; + * along with this program; if not, write to the Free Softwa=
re<br>
&gt; &gt;&gt; + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =
02111-1307<br>
&gt; &gt;&gt; USA + */<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#include &lt;linux/module.h&gt;<br>
&gt; &gt;&gt; +#include &lt;linux/jiffies.h&gt;<br>
&gt; &gt;&gt; +#include &lt;linux/hwmon.h&gt;<br>
&gt; &gt;&gt; +#include &lt;linux/hwmon-sysfs.h&gt;<br>
&gt; &gt;&gt; +#include &lt;linux/err.h&gt;<br>
&gt; &gt;&gt; +#include &lt;linux/mutex.h&gt;<br>
&gt; &gt;&gt; +#include &lt;linux/delay.h&gt;<br>
&gt; &gt;&gt; +#include &lt;linux/pci.h&gt;<br>
&gt; &gt;&gt; +#include &lt;linux/platform_device.h&gt;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define DRVNAME "gm965temp"<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +enum { SHOW_TEMP, SHOW_LABEL } SHOW;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define PCI_DEVICE_ID_INTEL_82965GM 0x2a00<br>
&gt; &gt;&gt; +#define PCI_DEVICE_ID_INTEL_82965GME 0x2a10<br>
&gt; &gt;&gt; +#define GM965_SYSFS_NAME_LEN 16<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define MCHBAR_I965 0x48 /* MCH Memory Mapped Register BAR *=
/<br>
&gt; &gt;&gt; +#define MCHBAR_MASK 0xfffffc000ULL /* bits 35:14 */<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static ssize_t show_label(struct device *dev,<br>
&gt; &gt;&gt; + struct device_attribute *devattr,<br>
&gt; &gt;&gt; + char *buf);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static ssize_t show_igp_temp(struct device *dev,<br>
&gt; &gt;&gt; + struct device_attribute *devattr,<br>
&gt; &gt;&gt; + char *buf);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +struct gm965temp_data {<br>
&gt; &gt;&gt; + struct device *hwmon_dev;<br>
&gt; &gt;&gt; + struct mutex update_lock;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + u64 igp_base;<br>
&gt; &gt;&gt; + unsigned long igp_len;<br>
&gt; &gt;&gt; + void __iomem *igp_mmio;<br>
&gt; &gt;&gt; + unsigned long chipset_id;<br>
&gt; &gt;&gt; +};<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static ssize_t show_name(struct device *dev, struct device_a=
ttribute<br>
&gt; &gt;&gt; *devattr, + char *buf)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; + return sprintf(buf, "%s\n", DRVNAME);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_igp_tem=
p, NULL,<br>
&gt; &gt;&gt; SHOW_TEMP);<br>
&gt; &gt;&gt; +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, =
NULL,<br>
&gt; &gt;&gt; SHOW_LABEL); +static DEVICE_ATTR(name, S_IRUGO, show_name, NU=
LL);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static struct attribute *gm965temp_attributes[] =3D {<br>
&gt; &gt;&gt; + &amp;sensor_dev_attr_temp1_label.dev_attr.attr,<br>
&gt; &gt;&gt; + &amp;sensor_dev_attr_temp1_input.dev_attr.attr,<br>
&gt; &gt;&gt; + NULL<br>
&gt; &gt;&gt; +};<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static const struct attribute_group gm965temp_group =3D {<br>
&gt; &gt;&gt; + .attrs =3D gm965temp_attributes,<br>
&gt; &gt;&gt; +};<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static struct platform_device *igp_pdev;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static u8 igp_read_byte(struct gm965temp_data *data, unsigne=
d long<br>
&gt; &gt;&gt; offset)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; + return ioread8(data-&gt;igp_mmio + offset);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static u16 igp_read_short(struct gm965temp_data *data, unsig=
ned long<br>
&gt; &gt;&gt; offset) +{<br>
&gt; &gt;&gt; + return ioread16(data-&gt;igp_mmio + offset);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static void igp_write_short(struct gm965temp_data *data, uns=
igned long<br>
&gt; &gt;&gt; offset, + u16 val)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; + iowrite16(val, data-&gt;igp_mmio + offset);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static ssize_t show_label(struct device *dev,<br>
&gt; &gt;&gt; + struct device_attribute *devattr,<br>
&gt; &gt;&gt; + char *buf)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; + return sprintf(buf, "GM965 IGP temperature report\n");<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define TSC1 0x1001<br>
&gt; &gt;&gt; +#define TSS1 0x1004<br>
&gt; &gt;&gt; +#define TR1 0x1006<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define TSE 0x8000<br>
&gt; &gt;&gt; +#define TMOV (0x01 &lt;&lt; 10)<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#define MAX_RETRIS 3<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static ssize_t show_igp_temp(struct device *dev,<br>
&gt; &gt;&gt; + struct device_attribute *devattr,<br>
&gt; &gt;&gt; + char *buf)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; + struct gm965temp_data *data =3D dev_get_drvdata(dev);<br>
&gt; &gt;&gt; + unsigned short tsc1_val =3D 0;<br>
&gt; &gt;&gt; + unsigned char tr1_val =3D 0;<br>
&gt; &gt;&gt; + unsigned short tss1_val =3D 0;<br>
&gt; &gt;&gt; + unsigned long temp =3D 0;<br>
&gt; &gt;&gt; + int i =3D 0;<br>
&gt; &gt;&gt; + i =3D MAX_RETRIS;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + mutex_lock(&amp;data-&gt;update_lock);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + tsc1_val =3D igp_read_short(data, TSC1);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + if (!(tsc1_val &amp; TSE)) {<br>
&gt; &gt;&gt; + igp_write_short(data, TSC1, tsc1_val|TSE);<br>
&gt; &gt;&gt; + tsc1_val =3D igp_read_short(data, TSC1);<br>
&gt; &gt;&gt; + } else {<br>
&gt; &gt;&gt; +try_againt:<br>
&gt; &gt;&gt; + tss1_val =3D igp_read_short(data, TSS1);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + if (tss1_val &amp; TMOV) {<br>
&gt; &gt;&gt; + tr1_val =3D igp_read_byte(data, TR1);<br>
&gt; &gt;&gt; + if ((tr1_val !=3D 0xFF) &amp;&amp; (tr1_val !=3D 0x0))<br>
&gt; &gt;&gt; + temp =3D (16*tr1_val*tr1_val - 11071*tr1_val + 1610500)<br>
&gt; &gt;&gt; + /10;<br>
&gt; &gt;&gt; + } else {<br>
&gt; &gt;&gt; + do {<br>
&gt; &gt;&gt; + mdelay(1);<br>
&gt; &gt;&gt; + udelay(300);<br>
&gt; &gt;&gt; + goto try_againt;<br>
&gt; &gt;&gt; + } while (i--);<br>
&gt; &gt;&gt; + }<br>
&gt; &gt;&gt; + }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + mutex_unlock(&amp;data-&gt;update_lock);<br>
&gt; &gt;&gt; + return sprintf(buf, "%d\n", (unsigned int)temp);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static int __devinit gm965temp_hwmon_init(struct platform_de=
vice *pdev)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; + int res =3D 0;<br>
&gt; &gt;&gt; + struct gm965temp_data *data =3D platform_get_drvdata(pdev);=
<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + res =3D device_create_file(&amp;pdev-&gt;dev, &amp;dev_attr=
_name);<br>
&gt; &gt;&gt; + if (res)<br>
&gt; &gt;&gt; + goto exit_remove;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + res =3D sysfs_create_group(&amp;pdev-&gt;dev.kobj, &amp;gm9=
65temp_group);<br>
&gt; &gt;&gt; + if (res)<br>
&gt; &gt;&gt; + goto exit_dev;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + data-&gt;hwmon_dev =3D hwmon_device_register(&amp;pdev-&gt;=
dev);<br>
&gt; &gt;&gt; + if (IS_ERR(data-&gt;hwmon_dev)) {<br>
&gt; &gt;&gt; + res =3D PTR_ERR(data-&gt;hwmon_dev);<br>
&gt; &gt;&gt; + goto exit_remove;<br>
&gt; &gt;&gt; + }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + return res;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +exit_remove:<br>
&gt; &gt;&gt; + sysfs_remove_group(&amp;pdev-&gt;dev.kobj, &amp;gm965temp_g=
roup);<br>
&gt; &gt;&gt; +exit_dev:<br>
&gt; &gt;&gt; + device_remove_file(&amp;pdev-&gt;dev, &amp;dev_attr_name);<=
br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + return res;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static int __devinit gm965temp_add(void)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; + int res =3D -ENODEV;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + /* only ever going to be one of these */<br>
&gt; &gt;&gt; + igp_pdev =3D platform_device_alloc(DRVNAME, 0);<br>
&gt; &gt;&gt; + if (!igp_pdev)<br>
&gt; &gt;&gt; + return -ENOMEM;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + res =3D platform_device_add(igp_pdev);<br>
&gt; &gt;&gt; + if (res)<br>
&gt; &gt;&gt; + goto err;<br>
&gt; &gt;&gt; + return 0;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +err:<br>
&gt; &gt;&gt; + platform_device_put(igp_pdev);<br>
&gt; &gt;&gt; + return res;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static int __devinit gm965_find_igp_registers(struct gm965te=
mp_data<br>
&gt; &gt;&gt; *data,<br>
&gt; &gt;&gt; + unsigned long devid)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; + struct pci_dev *pcidev;<br>
&gt; &gt;&gt; + u32 val32;<br>
&gt; &gt;&gt; + u64 val64 =3D 0x0ULL;<br>
&gt; &gt;&gt; + int res =3D -ENODEV;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + pcidev =3D pci_get_device(PCI_VENDOR_ID_INTEL,<br>
&gt; &gt;&gt; + devid,<br>
&gt; &gt;&gt; + NULL);<br>
&gt; &gt;&gt; + if (!pcidev) {<br>
&gt; &gt;&gt; + printk(KERN_ERR "pci_get_device failed\n");<br>
&gt; &gt;&gt; + return -ENODEV;<br>
&gt; &gt;&gt; + }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + if (pci_read_config_dword(pcidev, MCHBAR_I965 + 4, &amp;val=
32))<br>
&gt; &gt;&gt; + goto out;<br>
&gt; &gt;&gt; + val64 =3D (u64)val32;<br>
&gt; &gt;&gt; + val64 &lt;&lt;=3D 32;<br>
&gt; &gt;&gt; + if (pci_read_config_dword(pcidev, MCHBAR_I965, &amp;val32))=
<br>
&gt; &gt;&gt; + goto out;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + val64 |=3D val32;<br>
&gt; &gt;&gt; + data-&gt;igp_base =3D val64 &amp; MCHBAR_MASK;<br>
&gt; &gt;&gt; + data-&gt;igp_len =3D 16*1024;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + data-&gt;chipset_id =3D devid;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + res =3D 0;<br>
&gt; &gt;&gt; +out:<br>
&gt; &gt;&gt; + pci_dev_put(pcidev);<br>
&gt; &gt;&gt; + return res;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static unsigned long chipset_ids[] =3D {<br>
&gt; &gt;&gt; + PCI_DEVICE_ID_INTEL_82965GM,<br>
&gt; &gt;&gt; + PCI_DEVICE_ID_INTEL_82965GME,<br>
&gt; &gt;&gt; + 0<br>
&gt; &gt;&gt; +};<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static int __devinit gm965temp_probe(struct platform_device =
*pdev)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; + struct gm965temp_data *data;<br>
&gt; &gt;&gt; + struct resource *reso;<br>
&gt; &gt;&gt; + int i;<br>
&gt; &gt;&gt; + int res =3D -ENODEV;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + data =3D kzalloc(sizeof(*data), GFP_KERNEL);<br>
&gt; &gt;&gt; + if (!data)<br>
&gt; &gt;&gt; + return -ENOMEM;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + i =3D 0;<br>
&gt; &gt;&gt; + do {<br>
&gt; &gt;&gt; + res =3D gm965_find_igp_registers(data, chipset_ids[i]);<br>
&gt; &gt;&gt; + i++;<br>
&gt; &gt;&gt; + } while (res &amp;&amp; chipset_ids[i]);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + if (res)<br>
&gt; &gt;&gt; + goto err;<br>
&gt; &gt;&gt; + /* Set up resource regions */<br>
&gt; &gt;&gt; + reso =3D request_mem_region(data-&gt;igp_base, data-&gt;igp=
_len, DRVNAME);<br>
&gt; &gt;&gt; + if (!reso) {<br>
&gt; &gt;&gt; + printk(KERN_ERR "request_mem_region failed\n");<br>
&gt; &gt;&gt; + res =3D -EBUSY;<br>
&gt; &gt;&gt; + goto err;<br>
&gt; &gt;&gt; + }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + data-&gt;igp_mmio =3D ioremap_nocache(data-&gt;igp_base, da=
ta-&gt;igp_len);<br>
&gt; &gt;&gt; + if (!data-&gt;igp_mmio) {<br>
&gt; &gt;&gt; + printk(KERN_ERR "ioremap_nocache failed\n");<br>
&gt; &gt;&gt; + res =3D -EBUSY;<br>
&gt; &gt;&gt; + goto err_map_failed;<br>
&gt; &gt;&gt; + }<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + platform_set_drvdata(pdev, data);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + mutex_init(&amp;data-&gt;update_lock);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + res =3D gm965temp_hwmon_init(pdev);<br>
&gt; &gt;&gt; + if (res)<br>
&gt; &gt;&gt; + goto err_init_failed;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + return res;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +err_init_failed:<br>
&gt; &gt;&gt; + iounmap(data-&gt;igp_mmio);<br>
&gt; &gt;&gt; + platform_set_drvdata(pdev, NULL);<br>
&gt; &gt;&gt; +err_map_failed:<br>
&gt; &gt;&gt; + release_mem_region(data-&gt;igp_base, data-&gt;igp_len);<br>
&gt; &gt;&gt; +err:<br>
&gt; &gt;&gt; + kfree(data);<br>
&gt; &gt;&gt; + return res;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static int __devexit gm965temp_remove(struct platform_device=
 *pdev)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; + struct gm965temp_data *data =3D platform_get_drvdata(pdev);=
<br>
&gt; &gt;&gt; + hwmon_device_unregister(data-&gt;hwmon_dev);<br>
&gt; &gt;&gt; + device_remove_file(&amp;pdev-&gt;dev, &amp;dev_attr_name);<=
br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + iounmap(data-&gt;igp_mmio);<br>
&gt; &gt;&gt; + release_mem_region(data-&gt;igp_base, data-&gt;igp_len);<br>
&gt; &gt;&gt; + platform_set_drvdata(pdev, NULL);<br>
&gt; &gt;&gt; + kfree(data);<br>
&gt; &gt;&gt; + return 0;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static struct platform_driver gm965temp_driver =3D {<br>
&gt; &gt;&gt; + .driver =3D {<br>
&gt; &gt;&gt; + .owner =3D THIS_MODULE,<br>
&gt; &gt;&gt; + .name =3D DRVNAME,<br>
&gt; &gt;&gt; + },<br>
&gt; &gt;&gt; + .probe =3D gm965temp_probe,<br>
&gt; &gt;&gt; + .remove =3D __devexit_p(gm965temp_remove),<br>
&gt; &gt;&gt; +};<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static int __init gm965temp_init(void)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; + int res;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + res =3D platform_driver_register(&amp;gm965temp_driver);<br>
&gt; &gt;&gt; + if (res)<br>
&gt; &gt;&gt; + return res;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + res =3D gm965temp_add();<br>
&gt; &gt;&gt; + if (res)<br>
&gt; &gt;&gt; + platform_driver_unregister(&amp;gm965temp_driver);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + return res;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +static void __exit gm965temp_exit(void)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; + platform_device_unregister(igp_pdev);<br>
&gt; &gt;&gt; + platform_driver_unregister(&amp;gm965temp_driver);<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +MODULE_AUTHOR("Lu Zhihe");<br>
&gt; &gt;&gt; +MODULE_DESCRIPTION("Intel GM965 chipset IGP temperature sens=
or");<br>
&gt; &gt;&gt; +MODULE_LICENSE("GPL");<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +module_init(gm965temp_init);<br>
&gt; &gt;&gt; +module_exit(gm965temp_exit);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; ------------------------------<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Message: 2<br>
&gt; &gt;&gt; Date: Thu, 9 Jul 2009 07:19:09 -0700<br>
&gt; &gt;&gt; From: Juerg Haefliger &lt;juergh@gmail.com&gt;<br>
&gt; &gt;&gt; Subject: Re: [lm-sensors] sensors-detect and c7temp<br>
&gt; &gt;&gt; To: Hans de Goede &lt;hdegoede@redhat.com&gt;, Nicolas Chauve=
t<br>
&gt; &gt;&gt; &lt;kwizart@gmail.com&gt;<br>
&gt; &gt;&gt; Cc: LM Sensors &lt;lm-sensors@lm-sensors.org&gt;<br>
&gt; &gt;&gt; Message-ID:<br>
&gt; &gt;&gt; &lt;191fb4ca0907090719u4b4994b6x33a12874b83aaf04@mail.gmail.c=
om&gt;<br>
&gt; &gt;&gt; Content-Type: text/plain; charset=3DUTF-8<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Hans, Nicholas,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Hans, you reviewed it already a long time ago :-)<br>
&gt; &gt;&gt; (http://article.gmane.org/gmane.linux.drivers.sensors/17029/m=
atch=3Dc7temp<br>
&gt; &gt;&gt;) I personally don't have a C7 and the driver did never make i=
t into<br>
&gt; &gt;&gt; mainline I guess mainly because there were quite a few tester=
s that<br>
&gt; &gt;&gt; reported 0 C temp readings. Some C7 don't seem to have the SW=
 readable<br>
&gt; &gt;&gt; temp sensor enabled and I couldn't/never had the time to figu=
re out what<br>
&gt; &gt;&gt; is going on. On top of that, Harald from VIA posted a patch f=
or a<br>
&gt; &gt;&gt; different driver for the C7.<br>
&gt; &gt;&gt; http://lists.lm-sensors.org/pipermail/lm-sensors/2009-June/02=
6037.html<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Jean was asking which one he should pick to include and I rep=
lied with<br>
&gt; &gt;&gt; a few questions for Harald and we are waiting on a response. =
The ball<br>
&gt; &gt;&gt; is in Harald's court.<br>
&gt; &gt;&gt; http://lists.lm-sensors.org/pipermail/lm-sensors/2009-June/02=
6167.html<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Nicholas, feel free to test either or both drivers.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; It's time to get either one of them into the kernel. If we do=
n't hear<br>
&gt; &gt;&gt; from Harald I suggest to pick mine :-)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; ...juerg<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Thu, Jul 9, 2009 at 6:13 AM, Hans de Goede&lt;hdegoede@red=
hat.com&gt; wrote:<br>
&gt; &gt;&gt; &gt; Hi,<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; On 06/25/2009 09:48 PM, Nicolas Chauvet wrote:<br>
&gt; &gt;&gt; &gt;&gt; Hello Hans!<br>
&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; ?From http://www.lm-sensors.org/wiki/Device and abou=
t C7 (Esther)<br>
&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; I own such device, and it seems still requesting tes=
ters for the<br>
&gt; &gt;&gt; &gt;&gt; c7temp driver ?<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; I'm not sure what the status of this driver is, it seems=
 it never made<br>
&gt; &gt;&gt; &gt; it<br>
&gt; &gt;&gt; &gt; into<br>
&gt; &gt;&gt; &gt; the mainline kernel, which is a petty. I hope the author=
 of the driver<br>
&gt; &gt;&gt; &gt; (Juerg Haefliger &lt;juergh@gmail.com&gt;, in the CC) ca=
n answer this.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Juerg, what ever happened to the c7temp driver ? Are you=
 still<br>
&gt; &gt;&gt; &gt; interested<br>
&gt; &gt;&gt; &gt; in getting it into the mainline? If so Nicolas can test =
it and I can<br>
&gt; &gt;&gt; &gt; review it.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Thanks &amp; Regards,<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Hans<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; ------------------------------<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Message: 3<br>
&gt; &gt;&gt; Date: Thu, 9 Jul 2009 17:33:48 +0200<br>
&gt; &gt;&gt; From: Jean Delvare &lt;khali@linux-fr.org&gt;<br>
&gt; &gt;&gt; Subject: Re: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add suppo=
rt for<br>
&gt; &gt;&gt; GM/GME965 IGP temperature report.<br>
&gt; &gt;&gt; To: lu zhihe &lt;tombowfly@gmail.com&gt;<br>
&gt; &gt;&gt; Cc: lm-sensors@lm-sensors.org<br>
&gt; &gt;&gt; Message-ID: &lt;20090709173348.5bec7f14@hyperion.delvare&gt;<=
br>
&gt; &gt;&gt; Content-Type: text/plain; charset=3DUS-ASCII<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Hi Lu,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Thu, 9 Jul 2009 13:41:38 +0000, lu zhihe wrote:<br>
&gt; &gt;&gt; &gt; From: Lu Zhihe &lt;tombowfly@gmail.com&gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Subject: [PATCH] hwmon: add support for GM/GME965 IGP te=
mperature<br>
&gt; &gt;&gt; &gt; report.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Exported the graphics hot spot temperature report via sy=
sfs.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Signed-off-by: Lu Zhihe &lt;tombowfly@gmail.com&gt;<br>
&gt; &gt;&gt; &gt; ---<br>
&gt; &gt;&gt; &gt; (...)<br>
&gt; &gt;&gt; &gt; +static unsigned long chipset_ids[] =3D {<br>
&gt; &gt;&gt; &gt; + PCI_DEVICE_ID_INTEL_82965GM,<br>
&gt; &gt;&gt; &gt; + PCI_DEVICE_ID_INTEL_82965GME,<br>
&gt; &gt;&gt; &gt; + 0<br>
&gt; &gt;&gt; &gt; +};<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; These defines do not exist in the current kernel tree. I pres=
ume you<br>
&gt; &gt;&gt; forgot to includes changes to include/linux/pci_ids.h?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I am also curious what these PCI devices are. We do not want =
to have<br>
&gt; &gt;&gt; driver conflicts, so it might make more sense to add hardware=
<br>
&gt; &gt;&gt; monitoring functionality to an existing driver than writing a=
 brand new<br>
&gt; &gt;&gt; driver.<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; lm-sensors mailing list<br>
&gt; &gt; lm-sensors@lm-sensors.org<br>
&gt; &gt; http://lists.lm-sensors.org/mailman/listinfo/lm-sensors<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p></body></html>
--Boundary-01=_E3zjKKInpbDgBHx--


--===============3559272783554798856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3559272783554798856==--
