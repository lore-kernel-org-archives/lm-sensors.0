From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Sep 2012 18:56:34 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (lm70) Simplify show_name function
Message-Id: <20120916185634.GB25960@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347396773-32108-1-git-send-email-linux@roeck-us.net>
	<20120916150901.6df27a85@endymion.delvare>
	<20120916161934.GB24858@roeck-us.net>
	<20120916204456.16a94b98@endymion.delvare>
In-Reply-To: <20120916204456.16a94b98-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, lm-sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On Sun, Sep 16, 2012 at 08:44:56PM +0200, Jean Delvare wrote:
> On Sun, 16 Sep 2012 09:19:34 -0700, Guenter Roeck wrote:
> > On Sun, Sep 16, 2012 at 03:09:01PM +0200, Jean Delvare wrote:
> > > On Tue, 11 Sep 2012 13:52:50 -0700, Guenter Roeck wrote:
> > > That's a very nice cleanup, but it makes me wonder...
> > > 
> > > Wouldn't it make sense to create the "name" attribute of spi devices at
> > > the spi core level, as we do for i2c devices? All spi-based hwmon
> > > drivers create the hwmon attributes as the spi device level, as is done
> > > for i2c devices, so that would make no difference from a user-space
> > > perspective. And this would avoid code redundancy.
> > > 
> > > If we don't want to do that, then let's offer drivers a nicer function
> > > to retrieve the spi device name, e.g. spi_dev_name(). That way, the
> > > internal implementation can change in the future without having to
> > > update all drivers.
> >
> > Adding a "name" attribute would be great, but it is not used outside hwmon,
> > and I am not sure if we want to impose that on other users.
> 
> That's correct, but OTOH we do exactly that for i2c devices and I am
> not aware of anybody complaining about that so far.
> 
> > I am obviously fine with spi_dev_name().
> > 
> > Having said that, modalias is used heavily in SPI drivers, so my patches
> > don't really do anything special.
> 
> OK, good to know. This certainly speaks in favor of at least
> spi_dev_name(), but we can take your patches as is for the time being,
> pending Grant's decision.
> 
That is what I would suggest we should do.

Also copying Mark Brown; he is handling much of the SPI changes nowadays.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
