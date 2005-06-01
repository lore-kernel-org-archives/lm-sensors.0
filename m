From: david-b@pacbell.net (David Brownell)
Date: Wed, 01 Jun 2005 02:25:31 +0000
Subject: [lm-sensors] Re: [patch 2.6.12-rc3+] i2c driver for TPS6501x
Message-Id: <200505311724.42812.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200505051618.34980.david-b@pacbell.net>
In-Reply-To: <200505051618.34980.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 27 May 2005 2:54 pm, Jean Delvare wrote:
> Hi Dave,
> 
> > The "isp1301_omap" driver uses even more kernel features, FWIW, but
> > it's not exactly a "hardware monitoring" driver either.
> 
> And as a matter of fact it was not posted for review on the lm-sensors
> list.

It was posted a few times on the USB and OMAP lists.  There are some
patches lurking to split it into two parts (now that there's finally
some point to doing that, meaning a component that needs swapping),
which if you like I'll post to the sensors list for review.  (That's
still the only Linux I2C list, AFAIK...)


> > (...) why
> > remove everything from the I2C stack except hardware monitoring
> > support??
> 
> Non-i2c hardware monitoring drivers != non-hardware-monitoring i2c
> drivers. Not all hardware monitoring chips are I2C/SMBus based, and I
> would like to have these which are not moved to their respective
> subsystem rather than cluttering the i2c subsystem. We're far from that
> though.

I'll not disagree with that.  Good -- you weren't saying what I
was afraid you were saying!


> > > You should be using dev_dbg() instead. Ditto in show_regstatus() and
> > > show_chgconfig().
> > 
> > Actually that just makes the diagnostics annoyingly verbose;
> 
> Funny thing to read when you see how verbose the debugging messages
> themselves are in this driver ;)

It's a question of signal-to-noise ratio, that's all.  Interpreting
bits doesn't bother most folk (heck, the BSDs even have kernel printf
utilities to print bitfields!), but repeating the same string over
and over, redundantly, many times again and again, is overkill.  :)


> > there's no point to having more than one of these chips in a system.
> 
> But there is a point in having consistent messages among drivers. You
> should expect Greg to tell you the same when he finally reviews your
> driver for inclusion. If he is happy with the way you did, I'll admit
> you were right and will try to remember for my next review.

Well, he merged it and didn't tell me.  I concluded he's either happy,
content to not argue, way too busy, or all the above.  :)

Given I've been a big contributor to switching for example USB over to
use the driver model messages, I suspect he's accepted that I may have
good reasons for what I do.  For singleton drivers, there really is
no point to driver model messages.  For things like USB, it really
does make a huge difference to be able to tell for example WHICH hub
or disk is making trouble.


> > > You are limiting yourself to a single device by doing so. This is
> > > against the design of the i2c subsystem. What would it take to allow
> > > an unlimited number of devices?
> > 
> > First and foremost:  having more than one of them make sense from a
> > hardware perspective ... :)
> 
> I guess you assume very small values of 2 here, right? ;)

VERY small, yes.  :)

The reason the hardware supports two addreses is more likely IMO to
be a "just in case someone else needs to use the main address" than
anything else ... I've seen a bunch of boards using them, and in all
cases there's only one TPS chip managing one battery's output/input.


> > > In some cases, you actually want the bus scanning to stop on error.
> > > This is the case for memory shortage, as well as the "only one
> > > device supported" case.
> > 
> > But memory shortages can improve ... I'd have to go back and look at
> > the innards of I2C again, but I think this was mostly to be sure that
> > a failure here couldn't cause a surprise failure elsewhere.  I recall
> > thinking this was a place where the driver model and I2C don't quite
> > see eye-to-eye.
> 
> You are correct. This needs a full rewrite actually, which will happen
> someday. I wish I had a little less things to track simultaneously, or
> more time to work on them.

Yes.  Or a few more apprentice hackers you'd trust to rewrite core stuff!


> > > > +#else
> > > > +#define set_irq_type(num,trigger)	do{}while(0)
> > > > +#endif
> > > 
> > > Ugly trick if you want my opinion. First because that #else
> > > statement is not the counterpart of the #ifdef statement at all
> > > (they just *happen* to have an opposite condition).
> > 
> > I don't follow.  It's an ARM-specific API ... admittedly it's a huge
> > hole in the standard IRQ infrastructure (Linux should have a standard
> > way for drivers to say how their hardware triggers its IRQs), but that
> > also means there's no better #ifdef to use.
> 
> My point was as follow. Given A and B two unrelated instructions...

