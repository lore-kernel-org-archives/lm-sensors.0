From: Justin Chudgar <justin@justinzane.com>
Date: Sun, 23 Aug 2009 02:33:14 +0000
Subject: [lm-sensors] Combined C7 temp driver
Message-Id: <200908221933.14582.justin@justinzane.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_qpKkKFbS+tKiXiI"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--Boundary-00=_qpKkKFbS+tKiXiI
Content-Type: multipart/alternative; boundary="Boundary-01=_qpKkKPqRTZc5D4x"
Content-Transfer-Encoding: 7bit

--Boundary-01=_qpKkKPqRTZc5D4x
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

So, I have combined the working elements of both Juerg's and Harald's drive=
rs=20
into one. I decided to keep the name c7temp since sensors-detect already=20
recognizes this.

The combined source file is attached as c7temp.c

Thanks to Juerg and Harald and everyone else.
=2D-=20

Justin Chudgar
Information Technology Consultant
5040 Saddlehorn Rd, Weed, CA 96084
530-938-9692 (Home Office)

On Saturday 22 August 2009 02:16:16 am you wrote:
> Dear Justin,
>
>          Harald had a updated version of via_cputemp,
>
>         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
> index 1032355..2abe516 100644
> --- a/drivers/hwmon/via-cputemp.c
> +++ b/drivers/hwmon/via-cputemp.c
> @@ -37,7 +37,7 @@
>  #include <asm/msr.h>
>  #include <asm/processor.h>
>
> -#define DRVNAME        "via-cputemp"
> +#define DRVNAME        "via_cputemp"
>
>  typedef enum { SHOW_TEMP, SHOW_LABEL, SHOW_NAME } SHOW;
>
> @@ -81,7 +81,7 @@ static ssize_t show_temp(struct device *dev,
>        if (err)
>                return -EAGAIN;
>
> -       err =3D sprintf(buf, "%d\n", eax & 0xffffff);
> +       err =3D sprintf(buf, "%d\n", (eax & 0xffffff) * 1000);
>
>        return err;
>  }
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>        Had you try it?
>        Just a remind.
>
> 2009/8/22 Justin Chudgar <justin@justinzane.com>:
> > I've been messing (clumsily, since I am learning C while doing this...
> > please be patient with me :) with Harald's via_cputemp.ko driver and ha=
ve
> > noticed that while I do not get readings using his driver as is, some
> > printk's added into his code show that there is a reading being obtaine=
d.
> >
> > Here is some sample output:
> > acpitz-virtual-0
> > Adapter: Virtual device
> > temp1: +57.0=B0C (crit =3D +105.0=B0C)
> >
> > c7temp-isa-0000
> > Adapter: ISA adapter
> > in0: +0.84 V
> > temp1: +0.0=B0C
> >
> > via_cputemp-isa-0000
> > Adapter: ISA adapter
> > Core 0: +0.1=B0C
> >
> > root@justin-mininote:/lib/modules/2.6.31-rc6justin/kernel/drivers/hwmon#
> > dmesg | tail
> > [28068.954298] TEMP: 53
> > [28075.767438] show_temp: 3
> > [28075.767451] CPU: 0, MSR: 1169, eax: 35, edx: 0, err: 3
> > [28075.767459] TEMP: 53
> > [28096.575734] show_temp: 3
> > [28096.575746] CPU: 0, MSR: 1169, eax: 37, edx: 0, err: 3
> > [28096.575753] TEMP: 55
> > [28156.787908] show_temp: 3
> > [28156.787920] CPU: 0, MSR: 1169, eax: 38, edx: 0, err: 3
> > [28156.787928] TEMP: 56
> >
> > As you can see, the dmesg log shows a CPU temp that tracks with but does
> > not exactly duplicate the ACPI temp. To me, this means that I am probab=
ly
> > getting good data.
> >
> > The function in question is show_temp on lines 69-86 in the attached
> > code. If someone can help me understand how the string buffer 'buf' with
> > the temperature reading is supposed to be passed on to userland code, I=
'd
> > appreciate it.
> >
> > Once again, please be patient as I am NOT a programmer, just a guy with=
 a
> > C7 cpu who want to get lm-sensors working.
> >
> > Thanks.
> >
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

--Boundary-01=_qpKkKPqRTZc5D4x
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-=
html40/strict.dtd"><html><head><meta name=3D"qrichtext" content=3D"1" /><st=
yle type=3D"text/css">p, li { white-space: pre-wrap; }</style></head><body =
style=3D" font-family:'DejaVu Serif'; font-size:8pt; font-weight:400; font-=
style:normal;">So, I have combined the working elements of both Juerg's and=
 Harald's drivers into one. I decided to keep the name c7temp since sensors=
