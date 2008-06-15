From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 15 Jun 2008 19:17:07 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-new-driver-ti-tmp401.patch
Message-Id: <20080615211707.41790348@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4853E081.1020109@hhs.nl>
In-Reply-To: <4853E081.1020109@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

On Sun, 15 Jun 2008 19:23:11 +0100, Ben Dooks wrote:
> On Sat, Jun 14, 2008 at 05:15:13PM +0200, Hans de Goede wrote:
> > Hi All,
> > 
> > This is a new hwmon driver for TI's TMP401 temperature sensor IC. This 
> > driver
> > was written on behalf of an embedded systems vendor under the
> > linuxdriverproject.
> > 
> > It has been tested using a TI TMP401 sample attached to a i2c-tiny-usb 
> > adapter.
> > Which was provided by Till Harbaum, many thanks to him for this!
> > 
> > Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> > 
> > Regards,
> > 
> > Hans
> 
> > This is a new hwmon driver for TI's TMP401 temperature sensor IC. This driver
> > was written on behalf of an embedded systems vendor under the
> > linuxdriverproject.
> > 
> > It has been tested using a TI TMP401 sample attached to a i2c-tiny-usb adapter.
> > Which was provided by Till Harbaum, many thanks to him for this! 
> > 
> > Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> > (...)
> > +static struct i2c_driver tmp401_driver = {
> > +	.driver = {
> > +		.name	= TMP401_NAME,
> 
> the .owner field is missing, ie:
> 		.owner	= THIS_MODULE,

It's optional (i2c_add_driver adds it anyway). I don't like it and I
might revert this behavior someday, but for now that's how things are,
so Hans' code is correct.

> > +	},
> > +	.attach_adapter	= tmp401_attach_adapter,
> > +	.detach_client	= tmp401_detach_client,
> > +};
> 
> you should be using the new method of attaching the clients, as the
> old driver methods are being removed as soon as possible. 

If and only if the only users of this driver are embedded platforms. If
this chip is found on PCs or other systems where you can't instantiate
the I2C device, then the legacy methods must still be used. If both
types of users exist then you need two i2c_driver instances (for now;
I'm working on something better for 2.6.27.)

> > +
> > +	if (data->status & mask)
> > +		return sprintf(buf, "1\n");
> > +	else
> > +		return sprintf(buf, "0\n");
> > +}
> 
> you should be using snprintf() or some other bounded printf method
> against PAGE_SIZE, the return should be the length of the buffer.

I doubt it. snprintf returns the number of bytes written (just like
sprintf), not the size of the buffer, and I fail to see why you would
want to return the buffer size. That would cause sysfs to pass
uninitialized data to user-space.

I agree that in theory we should be using snprintf in these functions,
but the fact is that no hwmon driver does this, and frankly this sounds
overkill. There's just no way PAGE_SIZE can be smaller than room it
takes to print an integer.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
