From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 19 Apr 2008 14:44:04 +0000
Subject: Re: [lm-sensors] [PATCH] LM63: Add controls for configuring device
Message-Id: <20080419164404.3b8ef76c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080412173221.7b2a2f41@hyperion.delvare>
In-Reply-To: <20080412173221.7b2a2f41@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Trent,

I've voluntarily stripped the parts where I think my reply wouldn't add
anything to the discussion.

On Fri, 18 Apr 2008 15:45:43 -0700 (PDT), Trent Piepho wrote:
> On Sun, 13 Apr 2008, Jean Delvare wrote:
> > I fail to see how this matters. You'll have to know what register
> > values to change anyway. How we change them is an implementation detail.
> 
> Because the code that knows what needs to be set runs from userspace, after
> the system has booted and the lm63 driver is loaded.  At that point you can't
> set it with the firmware (if there was firmware) or platform code.  If the
> setup needed in in a file, how can platform code read the contents of this
> file?

Maybe you're thinking the wrong way around? You start from the fact
that you made the configuration data available to user-space only, and
from that you conclude that we must find a way to program the LM63
from user-space. You said that you were designing the system yourself,
so presumably you have a lot of control over it. Can't you make it such
that the configuration data is easily available from kernel-space, so
that the hardware setup can happen where it belongs, in the kernel?

> What's wrong with embedded developers and power users?  Linux isn't just for
> desktops.

There's nothing wrong with embedded developers and power users, as long
as we don't let them design the interfaces ;) Historically, lm-sensors
was written by people with great electronics skills, but who didn't
have desktop users (or, more generally speaking, wide use) in mind. The
result is that it took us several years to design a new interface that
is desktop-application-friendly and update the whole code accordingly.
I'm just trying to avoid making the same mistake again.

> > confusion with regards to the sysfs interface. We've been claiming that
> > the sysfs interface to hardware monitoring devices was essentially safe
> > to use, and that would no longer be always true.
> 
> I'm not sure what's less safe here.  With the existing interface I could set
> the pwm1 value to 0 and start a fire.  The CPU would at least lose its magic
> smoke.  I don't think there is any setting I added more dangerous than that.

Oh well, you're right. PWM settings are not safe.

> (...)
> And use i2cset?  You're back to looking up hex codes in the datasheet.  I can
> remember echo 1 > pwm1_polarity, I can't remember the i2cset command to change
> the polarity.  Do you know it off the top of your head?

I can't, but why would I? That's your system, not mine. You'd write a
script running the commands, properly documented, once and for all, so
there's nothing you need to remember.

Oh, BTW, I can't remember, does pwm1_polarity = 1 mean "reverse
polarity" or "high polarity"? See, it's not that clear either.

> But it seems that you're of the option that nothing that is primarily aimed at
> hardware developers or embedded systems is acceptable.  I do not see how one
> can possibly develop embedded systems under those conditions.

You are free to use local patches that help you during development.
That doesn't mean that they need to make it into the upstream kernel.
Just like you can use user-space tools which final users of your system
won't need.

> > (...)
> > Not very robust... If you have several hardware monitoring devices,
> > your lm63 chip could as well be hwmon1.
> 
> The nice thing about embedded systems is you know what you need to worry about
> and what you don't.  What's more, your hypothetical i2cset command would be a
> lot less robust.  How would you find out what bus and address the chip is on?

That's the beauty of the new-style i2c infrastructure: you choose the
i2c bus numbers yourself. So you actually know what bus the chip is on.
As for the address, well the LM63 is hardwired at 0x4c so that's not an
issue in your case. For a different chip, you would of course have to
know the address, but I fail to see how this is a problem.

And if you would like i2cset to operate by bus name rather than bus
number, well, I just happen to have implemented this last week:
http://lists.lm-sensors.org/pipermail/i2c/2008-April/003325.html

> (...)
> How do you do a read/modify/write of a single bit in a register with i2cset? 

i2cset supports this since October 2004:
http://www.lm-sensors.org/changeset/2721

But anyway, what i2cset can do or not is hardly a problem. It can be
improved if needed, or you can script around it, or you can build your
own i2c-dev helper if you need.

> > (...)
> > I'd make this an info message. As I understand it, users set the PWM
> > frequency only once so it shouldn't spam the logs in practice, and I
> > think it's a useful information.
> 
> I ending up playing with this one a lot.  Some fans do not like the slow pwm
> frequencies.  And some frequencies produce an audible, and quite annoying,
> sound.  Higher frequencies tend to be better than lower ones, but that reduces
> the number of pwm steps.  Lots of trade-offs involved.

Well, make it a debug message if you prefer, but then you should
document the issue clearly in Documentation/hwmon/lm63.

