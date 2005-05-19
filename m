From: alex@alexdalton.org (Alexandre d'Alton)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: ADM1030 Driver
Message-Id: <1082400088.656.5.camel@megapc>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
In-Reply-To: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2004-04-14 at 12:07, Jean Delvare wrote:
> Now I see that most of your choices were guided by the choice to have a
> single macro for all "set" functions. The other drivers also try to
> refactor these functions where possible, but to a lesser extent,
> obviously.
> 
> Remember that this is a macro, so you don't spare on the driver's size
> anyway. And remember that a number of set functions will not fit in your
> model anyway (set_fan_div among others).
> 
> I agree that your approach is interesting and makes code more compact,
> but for the sake of consistency, it may be preferable to follow the
> same policy as in the other drivers. But this is just my own opinion, I
> don't know if it is shared by the other developers. So just do as you
> like.

So I'll try to be more compliant with lm85 driver. And for the tricky
registers, I'll define functions that handles them without using the
global show and set macros.

> 
> > > Now I get why you were defining multiple macros. You can just pass
> > > the converter as an extra argument to set(). That said, some values
> > > will not fit in that model anyway (set(fan_min...) for example, but
> > > strangely you did not export it?)
> > 
> > In fact, fan_min and pwm are the same register. 
> > when in normal mode, pwm is the speed at which the fan will spin.
> > in automatic mode, it's the minimum speed at which the fan will
> > spin.
> 
> Oh, OK. Thanks for the information, altough this isn't the "fan_min" I
> was refering to. I was thinking of the fan speed (in RPM, not PWM)
> below which an alarm is triggered. All fan monitoring chips have that.
> Don't the ADM1030 do?
> 
> > > Where is fan1_min?
> > 
> > See above. Same as pwm1.
> 
> This cannot be, BTW, since fan1_min has to be a RPM value according to
> Documentation/i2c/sysfs-interface.
> 
> > > 1* How does bit 0 of configuration register 2 work? Maybe it could
> > > be exported as pwm1_enable (if that's what it does).
> >
> > Bit 0 of conf register 2 enables the pwm output, I think that if the
> > bit iscleared, the fan will never rotate. Even if in automatic mode.
> > But it is not verified yet...
> 
> Please try and tell me.

Clearing that bit disables PWM output, so the fan doesn't run at all!

> 
> > I'll try to integrate adm1031 support in the next version i'll post.
> > 
> > In order to detect them I'll use the device ID register.
> > 
> > Given for example that the second external temp channel is temp3
> > prefixed,
> > The correct way to handle both is to do something like :
> > 
> > if( kind = adm1031 ) {
> > 	device_create_file(&new_client->dev, &dev_attr_temp3_amin);
> > 	device_create_file(&new_client->dev, &dev_attr_temp3_range);
> > 	device_create_file(&new_client->dev, &dev_attr_temp3_min);
> > 	device_create_file(&new_client->dev, &dev_attr_temp3_max);
> > 	device_create_file(&new_client->dev, &dev_attr_temp3_crit);
> >         ...
> > }
> > 
> > isn't it ?
> 
> You got it.
> 
> More on automatic PWM after lunch ;)
