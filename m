From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 27 May 2005 23:54:34 +0000
Subject: [lm-sensors] Re: [patch 2.6.12-rc3+] i2c driver for TPS6501x
Message-Id: <20050527235443.5e210ce6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200505051618.34980.david-b@pacbell.net>
In-Reply-To: <200505051618.34980.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dave,

> The "isp1301_omap" driver uses even more kernel features, FWIW, but
> it's not exactly a "hardware monitoring" driver either.

And as a matter of fact it was not posted for review on the lm-sensors
list.

> > I would rather move all non-i2c hardware 
> > monitoring drivers out of the i2c subsystem before changing it
> > significantly.
> 
> I hope you're not saying what I think you're saying ...

I am saying what I am saying, but it looks like you are not
understanding what I am saying ;)

> (...) why
> remove everything from the I2C stack except hardware monitoring
> support??

Non-i2c hardware monitoring drivers != non-hardware-monitoring i2c
drivers. Not all hardware monitoring chips are I2C/SMBus based, and I
would like to have these which are not moved to their respective
subsystem rather than cluttering the i2c subsystem. We're far from that
though.

> > You should be using dev_dbg() instead. Ditto in show_regstatus() and
> > show_chgconfig().
> 
> Actually that just makes the diagnostics annoyingly verbose;

Funny thing to read when you see how verbose the debugging messages
themselves are in this driver ;)

> there's no point to having more than one of these chips in a system.

But there is a point in having consistent messages among drivers. You
should expect Greg to tell you the same when he finally reviews your
driver for inclusion. If he is happy with the way you did, I'll admit
you were right and will try to remember for my next review.

> > You are limiting yourself to a single device by doing so. This is
> > against the design of the i2c subsystem. What would it take to allow
> > an unlimited number of devices?
> 
> First and foremost:  having more than one of them make sense from a
> hardware perspective ... :)

I guess you assume very small values of 2 here, right? ;)

> > In some cases, you actually want the bus scanning to stop on error.
> > This is the case for memory shortage, as well as the "only one
> > device supported" case.
> 
> But memory shortages can improve ... I'd have to go back and look at
> the innards of I2C again, but I think this was mostly to be sure that
> a failure here couldn't cause a surprise failure elsewhere.  I recall
> thinking this was a place where the driver model and I2C don't quite
> see eye-to-eye.

You are correct. This needs a full rewrite actually, which will happen
someday. I wish I had a little less things to track simultaneously, or
more time to work on them.

> > > +#else
> > > +#define set_irq_type(num,trigger)	do{}while(0)
> > > +#endif
> > 
> > Ugly trick if you want my opinion. First because that #else
> > statement is not the counterpart of the #ifdef statement at all
> > (they just *happen* to have an opposite condition).
> 
> I don't follow.  It's an ARM-specific API ... admittedly it's a huge
> hole in the standard IRQ infrastructure (Linux should have a standard
> way for drivers to say how their hardware triggers its IRQs), but that
> also means there's no better #ifdef to use.

My point was as follow. Given A and B two unrelated instructions, if A
needs to be done under a condition and B needs to done under the
opposite condition, I would rather write:

#if condition
	A;
#endif

#if !condition
	B;
#endif

than:

#ifdef condition
	A;
#else
	B;
#endif

I find the first approach less error-prone. If the condition for A
changes at some point in time, the second approach is likely to result
in a wrong condition being used for B.

> > You don't really need an ID, do you? Just omit it.
> 
> What's it even for?

Actually everyone is wondering ;)

> (...) The docs show it used, but don't say how
> a driver author could know if it's needed.

You know it's needed if you use it yourself. The i2c core doesn't use
this ID as far as I remember. I saw some uses of it in some architecture
specific drivers, and possibly in some media/video drivers. Ultimately
this field may be removed entirely, but as the many things I have to
improve on the i2c subsystem, such a change affects several dozen
drivers so I try to be careful and do them one at a time.

