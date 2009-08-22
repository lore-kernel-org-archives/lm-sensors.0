From: Justin Chudgar <justin@justinzane.com>
Date: Sat, 22 Aug 2009 07:23:33 +0000
Subject: [lm-sensors] Harald's C7 temp driver
Message-Id: <200908220023.34028.justin@justinzane.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_2z5jKQnkOIa2WTX"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--Boundary-00=_2z5jKQnkOIa2WTX
Content-Type: multipart/alternative; boundary="Boundary-01=_2z5jKthnBn0hBDG"
Content-Transfer-Encoding: 7bit

--Boundary-01=_2z5jKthnBn0hBDG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I've been messing (clumsily, since I am learning C while doing this... plea=
se=20
be patient with me :) with Harald's via_cputemp.ko driver and have noticed=
=20
that while I do not get readings using his driver as is, some printk's adde=
d=20
into his code show that there is a reading being obtained.

Here is some sample output:
acpitz-virtual-0
Adapter: Virtual device
temp1:       +57.0=C2=B0C  (crit =3D +105.0=C2=B0C)

c7temp-isa-0000
Adapter: ISA adapter
in0:         +0.84 V
temp1:        +0.0=C2=B0C

via_cputemp-isa-0000
Adapter: ISA adapter
Core 0:       +0.1=C2=B0C

root@justin-mininote:/lib/modules/2.6.31-rc6justin/kernel/drivers/hwmon# dm=
esg=20
| tail
[28068.954298] TEMP: 53
[28075.767438] show_temp: 3
[28075.767451] CPU:        0, MSR:     1169, eax:       35, edx:        0,=
=20
err:        3
[28075.767459] TEMP: 53
[28096.575734] show_temp: 3
[28096.575746] CPU:        0, MSR:     1169, eax:       37, edx:        0,=
=20
err:        3
[28096.575753] TEMP: 55
[28156.787908] show_temp: 3
[28156.787920] CPU:        0, MSR:     1169, eax:       38, edx:        0,=
=20
err:        3
[28156.787928] TEMP: 56

As you can see, the dmesg log shows a CPU temp that tracks with but does no=
t=20
exactly duplicate the ACPI temp. To me, this means that I am probably getti=
ng=20
good data.

The function in question is show_temp on lines 69-86 in the attached code. =
If=20
someone can help me understand how the string buffer 'buf' with the tempera=
ture=20
reading is supposed to be passed on to userland code, I'd appreciate it.

Once again, please be patient as I am NOT a programmer, just a guy with a C=
7=20
cpu who want to get lm-sensors working.

Thanks.

--Boundary-01=_2z5jKthnBn0hBDG
Content-Type: text/html;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-=
html40/strict.dtd"><html><head><meta name=3D"qrichtext" content=3D"1" /><st=
yle type=3D"text/css">p, li { white-space: pre-wrap; }</style></head><body =
style=3D" font-family:'DejaVu Serif'; font-size:8pt; font-weight:400; font-=
style:normal;">I've been messing (clumsily, since I am learning C while doi=
ng this... please be patient with me :) with Harald's via_cputemp.ko driver=
 and have noticed that while I do not get readings using his driver as is, =
some printk's added into his code show that there is a reading being obtain=
ed.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>Here is some sample output:<br>
<span style=3D" font-family:'dejavu sans mono';">acpitz-virtual-0</span><br>
<span style=3D" font-family:'dejavu sans mono';">Adapter: Virtual device</s=
pan><br>
<span style=3D" font-family:'dejavu sans mono';">temp1:       +57.0=C2=B0C =
 (crit =3D +105.0=C2=B0C)</span><br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0; font-family:'dejavu sans mono';"><br></p><span style=3D" font-=
family:'dejavu sans mono';">c7temp-isa-0000</span><br>
<span style=3D" font-family:'dejavu sans mono';">Adapter: ISA adapter</span=
><br>
<span style=3D" font-family:'dejavu sans mono';">in0:         +0.84 V</span=
><br>
<span style=3D" font-family:'dejavu sans mono';">temp1:        +0.0=C2=B0C<=
/span><br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0; font-family:'dejavu sans mono';"><br></p><span style=3D" font-=
family:'dejavu sans mono';">via_cputemp-isa-0000</span><br>
<span style=3D" font-family:'dejavu sans mono';">Adapter: ISA adapter</span=
><br>
<span style=3D" font-family:'dejavu sans mono';">Core 0:       +0.1=C2=B0C<=
/span><br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0; font-family:'dejavu sans mono';"><br></p><span style=3D" font-=
family:'dejavu sans mono';">root@justin-mininote:/lib/modules/2.6.31-rc6jus=
tin/kernel/drivers/hwmon# dmesg | tail</span><br>
<span style=3D" font-family:'dejavu sans mono';">[28068.954298] TEMP: 53</s=
pan><br>
<span style=3D" font-family:'dejavu sans mono';">[28075.767438] show_temp: =
3</span><br>
<span style=3D" font-family:'dejavu sans mono';">[28075.767451] CPU:       =
 0, MSR:     1169, eax:       35, edx:        0, err:        3</span><br>
