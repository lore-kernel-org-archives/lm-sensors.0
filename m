From: Andre Prendel <andre.prendel@gmx.de>
Date: Thu, 14 May 2009 12:41:01 +0000
Subject: Re: [lm-sensors] [PATCH RFC 0/2] tmp401: Add support for Texas
Message-Id: <20090514124101.GD6644@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090514080653.GB4486@ubuntu>
In-Reply-To: <20090514080653.GB4486@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 14, 2009 at 01:20:00PM +0200, Jean Delvare wrote:
> On Thu, 14 May 2009 11:02:40 +0200, Hans de Goede wrote:
> > Hi Andre,
> > 
> > On 05/14/2009 10:06 AM, Andre Prendel wrote:
> > > Hello Jean, Hans,
> > >
> > > here is my first work at TI's 401/411 temperatur sensor. The patch(es)
> > > aren't intented to be applied. I just want some comments and maybe
> > > real testing by Hans.
> > >
> > > The first patch is the original one from Hans sent to me.
> > >
> > > The second patch contains some work of Hans' students. I've brought
> > > it in shape. The driver now has multichip support in the usual way.
> > >
> > > TODO:
> > > Update Kconfig
> > > Writing documentation
> > >
> > 
> > Great, thanks for working on this!
> > 
> > > There are a few remaining questions.
> > >
> > > 1. Hans' students implemented two additional sysfs entries
> > > (tempX_[lowest|highest]).
> > >
> > > The TMP411 chip has some additional registers for minimum and maximum
> > > temperatures measured since power-on and chip-reset.
> > >
> > > AFAIK there are no standard sysfs entries for these values. I don't
> > > remove the support so far. Should it be removed? Are there other chips
> > > with such features?
> > 
> > Ah, good point I forgot about that, I told my student to name the new
> > tempX_[lowest|highest] based on the existing and documented
> > (Documentation/hwmon/sysfs-interface) powerX_average_[lowest|highest]
> > sysfs attributes, which do the same (tracking min / max over time) for
> > powermeter IC's. So unless someone objects, I think these should stay
> > and get documented in Documentation/hwmon/sysfs-interface.
> 
> I agree. This is a very useful feature IMHO and I am surprised more
> sensor chips don't implement it.
> 
> > > 2. There is another command to reset the chip. Is this a useful feature?
> > 
> > An other very good point! My first response was no, but actually it is,
> > as this can be used to reset the min / max temp tracking. Modelling
> > after the powermeter API again, you should add a temp_reset_history, notice
> > no number there as it resets the history for all temps at once (AFAIK).
> > 
> > Again this needs to be documented, in 2 variants: temp_reset_history and
> > tempX_reset_history
> 
> Agreed.

Ok, I will add support for it to the driver.

> 
> > > 3. Indentation
> > >
> > > What is the right way to indent arguments in function declaration?
> > >
> > > a)
> > > static int tmp401_probe(struct i2c_client *client,
> > >                          const struct i2c_device_id *id)
> > >
> > > b)
> > > static int tmp401_probe(struct i2c_client *client,
> > >         const struct i2c_device_id *id)
> > >
> > > My emacs prefered the first one, but sometimes this doesn't look very
> > > well.
> > >
> > 
> > Erm, I think both are allowed, I myself usually use b, but I don't think
> > I'm consistent with that.
> 
> Both are OK, just try to be consistent within a given driver.
> 
> > > 4. May I add a copyright note of me in the header?
> > 
> > Sure.

Nice, so I will do it :)

> 
> +1 :)
> 
> > > Again, thank you very much for your help. It's a pleasure to work with
> > > you.
> > 
> > And it is a pleasure to work with you sir!
> 
> Same here :)
> 
> What a useful reply from me this was, wasn't it? :D

That's right :)

Andre

> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
