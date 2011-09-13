From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 13 Sep 2011 13:20:39 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon/f71882fg: Make the decision
Message-Id: <20110913132039.GB26559@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1315563155-15774-3-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1315563155-15774-3-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 13, 2011 at 03:19:32AM -0400, Hans de Goede wrote:
> Hi,
> 
> On 09/12/2011 08:47 PM, Guenter Roeck wrote:
> > On Fri, 2011-09-09 at 06:12 -0400, Hans de Goede wrote:
> >> Before this patch the f71882fg driver completely fails to initialize
> >> on systems which have reserved settings in the pwm enable register, and
> >> it disables all auto pwm sysfs attributes if any fan is controlled by
> >> a digital sensor reading.
> >>
> >> This patch changes the fail to initialize into don't register any attributes
> >> for the fan for which there are reserved settings in the pwm enable register
> >> and also makes the not registering of auto pwm sysfs attributes a per fan
> >> thing.
> >>
> >> Signed-off-by: Hans de Goede<hdegoede@redhat.com>
> >
> > Nice cleanup. One minor comment:
> >
> > [ ... ]
> >>
> >>   static int __devinit f71882fg_create_fan_sysfs_files(
> >> -	struct platform_device *pdev, int idx, bool pwm_auto_point)
> >> +	struct platform_device *pdev, int idx)
> >>   {
> >>   	struct f71882fg_data *data = platform_get_drvdata(pdev);
> >>   	int err;
> >>
> >> +	/* Sanity check the pwm setting */
> >> +	err = 0;
> >> +	switch (data->type) {
> >> +	case f71858fg:
> >> +		if (((data->pwm_enable>>  (idx * 2))&  3) = 3)
> >> +			err = 1;
> >> +		break;
> >> +	case f71862fg:
> >> +		if (((data->pwm_enable>>  (idx * 2))&  1) != 1)
> >> +			err = 1;
> >> +		break;
> >> +	case f8000:
> >> +		if (idx = 2)
> >> +			err = data->pwm_enable&  0x20;
> >> +		break;
> >> +	default:
> >> +		break;
> >> +	}
> >> +	if (err) {
> >> +		dev_err(&pdev->dev,
> >> +			"Invalid (reserved) pwm settings: 0x%02x, "
> >> +			"skipping fan %d\n",
> >> +			(data->pwm_enable>>  (idx * 2))&  3, idx + 1);
> >> +		return 0; /* This is a non fatal condition */
> >> +	}
> >
> > Since this is no longer a fatal condition, it might make sense to use
> > dev_warn instead.
> 
> Despite being non fatal, this is still very much an error. f71882fg has
> been doing these checks for quite some time now, and Daniel's mobo is the
> first one to actual trigger them. Who knows this error may even point out
> to some BIOS developer that he is doing something wrong (yeah right BIOS
> developers testing with Linux, well we can always hope).
> 
> iow I would prefer to keep this as is :)
> 
Ok, I'll accept that. All three patches applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
