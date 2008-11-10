From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 10 Nov 2008 09:34:10 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] k8temp add support for family 10h and
Message-Id: <20081110103410.6e8371e4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F7B6.4000901@assembler.cz>
In-Reply-To: <48E3F7B6.4000901@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Thu, 02 Oct 2008 00:20:38 +0200, Rudolf Marek wrote:
> I finally had time to add support to k8temp  for the new family 10h and family
> 11h of CPUs.
> 
> The patch adds support for new fam10h and fam11h CPUs (aka Phenom and new 45nm
> CPUs). The patch was tested on K8 fam 0fh revE and revF CPU. I dont know if it
> works at all on new CPUs. Please test. You should see the max temp (always 70C
> and one temperature per CPU). Of course test is on your own risk ;)
> 
> Andreas, please is TcontrolMax also 70C for fam 11h CPUs?
> 
> The patch needs review too. I tried not to change many things in the driver,
> especially the sensorsp logic, but mine test sempron has -49 at core0 place0,
> which needs to be fixed by another logic which will tell driver what CPU
> temperatures are usable. But maybe this is for another "cleanup" patch. I think
> we really need to get this kind of change to kernel first.
> 
> What do you think?

Looking at your patch, there doesn't seem to be much in common between
the family 0Fh and the family 10h. The temperature conversion formula
is different, the registers are different... And I seem to understand
that the family 10h has a single sensor? In the end your patch is
larger than the k8temp driver itself. So I am wondering, does it really
make sense to support both families with the same driver?

