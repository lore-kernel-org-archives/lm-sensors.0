From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Sep 2012 16:19:34 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (lm70) Simplify show_name function
Message-Id: <20120916161934.GB24858@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347396773-32108-1-git-send-email-linux@roeck-us.net>
	<20120916150901.6df27a85@endymion.delvare>
In-Reply-To: <20120916150901.6df27a85-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lm-sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On Sun, Sep 16, 2012 at 03:09:01PM +0200, Jean Delvare wrote:
> Hi Guenter,
> 
> On Tue, 11 Sep 2012 13:52:50 -0700, Guenter Roeck wrote:
> > Instead of using a switch statement to determine the device name, use
> > to_spi_device(dev)->modalias to simplify the code and reduce module size.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/lm70.c |   21 +--------------------
> >  1 file changed, 1 insertion(+), 20 deletions(-)
> > 
> > diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
> > index 789753d..2d1777a 100644
> > --- a/drivers/hwmon/lm70.c
> > +++ b/drivers/hwmon/lm70.c
> > @@ -124,26 +124,7 @@ static DEVICE_ATTR(temp1_input, S_IRUGO, lm70_sense_temp, NULL);
> >  static ssize_t lm70_show_name(struct device *dev, struct device_attribute
> >  			      *devattr, char *buf)
> >  {
> > -	struct lm70 *p_lm70 = dev_get_drvdata(dev);
> > -	int ret;
> > -
> > -	switch (p_lm70->chip) {
> > -	case LM70_CHIP_LM70:
> > -		ret = sprintf(buf, "lm70\n");
> > -		break;
> > -	case LM70_CHIP_TMP121:
> > -		ret = sprintf(buf, "tmp121\n");
> > -		break;
> > -	case LM70_CHIP_LM71:
> > -		ret = sprintf(buf, "lm71\n");
> > -		break;
> > -	case LM70_CHIP_LM74:
> > -		ret = sprintf(buf, "lm74\n");
> > -		break;
> > -	default:
> > -		ret = -EINVAL;
> > -	}
> > -	return ret;
> > +	return sprintf(buf, "%s\n", to_spi_device(dev)->modalias);
> >  }
> 
> That's a very nice cleanup, but it makes me wonder...
> 
> Wouldn't it make sense to create the "name" attribute of spi devices at
> the spi core level, as we do for i2c devices? All spi-based hwmon
> drivers create the hwmon attributes as the spi device level, as is done
> for i2c devices, so that would make no difference from a user-space
> perspective. And this would avoid code redundancy.
> 
> If we don't want to do that, then let's offer drivers a nicer function
> to retrieve the spi device name, e.g. spi_dev_name(). That way, the
> internal implementation can change in the future without having to
> update all drivers.
> 
Adding a "name" attribute would be great, but it is not used outside hwmon,
and I am not sure if we want to impose that on other users. I am obviusly
fine with spi_dev_name().

Having said that, modalias is used heavily in SPI drivers, so my patches
don't really do anything special.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