> > (...)
> > Of course the underlying I2C adapter and its driver have to support
> > this. I2C block read isn't too widely supported, the other two are.
> 
> Hmm, sounds like a lot of trouble.  I'm pretty sure that the i2c block read
> will work for me, but what if the adapter doesn't support it?  It looks like
> the smbus layer doesn't emulate it for you with read_byte_data(s) if the
> adapter doesn't have it, so you've got do that yourself.

Indeed, the smbus layer doesn't emulate it for you, and I am glad it
doesn't! There are no semantics attached to the I2C transactions, so
arbitrarily replacing a big one by several shorter ones would be plain
wrong. In your case it may happen that an I2C block read of length N is
equivalent to N SMBus byte reads, but for other devices both might
produce different results.

Anyway, doing the loop yourself isn't that difficult, take a look at
eeprom_update_client() in the eeprom driver for an example.
Alternatively, you can make the extra feature only available if the
underlying i2c adapter supports block transactions in the first place -
but this will probably result in the same amount of code in the end.
It's up to you to decide if the extra code is worth the speed gain.

> > Thinking about it, this seems to be a case where a new-style i2c driver
> > would help. As this is an embedded system, presumably you have some
> > dedicated platform code running at boot. The new i2c infrastructure
> > added by David Brownell would let you instantiate your lm63 device
> > explicitly from the platform code. The advantage is that you then can
> > pass an arbitrary structure containing initialization values to the lm63
> > driver. In your case, this could include the PWM polarity, the
> > conversion rate, the tachometer input / alert output setup, etc. This
> > has all the advantages:
> > * You have access to the lm63 driver facilities (register names, etc.)
> > * Most of the setup code can go away after initialization if it is
> >  tagged properly.
> > * You don't define a user-space interface so it doesn't have to follow
> >  any standard and can be changed later as needed.
> > * You no longer rely on user-space for device initialization, so
> >  nothing can go wrong if user-space doesn't come up for some reason.
> 
> It does have some disadvantages:
> * The decision of how to configure the device must be done in the kernel, in
>    the platform code that runs in the early bootup phase.  What if the proper
>    setting is stored in a file, based on what fan the user connected?  Or

The settings which depend on what fan is connected (e.g. pwm1_freq)
have sysfs files. That's something we already agreed upon. The
remaining settings, which I say should go in the platform code and you
say shouldn't, are things which only depend on hardware settings, which
the user can't change. For this reason I don't see the problem of
setting these things up in the kernel.

>    depends on a hardware revision that's stored somewhere that's difficult to
>    access from the kernel at this point in the boot process.  Say it's behind
>    an FPGA, and the image for the FPGA is loaded from userspace after boot?
>    It's far easier to get at and change configuration information from
>    userspace than it is to compile it into the kernel.

If your design is such that you really need to rely on user-space to do
low-level hardware configuration then I claim that your design is
broken.

> 
> * All the code to do this needs to be in the kernel, which is the hardest
>    to keep in sync with new developments, because it changes the most.  An
>    initscript with a bunch of cat commands is much less likely to stop working
>    after changing kernels than a kernel patch is to no longer apply cleanly and
>    work.  A lot more people have the skill to change a filename in a script
>    than to update kernel patches.

But there's zero reason why you'd need kernel patches if you get your
code upstream (which it seems is what you are trying to do right now).

> 
> * Nothing can be changed while the system is running.  Us developers need
>    tools too.  I didn't add these controls because they were there, I added
>    them because I wanted to change them.  There are other controls I didn't
>    add, because I haven't cared about them.  If these controls are something I
>    wanted to change, there is probably someone else who will too.

Again, this is per design. Changing the pin usage or the fan polarity shouldn't
happen at runtime, as it's intimately tied to the hardware. You
developers have your local patches and i2cset if you really need that
during the development stage.

> 
> * And the big one.  Every time you want to change something, you need to
>    compile and re-flash an entire new kernel!  If I want to tell someone the
>    lm63 setup for their board with a different pwm connection setup, I can just
>    give them an echo command to set it, with linux and sysfs.  If it's platform
>    code (or vxworks) I have to compile an entirely new kernel for them to
>    flash.  No one likes the vxworks way of doing things, and this would be
>    re-creating that.  It's just a nightmare to work with, for development,
>    maintenance and support.

I just don't get that. You only need to add platform data if there is
new hardware. I can't believe that someone would be skilled enough to
design and build new hardware, but wouldn't be able to add 3 lines of
kernel code and flash the new kernel.

As a summary, you are free to ignore my suggestions. You just won't get
my Acked-by on the patches which I think do the wrong thing. If you can
find another developer to ack them, and if you ultimately manage to
convince Mark M. Hoffman that your implementation is right, then all
the best to you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