> (...) Sounds like maybe
> the docs should stop recommending it be set...

Patches are welcome :)

> > The __exit_p() looks suspicious to me. Can you justify it? None of
> > the other i2c client drivers have it.
> 
> It's a standard idiom used in drivers to wrap pointers to __exit
> functions, which often vanish when drivers are statically linked.
> The "__exit_p" evaluates to NULL in that case rather than garbage,
> preventing oopses.
> 
> Most drivers use it for their remove() methods; that's basically
> the role of the I2C detach_client() method.   See <linux/init.h>
> and most hotpluggable PCI drivers.
> 
> Drivers that don't much care about small kernel size aren't going to
> use that for very much; drivers on embedded hardware need to care.
> The other I2C drivers don't much use __exit markings.

I know what __exit_p() is for. What I would like you to explain is why
tps65010_detach_client was tagged __exit in the first place. There are
two cases where an i2c client can be removed: when its i2c chip driver
itself is removed, or when the i2c adapter driver it sits on is removed.
I can easily understand that the first case cannot happen if that
__exit_p() resolved to NULL. The second case could happen however,
unless you prove otherwise. My point is that an i2c_driver.detach_client
method can only be tagged __exit_p if you ensure that clients will only
attach to i2c adapter drivers which cannot be removed themselves. This
is quite a bold statement to hold, if you want my opinion. You would
need to do much more tests that you are doing right now on the
driver/adapter connection.

> > > +static int __init tps_init(void)
> > > +{
> > > +	u32	tries = 3;
> > > +	int	status = -ENODEV;
> > 
> > Useless initialization of status as far as I can see.
> > 
> > > +	/* some boards have startup glitches */
> > > +	while (tries--) {
> > > +		status = i2c_add_driver(&tps65010_driver);
> 
> You can see it's useless, as can I, but some tools don't
> seem to understand that if "tries" starts as "3" then this
> statement is always going to get executed.  The initialation
> avoids annoying warnings.

Please tag it as such in this case. Alternatively you could probably
switch to a do {} while() statement, which such code analysis tools
would enjoy more. (This is a pretty simple case BTW, and such code
analysis tools should be improved to support it. Also, making the code
worse isn't the goal of code analysis tools, yes this is what happens
here. Sigh.)

> The problem seemed to be that on certain boards the I2C controller
> has startup glitches.  Since those boards don't boot Linux properly
> without this chip running -- as in, essential devices unavailable
> without the TPS chip being available to manage them -- it's critical
> that this driver initialize.  Usually one re-probe suffices.
> 
> Yes, that's annoying, and quite possibly the I2C controller driver
> is a better place to fix this ... if not the hardware.  But until
> such a fix exists, this is the best workaround we have.

If the I2C controller is faulty, the workaround should be moved to its
driver, as you seem to agree upon yourself. See, "such a fix exists"
could be made a condition for your tps65010 driver to be accepted in the
main kernel tree. It's really easy ;)

And finally some minor comments on your incremental patch:

> -	dev_dbg (&the_tps->client.dev, "led%i_on   0x%02x\n", led,
> -		i2c_smbus_read_byte_data(&the_tps->client, TPS_LED1_ON + offs));
> (...)
> +	pr_debug("%s: led%i_on   0x%02x\n", DRIVER_NAME, led,
> +		i2c_smbus_read_byte_data(&the_tps->client,
> +				TPS_LED1_ON + offs));

Let it be clear that my complaint about the coding style was about the
additional space between dev_dbg and the opening parenthesis. Nothing
more. The rest of the changes are up to you.

>  	if (status != 0)
>  		printk(KERN_ERR "%s: Failed to write vdcdc1 register\n", 
> -		       DRIVER_NAME);
> +			DRIVER_NAME);
>  	else

For some reason I wasn't seeing the correct indentations when reviewing
your original patch this morning, thus my complaint. However the
indentation was actually just fine, so this change is not needed at all
(I personally prefer it the original way).

-- 
Jean Delvare
