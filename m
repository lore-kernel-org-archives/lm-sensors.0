From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Aug 2008 19:50:52 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] lm87: Add support for configuration
Message-Id: <20080819215052.18afe19b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080819150228.GI7908@solarflare.com>
In-Reply-To: <20080819150228.GI7908@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

On Tue, 19 Aug 2008 19:30:36 +0100, Ben Hutchings wrote:
> Jean Delvare wrote:
> > Hi Ben,
> > 
> > On Tue, 19 Aug 2008 16:02:29 +0100, Ben Hutchings wrote:
> [...]
> > > --- a/drivers/hwmon/lm87.c
> > > +++ b/drivers/hwmon/lm87.c
> > > @@ -21,11 +21,12 @@
> > >   *   http://www.national.com/pf/LM/LM87.html
> > >   *
> > >   * Some functions share pins, so not all functions are available at the same
> > > - * time. Which are depends on the hardware setup. This driver assumes that
> > > - * the BIOS configured the chip correctly. In that respect, it  differs from
> > > - * the original driver (from lm_sensors for Linux 2.4), which would force the
> > > - * LM87 to an arbitrary, compile-time chosen mode, regardless of the actual
> > > - * chipset wiring.
> > > + * time. Which are depends on the hardware setup. This driver normally
> > > + * assumes that firmware configured the chip correctly. Where this is not
> > > + * the case, platform code must set the I2C client's platform_data to point
> > > + * to a u8 value to be written to the channel register. In that case the
> > > + * driver will assume that it is the only user of the chip and will reset
> > > + * it in the probe and remove functions.
> > 
> > I fail to see how setting the channel mode is related to resetting the
> > chip. Not that I really get the point of resetting the chip in the
> > first place, but if you want to do that, it should be independent of
> > setting the channel mode.
> 
> I'm expecting that either
> (1) firmware does most of the initialisation and may use the chip behind
>     our back, so we make minimal configuration changes
> or
> (2) firmware does nothing and we are in exclusive control of the chip, so
>     we initialise it from scratch and disable it when removed

In fact there are many cases where the firmware (or actually BIOS)
initializes the chip but doesn't access it in our back. These are
independent things.

> 
> In case (1) platform_data is not set and in case (2) it is.  I don't think
> there is a third case where we would want to set the channel but not reset
> the chip.

Hmm, OK, this makes some sense. I'm still not sure what is the point of
resetting the chip though. If the firmware had initialized it, you
loose the settings. If it didn't, the reset is a no-op.

And resetting the chip at removal time makes even less sense to me.
While I would understand that you stop the monitoring (if and only if
the chip wasn't already running at load time), resetting it but letting
it run seems pointless.

> 
> > > @@ -842,9 +846,17 @@ static void lm87_init_client(struct i2c_client *client)
> > >  	struct lm87_data *data = i2c_get_clientdata(client);
> > >  	u8 config;
> > >  
> > > -	data->channel = lm87_read_value(client, LM87_REG_CHANNEL_MODE);
> > > +	if (client->dev.platform_data) {
> > > +		config = 0x80;
> > > +		lm87_write_value(client, LM87_REG_CONFIG, config);
> > > +		data->channel = *(u8 *)client->dev.platform_data;
> > 
> > I'm not fond of that kind of cast. Which leads me to the following
> > porposal: define a proper structure controlling the LM87 device
> > initialization.
> > 
> > struct lm87_platform_data {
> > 	u8 channel_mode;
> > 	unsigned int reset:1;
> > }
> > 
> > So that the caller has control over the channel mode and the resetting
> > of the chip, in a clear and independent way. This is much better than
> > (ab)using the platform_data pointer for everything.
> [...]
> 
> This is what I proposed before.  But you didn't seem so happy with it, so
> I changed to this minimal "structure" which doesn't even need a new header
> file.

As I recall, what you proposed before was a complete reorganization of
struct lm87_data, with the aim to let the platform code initialize the
whole chip, including all the limit registers, while we have the whole
infrastructure to handle this in user-space already. It seems to me that
you went from one extreme to the other. Now you don't even want to
define a structure to transmit the initialization information from the
platform to the driver.

Not that I care much... After all, you'll be the only user of that
code, at least for now, and it can evolve later if others have
different needs. But I am still worried that you are defining a
non-intuitive interface and do not document it. If you were to add a
paragraph to Documentation/hwmon/lm87 about how platform code can
influence the initialization, I'd probably buy it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