About the code itself (limited review as I can't apply the patch):

> Index: linux-2.6.27-rc7/drivers/hwmon/k8temp.c
> =================================> --- linux-2.6.27-rc7.orig/drivers/hwmon/k8temp.c	2008-09-28 11:13:42.000000000 +0200
> +++ linux-2.6.27-rc7/drivers/hwmon/k8temp.c	2008-10-02 00:01:56.383473013 +0200
> @@ -1,7 +1,7 @@
>  /*
>   * k8temp.c - Linux kernel module for hardware monitoring
>   *
> - * Copyright (C) 2006 Rudolf Marek <r.marek@assembler.cz>
> + * Copyright (C) 2006, 2008 Rudolf Marek <r.marek@assembler.cz>
>   *
>   * Inspired from the w83785 and amd756 drivers.
>   *
> @@ -32,11 +32,18 @@
>  #include <linux/err.h>
>  #include <linux/mutex.h>
>  
> -#define TEMP_FROM_REG(val)	(((((val) >> 16) & 0xff) - 49) * 1000)
> -#define REG_TEMP	0xe4
> +#define FAM_F_TEMP_FROM_REG(val)	(((((val) >> 16) & 0xff) - 49) * 1000)
> +#define FAM_10_TEMP_FROM_REG(val)	(((val) >> 21) * 125)

It's probably the right time to turn these macros into inline functions.

> +
> +#define FAM_F_REG_TEMP	0xe4
> +#define FAM_10_REG_TEMP	0xa5
> +
>  #define REG_CPUID	0xfc
> +/* real bitpos */
>  #define SEL_PLACE	0x40
>  #define SEL_CORE	0x04
> +/* program logic bitpos */
> +#define SEL_TEMPMAX	0x01

These comments are rather obscure to me. I had to read the driver code
to understand what they meant. This pretty much voids the point of
comments, doesn't it? ;)

I don't think you need SEL_TEMPMAX anyway. You only use it to determine
whether to create file temp1_max or not, but you could use
(data->tcontrol_max != 0) or (data->fam >= 0x10) for that.

>  
>  struct k8temp_data {
>  	struct device *hwmon_dev;
> @@ -45,46 +52,69 @@
>  	char valid;		/* zero until following fields are valid */
>  	unsigned long last_updated;	/* in jiffies */
>  
> -	/* registers values */
>  	u8 sensorsp;		/* sensor presence bits - SEL_CORE & SEL_PLACE */
> -	u32 temp[2][2];		/* core, place */
> +	int temp[2][2];		/* core, place */
> +	int tcontrol_max;
>  	u8 fam;
> +	u32 cpuid;

Why do you store cpuid? You never use it.

>  };
>  
> -static struct k8temp_data *k8temp_update_device(struct device *dev)
> +static void k8temp_update_device_fam_10(struct device *dev)
>  {
>  	struct k8temp_data *data = dev_get_drvdata(dev);
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	u8 tmp;
> +	u32 tmp;
>  
>  	mutex_lock(&data->update_lock);
>  
>  	if (!data->valid
>  	    || time_after(jiffies, data->last_updated + HZ)) {
> -		pci_read_config_byte(pdev, REG_TEMP, &tmp);
> +
> +		pci_read_config_dword(pdev, FAM_10_REG_TEMP, &tmp);
> +		data->temp[0][0] = FAM_10_TEMP_FROM_REG(tmp);
> +
> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +}
> +
> +static void k8temp_update_device_fam_f(struct device *dev)
> +{
> +	struct k8temp_data *data = dev_get_drvdata(dev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	u32 tmp;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (!data->valid
> +	    || time_after(jiffies, data->last_updated + HZ)) {
> +		pci_read_config_dword(pdev, FAM_F_REG_TEMP, &tmp);
>  		tmp &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
> -		pci_write_config_byte(pdev, REG_TEMP, tmp);
> -		pci_read_config_dword(pdev, REG_TEMP, &data->temp[0][0]);
> +		pci_write_config_byte(pdev, FAM_F_REG_TEMP, tmp);
> +		pci_read_config_dword(pdev, FAM_F_REG_TEMP, &tmp);
> +		data->temp[0][0] = FAM_F_TEMP_FROM_REG(tmp);
>  
>  		if (data->sensorsp & SEL_PLACE) {
>  			tmp |= SEL_PLACE;	/* Select sensor 1, core0 */
> -			pci_write_config_byte(pdev, REG_TEMP, tmp);
> -			pci_read_config_dword(pdev, REG_TEMP,
> -					      &data->temp[0][1]);
> +			pci_write_config_byte(pdev, FAM_F_REG_TEMP, tmp);
> +			pci_read_config_dword(pdev, FAM_F_REG_TEMP, &tmp);
> +			data->temp[0][1] = FAM_F_TEMP_FROM_REG(tmp);
>  		}
>  
>  		if (data->sensorsp & SEL_CORE) {
>  			tmp &= ~SEL_PLACE;	/* Select sensor 0, core1 */
>  			tmp |= SEL_CORE;
> -			pci_write_config_byte(pdev, REG_TEMP, tmp);
> -			pci_read_config_dword(pdev, REG_TEMP,
> -					      &data->temp[1][0]);
> +			pci_write_config_byte(pdev, FAM_F_REG_TEMP, tmp);
> +			pci_read_config_dword(pdev, FAM_F_REG_TEMP, &tmp);
> +			data->temp[1][0] = FAM_F_TEMP_FROM_REG(tmp);
>  
>  			if (data->sensorsp & SEL_PLACE) {
>  				tmp |= SEL_PLACE;	/* Select sensor 1, core1 */
> -				pci_write_config_byte(pdev, REG_TEMP, tmp);
> -				pci_read_config_dword(pdev, REG_TEMP,
> -						      &data->temp[1][1]);
> +				pci_write_config_byte(pdev, FAM_F_REG_TEMP, tmp);
> +				pci_read_config_dword(pdev, FAM_F_REG_TEMP, &tmp);
> +				data->temp[1][1] = FAM_F_TEMP_FROM_REG(tmp);
>  			}
>  		}
>  
> @@ -93,7 +123,6 @@
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> -	return data;
>  }
>  
>  /*
> @@ -116,15 +145,36 @@
>  	    to_sensor_dev_attr_2(devattr);
>  	int core = attr->nr;
>  	int place = attr->index;
> -	struct k8temp_data *data = k8temp_update_device(dev);
> +	struct k8temp_data *data = dev_get_drvdata(dev);
> +
> +	switch (data->fam) {
> +		case 0xf:
> +			k8temp_update_device_fam_f(dev);
> +			break;
> +		case 0x10:
> +			k8temp_update_device_fam_10(dev);
> +			break;
> +		case 0x11:
> +			k8temp_update_device_fam_10(dev);
> +			break;

You could merge case 0x10 and case 0x11.

> +	}
> +
> +	return sprintf(buf, "%d\n", data->temp[core][place]);
> +}
> +
>  
> -	return sprintf(buf, "%d\n",
> -		       TEMP_FROM_REG(data->temp[core][place]));
> +static ssize_t show_max(struct device *dev, struct device_attribute
> +			  *devattr, char *buf)
> +{
> +	struct k8temp_data *data = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%d\n", data->tcontrol_max);
>  }
>  
>  /* core, place */
>  
>  static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_max, NULL, 0);

This could be a simple DEVICE_ATTR() as you never use the parameter
value.

>  static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1);
>  static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 1, 0);
>  static SENSOR_DEVICE_ATTR_2(temp4_input, S_IRUGO, show_temp, NULL, 1, 1);
> @@ -132,65 +182,52 @@
>  
>  static struct pci_device_id k8temp_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1203) },