=2Ddetect already recognizes this.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>The combined source file is attached as c7temp.c<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>Thanks to Juerg and Harald and everyone else.<br />--=
 <br /><br>
<span style=3D" font-family:'betecknalowercasebold';">Justin Chudgar</span>=
<br>
Information Technology Consultant<br>
5040 Saddlehorn Rd, Weed, CA 96084<br>
530-938-9692 (Home Office)<br>
<br />On Saturday 22 August 2009 02:16:16 am you wrote:<br>
&gt; Dear Justin,<br>
&gt;<br>
&gt;          Harald had a updated version of via_cputemp,<br>
&gt;<br>
&gt;         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c=
<br>
&gt; index 1032355..2abe516 100644<br>
&gt; --- a/drivers/hwmon/via-cputemp.c<br>
&gt; +++ b/drivers/hwmon/via-cputemp.c<br>
&gt; @@ -37,7 +37,7 @@<br>
&gt;  #include &lt;asm/msr.h&gt;<br>
&gt;  #include &lt;asm/processor.h&gt;<br>
&gt;<br>
&gt; -#define DRVNAME        "via-cputemp"<br>
&gt; +#define DRVNAME        "via_cputemp"<br>
&gt;<br>
&gt;  typedef enum { SHOW_TEMP, SHOW_LABEL, SHOW_NAME } SHOW;<br>
&gt;<br>
&gt; @@ -81,7 +81,7 @@ static ssize_t show_temp(struct device *dev,<br>
&gt;        if (err)<br>
&gt;                return -EAGAIN;<br>
&gt;<br>
&gt; -       err =3D sprintf(buf, "%d\n", eax &amp; 0xffffff);<br>
&gt; +       err =3D sprintf(buf, "%d\n", (eax &amp; 0xffffff) * 1000);<br>
&gt;<br>
&gt;        return err;<br>
&gt;  }<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;<br>
&gt;        Had you try it?<br>
&gt;        Just a remind.<br>
&gt;<br>
&gt; 2009/8/22 Justin Chudgar &lt;justin@justinzane.com&gt;:<br>
&gt; &gt; I've been messing (clumsily, since I am learning C while doing th=
is...<br>
&gt; &gt; please be patient with me :) with Harald's via_cputemp.ko driver =
and have<br>
&gt; &gt; noticed that while I do not get readings using his driver as is, =
some<br>
&gt; &gt; printk's added into his code show that there is a reading being o=
btained.<br>
&gt; &gt;<br>
&gt; &gt; Here is some sample output:<br>
&gt; &gt; acpitz-virtual-0<br>
&gt; &gt; Adapter: Virtual device<br>
&gt; &gt; temp1: +57.0=B0C (crit =3D +105.0=B0C)<br>
&gt; &gt;<br>
&gt; &gt; c7temp-isa-0000<br>
&gt; &gt; Adapter: ISA adapter<br>
&gt; &gt; in0: +0.84 V<br>
&gt; &gt; temp1: +0.0=B0C<br>
&gt; &gt;<br>
&gt; &gt; via_cputemp-isa-0000<br>
&gt; &gt; Adapter: ISA adapter<br>
&gt; &gt; Core 0: +0.1=B0C<br>
&gt; &gt;<br>
&gt; &gt; root@justin-mininote:/lib/modules/2.6.31-rc6justin/kernel/drivers=
/hwmon#<br>
&gt; &gt; dmesg | tail<br>
&gt; &gt; [28068.954298] TEMP: 53<br>
&gt; &gt; [28075.767438] show_temp: 3<br>
&gt; &gt; [28075.767451] CPU: 0, MSR: 1169, eax: 35, edx: 0, err: 3<br>
&gt; &gt; [28075.767459] TEMP: 53<br>
&gt; &gt; [28096.575734] show_temp: 3<br>
&gt; &gt; [28096.575746] CPU: 0, MSR: 1169, eax: 37, edx: 0, err: 3<br>
&gt; &gt; [28096.575753] TEMP: 55<br>
&gt; &gt; [28156.787908] show_temp: 3<br>
&gt; &gt; [28156.787920] CPU: 0, MSR: 1169, eax: 38, edx: 0, err: 3<br>
&gt; &gt; [28156.787928] TEMP: 56<br>
&gt; &gt;<br>
&gt; &gt; As you can see, the dmesg log shows a CPU temp that tracks with b=
ut does<br>
&gt; &gt; not exactly duplicate the ACPI temp. To me, this means that I am =
probably<br>
&gt; &gt; getting good data.<br>
&gt; &gt;<br>
&gt; &gt; The function in question is show_temp on lines 69-86 in the attac=
hed<br>
&gt; &gt; code. If someone can help me understand how the string buffer 'bu=
f' with<br>
&gt; &gt; the temperature reading is supposed to be passed on to userland c=
ode, I'd<br>
&gt; &gt; appreciate it.<br>
&gt; &gt;<br>
&gt; &gt; Once again, please be patient as I am NOT a programmer, just a gu=
y with a<br>
&gt; &gt; C7 cpu who want to get lm-sensors working.<br>
&gt; &gt;<br>
&gt; &gt; Thanks.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; lm-sensors mailing list<br>
&gt; &gt; lm-sensors@lm-sensors.org<br>
&gt; &gt; http://lists.lm-sensors.org/mailman/listinfo/lm-sensors<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p></body></html>
--Boundary-01=_qpKkKPqRTZc5D4x--

