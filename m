From: david-b@pacbell.net (David Brownell)
Date: Fri, 27 May 2005 21:09:49 +0000
Subject: [lm-sensors] Re: [patch 2.6.12-rc3+] i2c driver for TPS6501x
Message-Id: <200505271209.09676.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200505051618.34980.david-b@pacbell.net>
In-Reply-To: <200505051618.34980.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 27 May 2005 4:09 am, Jean Delvare wrote:
> 
> Hi Dave,

Hi Jean, thanks for the comments.  I'll provide some responses
now, and the attached patch addresses some of your feedback.


> > Complicated?  Heh!  What's complicated about it?  It's common
> > for drivers to use IRQs and workqueues, and expose APIs to other
> > drivers.  Not for "sensors" drivers, true; most of them don't
> > expose APIs to other parts of the system (except by sysfs).
> 
> Nothing is fundamentally complicated. How much complicated we think a
> thing is mostly depends on what we are used to deal with.

Yes.  Also interrelationships with things we don't deal with,
which was my suspicion about what the biggest issue was.


> It happens 
> that the driver you submitted deals we an architecture we don't know
> much about, is for a kind of chip we never met before, and uses many
> kernel features that are never found in hardware monitoring drivers.
> This means that we couldn't properly review your code without investing
> a significant amount of our time in learning about this new context.
> Other folks on other lists are likely to be more skilled that us for the
> job. This is the reason why I did not review your driver.

Suspicion confirmed!  Though there's not a lot that's ARM-specific
there except the IRQ trigger type stuff, and machine_is_XXX() checks
for board-specific logic.

The "isp1301_omap" driver uses even more kernel features, FWIW, but
it's not exactly a "hardware monitoring" driver either.  I2C being
used in both cases as a low-speed system control bus, which happens
to have the nice feature of needing only two signals routed.  That
is, in addition to the chip's IRQ.  :)


> > From an I2C list I'd expect feedback about I2C issues more than
> > about how it relates to system booting and power management.
> 
> That's a different issue then. If all you expect from us is a review of
> the i2c part of the code, that's something I may do. Maybe this is how
> we should have understood your request in the first place. Maybe you
> could have made it a bit clearer in the first place (or we need to
> become more clever). That being said, it ain't easy to read *only* a
> part of a driver. You have to understand how things work, and this
> require to read the whole code at some point.

True enough.


> > Or maybe about how much simpler such drivers can be when I2C
> > finally gets an async message based API ... though this is not
> > one of the drivers that'd _really_ benefit from that, IMO.  ;)
> 
> No idea on this, see with Corey Minyard, he's the one working on this.
> This is a big change he is proposing, and I do not have the time to take
> a look at it for now. 

I looked at it when he first proposed it, and applauded.
Haven't had reason to look at it again since then, but I
hope it's ready next time I need to write an I2C driver
tht processes hardware IRQs!


> I would rather move all non-i2c hardware 
> monitoring drivers out of the i2c subsystem before changing it
> significantly.

I hope you're not saying what I think you're saying ... why
remove everything from the I2C stack except hardware monitoring
support??  I2C is used for more than that, and it's the "more"
which most needs features like being able to issue requests in
IRQ handlers (and then get async completion notifications).


> > +/* only two addresses possible */
> > +#define	TPS_BASE	0x48
> > +static unsigned short normal_i2c[] = {
> > +	TPS_BASE,
> > +	I2C_CLIENT_END };
> 
> This is only one address as far as I can see. So either the comment is
> wrong, or there is one address missing in the list.

As part of a port to a new board, someone removed the TPS_BASE + 1 there
without updating the comment.  I think the story is I2C scanning doesn't
work right on some of the systems ... and in any case, no board with this
chip currently uses Linux and address 0x49.


>	I see very little benefit in the
> #define anyway, 

True enough; it's gone.

> > +		(regstatus & TPS_REG_PG_LD02) ? " ld01_bad" : "",
> 
> Hmm, typo?

Yes, thanks!

> > +		({int p; switch ((chgconfig >> 3) & 3) {
> > +		case 3:		p = 100; break;
> > +		case 2:		p = 75; break;
> > +		case 1:		p = 50; break;
> > +		default:	p = 25; break;
> > +		}; p; }),
> 
> Putting this inside the printf-like construct

I suppose snprintf() is "printf-like" ... ;)

> doesn't help readability. 
> Why don't you move it outside, like you did for hibit?

The "hibit" case just started out really evil as an inline expression,
though by now it's simplified.  As you say about complexity, this is
just a case of what you're used to; I guess I'm used to having one-shot
things like that in-line.  In context, it's unambiguous; and the whole
thing started out as a macro way back when.  Before the tps65011/13
support produced any need for "hibit".


