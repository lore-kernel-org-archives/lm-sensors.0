From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 23 Apr 2008 12:27:31 +0000
Subject: Re: [lm-sensors] [PATCH] LM63: Add controls for configuring device
Message-Id: <20080423142731.66d7af5c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080412173221.7b2a2f41@hyperion.delvare>
In-Reply-To: <20080412173221.7b2a2f41@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Trent,

Not sure if I should reply as it seems we're not going anywhere, but...

On Mon, 21 Apr 2008 17:30:01 -0700 (PDT), Trent Piepho wrote:
> IMHO, doing system configuration later vs early is a better idea.  And
> I'm not the only one who thinks so, from the initramfs docs:
> 
>  	The move to early userspace is necessary because finding and
>  	mounting the real root device is complex.  Root partitions can
>  	span multiple devices (raid or separate journal).  They can be
>  	out on the network (requiring dhcp, setting a specific MAC
>  	address, logging into a server, etc).  They can live on removable
>  	media, with dynamically allocated major/minor numbers and
>  	persistent naming issues requiring a full udev implementation to
>  	sort out.  They can be compressed, encrypted, copy-on-write,
>  	loopback mounted, strangely partitioned, and so on.
> 
>  	This kind of complexity (which inevitably includes policy) is
>  	rightly handled in userspace.  Both klibc and busybox/uClibc are
>  	working on simple initramfs packages to drop into a kernel build.
> 

This sounds sane, but OTOH I can hardly find a relation between your
quote above and the problem at hand.

> The direction the kernel is going, IMHO rightly, is to do as much system
> configuration as possible from userspace.  The only system configuration
> that needs to be compiled into the kernel is the minimum needed to get
> userspace up, and things like initramfs are there to get to userspace as
> soon as possible.

I don't see the kernel going into that direction that much, other than
by delegating the creation of device nodes to udev. Things that are
directly related to the hardware, like IRQ routing, is still handled
inside the kernel.

> > have desktop users (or, more generally speaking, wide use) in mind. The
> > result is that it took us several years to design a new interface that
> > is desktop-application-friendly and update the whole code accordingly.
> > I'm just trying to avoid making the same mistake again.
> 
> By creating a desktop-application-friendly interface to begin with, or by
> not having an interface at all?

By having an interface which user-space applications can build on,
with consistent semantics, and which doesn't change every other month.

> > You are free to use local patches that help you during development.
> 
> It would have helped me even more if the code was already there because
> the last person who needed it sent it upstream.

It would also help if you would send us a patch with the changes I said
I agree should go into the kernel. That way the next person who will
need features similar to what you needed would only have a small part
to write instead of a big part.

> > Indeed, the smbus layer doesn't emulate it for you, and I am glad it
> > doesn't! There are no semantics attached to the I2C transactions, so
> > arbitrarily replacing a big one by several shorter ones would be plain
> > wrong. In your case it may happen that an I2C block read of length N is
> > equivalent to N SMBus byte reads, but for other devices both might
> > produce different results.
> 
> I was thinking of i2c_smbus_read_i2c_block_data(), not arbitrary i2c
> transactions.  You have your basic smbus register read, were the master
> sends the register address then does a repeated start and reads a byte. 
> That's one of the specific i2c transactions that smbus documents, and all
> some controllers and/or drivers support.
> 
> Now, a great many i2c/smbus devices have an auto incrementing index
> register, so if you read another byte you get the next register, and so
> on.
> 
> So, one could have a function called "read contiguous block of smbus
> registers", which is something a lot of drivers do, even if they just
> code it as a bunch of random reads.  This function would use the most
> efficient transaction(s) supported by the controller, which could get all
> the registers one multi-byte read, or do individual smbus byte reads for
> each register, or two bytes at a time, depending on the controller's
> abilities.

Which basically means moving part of the code from
eeprom.c:eeprom_update_client() to i2c-core. If enough drivers need
this, then sure, why not. Just send a patch. But first, please test
that the LM63 really supports that.

But you should keep in mind that the problem isn't as easy at it looks.
SMBus added semantics on top of certain arbitrary I2C transactions.
"SMBus Read Byte" is one of these. I2C block reads, OTOH, aren't
specified in SMBus (don't get fooled by the Linux function name), so
"SMBus-compliant" devices aren't suppose to support them at all.
Instead you have "SMBus Block Read", which has a different format, such
that devices must explicitly support it - not like the auto-increment.
"SMBus Receive Byte" and to some extent even "SMBus Read Word" do
comply with the spirit of auto-increment, however the former isn't safe
to use on multi-master buses (and not necessarily on single-master
buses without proper locking, which didn't prevent us to use it in the
eeprom driver though).

So the idea of trading SMBus Read Byte transactions for a more
efficient I2C block read is smart and happens to work for some chips,
but it is not relying on any specification. All this needs proper
documentation if we make it a public function part of the i2c-core API.

> >> It does have some disadvantages:
> >> * The decision of how to configure the device must be done in the kernel, in
> >>    the platform code that runs in the early bootup phase.  What if the proper
> >>    setting is stored in a file, based on what fan the user connected?  Or
> >
> > The settings which depend on what fan is connected (e.g. pwm1_freq)
> > have sysfs files. That's something we already agreed upon. The
> > remaining settings, which I say should go in the platform code and you
> > say shouldn't, are things which only depend on hardware settings, which
> > the user can't change. For this reason I don't see the problem of
> > setting these things up in the kernel.
> 
> No so.  For instance, pwm control and fan speed monitoring are mutually
> exclusive.

How that? The way I read the LM63 datasheet, fan speed monitoring is
exclusive with alert output, but PWM control is always available.

> If the device is an a server room, fan noise may be
> irrelevant and monitoring fan operation with SNMP or something of that
> nature might be desirable.  On the other hand, if the device is on a
> user's desk, quieting a noisy fan could by of the utmost importance and
> an the user is unlikely to have or care to use some network device health
> monitoring system.
> 
> So you see, fan1_enable depends not just on the fan connected, but where
> the device is located.  How can one compile the device's location and the
> user's sensitivity to noise into the kernel?

In the case of the LM63, fan1_enable depends on whether the _hardware_
was designed to have a fan connected to the pin _or_ to have instead
some device processing the alert signal. It's an either-or thing and
it's decided by the hardware. Unless you solder new hardware live on
your system, changing the value of fan1_enable for an LM63 at runtime
just doesn't make sense.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