<span style=3D" font-family:'dejavu sans mono';">[28075.767459] TEMP: 53</s=
pan><br>
<span style=3D" font-family:'dejavu sans mono';">[28096.575734] show_temp: =
3</span><br>
<span style=3D" font-family:'dejavu sans mono';">[28096.575746] CPU:       =
 0, MSR:     1169, eax:       37, edx:        0, err:        3</span><br>
<span style=3D" font-family:'dejavu sans mono';">[28096.575753] TEMP: 55</s=
pan><br>
<span style=3D" font-family:'dejavu sans mono';">[28156.787908] show_temp: =
3</span><br>
<span style=3D" font-family:'dejavu sans mono';">[28156.787920] CPU:       =
 0, MSR:     1169, eax:       38, edx:        0, err:        3</span><br>
<span style=3D" font-family:'dejavu sans mono';">[28156.787928] TEMP: 56</s=
pan><br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0; font-family:'dejavu sans mono';"><br></p><span style=3D" font-=
family:'dejavu serif';">As you can see, the dmesg log shows a CPU temp that=
 tracks with but does not exactly duplicate the ACPI temp. To me, this mean=
s that I am probably getting good data.</span><br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0; font-family:'dejavu serif';"><br></p><span style=3D" font-fami=
ly:'dejavu serif';">The function in question is show_temp on lines 69-86 in=
 the attached code. If someone can help me understand how the string buffer=
 'buf' with the temperature reading is supposed to be passed on to userland=
 code, I'd appreciate it.</span><br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0; font-family:'dejavu serif';"><br></p><span style=3D" font-fami=
ly:'dejavu serif';">Once again, please be patient as I am NOT a programmer,=
 just a guy with a C7 cpu who want to get lm-sensors working.</span><br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0; font-family:'dejavu serif';"><br></p><span style=3D" font-fami=
ly:'dejavu serif';">Thanks.</span><br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0; font-family:'dejavu sans mono';"><br></p></body></html>
--Boundary-01=_2z5jKthnBn0hBDG--

--Boundary-00=_2z5jKQnkOIa2WTX
Content-Type: text/x-csrc;
  charset="UTF-8";
  name="via_cputemp.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="via_cputemp.c"

/*
* via_cputemp.c - Driver for VIA CPU core temperature monitoring
* Copyright (C) 2009 VIA Technologies, Inc.
*
* based on existing coretemp.c, which is
*
* Copyright (C) 2007 Rudolf Marek <r.marek at assembler.cz>
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; version 2 of the License.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
* 02110-1301 USA.
*
* Original work by Harald Welte, modified by Justin Chudgar <justin@justinzane.com>
*/

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/delay.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/jiffies.h>
#include <linux/hwmon.h>
#include <linux/sysfs.h>
#include <linux/hwmon-sysfs.h>
#include <linux/err.h>
#include <linux/mutex.h>
#include <linux/list.h>
#include <linux/platform_device.h>
#include <linux/cpu.h>
#include <asm/msr.h>
#include <asm/processor.h>

#define DRVNAME    "via_cputemp"

enum { SHOW_TEMP, SHOW_LABEL, SHOW_NAME } SHOW;

struct via_cputemp_data {
    struct device *hwmon_dev;
    const char *name;
    u32 id;
    u32 msr;
};

static ssize_t show_name(struct device *dev, struct device_attribute *devattr, char *buf)
{
    int ret;
    struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
    struct via_cputemp_data *data = dev_get_drvdata(dev);
    
    if (attr->index == SHOW_NAME) {
        ret = sprintf(buf, "%s\n", data->name);
    }
    else  {  /* show label */
        ret = sprintf(buf, "Core %d\n", data->id);
    }
    return ret;
}

static ssize_t show_temp(struct device *dev, struct device_attribute *devattr, char *buf)
{
    struct via_cputemp_data *data = dev_get_drvdata(dev);
    u32 eax, edx;
    int err;
    
    err = rdmsr_safe_on_cpu(data->id, data->msr, &eax, &edx);
    if (err)
        return -EAGAIN;
    
    err = sprintf(buf, "%d\n", eax & 0xffffff); 
    
    printk(KERN_ALERT "show_temp: %d", err);
    printk(KERN_ALERT "CPU: %8x, MSR: %8x, eax: %8x, edx: %8x, err: %8x", data->id, data->msr, eax, edx, err);
    printk(KERN_ALERT "TEMP: %d", eax & 0xffffff);
    
    return err;
}

