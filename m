From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 27 May 2005 13:17:56 +0000
Subject: [lm-sensors] Re: [patch 2.6.12-rc3+] i2c driver for TPS6501x
Message-Id: <U3ISTv6n.1117192158.7690050.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200505051618.34980.david-b@pacbell.net>
In-Reply-To: <200505051618.34980.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Dave,

> Complicated?  Heh!  What's complicated about it?  It's common
> for drivers to use IRQs and workqueues, and expose APIs to other
> drivers.  Not for "sensors" drivers, true; most of them don't
> expose APIs to other parts of the system (except by sysfs).

Nothing is fundamentally complicated. How much complicated we think a
thing is mostly depends on what we are used to deal with. It happens
that the driver you submitted deals we an architecture we don't know
much about, is for a kind of chip we never met before, and uses many
kernel features that are never found in hardware monitoring drivers.
This means that we couldn't properly review your code without investing
a significant amount of our time in learning about this new context.
Other folks on other lists are likely to be more skilled that us for the
job. This is the reason why I did not review your driver.

> From an I2C list I'd expect feedback about I2C issues more than
> about how it relates to system booting and power management.

That's a different issue then. If all you expect from us is a review of
the i2c part of the code, that's something I may do. Maybe this is how
we should have understood your request in the first place. Maybe you
could have made it a bit clearer in the first place (or we need to
become more clever). That being said, it ain't easy to read *only* a
part of a driver. You have to understand how things work, and this
require to read the whole code at some point.

> Or maybe about how much simpler such drivers can be when I2C
> finally gets an async message based API ... though this is not
> one of the drivers that'd _really_ benefit from that, IMO.  ;)

No idea on this, see with Corey Minyard, he's the one working on this.
This is a big change he is proposing, and I do not have the time to take
a look at it for now. I would rather move all non-i2c hardware
monitoring drivers out of the i2c subsystem before changing it
significantly.

Here are a few random comments on your code, as I finally have some time
to review it. Per your own request, I skipped the parts dealing with
things I am not skilled in.

> +	  This driver can also be built as a module.  If so, the module
> +	  will be called tps65010.
> +
> +

Single empty line here please.

> --- linux-2.6/drivers/i2c/chips/tps65010.c
> +++ omap-2.6/drivers/i2c/chips/tps65010.c
> (...)
> +#undef	DEBUG

No. Debugging is controlled through Kconfig, you're breaking that
mechanism by doing this.

> +/* only two addresses possible */
> +#define	TPS_BASE	0x48
> +static unsigned short normal_i2c[] = {
> +	TPS_BASE,
> +	I2C_CLIENT_END };

This is only one address as far as I can see. So either the comment is
wrong, or there is one address missing in the list.

Also note that "TPS_BASE" is a poor name. Most I2C chips, including
this one, have a single address, nothing like an I/O port range, so the
term "base" doesn't make much sense. I see very little benefit in the
#define anyway, the value is really only used here and it's quite
explicit what it is, so the preprocessing overhead is mostly unjustified
IMHO.

