From: "Fred R. Beck" <beckfr@comcast.net>
Date: Sat, 19 Apr 2008 05:44:31 +0000
Subject: Re: [lm-sensors] AMD K10 (Phenom) Sensor Module
Message-Id: <480986BF.8010305@comcast.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050000080705050209080201"
List-Id: <lm-sensors.vger.kernel.org>
References: <47642FDA.6000801@cox.net>
In-Reply-To: <47642FDA.6000801@cox.net>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------050000080705050209080201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rudolf,

I've been tied up and just got back to this.  Thanks much for the 
"stripped down" version.  It looked much like my last attempt though I'd 
missed on some of the registers...  I think you are right, this is 
simple enough that there isn't much sense in combining the two drivers, 
so I'll scrap that...

As for accuracy, the way these thermistors are implemented, the only way 
to get any reasonable "accuracy" is to use as statistical approach and 
look for means and trends.  They just aren't accurate enough nor 
responsive enough other than to give a relative approximation.  However, 
that really should be good enough to be alerted to problems.

I'm including the k10temp.c that I compiled into the Fedora 8 kernel 
distro (2.6.24.4).  I made a few minor changes to clean up warnings.  
I'm also ready to generate a patch when we think this thing is ready.  I 
can now run a make in the kernel and all builds fine.

To test, I did as you suggested and just replaced the k8temp.c with your 
new one.  If anyone else wants to try, I compiled it with:

    cd /usr/src/BUILD/kernel-2.6.24/linux-2.6.24.i686
    make -C /lib/modules/2.6.24.4-64.fc8/build SUBDIRS=`pwd` modules
    cp k8temp.ko /lib/modules/2.6.24.4-64.fc8/kernel/drivers/hwmon/

( I strongly suggest backing up k8temp.c in the source directory, and 
k8temp.ko in the module path before attempting - for those trying this...)

So, running sensors now gives:

    # modprobe k8temp
    # sensors
    it8718-isa-0228
    Adapter: ISA adapter
    in0:       +1.07 V  (min =  +0.00 V, max =  +4.08 V)  
    in1:       +1.90 V  (min =  +0.00 V, max =  +4.08 V)  
    in2:       +3.38 V  (min =  +0.00 V, max =  +4.08 V)  
    in3:       +3.01 V  (min =  +0.00 V, max =  +4.08 V)  
    in4:       +3.01 V  (min =  +0.00 V, max =  +4.08 V)  
    in5:       +3.25 V  (min =  +0.00 V, max =  +4.08 V)  
    in6:       +4.08 V  (min =  +0.00 V, max =  +4.08 V)  
    in7:       +0.00 V  (min =  +0.00 V, max =  +4.08 V)  
    in8:       +3.07 V
    fan1:     1859 RPM  (min =   10 RPM)                  
    fan2:        0 RPM  (min =    0 RPM)                  
    fan3:        0 RPM  (min =    0 RPM)                  
    fan5:        0 RPM  (min =    0 RPM)                  
    temp1:       +39 C  (low  =  +127 C, high =  +127 C)   sensor = 
thermistor  
    temp2:       +41 C  (low  =  +127 C, high =   +70 C)   sensor = diode  
    temp3:       +84 C  (low  =  +127 C, high =  +127 C)   sensor = 
thermistor  
    vid:      +0.000 V

    k10temp-pci-00c3
    Adapter: PCI adapter

As you can see, I'm still figuring out how to configure lm_sensors for 
my GA-MA790FX-DS5...  However, temp1 looks ok and matches what I'm 
seeing in the BIOS.

So, what do you think?  Close enough for folks to give it a try?

Thanks again,

Fred Beck

Rudolf Marek wrote:
> Hi Fred,
>
> I think we can CC the list too, so others know that we work on this. 
> I'm CCing some people which got interrested too.
>
>> Now I'm down to the specifics peculiar to the k10 family.  I see that 
>> the calculation for CurTmp is different for k10,
>> but am a bit confused on the core selection code as pertains to the 
>> k10 and a bit lost in the AMD BKDG.  Seems to
>> be a bit of conflict on how many sensors there are (1 vs. 4).  It also 
>
> I think it is just one, It might be undocumented for any other sensors.
>
>> appears that the k10 reports a relative temp rather
>> than an absolute (referenced to 49) like the k8's did.
>
> Yes the temperature is just non-physical. So to make the driver sense 
> we need to know the MAX value. The thermal guide is still not 
> published, but Jordan is hopefully still trying ;) There is some 
> suspicion that it is 70C (TControlMAX from older processor family).
>
> I'm trying too, but now I want to get sorted some errata problems - 
> k8temps are sometimes wrong. Btw all K10 processors still suffers from 
> errata 319 Inaccurate Temperature Measurement
>
> Description
> The internal thermal sensor used for CurTmp (F3xA4[31:21]), hardware 
> thermal control (HTC), software thermal control (STC), and the 
> sideband temperature sensor interface (SB-TSI) may report inconsistent 
> values.
>
>
> So question is if to go for the driver at all :/
>
>> Eventually, I was thinking that this driver should be called kxtemp, 
>> or something similar and support both k8/k10.
>> There would need to be a bit more work on CPUID, but that shouldn't 
>> be too difficult.  Anyway, as an example, I have:
>>
>>    #define TEMP_FROM_REG_K08(val)   (((((val) >> 16) & 0xff) - 49) * 
>> 1000)
>>    #define TEMP_FROM_REG_K10(val)   (((((val) >> 16) & 0xff) /  8) * 
>> 1000)
>
> Hmm the reg is 0xA4 and temp is in bits 31:21 so perhaps >>16 is wrong 
> too?
>
>> Haven't subscribed to lm-sensors since it appears that you are 
>> basically the only one working on this.  I need some guidance,
>> but am willing to help.  Am an old (rusty) kernel hacker, though have 
>> not played with CPU/NB registers before.  Mostly
>> peripheral drivers and tcp/ip stack code tuning.
>
> Well never mind I can certainly help.
>
>> Look forward to working with you on this,
>
> Question is if we can go just for one driver, it depends on amount of 
> changes.
> I'm attaching some striped down version driver, which MIGHT work. 
> Quick hack, but well will see.
>
> Just replace your k8temp.c with one attached and recompile kernel. Run 
> sufficiently knew 'sensors' command, maybe it will print something 
> useful ;)
>
> Thanks,
> Rudolf
>