PCI_DEVICE_ID_AMD_10H_NB_MISC

> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1303) },

PCI_DEVICE_ID_AMD_11H_NB_MISC

>  	{ 0 },
>  };
>  
>  MODULE_DEVICE_TABLE(pci, k8temp_ids);
>  
> -static int __devinit k8temp_probe(struct pci_dev *pdev,
> -				  const struct pci_device_id *id)
> -{
> -	int err;
> -	u8 scfg;
> -	u32 temp;
> -
> -	struct k8temp_data *data;
> -	u32 cpuid = cpuid_eax(1);
>  
> -	/* this feature should be available since SH-C0 core */
> -	if ((cpuid = 0xf40) || (cpuid = 0xf50) || (cpuid = 0xf51)) {
> -		err = -ENODEV;
> -		goto exit;
> -	}
> -
> -	if (!(data = kzalloc(sizeof(struct k8temp_data), GFP_KERNEL))) {
> -		err = -ENOMEM;
> -		goto exit;
> -	}
> +static int __devinit setup_fam_10(struct pci_dev *pdev, struct k8temp_data *data)
> +{
> +	/* we need max temp */
> +	data->sensorsp = SEL_TEMPMAX;
> +	data->tcontrol_max = 70000;
>  
> -	/* get real PCI based cpuid, prior revF of fam 0Fh, this reg is 0 */
> -	pci_read_config_dword(pdev, REG_CPUID, &cpuid);
> +	data->name = (data->fam  = 0x11) ? "fam11temp" : "fam10temp";

What sexy names! :/

>  
> -	data->fam = (cpuid & 0x00000f00) >> 8;
> -	data->fam += (cpuid & 0x00f00000) >> 20;
> +	return 0;
> +}
>  
> -	switch (data->fam) {
> -		case 0xf:
> -			dev_warn(&pdev->dev, "Temperature readouts might be wrong"
> -						" - check errata #141\n");
> -	}
> +static int __devinit setup_fam_f(struct pci_dev *pdev, struct k8temp_data *data)
> +{
> +	u8 scfg;
> +	u32 temp;
> +	int err = 0;
>  
> -	pci_read_config_byte(pdev, REG_TEMP, &scfg);
> +	pci_read_config_byte(pdev, FAM_F_REG_TEMP, &scfg);
>  	scfg &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
> -	pci_write_config_byte(pdev, REG_TEMP, scfg);
> -	pci_read_config_byte(pdev, REG_TEMP, &scfg);
> +	pci_write_config_byte(pdev, FAM_F_REG_TEMP, scfg);
> +	pci_read_config_byte(pdev, FAM_F_REG_TEMP, &scfg);
>  
>  	if (scfg & (SEL_PLACE | SEL_CORE)) {
>  		dev_err(&pdev->dev, "Configuration bit(s) stuck at 1!\n");
>  		err = -ENODEV;
> -		goto exit_free;
> +		goto exit_setup;
>  	}
>  
>  	scfg |= (SEL_PLACE | SEL_CORE);
> -	pci_write_config_byte(pdev, REG_TEMP, scfg);
> +	pci_write_config_byte(pdev, FAM_F_REG_TEMP, scfg);
>  
>  	/* now we know if we can change core and/or sensor */
> -	pci_read_config_byte(pdev, REG_TEMP, &data->sensorsp);
> +	pci_read_config_byte(pdev, FAM_F_REG_TEMP, &data->sensorsp);
>  
>  	if (data->sensorsp & SEL_PLACE) {
>  		scfg &= ~SEL_CORE;	/* Select sensor 1, core0 */
> -		pci_write_config_byte(pdev, REG_TEMP, scfg);
> -		pci_read_config_dword(pdev, REG_TEMP, &temp);
> +		pci_write_config_byte(pdev, FAM_F_REG_TEMP, scfg);
> +		pci_read_config_dword(pdev, FAM_F_REG_TEMP, &temp);
>  		scfg |= SEL_CORE;	/* prepare for next selection */
>  		if (!((temp >> 16) & 0xff))	/* if temp is 0 -49C is not likely */
>  			data->sensorsp &= ~SEL_PLACE;
> @@ -198,13 +235,74 @@
>  
>  	if (data->sensorsp & SEL_CORE) {
>  		scfg &= ~SEL_PLACE;	/* Select sensor 0, core1 */
> -		pci_write_config_byte(pdev, REG_TEMP, scfg);
> -		pci_read_config_dword(pdev, REG_TEMP, &temp);
> +		pci_write_config_byte(pdev, FAM_F_REG_TEMP, scfg);
> +		pci_read_config_dword(pdev, FAM_F_REG_TEMP, &temp);
>  		if (!((temp >> 16) & 0xff))	/* if temp is 0 -49C is not likely */
>  			data->sensorsp &= ~SEL_CORE;
>  	}
>  
> +	/* we use sensorsp for programm logic too */

Spelling: program.

> +	data->sensorsp &= (SEL_PLACE | SEL_CORE);
>  	data->name = "k8temp";
> +
> +exit_setup:
> +	return err;

Doesn't seem terribly useful, you might as well have returned the error
code directly.

> +}
> +
> +static int __devinit k8temp_probe(struct pci_dev *pdev,
> +				  const struct pci_device_id *id)
> +{
> +	int err = 0;
> +
> +	struct k8temp_data *data;
> +	u32 cpuid = cpuid_eax(1);
> +
> +	/* this feature should be available since SH-C0 core */
> +	if ((cpuid = 0xf40) || (cpuid = 0xf50) || (cpuid = 0xf51)) {
> +		err = -ENODEV;
> +		goto exit;
> +	}
> +
> +	if (!(data = kzalloc(sizeof(struct k8temp_data), GFP_KERNEL))) {

Preferred coding style (as checkpatch.pl would have told you) is:

	data = kzalloc(sizeof(struct k8temp_data), GFP_KERNEL);
	if (!data) {

> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	/* get real PCI based cpuid, prior revF of fam 0Fh, this reg is 0 */
> +	pci_read_config_dword(pdev, REG_CPUID, &data->cpuid);
> +
> +	data->fam = (data->cpuid & 0x00000f00) >> 8;
> +	data->fam += (data->cpuid & 0x00f00000) >> 20;

Same mask bug as the previous patch had.

> +
> +	switch (data->fam) {
> +		case 0xf:

And same indentation issue here.

> +			dev_warn(&pdev->dev, "Temperature readouts might be wrong"
> +						" - check errata #141\n");
> +			if ((err = setup_fam_f(pdev, data)))

Here again checkpatch.pl would tell you to separate the function call
and the error check. Same below.

> +				goto exit_free;
> +			break;
> +		case 0x10:
> +			dev_warn(&pdev->dev, "Temperature readouts might be wrong"
> +						" - check errata #319\n");

You can save a few bytes by making the errata number a %d and passing
it as parameter.

> +			if ((err = setup_fam_10(pdev, data)))
> +				goto exit_free;
> +			break;
> +		case 0x11:
> +			if ((err = setup_fam_10(pdev, data)))
> +				goto exit_free;
> +			break;
> +		case 0x0:
> +			/* mark revE fam 0fh as fam 0fh */
> +			data->fam = 0xf;
> +			if ((err = setup_fam_f(pdev, data)))
> +				goto exit_free;
> +			break;
> +		default:
> +			err = -ENODEV;
> +			dev_err(&pdev->dev, "Unknown family with known PCI ID\n");
> +			goto exit_free;
> +	}
> +
>  	mutex_init(&data->update_lock);
>  	dev_set_drvdata(&pdev->dev, data);
>  
> @@ -236,6 +334,13 @@
>  				goto exit_remove;
>  	}
>  
> +	if (data->sensorsp & SEL_TEMPMAX) {
> +		err = device_create_file(&pdev->dev,
> +				   &sensor_dev_attr_temp1_max.dev_attr);
> +		if (err)
> +			goto exit_remove;
> +	}
> +
>  	err = device_create_file(&pdev->dev, &dev_attr_name);
>  	if (err)
>  		goto exit_remove;
> @@ -253,6 +358,8 @@
>  	device_remove_file(&pdev->dev,
>  			   &sensor_dev_attr_temp1_input.dev_attr);
>  	device_remove_file(&pdev->dev,
> +			   &sensor_dev_attr_temp1_max.dev_attr);
> +	device_remove_file(&pdev->dev,
>  			   &sensor_dev_attr_temp2_input.dev_attr);
>  	device_remove_file(&pdev->dev,
>  			   &sensor_dev_attr_temp3_input.dev_attr);
> @@ -274,6 +381,8 @@
>  	device_remove_file(&pdev->dev,
>  			   &sensor_dev_attr_temp1_input.dev_attr);
>  	device_remove_file(&pdev->dev,
> +			   &sensor_dev_attr_temp1_max.dev_attr);
> +	device_remove_file(&pdev->dev,
>  			   &sensor_dev_attr_temp2_input.dev_attr);
>  	device_remove_file(&pdev->dev,
>  			   &sensor_dev_attr_temp3_input.dev_attr);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
