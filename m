From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 16 May 2013 16:59:23 +0000
Subject: Re: [lm-sensors] Linux drivers
Message-Id: <20130516165923.GA17377@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <BB68DB2AA0F98748814ADCB4C9FBCE4716BAAC18@DNCE04.ent.ti.com>
In-Reply-To: <BB68DB2AA0F98748814ADCB4C9FBCE4716BAAC18@DNCE04.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Resending, as the previous one was rejected by some recipients due to
spam block issues (which should hopefully be resolved by now).

On Thu, May 16, 2013 at 01:37:11PM +0200, Jean Delvare wrote:
> On Thu, 16 May 2013 12:53:09 +0200, Jean Delvare wrote:
> > On Thu, 16 May 2013 09:06:40 +0000, Van Lembergen, Lieven wrote:
> > > -              extended temperature enabling without patching the init?? Can that be done?
> > 
> > The driver doesn't yet support the extended temperature format. This
> > could be added, you can either contribute it as a patch or wait for (or
> > even sponsor) someone to implement it for you.
> 
> Sorry, I meant: setting (or clearing) the extended temperature format
> is not supported. The extended temperature format itself is supported
> already.
> 
> The proper mode is supposed to have been set by the BIOS/firmware. If
> for some reason this doesn't work for you, the proper way would be to
> pass the setting as platform data when you instantiate the device. If
> for some reason you can't do that, you can overwrite the configuration
> register using i2cset (from package i2c-tools) and the i2c-dev driver,
> before the tmp401 driver gets loaded.
> 
> We _could_ add a module parameter or a sysfs attribute to select it,
> but this means extra code in the driver, and caution is needed because
> the value of many registers depend on the format so we would have to
> update them all at once to preserve existing settings. A module
> parameter would be suboptimal because all chips handled by the driver
> would need to have the same setting.
> 
> Yet another approach would be to auto-select the range depending on
> which limits are set. This means even more code, but has the advantage
> to not introduce a new interface.
> 
> Guenter, what do you think?
> 
I dislike module parameters, as those would apply to all instances
of the driver.

I like the idea of auto-selecting the range based on specified limits.
It would be quite flexible, though require some careful coding.
Question is if it is really needed and valuable enough to go through
the trouble of implementing and testing it.

If the platform supports devicetree, another option would be to define
a devicetree property for selecting the range. That would be done during
initialization and thus be much simpler than auto-selecting it.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