--Boundary-00=_qpKkKFbS+tKiXiI
Content-Type: text/x-csrc;
  charset="UTF-8";
  name="c7temp.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="c7temp.c"

/*
* c7temp.c - Driver for VIA CPU core temperature monitoring
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
* Original work by Harald Welte and Juerg Haefliger,
* modified by Justin Chudgar <justin@justinzane.com>
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

#define DRVNAME    "c7temp"

enum { SHOW_TEMP, SHOW_IN, SHOW_LABEL, SHOW_NAME } SHOW;

struct c7temp_data {
    struct device *hwmon_dev;
    const char *name;
    u32 id;
    u32 msr;
    struct mutex update_lock;
    char valid;                 // != 0 if followingfields are valid
    unsigned long last_update;  // in jiffies
};

static ssize_t show_name(struct device *dev, struct device_attribute *devattr, char *buf)
{
    struct c7temp_data *data = dev_get_drvdata(dev);
    return sprintf(buf, "%s\n", data->name);
}  //Juerg's Version
/*
 * {
 *    int ret;
 *    struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 *    struct c7temp_data *data = dev_get_drvdata(dev);
 *    
 *    if (attr->index == SHOW_NAME) {
 *        ret = sprintf(buf, "%s\n", data->name);
 *    }
 *    else  {  //show label
 *        ret = sprintf(buf, "Core %d\n", data->id);
 *    }
 *    return ret;
 *} Harald's Version - is this necessary for multicore? 
 */

static ssize_t show_temp(struct device *dev, struct device_attribute *devattr, char *buf)
{
    struct c7temp_data *data = dev_get_drvdata(dev);
    u32 eax, edx;
    int err;
    
    err = rdmsr_safe_on_cpu(data->id, data->msr, &eax, &edx);
    if (err)
        return -EAGAIN;
    
    err = sprintf(buf, "%d\n", (eax & 0xffffff) * 1000); 
    
    #ifdef DEBUG
    printk(KERN_DEBUG "CPU: %x, MSR: %x, eax: %x, edx: %x, err: %x", data->id, data->msr, eax, edx, err);
    printk(KERN_DEBUG "TEMP: %d", eax & 0xffffff);
    #endif //DEBUG
    
    return err;
}

static ssize_t show_in(struct device *dev, struct device_attribute *devattr, char *buf)
{
    int voltage;
    u32 eax, ebx, ecx, edx;
    
    cpuid(0xc0000002, &eax, &ebx, &ecx, &edx);  // Where is 0xc0000002 from?
    voltage = ebx & 0xff;
    
    return sprintf(buf, "%d", (voltage << 4) + 700);
} // From Juerg's c7temp

static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, SHOW_TEMP);
static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABEL);
static SENSOR_DEVICE_ATTR(in1_input,   S_IRUGO, show_in,   NULL, SHOW_IN);
static SENSOR_DEVICE_ATTR(name,        S_IRUGO, show_name, NULL, SHOW_NAME);

static struct attribute *c7temp_attributes[] = {
    &sensor_dev_attr_name.dev_attr.attr,
    &sensor_dev_attr_temp1_label.dev_attr.attr,
    &sensor_dev_attr_temp1_input.dev_attr.attr,
    &sensor_dev_attr_in1_input.dev_attr.attr,
    NULL
};

static const struct attribute_group c7temp_group = {
    .attrs = c7temp_attributes,
};