> > +static void show_chgstatus(const char *label, u8 chgstatus)
> > +{
> > (...)
> > +	pr_debug("%s: %s %s", DRIVER_NAME, label, buf);
> 
> You should be using dev_dbg() instead. Ditto in show_regstatus() and
> show_chgconfig().

Actually that just makes the diagnostics annoyingly verbose; there's
no point to having more than one of these chips in a system.  There's
a bit of inconsistency here since several folk have morphed this driver
over time, but it's improving.  (E.g. now that tps65013 routine could
probably be merged into its sibling ... by someone who can test against
both types of hardware.)


> > +#else
> > +
> > +static inline void show_chgstatus(const char *label, u8 chgstatus) { }
> > +static inline void show_regstatus(const char *label, u8 chgstatus) { }
> > +static inline void show_chgconfig(int por, const char *label, u8
> > +                                  chgconfig) { }
> > +
> > +#endif
> 
> Doesn't look good to me, as the driver will include useless function
> calls in non-debug mode (unless the compiler can automatically skip
> these?) I would rather skip the calls themselves (but see below).

The compiler does indeed inline those as NOPs, generating no code.
That's the whole point of that idiom ... there's just one #ifdef,
and the main body of the code doesn't get cluttered with others.


> > +	(void) schedule_delayed_work(&tps->work, POWER_POLL_DELAY);
> 
> Excuse my ignorance, but what is the (void) for?

Why does one cast a value into the void?  To make it clear that
one doesn't want it.  Some tools give annoying warnings about
unused function return values ... this shuts them up.  That
particular value is useless here; we don't care if some work
has already been scheduled or not.


> > +static struct tps65010 *the_tps;
> 
> You are limiting yourself to a single device by doing so. This is against
> the design of the i2c subsystem. What would it take to allow an
> unlimited number of devices?

First and foremost:  having more than one of them make sense from a
hardware perspective ... :)

Goals for these chips include supporting highly integrated systems
with very low chip count.  There's no real need for multiple Vcore
and Vmain regulators or battery chargers; and sharing for example
one VBUS power source between two chips makes no sense.  If a system
needs more power, it'll use a different chip, not several of these.

The same response applies to the points you made about debug
messages and the APIs not accepting some sort of chip ID as a
parameter.  If multiple chips made sense in some experimental
board, the folk working with that would first have to sort out
a lot of other issues before their solutions could be reusable.


> > +static int __exit tps65010_detach_client(struct i2c_client *client)
> > +{
> > (...)
> > the_tps = 0;
> 
> That would rather be = NULL.

Huh, I could have sworn I ran "sparse" over this recently to catch
such style issues; I guess not.  Fixed.


> > +/* no error returns, they'd just make bus scanning stop */
> > +static int __init
> > +tps65010_probe(struct i2c_adapter *bus, int address, int kind)
> > (...)
> > +	tps = kmalloc(sizeof *tps, GFP_KERNEL);
> > +	if (!tps)
> > +		return 0;
> 
> In some cases, you actually want the bus scanning to stop on error. This
> is the case for memory shortage, as well as the "only one device
> supported" case.

But memory shortages can improve ... I'd have to go back and look at
the innards of I2C again, but I think this was mostly to be sure that
a failure here couldn't cause a surprise failure elsewhere.  I recall
thinking this was a place where the driver model and I2C don't quite
see eye-to-eye.


> > +fail1:
> > +		kfree(tps);
> > +		return 0;
> > +	}
> 
> Please move this common error path at the end of the function, like the
> other drivers do.

OK, simple enough ...


> > +#else
> > +#define set_irq_type(num,trigger)	do{}while(0)
> > +#endif
> 
> Ugly trick if you want my opinion. First because that #else statement is
> not the counterpart of the #ifdef statement at all (they just *happen*
> to have an opposite condition).

I don't follow.  It's an ARM-specific API ... admittedly it's a huge
hole in the standard IRQ infrastructure (Linux should have a standard
way for drivers to say how their hardware triggers its IRQs), but that
also means there's no better #ifdef to use.


> Second because you could just as easily 
> surround the only call to set_irq_type() with #ifdef CONFIG_ARM/#endif
> for more clarity.

Again:  the general policy is to avoid scattering #ifdefs throughout
code; this avoids exactly such an #ifdef.


> > +static struct i2c_driver tps65010_driver = {
> > +	.owner		= THIS_MODULE,
> > +	.name		= "tps65010",
> > +	.id		= 888,		/* FIXME assign "official" value */
> 
> You don't really need an ID, do you? Just omit it.

What's it even for?  The docs show it used, but don't say how
a driver author could know if it's needed.  Sounds like maybe
the docs should stop recommending it be set...


> +	.flags		= I2C_DF_NOTIFY,
> +	.attach_adapter	= tps65010_scan_bus,
> +	.detach_client	= __exit_p(tps65010_detach_client),
> +};
> 
> The __exit_p() looks suspicious to me. Can you justify it? None of the
> other i2c client drivers have it.

