From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Sep 2012 14:09:09 +0000
Subject: Re: [lm-sensors] [Patch v1 5/7] DA9055 HWMON driver
Message-Id: <20120917140909.GA1553@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347629518.18587.17.camel@dhruva>
In-Reply-To: <1347629518.18587.17.camel@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 17, 2012 at 10:00:18AM +0000, Ashish Jangam wrote:
> > -----Original Message-----
> > Subject: Re: [Patch v1 5/7] DA9055 HWMON driver
> > 
> > On Fri, Sep 14, 2012 at 07:01:58PM +0530, Ashish Jangam wrote:
> > > This is the HWMON patch for DA9055 PMIC and has got dependency on the
> > > DA9055 MFD core.
> > >
> > > This patch monitors the DA9055 PMIC's ADC channels vddout, junction
> > > temperature and auxiliary channels.
> > >
> > > +static const char * const input_names[] = {
> > > +	[DA9055_ADC_VSYS]	=	"VSYS",
> > > +	[DA9055_ADC_ADCIN1]	=	"ADC IN1",
> > > +	[DA9055_ADC_ADCIN2]	=	"ADC IN2",
> > > +	[DA9055_ADC_ADCIN3]	=	"ADC IN3",
> > > +	[DA9055_ADC_TJUNC]	=	"CHIP TEMP",
> > 
> > Why tab after = ? Inconsistent with code below.
> Ok, will take care of this.
> > 
> > > +};
> > > +
> > > +static const u8 chan_mux[DA9055_ADC_TJUNC + 1] = {
> > > +	[DA9055_ADC_VSYS]	= DA9055_ADC_MUX_VSYS,
> > > +	[DA9055_ADC_ADCIN1]	= DA9055_ADC_MUX_ADCIN1,
> > > +	[DA9055_ADC_ADCIN2]	= DA9055_ADC_MUX_ADCIN2,
> > > +	[DA9055_ADC_ADCIN3]	= DA9055_ADC_MUX_ADCIN1,
> > > +	[DA9055_ADC_TJUNC]	= DA9055_ADC_MUX_T_SENSE,
> > > +};
> > > +
> > > +
> > > +static ssize_t da9055_read_tjunc(struct device *dev,
> > > +				 struct device_attribute *devattr, char *buf)
> > > +{
> > > +	struct da9055_hwmon *hwmon = dev_get_drvdata(dev);
> > > +	int tjunc;
> > > +	int toffset;
> > > +
> > > +	tjunc = da9055_adc_manual_read(hwmon, DA9055_ADC_TJUNC);
> > > +	if (tjunc < 0)
> > > +		return tjunc;
> > > +
> > Just wondering ... is this a dynamic value ? Becaue if not, it is quite an
> > expensive operation to perform for each conversion.
> Yes, junction temperature is read from ADC and then converted to degree Celsius.
> > 
> > > +	toffset = da9055_reg_read(hwmon->da9055, DA9055_REG_T_OFFSET);
> > > +	if (toffset < 0)
> > > +		return toffset;
> > > +
> > > +	/*
> > > +	 * Degrees celsius = -0.4084 * (ADC_RES - T_OFFSET) - 307.6332
> > > +	 * T_OFFSET is a trim value used to improve accuracy of the result
> > > +	 */
> > > +	return sprintf(buf, "%d\n", DIV_ROUND_CLOSEST(-4084 * (tjunc -
> > toffset)
> > > +							+ 3076332, 10000));
> > 
> > Either the calculation or the comment is wrong here.
> Comment is wrong will correct it.
> > 
> > > +static int __init da9055_hwmon_probe(struct platform_device *pdev)
> > > +{
> > > +	struct da9055_hwmon *hwmon;
> > > +	int hwmon_irq, ret;
> > > +
> > > +	hwmon = devm_kzalloc(&pdev->dev, sizeof(struct da9055_hwmon),
> > > +			     GFP_KERNEL);
> > > +	if (!hwmon)
> > > +		return -ENOMEM;
> > > +
> > > +	mutex_init(&hwmon->hwmon_lock);
> > > +	mutex_init(&hwmon->irq_lock);
> > > +
> > I wasn't copied on all the code, so I don't see the actual register read
> > and
> > write operations. I do wonder, though, if the operations protected by
> > hwmon_lock
> > and the operations protected by irq_lock can interfer with each other.
> Both should not interfere since hwmon_lock is for auto mode ADC and 
> irq_lock  is for manual ADC. Auto mode ADC cannot trigger irq on which
> this lock is operating. I will copy you the code too.
> > 
> > > +	init_completion(&hwmon->done);
> > > +	hwmon->da9055 = dev_get_drvdata(pdev->dev.parent);
> > > +
> > > +	platform_set_drvdata(pdev, hwmon);
> > > +
> > > +	ret = sysfs_create_group(&pdev->dev.kobj, &da9055_attr_group);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > You have a race condition here - the files are created and its access
> > functions
> > can be called, but the irq has not been installed yet. You should install
> > the
> > irq first, then create the attribute files.
> I got your point but will it matter since hwmon device gets registered later.
> > 
> > > +	hwmon_irq = platform_get_irq_byname(pdev, "HWMON");
> > 
> > This can return -ENXIO.
> But only if there is no associated resource so I can ignore it as DA9055 mfd
> defines it.

Not acceptable. A driver can not depend on its parent doing the right thing.

With that same logic, every driver which needs platform data would not have to
test if it exists.

Guenter

> > 
> > > +	ret = request_threaded_irq(hwmon_irq,
> > > +					NULL, da9055_auxadc_irq,
> > > +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > > +					"adc irq", hwmon);
> > 
> > There is now devm_request_threaded_irq which you can use to simplify the
> > code
> > further.
> Ok.
> > 
> > > +static int __devexit da9055_hwmon_remove(struct platform_device *pdev)
> > > +{
> > > +	struct da9055_hwmon *hwmon = platform_get_drvdata(pdev);
> > > +	int hwmon_irq;
> > > +
> > > +	hwmon_irq = platform_get_irq_byname(pdev, "HWMON");
> > > +
> > > +	free_irq(hwmon_irq, hwmon);
> > > +	hwmon_device_unregister(hwmon->class_device);
> > > +	sysfs_remove_group(&pdev->dev.kobj, &da9055_attr_group);
> > > +	platform_set_drvdata(pdev, NULL);
> > > +
> > I thought this taken care of by the infrastructure and no longer needed.
> Ok.
> > 
> Thanks,
> Ashish
> 
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
