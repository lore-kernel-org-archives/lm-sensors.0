From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 29 Aug 2011 14:11:02 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: Add driver for EXYNOS4 TMU
Message-Id: <20110829141102.GA22151@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314613983-3331-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1314613983-3331-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 29, 2011 at 08:22:07AM -0400, R, Durgadoss wrote:
> Hi,
> 
> Some minor comments.
> Removing the clean code, to reduce traffic.
> 
> > +Sysfs Interface
> > +---------------
> > +name		name of the temperature sensor
> > +		RO
> > +
> > +temp1_input	temperature
> > +		RO
> > +
> > +temp1_max	temperature for level_1 interrupt
> > +		RO
> > +
> > +temp1_crit	temperature for level_2 interrupt
> > +		RO
> > +
> > +temp1_emergency	temperature for level_3 interrupt
> > +		RO
> > +
> > +temp1_max_alarm	alarm for level_1 interrupt
> > +		RO
> > +
> > +temp1_crit_alarm
> > +		alarm for level_2 interrupt
> > +		RO
> > +
> > +temp1_emergency_alarm
> > +		alarm for level_3 interrupt
> > +		RO
> 
> All these are standard ABI for Thermal related Hwmon drivers.
> So, Do we really need to have them explained here again ?
> 
> Guenter/Jean, I would like to see your inputs here.
> 
For my part, I think listing the attributes is useful to show the user
which attributes are supported without having to look into the code.
In this case, listing the attributes is even more useful because it shows
that the limits are RO.

> > +static int exynos4_tmu_initialize(struct platform_device *pdev)
> > +{
> > +	struct exynos4_tmu_data *data = platform_get_drvdata(pdev);
> > +	struct exynos4_tmu_platform_data *pdata = data->pdata;
> > +	unsigned int status, trim_info;
> 
> Can the status be a 'u8' since we are populating it with readb(...) ?
> I am blindly assuming readb returns a byte. Please correct me if I am wrong.
> 
One general comment regarding variable types. On many platforms, u8 is more
expensive than int or unsigned int because the compiler needs to mask pretty much
every operation. That is probably not an issue for Intel CPUs, but for most others.
For that reason, I usually leave it to the implementors to decide what variable
types to use.

That is a bit different for stored data, but even there it does not provide value 
to embed an u8 in integers because the compiler will end up aligning the structure
anyway. 

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