static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, SHOW_TEMP);
static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABEL);
static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);

static struct attribute *via_cputemp_attributes[] = {
    &sensor_dev_attr_name.dev_attr.attr,
    &sensor_dev_attr_temp1_label.dev_attr.attr,
    &sensor_dev_attr_temp1_input.dev_attr.attr,
    NULL
};

static const struct attribute_group via_cputemp_group = {
    .attrs = via_cputemp_attributes,
};

static int __devinit via_cputemp_probe(struct platform_device *pdev)
{
    struct via_cputemp_data *data;
    struct cpuinfo_x86 *c = &cpu_data(pdev->id);
    int err;
    u32 eax, edx;
    
    if (!(data = kzalloc(sizeof(struct via_cputemp_data), GFP_KERNEL))) {
        err = -ENOMEM;
        dev_err(&pdev->dev, "Out of memory\n");
        goto exit;
    }
    
    data->id = pdev->id;
    data->name = "via_cputemp";
    
    switch (c->x86_model) {
        case 0xA:
            printk(KERN_ALERT "We are using a VIA C7 model A CPU.");
            data->msr = 0x1169;
            break;
        case 0xB:
            printk(KERN_ALERT "We are using a VIA C7 model B CPU.");
            data->msr = 0x1169;
            break;
        case 0xC:
            printk(KERN_ALERT "We are using a VIA C7 model C CPU.");
            data->msr = 0x1169;
            break;
        case 0xD:
            printk(KERN_ALERT "We are using a VIA C7 model D CPU.");
            data->msr = 0x1169; // MSR 0x1167 is the user Therm Threshold Temp
            break;
        case 0xF:
            printk(KERN_ALERT "We are using a VIA Nano CPU.");
            data->msr = 0x1423;
            break;
        default:
            printk(KERN_ALERT "We are using an unidentified CPU.");
            err = -ENODEV;
            goto exit_free;
    }
    
    /* test if we can access the TEMPERATURE MSR */
    err = rdmsr_safe_on_cpu(data->id, data->msr, &eax, &edx);
    printk(KERN_ALERT "Read MSR from CPU %d, MSR %x, %x, %x: ", data->id, data->msr, &eax, &edx);
    if (err) {
        dev_err(&pdev->dev, "Unable to access TEMP MSR, giving up\n");
        goto exit_free;
    }
    
    platform_set_drvdata(pdev, data);
    
    if ((err = sysfs_create_group(&pdev->dev.kobj, &via_cputemp_group)))
        goto exit_free;
    
    data->hwmon_dev = hwmon_device_register(&pdev->dev);
    if (IS_ERR(data->hwmon_dev)) {
        err = PTR_ERR(data->hwmon_dev);
        dev_err(&pdev->dev, "Class registration failed (%d)\n",
                err);
                goto exit_class;
    }
    
    return 0;
    
    exit_class:
    sysfs_remove_group(&pdev->dev.kobj, &via_cputemp_group);
    exit_free:
    kfree(data);
    exit:
    return err;
}

static int __devexit via_cputemp_remove(struct platform_device *pdev)
{
    struct via_cputemp_data *data = platform_get_drvdata(pdev);
    
    hwmon_device_unregister(data->hwmon_dev);
    sysfs_remove_group(&pdev->dev.kobj, &via_cputemp_group);
    platform_set_drvdata(pdev, NULL);
    kfree(data);
    return 0;
}

static struct platform_driver via_cputemp_driver = {
    .driver = {
        .owner = THIS_MODULE,
        .name = DRVNAME,
    },
    .probe = via_cputemp_probe,
    .remove = __devexit_p(via_cputemp_remove),
};

struct pdev_entry {
    struct list_head list;
    struct platform_device *pdev;
    unsigned int cpu;
};

static LIST_HEAD(pdev_list);
static DEFINE_MUTEX(pdev_list_mutex);