It's a standard idiom used in drivers to wrap pointers to __exit
functions, which often vanish when drivers are statically linked.
The "__exit_p" evaluates to NULL in that case rather than garbage,
preventing oopses.

Most drivers use it for their remove() methods; that's basically
the role of the I2C detach_client() method.   See <linux/init.h>
and most hotpluggable PCI drivers.

Drivers that don't much care about small kernel size aren't going to
use that for very much; drivers on embedded hardware need to care.
The other I2C drivers don't much use __exit markings.


> > +int tps65010_set_led(unsigned led, unsigned mode)
> > (...)
> > +	dev_dbg (&the_tps->client.dev, "led%i_on   0x%02x\n", led,
> 
> Coding style (several more in this function).

I'll look; contributions from other people weren't necessarily
eyeballed by me before they got merged.  (I just pulled the latest
from GIT.)


> > +static int __init tps_init(void)
> > +{
> > +	u32	tries = 3;
> > +	int	status = -ENODEV;
> 
> Useless initialization of status as far as I can see.
> 
> > +	/* some boards have startup glitches */
> > +	while (tries--) {
> > +		status = i2c_add_driver(&tps65010_driver);

You can see it's useless, as can I, but some tools don't
seem to understand that if "tries" starts as "3" then this
statement is always going to get executed.  The initialation
avoids annoying warnings.


> > +		if (the_tps)
> > +			break;
> > +		i2c_del_driver(&tps65010_driver);
> > +		if (!tries) {
> > +			printk(KERN_ERR "%s: no chip?\n", DRIVER_NAME);
> > +			return -ENODEV;
> > +		}
> > +		pr_debug("%s: re-probe ...\n", DRIVER_NAME);
> > +		msleep(10);
> > +	}
> 
> This is very, very ugly. Cycling a driver because a device may fail to
> register sucks. Please isolate the one part which may fail, and restart
> only this one. 

That's what this code does.  :(

The problem seemed to be that on certain boards the I2C controller
has startup glitches.  Since those boards don't boot Linux properly
without this chip running -- as in, essential devices unavailable
without the TPS chip being available to manage them -- it's critical
that this driver initialize.  Usually one re-probe suffices.

Yes, that's annoying, and quite possibly the I2C controller driver
is a better place to fix this ... if not the hardware.  But until
such a fix exists, this is the best workaround we have.


> > +#if defined(CONFIG_ARM)
> 
> Why not simply #ifdef?

No good reason.  It just grew that way.  :)


> > +subsys_initcall(tps_init);
> 
> What if the driver is compiled as a module? (This is really a question, I
> don't know and am willing to learn.)

Then <linux/init.h> makes this be the same as module_init(), and various
board features will be unusable.  Now that the driver is working, I wonder
if it even makes sense to support compiling it as a module ... it was of
course rather handy during initial development.  Now the module option
seems to cause nothing but trouble.

(Note that the I2C driver on those systems is also a subsys_initcall, to
ensure the TPS chip is available before the drivers relying on it start
to initialize ...)


> And one additional note about debugging. That part of the driver is
> rather big, and the implementation isn't exactly elegant (100 byte
> local buffers... iirk).

Got a better solution?  But 100 bytes doesn't seem worrisome.


> It seems to be the consequence of you trying to 
> make debugging available through either the logs or debugfs, and having
> common code for both methods. This may be overkill for a simple device
> driver.

Maybe, but it works and has been useful.  At this point it'd be more
work to remove it than keep it.


> I would suggest that you either drop one of the two debugging 
> methods, or make the non-debugfs way more simple (you don't really need
> to decode all the individual bits of each register, this can easily be
> done in userspace.) Doing so would get rid of a few unelegant constructs
> too. Just my humble opinion anyway, it's only debugging after all.

And it normally compiles away to nothing, too. :)

Thing is, it's actually handy when debugging to have two different
kinds of view of the hardware.  One being "right now" during some
sort of event sequence (e.g. logging during IRQ handling) and the
other being a more static overview of the whole state (debugfs).
The two views turn up different kinds of information, and it's
easier to use them if they both provide the same decoding.

I expect that when someone implements the "fast battery charge"
both kinds of debug info will again be useful.  Right now this
only uses the hardware default charge rate.

- Dave



> 
> --
> Jean Delvare
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: tps.tweaks
Type: text/x-diff
Size: 5952 bytes
Desc: not available
Url : http://lists.atrpms.net/pipermail/lm-sensors/attachments/20050527/3024f956/tps-0001.bin
