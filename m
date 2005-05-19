From: alex@alexdalton.org (Alexandre d'Alton)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: ADM1030 Driver
Message-Id: <1081938139.407d10db2c415@imp5-q.free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
In-Reply-To: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Jean Delvare <khali@linux-fr.org>:

> > I thought that I had changed all to take 0-1 as parameter.
> > The bottom macros uses 1-2 bacause of the file naming conventions, I
> > think that defining registers with not real values is also confusing.
> 
> I'm not sure I get what you mean exactly.
> 
> You can still call the macros with (nr-1) as the parameter, so it
> shouldn't cause problems (and I now see that you already do that).

OK we agreed then.

> 
> > > You aren't taking advantage of the extended temperature resolution
> > > bits, are you?
> > 
> > No I don't for instance.
> 
> ("for instance" = "par exemple")

Have to improve my english :)
So I would say, I don't take advantage of extended resolution YET.

> 
> > > > /* These macros converts sysfs-sensors compliant values into
> > > >  * corresponding register value.
> > > >  */
> > > > #define to_reg_temp_min(reg, val) ((((val)/500) & 0xf8)|((reg) &
> > 0x7))
> > > > #define to_reg_temp_range(reg, val) (((reg) & 0xf8) | \
> > > > (((val)<10000 ? 0 :                                   \
> > > >   (val)<20000 ? 1 :                                   \
> > > >   (val)<40000 ? 2 :                                   \
> > > >   (val)<80000 ? 3 : 4) & 7))
> > > 
> > > It just me, or is this macro plain broken?
> > 
> > Can I ask why without beeing an idiot ?
> 
> Answer 1: it was just me. So I am the actual idiot ;)

Nobody is an idiot.

> 
> > > And usually, converters do not deal with the registers as you do.
> > > The converters should return the "raw" values, and the caller can
> > > then combine these with other values.
> > 
> > That means that we'll have different versions of set and show
> > functions ?
> 
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

So, if I get you, if it is easier to read to define more than one set macro or
function, I can do it ?

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

Yes, it is the TACH register. I have to implement the access to that register.

> 
> > > Where is fan1_min?
> > 
> > See above. Same as pwm1.
> 
> This cannot be, BTW, since fan1_min has to be a RPM value according to
> Documentation/i2c/sysfs-interface.

I misunderstood, you're right, pwm1 will be the min value at which the fan will
spin, and fan1_min (to be added) will be the fan speed uner which the chip will
generate a fan_fault interrupt.

> 
> > > 1* How does bit 0 of configuration register 2 work? Maybe it could
> > > be exported as pwm1_enable (if that's what it does).
> >
> > Bit 0 of conf register 2 enables the pwm output, I think that if the
> > bit iscleared, the fan will never rotate. Even if in automatic mode.
> > But it is not verified yet...
> 
> Please try and tell me.

I'll test it as soon as I'll be in front of my computer.

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

Bon appetit !

> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
> 
> 


-- 
-------------------------------------------------
Alexandre d'ALTON
                              alex@alexdalton.org