static int __cpuinit via_cputemp_device_add(unsigned int cpu)
{
    int err;
    struct platform_device *pdev;
    struct pdev_entry *pdev_entry;
    
    pdev = platform_device_alloc(DRVNAME, cpu);
    if (!pdev) {
        err = -ENOMEM;
        printk(KERN_ERR DRVNAME ": Device allocation failed\n");
        goto exit;
    }
    
    pdev_entry = kzalloc(sizeof(struct pdev_entry), GFP_KERNEL);
    if (!pdev_entry) {
        err = -ENOMEM;
        goto exit_device_put;
    }
    
    err = platform_device_add(pdev);
    if (err) {
        printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n", err);
        goto exit_device_free;
    }
    
    pdev_entry->pdev = pdev;
    pdev_entry->cpu = cpu;
    mutex_lock(&pdev_list_mutex);
    list_add_tail(&pdev_entry->list, &pdev_list);
    mutex_unlock(&pdev_list_mutex);
    
    return 0;
    
    exit_device_free:
    kfree(pdev_entry);
    exit_device_put:
    platform_device_put(pdev);
    exit:
    return err;
}

#ifdef CONFIG_HOTPLUG_CPU
static void via_cputemp_device_remove(unsigned int cpu)
{
    struct pdev_entry *p, *n;
    mutex_lock(&pdev_list_mutex);
    list_for_each_entry_safe(p, n, &pdev_list, list) {
        if (p->cpu == cpu) {
            platform_device_unregister(p->pdev);
            list_del(&p->list);
            kfree(p);
        }
    }
    mutex_unlock(&pdev_list_mutex);
}

static int __cpuinit via_cputemp_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
{
    unsigned int cpu = (unsigned long) hcpu;
    
    switch (action) {
        case CPU_ONLINE:
        case CPU_DOWN_FAILED:
            via_cputemp_device_add(cpu);
            break;
        case CPU_DOWN_PREPARE:
            via_cputemp_device_remove(cpu);
            break;
    }
    return NOTIFY_OK;
}

static struct notifier_block via_cputemp_cpu_notifier __refdata = {
    .notifier_call = via_cputemp_cpu_callback,
};
#endif             /* !CONFIG_HOTPLUG_CPU */

static int __init via_cputemp_init(void)
{
    int i, err = -ENODEV;
    struct pdev_entry *p, *n;
    
    printk(KERN_ALERT "Initilizing module: %s", DRVNAME);
    
    if (cpu_data(0).x86_vendor != X86_VENDOR_CENTAUR) {
        printk(KERN_ALERT "Not a VIA CPU\n");
        goto exit;
    }
    
    err = platform_driver_register(&via_cputemp_driver);
    if (err)
        goto exit;
    
    for_each_online_cpu(i) {
        struct cpuinfo_x86 *c = &cpu_data(i);
        printk(KERN_ALERT "c->x86: %d", c->x86);
        
        if (c->x86 != 6) { continue; }
        if (c->x86_model < 0x0a) { continue; }
        if (c->x86_model > 0x0f) {
            printk(KERN_WARNING DRVNAME ": Unknown CPU model %x\n", c->x86_model);
            continue;
        }
        
        err = via_cputemp_device_add(i);
        if (err)
            goto exit_devices_unreg;
    }
    
    if (list_empty(&pdev_list)) {
        err = -ENODEV;
        goto exit_driver_unreg;
    }
    
    #ifdef CONFIG_HOTPLUG_CPU
    register_hotcpu_notifier(&via_cputemp_cpu_notifier);
    #endif
    return 0;
    
    exit_devices_unreg:
    mutex_lock(&pdev_list_mutex);
    list_for_each_entry_safe(p, n, &pdev_list, list) {
        platform_device_unregister(p->pdev);
        list_del(&p->list);
        kfree(p);
    }
    mutex_unlock(&pdev_list_mutex);
    exit_driver_unreg:
    platform_driver_unregister(&via_cputemp_driver);
    exit:
    return err;
}

static void __exit via_cputemp_exit(void)
{
    struct pdev_entry *p, *n;
    
    printk(KERN_ALERT "Exiting module: %s", DRVNAME);
    
    #ifdef CONFIG_HOTPLUG_CPU
    unregister_hotcpu_notifier(&via_cputemp_cpu_notifier);
    #endif
    
    mutex_lock(&pdev_list_mutex);
    list_for_each_entry_safe(p, n, &pdev_list, list) {
        platform_device_unregister(p->pdev);
        list_del(&p->list);
        kfree(p);
    }
    mutex_unlock(&pdev_list_mutex);
    platform_driver_unregister(&via_cputemp_driver);
}

MODULE_AUTHOR("Harald Welte <HaraldWelte at viatech.com>");
MODULE_DESCRIPTION("VIA CPU temperature monitor");
MODULE_LICENSE("GPL");

module_init(via_cputemp_init)
module_exit(via_cputemp_exit)

--Boundary-00=_2z5jKQnkOIa2WTX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_2z5jKQnkOIa2WTX--