--------------050000080705050209080201
Content-Type: text/x-csrc;
 name="k10temp.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="k10temp.c"

/*
 * k10temp.c - Linux kernel module for hardware monitoring
 *
 * Copyright (C) 2008 Rudolf Marek <r.marek@assembler.cz>
 *
 * Inspired from the k8temp driver.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
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
 */

#include <linux/module.h>
#include <linux/delay.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/jiffies.h>
#include <linux/pci.h>
#include <linux/hwmon.h>
#include <linux/hwmon-sysfs.h>
#include <linux/err.h>
#include <linux/mutex.h>

/* 1000 / 8 = 125 no mask because we shift from bit 31 */
#define TEMP_FROM_REG(val)	(((val) >> 21) * 125)
#define REG_TEMP	0xa4

struct k10temp_data {
	struct device *hwmon_dev;
	struct mutex update_lock;
	const char *name;
	char valid;		/* zero until following fields are valid */
	unsigned long last_updated;	/* in jiffies */

	/* registers values */
	u32 temp;		/* raw value */
};

static struct k10temp_data *k10temp_update_device(struct device *dev)
{
	struct k10temp_data *data = dev_get_drvdata(dev);
	struct pci_dev *pdev = to_pci_dev(dev);

	mutex_lock(&data->update_lock);

	if (!data->valid
	    || time_after(jiffies, data->last_updated + HZ)) {

		pci_read_config_dword(pdev, REG_TEMP, &data->temp);

		data->last_updated = jiffies;
		data->valid = 1;
	}

	mutex_unlock(&data->update_lock);
	return data;
}

/*
 * Sysfs stuff
 */

static ssize_t show_name(struct device *dev, struct device_attribute
			 *devattr, char *buf)
{
	struct k10temp_data *data = dev_get_drvdata(dev);

	return sprintf(buf, "%s\n", data->name);
}


static ssize_t show_temp(struct device *dev,
			 struct device_attribute *devattr, char *buf)
{
	struct k10temp_data *data = k10temp_update_device(dev);

	return sprintf(buf, "%d\n",
		       TEMP_FROM_REG(data->temp));
}

static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);

static struct pci_device_id k10temp_ids[] = {
	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K10_NB_MISC) },
	{ 0 },
};

MODULE_DEVICE_TABLE(pci, k10temp_ids);

static int __devinit k10temp_probe(struct pci_dev *pdev,
				  const struct pci_device_id *id)
{
	int err;
	struct k10temp_data *data;

	if (!(data = kzalloc(sizeof(struct k10temp_data), GFP_KERNEL))) {
		err = -ENOMEM;
		goto exit;
	}

	data->name = "k10temp";
	mutex_init(&data->update_lock);
	dev_set_drvdata(&pdev->dev, data);

	/* Register sysfs hooks */
	err = device_create_file(&pdev->dev,
			   &sensor_dev_attr_temp1_input.dev_attr);
	if (err)
		goto exit_remove;

	err = device_create_file(&pdev->dev, &dev_attr_name);
	if (err)
		goto exit_remove;

	data->hwmon_dev = hwmon_device_register(&pdev->dev);

	if (IS_ERR(data->hwmon_dev)) {
		err = PTR_ERR(data->hwmon_dev);
		goto exit_remove;
	}

	return 0;

exit_remove:
	device_remove_file(&pdev->dev,
			   &sensor_dev_attr_temp1_input.dev_attr);
	device_remove_file(&pdev->dev, &dev_attr_name);
	dev_set_drvdata(&pdev->dev, NULL);
	kfree(data);
exit:
	return err;
}

static void __devexit k10temp_remove(struct pci_dev *pdev)
{
	struct k10temp_data *data = dev_get_drvdata(&pdev->dev);

	hwmon_device_unregister(data->hwmon_dev);
	device_remove_file(&pdev->dev,
			   &sensor_dev_attr_temp1_input.dev_attr);
	device_remove_file(&pdev->dev, &dev_attr_name);
	dev_set_drvdata(&pdev->dev, NULL);
	kfree(data);
}

static struct pci_driver k10temp_driver = {
	.name = "k10temp",
	.id_table = k10temp_ids,
	.probe = k10temp_probe,
	.remove = __devexit_p(k10temp_remove),
};

static int __init k10temp_init(void)
{
	return pci_register_driver(&k10temp_driver);
}

static void __exit k10temp_exit(void)
{
	pci_unregister_driver(&k10temp_driver);
}

MODULE_AUTHOR("Rudolf Marek <r.marek@assembler.cz>");
MODULE_DESCRIPTION("AMD K10 core temperature monitor");
MODULE_LICENSE("GPL");

module_init(k10temp_init)
module_exit(k10temp_exit)

--------------050000080705050209080201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------050000080705050209080201--
