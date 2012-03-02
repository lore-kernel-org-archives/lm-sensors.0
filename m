From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 02 Mar 2012 16:50:53 +0000
Subject: Re: [lm-sensors] [PATCH 02/03] HWMON: HWMON driver for DA9052/53 PMIC v3
Message-Id: <1330707053.23014.279.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330698545.21817.31.camel@dhruva>
	 <4D68720C2E767A4AA6A8796D42C8EB59046AE9@BGSMSX101.gar.corp.intel.com>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB59046AE9@BGSMSX101.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: Ashish Jangam <ashish.jangam@kpitcummins.com>, "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "dchen@diasemi.com" <dchen@diasemi.com>

Hi Durga,

On Fri, 2012-03-02 at 11:44 -0500, R, Durgadoss wrote:
> Hi,
> 
> > -----Original Message-----
> > From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-
> > sensors.org] On Behalf Of Ashish Jangam
> > Sent: Friday, March 02, 2012 7:59 PM
> > To: Guenter Roeck
> > Cc: randy.dunlap@oracle.com; linaro-dev@lists.linaro.org;
> > sameo@linux.intel.com; linux-kernel@vger.kernel.org; lm-sensors@lm-sensors.org;
> > dchen@diasemi.com
> > Subject: [lm-sensors] [PATCH 02/03] HWMON: HWMON driver for DA9052/53 PMIC v3
> >
> > The DA9052 PMIC provides an Analogue to Digital Converter with 10 bits
> > resolution and 10 channels.
> >
> > This patch monitors the DA9052 PMIC's ADC channels mostly for battery
> > parameters like battery temperature, junction temperature, battery
> > current etc.
> >
> > This patch is functionally tested on Samsung SMDKV6410
> >
> > Signed-off-by: David Dajun Chen <dchen@diasemi.com>
> > Signed-off-by: Ashish Jangam <ashish.jangam@kpitcummins.com>

[ ... ]

> > +static int __init da9052_hwmon_probe(struct platform_device *pdev)
> > +{
> > +     struct da9052_hwmon *hwmon;
> > +     int ret;
> > +
> > +     hwmon = devm_kzalloc(&pdev->dev, sizeof(struct da9052_hwmon),
> > +                          GFP_KERNEL);
> > +     if (!hwmon)
> > +             return -ENOMEM;
> > +
> > +     mutex_init(&hwmon->hwmon_lock);
> > +     hwmon->da9052 = dev_get_drvdata(pdev->dev.parent);
> > +
> > +     platform_set_drvdata(pdev, hwmon);
> > +
> > +     ret = sysfs_create_group(&pdev->dev.kobj, &da9052_attr_group);
> > +     if (ret)
> > +             goto err_mem;
> > +
> > +     hwmon->class_device = hwmon_device_register(&pdev->dev);
> > +     if (IS_ERR(hwmon->class_device)) {
> > +             ret = PTR_ERR(hwmon->class_device);
> > +             goto err_sysfs;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_sysfs:
> > +     sysfs_remove_group(&pdev->dev.kobj, &da9052_attr_group);
> > +err_mem:
> 
> I think you should do a kfree(hwmon) here.
> 

Not needed because devm_kzalloc() is used above.

> > +     return ret;
> > +}
> > +
> > +static int __devexit da9052_hwmon_remove(struct platform_device *pdev)
> > +{
> > +     struct da9052_hwmon *hwmon = platform_get_drvdata(pdev);
> > +
> > +     hwmon_device_unregister(hwmon->class_device);
> > +     sysfs_remove_group(&pdev->dev.kobj, &da9052_attr_group);
> 
>  Kfree(hwmon);
> 
Same here.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