My point was that "!A" is today the only portable test for B.
So in that sense they are NOT unrelated.

> 
> > > You don't really need an ID, do you? Just omit it.
> > 
> > What's it even for?
> 
> Actually everyone is wondering ;)
> 
> ...
> 
> > (...) Sounds like maybe
> > the docs should stop recommending it be set...
> 
> Patches are welcome :)

Attached.  Glad to know I wasn't the only one being puzzled!


> > > The __exit_p() looks suspicious to me. Can you justify it? None of
> > > the other i2c client drivers have it.
> > 
> > It's a standard idiom used in drivers to wrap pointers to __exit
> > functions, which often vanish when drivers are statically linked.
> > The "__exit_p" evaluates to NULL in that case rather than garbage,
> > preventing oopses.
> > 
> > ...
> 
> I know what __exit_p() is for. What I would like you to explain is why
> tps65010_detach_client was tagged __exit in the first place. There are
> two cases where an i2c client can be removed: when its i2c chip driver
> itself is removed, or when the i2c adapter driver it sits on is removed.
> I can easily understand that the first case cannot happen if that
> __exit_p() resolved to NULL. The second case could happen however,
> unless you prove otherwise. My point is that an i2c_driver.detach_client
> method can only be tagged __exit_p if you ensure that clients will only
> attach to i2c adapter drivers which cannot be removed themselves. This
> is quite a bold statement to hold, if you want my opinion. You would
> need to do much more tests that you are doing right now on the
> driver/adapter connection.

I understand your point, but systems that use these chips rely on them.
rather fundamentally.  Normally both the I2C bus driver and the TPS
driver are _both_ statically linked ... you'd not remove the I2C bus
driver any more than you'd remove the PCI driver from a x86 box.


> > The problem seemed to be that on certain boards the I2C controller
> > has startup glitches.  Since those boards don't boot Linux properly
> > without this chip running -- as in, essential devices unavailable
> > without the TPS chip being available to manage them -- it's critical
> > that this driver initialize.  Usually one re-probe suffices.
> > 
> > Yes, that's annoying, and quite possibly the I2C controller driver
> > is a better place to fix this ... if not the hardware.  But until
> > such a fix exists, this is the best workaround we have.
> 
> If the I2C controller is faulty, the workaround should be moved to its
> driver, as you seem to agree upon yourself.

I said "possibly".  It's not clear.  If that were the case, why
was the startup glitch only seen with the TPS driver?  And in any
case, nobody seems to have time to debug that particular board's
specific hardware problem lately.  These sorts of things are
hard to spy on even with a decent hardware debug setup, since
the main chips are surface mount BGA and there's no place to stick
any kind of logic analyser in those multilayer boards... :(


> And finally some minor comments on your incremental patch:
> 
> > -	dev_dbg (&the_tps->client.dev, "led%i_on   0x%02x\n", led,
> > -		i2c_smbus_read_byte_data(&the_tps->client, TPS_LED1_ON + offs));
> > (...)
> > +	pr_debug("%s: led%i_on   0x%02x\n", DRIVER_NAME, led,
> > +		i2c_smbus_read_byte_data(&the_tps->client,
> > +				TPS_LED1_ON + offs));
> 
> Let it be clear that my complaint about the coding style was about the
> additional space between dev_dbg and the opening parenthesis. Nothing
> more. The rest of the changes are up to you.

Yes, I realized that.  I've been getting rid of redundant messages
incrementally.  Ditto bogus whitespace/tabbing, as with the next one:


> >  	if (status != 0)
> >  		printk(KERN_ERR "%s: Failed to write vdcdc1 register\n", 
> > -		       DRIVER_NAME);
> > +			DRIVER_NAME);
> >  	else
> 
> For some reason I wasn't seeing the correct indentations when reviewing
> your original patch this morning, thus my complaint. However the
> indentation was actually just fine, so this change is not needed at all
> (I personally prefer it the original way).

Mixed whitespace and tabs at line starts??  Positively revolting!  :)

- Dave

-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c.doc
Type: text/x-diff
Size: 1496 bytes
Desc: not available
Url : http://lists.atrpms.net/pipermail/lm-sensors/attachments/20050531/02d238e2/i2c.bin
