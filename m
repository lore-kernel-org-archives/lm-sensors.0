From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 29 Aug 2011 15:17:45 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: Add driver for EXYNOS4 TMU
Message-Id: <1314631065.2796.156.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314613983-3331-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1314613983-3331-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-08-29 at 08:22 -0400, R, Durgadoss wrote:
> Hi,
> 
> Some minor comments.
> Removing the clean code, to reduce traffic.
[ ... ]
> > +
> > +static int exynos4_tmu_read(struct exynos4_tmu_data *data)
> 
> The return type can better be 'u8', since translate_code_to_temp(...)
> returns a 'u8'.
> 
> > +static irqreturn_t exynos4_tmu_irq(int irq, void *id)
> > +{
> > +	struct exynos4_tmu_data *data = id;
> 
> I am not sure whether we _must_ cast 'id', as (struct exynos4_tmu_data *)..
>  
Typecast is not necessary for void pointers.

[ ... ]

> 
> > +static int __devexit exynos4_tmu_remove(struct platform_device *pdev)
> > +{
> > +	struct exynos4_tmu_data *data = platform_get_drvdata(pdev);
> > +
> > +	exynos4_tmu_control(pdev, false);
> > +
> > +	hwmon_device_unregister(data->hwmon_dev);
> > +	sysfs_remove_group(&pdev->dev.kobj, &exynos4_tmu_attr_group);
> 
> Shouldn't we send a KOBJ_REMOVE event here ?
> 
sysfs_remove_group should take care of that, though I did not test it
and may be wrong.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