static int __devinit c7temp_probe(struct platform_device *pdev)
{
    struct c7temp_data *data;
    struct cpuinfo_x86 *c = &cpu_data(pdev->id);
    int err;
    u32 eax, edx;
    
    if (!(data = kzalloc(sizeof(struct c7temp_data), GFP_KERNEL))) {
        err = -ENOMEM;
        dev_err(&pdev->dev, "Out of memory\n");
        goto exit;
    }
    
    data->id = pdev->id;
    data->name = "c7temp";
    
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
    //printk(KERN_ALERT "Read MSR from CPU %d, MSR %x, %x, %x: ", data->id, data->msr, &eax, &edx);
    if (err) {
        dev_err(&pdev->dev, "Unable to access TEMP MSR, giving up\n");
        goto exit_free;
    }
    
    platform_set_drvdata(pdev, data);
    
    if ((err = sysfs_create_group(&pdev->dev.kobj, &c7temp_group)))
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
    sysfs_remove_group(&pdev->dev.kobj, &c7temp_group);
    exit_free:
    kfree(data);
    exit:
    return err;
}

static int __devexit c7temp_remove(struct platform_device *pdev)
{
    struct c7temp_data *data = platform_get_drvdata(pdev);
    
    hwmon_device_unregister(data->hwmon_dev);
    sysfs_remove_group(&pdev->dev.kobj, &c7temp_group);
    platform_set_drvdata(pdev, NULL);
    kfree(data);
    return 0;
}

static struct platform_driver c7temp_driver = {
    .driver = {
        .owner = THIS_MODULE,
        .name = DRVNAME,
    },
    .probe = c7temp_probe,
    .remove = __devexit_p(c7temp_remove),
}; //Same for both Juerg and Harald

struct pdev_entry {
    struct list_head list;
    struct platform_device *pdev;
    unsigned int cpu;
};

static LIST_HEAD(pdev_list);
static DEFINE_MUTEX(pdev_list_mutex);

static int __cpuinit c7temp_device_add(unsigned int cpu)
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
static void c7temp_device_remove(unsigned int cpu)
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

static int __cpuinit c7temp_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
{
    unsigned int cpu = (unsigned long) hcpu;
    
    switch (action) {
        case CPU_ONLINE:
        case CPU_DOWN_FAILED:
            c7temp_device_add(cpu);
            break;
        case CPU_DOWN_PREPARE:
            c7temp_device_remove(cpu);
            break;
    }
    return NOTIFY_OK;
}

static struct notifier_block c7temp_cpu_notifier __refdata = {
    .notifier_call = c7temp_cpu_callback,
};
#endif             /* !CONFIG_HOTPLUG_CPU */

static int __init c7temp_init(void)
{
    int i, err = -ENODEV;
    struct pdev_entry *p, *n;
    
    #ifdef DEBUG
    printk(KERN_DEBUG "Initilizing module: %s", DRVNAME);
    #endif
    
    if (cpu_data(0).x86_vendor != X86_VENDOR_CENTAUR) {
        printk(KERN_ERR DRVNAME "Not a VIA CPU\n");
        goto exit;
    }
    
    err = platform_driver_register(&c7temp_driver);
    if (err)
        goto exit;
    
    for_each_online_cpu(i) {
        struct cpuinfo_x86 *c = &cpu_data(i);
        
        if (c->x86 != 6) { continue; }
        if (c->x86_model < 0x0a) { continue; }
        if (c->x86_model > 0x0f) {
            printk(KERN_WARNING DRVNAME ": Unknown CPU model %x\n", c->x86_model);
            continue;
        }
        
        err = c7temp_device_add(i);
        if (err)
            goto exit_devices_unreg;
    }
    
    if (list_empty(&pdev_list)) {
        err = -ENODEV;
        goto exit_driver_unreg;
    }
    
    #ifdef CONFIG_HOTPLUG_CPU
    register_hotcpu_notifier(&c7temp_cpu_notifier);
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
    platform_driver_unregister(&c7temp_driver);
    exit:
    return err;
}

static void __exit c7temp_exit(void)
{
    struct pdev_entry *p, *n;
    
    #ifdef DEBUG
    printk(KERN_ALERT "Exiting module: %s", DRVNAME);
    #endif
    
    #ifdef CONFIG_HOTPLUG_CPU
    unregister_hotcpu_notifier(&c7temp_cpu_notifier);
    #endif
    
    mutex_lock(&pdev_list_mutex);
    list_for_each_entry_safe(p, n, &pdev_list, list) {
        platform_device_unregister(p->pdev);
        list_del(&p->list);
        kfree(p);
    }
    mutex_unlock(&pdev_list_mutex);
    platform_driver_unregister(&c7temp_driver);
}  

MODULE_AUTHOR("Juerg Haefliger <juergh@gmail.com>, Harald Welte <HaraldWelte at viatech.com>, Justin Chudgar <justin@justinzane.com>");
MODULE_DESCRIPTION("VIA C7 Family CPU temperature and voltage monitor");
MODULE_LICENSE("GPL");

module_init(c7temp_init)
module_exit(c7temp_exit)

--Boundary-00=_qpKkKFbS+tKiXiI
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_qpKkKFbS+tKiXiI--
