From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 23 Aug 2006 14:03:25 +0000
Subject: [lm-sensors] [PATCH] AMD K8 digital sensor - take2
Message-Id: <20060823160325.6245d90a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44EB67BB.5010604@sh.cvut.cz>
In-Reply-To: <44EB67BB.5010604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf,

> This patch adds support for the temperature sensor(s) found in AMD K8 CPUs.
> 
> Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>
> 
> All fixed & tested on quad CPU - dual dual core ;), please apply.

Sorry I still have some comments on the code...

> +#define TEMP_FROM_REG(val)	((((val >> 16) & 0xFF) - 49) * 1000)

Missing parentheses around "val".

> +#define REG_TEMP	0xe4
> +#define REG_TEMP_T	0xe6
> +#define PLACE	0x40
> +#define CORE	0x04

The names you chose for the register names are almost similar, it's
confusing. In fact it's so confusing that I thought your code below was
broken. Please find better names. Either make it clear which is the
temperature value register and which is the core/sensor selection
register, or don't define REG_TEMP_T at all.

While you're there it would be nice to properly align all the values.
And maybe find a common prefix to PLACE and CORE to make it clear they
refer to the sensor selection register (SEL_PLACE and SEL_CORE, maybe?)

> +
> +struct k8temp_data {
> +	struct class_device *class_dev;
> +	struct mutex update_lock;
> +	const char *name;
> +	char valid;		/* zero until following fields are valid */
> +	unsigned long last_updated;	/* in jiffies */
> +
> +	/* registers values */
> +	u8 sensorsp;		/* sensor presence bits - CORE & PLACE */
> +	u32 temp[2][2];		/* core, place */
> +};
> +
> +static struct k8temp_data *k8temp_update_device(struct device *dev)
> +{
> +	struct k8temp_data *data = dev_get_drvdata(dev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	u8 tmp;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (!data->valid
> +	    || time_after(jiffies, data->last_updated + HZ)) {
> +		dev_dbg(&pdev->dev, "Updating k8temp data.\n");

You can use "dev" directly. BTW I really wonder what is the point of
this debug message. I know we have it in many other hardware monitoring
drivers, but is it really useful? We pretty well know when the data is
updated.

> +
> +		pci_read_config_byte(pdev, REG_TEMP, &tmp);
> +		tmp &= ~(PLACE | CORE);		/* Select sensor 0, core0 */
> +		pci_write_config_byte(pdev, REG_TEMP, tmp);
> +		pci_read_config_dword(pdev, REG_TEMP, &data->temp[0][0]);

I found it very confusing to see you read the sensor selection and
the temperature value from the same register, until I realized there
was a byte read and a dword read and you are then using some
masking/shifting to extract the part you need.

Why don't you make a _word_ read from REG_TEMP_T (0xe6) instead? This
would be much clearer. At any rate, defining REG_TEMP_T and using it
only during the initialization step is very confusing.

> +
> +		if (data->sensorsp & PLACE) {
> +			tmp |= PLACE;	/* Select sensor 1, core0 */
> +			pci_write_config_byte(pdev, REG_TEMP, tmp);
> +			pci_read_config_dword(pdev, REG_TEMP,
> +					      &data->temp[0][1]);
> +		}
> +
> +		if (data->sensorsp & CORE) {
> +			tmp &= ~PLACE;	/* Select sensor 0, core1 */
> +			tmp |= CORE;
> +			pci_write_config_byte(pdev, REG_TEMP, tmp);
> +			pci_read_config_dword(pdev, REG_TEMP,
> +					      &data->temp[1][0]);
> +
> +			if (data->sensorsp & PLACE) {
> +				tmp |= PLACE;	/* Select sensor 1, core1 */
> +				pci_write_config_byte(pdev, REG_TEMP, tmp);
> +				pci_read_config_dword(pdev, REG_TEMP,
> +						      &data->temp[1][1]);
> +			}
> +		}
> +
> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +	return data;
> +}
> +
> +/*
> + * Sysfs stuff
> + */
> +
> +static ssize_t show_name(struct device *dev, struct device_attribute
> +			 *devattr, char *buf)
> +{
> +	struct k8temp_data *data = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", data->name);
> +}
> +
> +
> +static ssize_t show_temp(struct device *dev,
> +			 struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute_2 *attr > +	    to_sensor_dev_attr_2(devattr);
> +	int core = attr->nr;
> +	int place = attr->index;
> +	struct k8temp_data *data = k8temp_update_device(dev);
> +	
> +	return sprintf(buf, "%d\n",
> +		       TEMP_FROM_REG(data->temp[core][place]));
> +}
> +
> +/* core, place */
> +
> +static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
> +static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1);
> +static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 1, 0);
> +static SENSOR_DEVICE_ATTR_2(temp4_input, S_IRUGO, show_temp, NULL, 1, 1);
> +static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
> +
> +static struct pci_device_id k8temp_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
> +	{ 0 },
> +};
> +
> +static int __devinit k8temp_probe(struct pci_dev *pdev,
> +				  const struct pci_device_id *id)
> +{
> +	int err;
> +	u8 scfg, temp;
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
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	pci_read_config_byte(pdev, REG_TEMP, &scfg);
> +	scfg &= ~(PLACE | CORE);		/* Select sensor 0, core0 */
> +	pci_write_config_byte(pdev, REG_TEMP, scfg);
> +	pci_read_config_byte(pdev, REG_TEMP, &scfg);
> +
> +	if (scfg & (PLACE | CORE)) {
> +		dev_err(&pdev->dev, "Configuration bit(s) stuck at 1!\n");
> +		err = -ENODEV;
> +		goto exit_free;
> +	}
> +
> +	scfg |= (PLACE | CORE);
> +	pci_write_config_byte(pdev, REG_TEMP, scfg);
> +
> +	/* now we know if we can change core and/or sensor */
> +	pci_read_config_byte(pdev, REG_TEMP, &data->sensorsp);
> +
> +	if (data->sensorsp & PLACE) {
> +		scfg &= ~CORE;	/* Select sensor 1, core0 */
> +		pci_write_config_byte(pdev, REG_TEMP, scfg);
> +		pci_read_config_byte(pdev, REG_TEMP_T, &temp);
> +		scfg |= CORE;	/* prepare for next selection */
> +		if (!temp)	/* if temp is 0 -49C is not likely */
> +			data->sensorsp &= ~PLACE;
> +	}
> +
> +	if (data->sensorsp & CORE) {
> +		scfg &= ~PLACE;	/* Select sensor 0, core1 */
> +		pci_write_config_byte(pdev, REG_TEMP, scfg);
> +		pci_read_config_byte(pdev, REG_TEMP_T, &temp);
> +		if (!temp)	/* if temp is 0 -49C is not likely */
> +			data->sensorsp &= ~CORE;
> +	}
> +
> +	data->name = "k8temp";
> +	mutex_init(&data->update_lock);
> +	dev_set_drvdata(&pdev->dev, data);
> +
> +	/* Register sysfs hooks */
> +	err = device_create_file(&pdev->dev,
> +			   &sensor_dev_attr_temp1_input.dev_attr);
> +	if (err)
> +		goto exit_remove;
> +
> +	/* sensor can be changed and reports something */
> +	if (data->sensorsp & PLACE) {
> +		err = device_create_file(&pdev->dev,
> +				   &sensor_dev_attr_temp2_input.dev_attr);
> +		if (err)
> +			goto exit_remove;
> +	}
> +
> +	/* core can be changed and reports something */
> +	if (data->sensorsp & CORE) {
> +		err = device_create_file(&pdev->dev,
> +				   &sensor_dev_attr_temp3_input.dev_attr);
> +		if (err)
> +			goto exit_remove;
> +		if (data->sensorsp & PLACE)
> +			err = device_create_file(&pdev->dev,
> +					   &sensor_dev_attr_temp4_input.
> +					   dev_attr);
> +			if (err)
> +				goto exit_remove;
> +	}
> +
> +	err = device_create_file(&pdev->dev, &dev_attr_name);
> +	if (err)
> +		goto exit_remove;
> +
> +	data->class_dev = hwmon_device_register(&pdev->dev);
> +
> +	if (IS_ERR(data->class_dev)) {
> +		err = PTR_ERR(data->class_dev);
> +		goto exit_remove;
> +	}
> +
> +	return 0;
> +
> +exit_remove:
> +	device_remove_file(&pdev->dev,
> +			   &sensor_dev_attr_temp1_input.dev_attr);
> +	device_remove_file(&pdev->dev,
> +			   &sensor_dev_attr_temp2_input.dev_attr);
> +	device_remove_file(&pdev->dev,
> +			   &sensor_dev_attr_temp3_input.dev_attr);
> +	device_remove_file(&pdev->dev,
> +			   &sensor_dev_attr_temp4_input.dev_attr);
> +	device_remove_file(&pdev->dev, &dev_attr_name);	
> +exit_free:
> +	dev_set_drvdata(&pdev->dev, NULL);
> +	kfree(data);
> +exit:
> +	return err;
> +}
> +
> +static void __devexit k8temp_remove(struct pci_dev *pdev)
> +{
> +	struct k8temp_data *data = dev_get_drvdata(&pdev->dev);
> +
> +	hwmon_device_unregister(data->class_dev);
> +	device_remove_file(&pdev->dev,
> +			   &sensor_dev_attr_temp1_input.dev_attr);
> +	device_remove_file(&pdev->dev,
> +			   &sensor_dev_attr_temp2_input.dev_attr);
> +	device_remove_file(&pdev->dev,
> +			   &sensor_dev_attr_temp3_input.dev_attr);
> +	device_remove_file(&pdev->dev,
> +			   &sensor_dev_attr_temp4_input.dev_attr);
> +	device_remove_file(&pdev->dev, &dev_attr_name);
> +	dev_set_drvdata(&pdev->dev, NULL);
> +	kfree(data);
> +}
> +
> +static struct pci_driver k8temp_driver = {
> +	.name = "k8temp",
> +	.id_table = k8temp_ids,
> +	.probe = k8temp_probe,
> +	.remove = __devexit_p(k8temp_remove),
> +};
> +
> +static int __init k8temp_init(void)
> +{
> +	return pci_module_init(&k8temp_driver);

Deprecated, please use pci_register_driver instead. I was going to fix
it myself, but since we'll need one more iteration anyway...

> +}
> +
> +static void __exit k8temp_exit(void)
> +{
> +	pci_unregister_driver(&k8temp_driver);
> +}
> +
> +MODULE_AUTHOR("Rudolf Marek <r.marek at sh.cvut.cz>");
> +MODULE_DESCRIPTION("AMD K8 core temperature monitor");
> +MODULE_LICENSE("GPL");
> +
> +module_init(k8temp_init)
> +module_exit(k8temp_exit)
> 


-- 
Jean Delvare