> +struct tps65010 {
> (...)
> +	/* plus four GPIOs, probably used to switch power */

I don't get this comment.

> +static void dbg_regstat(char *buf, size_t len, u8 regstatus)
> +{
> (...)
> +		(regstatus & TPS_REG_PG_LD02) ? " ld01_bad" : "",

Hmm, typo?

> +static void dbg_chgconf(int por, char *buf, size_t len, u8 chgconfig)
> +{
> +	char *hibit;
> +
> +	if (por)
> +		hibit = (chgconfig & TPS_CHARGE_POR)
> +				? "PORims" : "POR=1sec";
> +	else
> +		hibit = (chgconfig & TPS65013_AUA) ? "AUA" : "";

hibit could be made a const char *, methinks.

> +		({int p; switch ((chgconfig >> 3) & 3) {
> +		case 3:		p = 100; break;
> +		case 2:		p = 75; break;
> +		case 1:		p = 50; break;
> +		default:	p = 25; break;
> +		}; p; }),

Putting this inside the printf-like construct doesn't help readability.
Why don't you move it outside, like you did for hibit?

> +static void show_chgstatus(const char *label, u8 chgstatus)
> +{
> (...)
> +	pr_debug("%s: %s %s", DRIVER_NAME, label, buf);

You should be using dev_dbg() instead. Ditto in show_regstatus() and
show_chgconfig().

> +#else
> +
> +static inline void show_chgstatus(const char *label, u8 chgstatus) { }
> +static inline void show_regstatus(const char *label, u8 chgstatus) { }
> +static inline void show_chgconfig(int por, const char *label, u8
> +                                  chgconfig) { }
> +
> +#endif

Doesn't look good to me, as the driver will include useless function
calls in non-debug mode (unless the compiler can automatically skip
these?) I would rather skip the calls themselves (but see below).

> +static int dbg_show(struct seq_file *s, void *_)

Not that it really matters, but usual name for unused variables is
"dummy".

> +	(void) schedule_delayed_work(&tps->work, POWER_POLL_DELAY);

Excuse my ignorance, but what is the (void) for?

> +		if (value & (1 << (4 +i)))

Coding style.

> +static struct tps65010 *the_tps;

You are limiting yourself to a single device by doing so. This is against
the design of the i2c subsystem. What would it take to allow an
unlimited number of devices?

> +static int __exit tps65010_detach_client(struct i2c_client *client)
> +{
> (...)
> the_tps = 0;

That would rather be = NULL.

> +/* no error returns, they'd just make bus scanning stop */
> +static int __init
> +tps65010_probe(struct i2c_adapter *bus, int address, int kind)
> (...)
> +	tps = kmalloc(sizeof *tps, GFP_KERNEL);
> +	if (!tps)
> +		return 0;

In some cases, you actually want the bus scanning to stop on error. This
is the case for memory shortage, as well as the "only one device
supported" case.

> +fail1:
> +		kfree(tps);
> +		return 0;
> +	}

Please move this common error path at the end of the function, like the
other drivers do.

> +#else
> +#define set_irq_type(num,trigger)	do{}while(0)
> +#endif

Ugly trick if you want my opinion. First because that #else statement is
not the counterpart of the #ifdef statement at all (they just *happen*
to have an opposite condition). Second because you could just as easily
surround the only call to set_irq_type() with #ifdef CONFIG_ARM/#endif
for more clarity.

> +		printk(KERN_WARNING "%s: IRQ not configured!\n",
> +				DRIVER_NAME);

Why not dev_warn()? Same for many, many printk/pr_debug all around.

You should probably split the tps65010_probe() into parts, it's too
long. E.g. the chip initialization should be a separate function.

> +static struct i2c_driver tps65010_driver = {
> +	.owner		= THIS_MODULE,
> +	.name		= "tps65010",
> +	.id		= 888,		/* FIXME assign "official" value */

You don't really need an ID, do you? Just omit it.

+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= tps65010_scan_bus,
+	.detach_client	= __exit_p(tps65010_detach_client),
+};

The __exit_p() looks suspicious to me. Can you justify it? None of the
other i2c client drivers have it.

> +int tps65010_set_vbus_draw(unsigned mA)
> (...)
> EXPORT_SYMBOL(tps65010_set_vbus_draw);

This function, as well as the rest of the interface, solely relies on the
fact that only chip can be handled by the driver. This may show its
limit at some point, causing an interface change. You could make it so
that the users of the interface have a pointer to the i2c client and
pass it to the function. That way, the interface would not need to be
changed for multiple device support.

> +int tps65010_set_led(unsigned led, unsigned mode)
> (...)
> +	dev_dbg (&the_tps->client.dev, "led%i_on   0x%02x\n", led,

Coding style (several more in this function).

> +	if (status != 0)
> +		printk(KERN_ERR "%s: Failed to write vdcdc1 register\n",
> +	 DRIVER_NAME);
> +	else

Indentation.

> +static int __init tps_init(void)
> +{
> +	u32	tries = 3;
> +	int	status = -ENODEV;

Useless initialization of status as far as I can see.

> +	/* some boards have startup glitches */
> +	while (tries--) {
> +		status = i2c_add_driver(&tps65010_driver);
> +		if (the_tps)
> +			break;
> +		i2c_del_driver(&tps65010_driver);
> +		if (!tries) {
> +			printk(KERN_ERR "%s: no chip?\n", DRIVER_NAME);
> +			return -ENODEV;
> +		}
> +		pr_debug("%s: re-probe ...\n", DRIVER_NAME);
> +		msleep(10);
> +	}

This is very, very ugly. Cycling a driver because a device may fail to
register sucks. Please isolate the one part which may fail, and restart
only this one. If the driver ever supports more that one device (and it
really should), then cycling the driver will unregister possibly working
clients and have them register again, giving them one more chance to
fail - let alone the waste of time and power. The retries should really
be done at device level, not driver level.

> +#if defined(CONFIG_ARM)

Why not simply #ifdef?

> +subsys_initcall(tps_init);

What if the driver is compiled as a module? (This is really a question, I
don't know and am willing to learn.)

And one additional note about debugging. That part of the driver is
rather big, and the implementation isn't exactly elegant (100 byte
local buffers... iirk). It seems to be the consequence of you trying to
make debugging available through either the logs or debugfs, and having
common code for both methods. This may be overkill for a simple device
driver. I would suggest that you either drop one of the two debugging
methods, or make the non-debugfs way more simple (you don't really need
to decode all the individual bits of each register, this can easily be
done in userspace.) Doing so would get rid of a few unelegant constructs
too. Just my humble opinion anyway, it's only debugging after all.

--
Jean Delvare
