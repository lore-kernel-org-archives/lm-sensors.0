From: Trent Piepho <tpiepho@freescale.com>
Date: Fri, 18 Apr 2008 22:45:43 +0000
Subject: Re: [lm-sensors] [PATCH] LM63: Add controls for configuring device
Message-Id: <Pine.LNX.4.64.0804130338120.20834@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080412173221.7b2a2f41@hyperion.delvare>
In-Reply-To: <20080412173221.7b2a2f41@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 13 Apr 2008, Jean Delvare wrote:
>> If the default LM63 polarity is wrong, how is it supposed to be changed?
>
> I'd say firmware, platform code, or i2cset, in this order of

What firmware?

Platform code, that's a lot harder to change than user space.  You have to
recompile and re-flash to do anything.  It's also hardest to port across
kernel versions.

i2cset, way too manual.

> preference. Relying on user-space to configure a hardware monitoring
> chip is somewhat dangerous, user-space might as well never come up.

The kernel might not come up either.  Generally if the kernel boots up to the
point where i2c is around, userspace is will be ok.  Setup from userspace adds
very little risk, especially in production use, over setup in the kernel.  Of
course it would a lot better if the chip let you strap these options when it
came out of reset.

>> Suppose the correct polarity depends on the hardware revision?  Or some
>> kind of configuration setting?  It's possible that the polarity of the lm63
>> will be controlled by a dip switch in the next hardware revision, as the
>> polarity also controls whether the lm63 comes out of reset with the fan on
>> or off, and if one can use pwm and fan speed monitoring at the same time.
>
> I fail to see how this matters. You'll have to know what register
> values to change anyway. How we change them is an implementation detail.

Because the code that knows what needs to be set runs from userspace, after
the system has booted and the lm63 driver is loaded.  At that point you can't
set it with the firmware (if there was firmware) or platform code.  If the
setup needed in in a file, how can platform code read the contents of this
file?

> Me, I am thinking long-term. You're creating a precedent with
> CONFIG_SENSORS_LM63_SETUP. If one driver has this, I can see all the
> embedded developers and power users rush in and ask for something
> similar for their hardware monitoring driver. Not only that would be a

What's wrong with embedded developers and power users?  Linux isn't just for
desktops.

> confusion with regards to the sysfs interface. We've been claiming that
> the sysfs interface to hardware monitoring devices was essentially safe
> to use, and that would no longer be always true.

I'm not sure what's less safe here.  With the existing interface I could set
the pwm1 value to 0 and start a fire.  The CPU would at least lose its magic
smoke.  I don't think there is any setting I added more dangerous than that.

> We have also been claiming loudly that the sysfs interface to hardware
> monitoring devices was now standardized. If we want this to be still
> true, then all CONFIG_SENSORS_*_SETUP extensions would have to agree on
> standards for the extra setup functions. That would be a lot of work
> and I am definitely not willing to invest time in this. Alternatively,
> we could just say that the advanced setup sysfs files are not standard,
> but I can see this cause even more confusion when two drivers will offer
> sysfs files by the same name but expecting different conventions.

IMHO, trying to standardize every last feature and quirk just isn't worth it. 
You end up with a huge standard that doesn't work very well for anyone.  The
abilities defined for the hwmon sysfs can be standard, and if some device
creates a new file not covered, that's not part of the standard.  Sort of
like V4L2 private controls.

If some software project only wants to work with standard interfaces, they
just don't support the non-standard files.  They are no worse off than if
those extra features didn't exist in the first place.

> give it a run-time interface. This means that you have to keep the code
> in memory forever while you really only need it once. Given that you
> are working on a system with limited resources, I thought that this is
> something you would care about.

Flash is by far the most limited resource and that gets used no matter where
the code is.  The question is what is least amount of code, and how much
development effort is it worth for the savings involved.

> happening behind their back, by design, as discussed later. But anyway,
> these are settings you simply shouldn't change at run-time. If you're
> debugging stuff, just unload the lm63 driver, run i2cset, and load the
> lm63 driver again.

Modules?  That would cause the kernel code to spill into the root filesystem. 
And use i2cset?  You're back to looking up hex codes in the datasheet.  I can
remember echo 1 > pwm1_polarity, I can't remember the i2cset command to change
the polarity.  Do you know it off the top of your head?

>>> fan1_enable and maybe conv_rate if you can explain) that would belong
>>> to CONFIG_SENSORS_LM63_SETUP. Quite frankly, I'd rather see you use
>>> i2cset to write them to the LM63 chip at boot time, rather than adding
>>> code to the lm63 driver, even as a separate option. You'll have to
>>
>> Well, why write a lm63 driver at all?  Just use i2cset for everything.
>
> Excellent idea, please do that.
>
> You know, I have been spending about 2 hours reviewing your patch
> originally, and now I'm spending again one hour just to reply to this
> mail. If you're not going to listen to my experience with hardware
> monitoring drivers, just tell me right away and I'll go spend my
> precious time in a more useful way.

And I appreciate that.  I've spent several hours incorporating most of your
suggestions.

But it seems that you're of the option that nothing that is primarily aimed at
hardware developers or embedded systems is acceptable.  I do not see how one
can possibly develop embedded systems under those conditions.

>> Looking up register values in the datasheet and converting them to hex
>> bytes in your head gets old fast.  It's also very convenient to put
>> something like this:
>>
>> echo $SYSCFG_PWM_POLARITY > /sys/class/hwmon/hwmon0/device/pwm1_polarity
>
> Not very robust... If you have several hardware monitoring devices,
> your lm63 chip could as well be hwmon1.

The nice thing about embedded systems is you know what you need to worry about
and what you don't.  What's more, your hypothetical i2cset command would be a
lot less robust.  How would you find out what bus and address the chip is on?

>> In your startup script.  Instead of having to include i2cset and i2cdump on
>> your embedded device (there goes another sector of flash) and trying to
>> implement a script that sets the necessary bit.
>
> You shouldn't need i2cdump, i2cset (and the i2c-dev driver) should be
> enough. If anything, I'd rather add i2cget (but again in most cases
> i2cset should suffice.) i2cset weights about 18 kB, the i2c-dev driver
> about 6 kB, that's pretty small, and more importantly, both can be
> removed from memory after use, while the hardware monitoring drivers
> cannot.

How do you do a read/modify/write of a single bit in a register with i2cset? 
And even if these utilities can be removed from memory, they can't be removed
from flash.

>> This isn't something that changes a lot, if ever, and it's the easiest way
>> to do it.  Otherwise it's a lot more work to become robust against sysfs
>> and the config work becoming out of sync.  I thought code simplicity and
>> clarity were more important than speed in this case.
>
> "A lot of work"? Store a bit in struct lm63_data to remember whether
> the files are created or not, and you're done.

That would still be several lines of code.  If someone is turning the fan on
over and over again when it's already on, they're just stupidly telling the
driver to do nothing.  So does it really matter how efficient the driver is at
doing nothing?

> I'd make this an info message. As I understand it, users set the PWM
> frequency only once so it shouldn't spam the logs in practice, and I
> think it's a useful information.

I ending up playing with this one a lot.  Some fans do not like the slow pwm
frequencies.  And some frequencies produce an audible, and quite annoying,
sound.  Higher frequencies tend to be better than lower ones, but that reduces
the number of pwm steps.  Lots of trade-offs involved.

> The LM63 datasheet is exceptionally scarce about which SMBus (or I2C)
> transactions are supported. As I don't have an LM63 chip, you'll have
> to try by yourself. I hope they would have mentioned it if the SMBus
> block reads were supported, so we can probably rule this one out. This
> leaves us with (by order of preference):
> * I2C block read.
> * SMBus word read, giving you two register values per transaction.
>  I doubt this will work if I2C block read failed.
> * SMBus send byte followed by N SMBus receive bytes (also known as
>  continuous byte read). Note that this may NOT be faster than
>  simple byte reads on some systems, and may even be slightly slower.
>
> Of course the underlying I2C adapter and its driver have to support
> this. I2C block read isn't too widely supported, the other two are.

Hmm, sounds like a lot of trouble.  I'm pretty sure that the i2c block read
will work for me, but what if the adapter doesn't support it?  It looks like
the smbus layer doesn't emulate it for you with read_byte_data(s) if the
adapter doesn't have it, so you've got do that yourself.

> Back to the "where does the initialization go" problem...
>
> Thinking about it, this seems to be a case where a new-style i2c driver
> would help. As this is an embedded system, presumably you have some
> dedicated platform code running at boot. The new i2c infrastructure
> added by David Brownell would let you instantiate your lm63 device
> explicitly from the platform code. The advantage is that you then can
> pass an arbitrary structure containing initialization values to the lm63
> driver. In your case, this could include the PWM polarity, the
> conversion rate, the tachometer input / alert output setup, etc. This
> has all the advantages:
> * You have access to the lm63 driver facilities (register names, etc.)
> * Most of the setup code can go away after initialization if it is
>  tagged properly.
> * You don't define a user-space interface so it doesn't have to follow
>  any standard and can be changed later as needed.
> * You no longer rely on user-space for device initialization, so
>  nothing can go wrong if user-space doesn't come up for some reason.

It does have some disadvantages:
* The decision of how to configure the device must be done in the kernel, in
   the platform code that runs in the early bootup phase.  What if the proper
   setting is stored in a file, based on what fan the user connected?  Or
   depends on a hardware revision that's stored somewhere that's difficult to
   access from the kernel at this point in the boot process.  Say it's behind
   an FPGA, and the image for the FPGA is loaded from userspace after boot?
   It's far easier to get at and change configuration information from
   userspace than it is to compile it into the kernel.

* All the code to do this needs to be in the kernel, which is the hardest
   to keep in sync with new developments, because it changes the most.  An
   initscript with a bunch of cat commands is much less likely to stop working
   after changing kernels than a kernel patch is to no longer apply cleanly and
   work.  A lot more people have the skill to change a filename in a script
   than to update kernel patches.

* Nothing can be changed while the system is running.  Us developers need
   tools too.  I didn't add these controls because they were there, I added
   them because I wanted to change them.  There are other controls I didn't
   add, because I haven't cared about them.  If these controls are something I
   wanted to change, there is probably someone else who will too.

* And the big one.  Every time you want to change something, you need to
   compile and re-flash an entire new kernel!  If I want to tell someone the
   lm63 setup for their board with a different pwm connection setup, I can just
   give them an echo command to set it, with linux and sysfs.  If it's platform
   code (or vxworks) I have to compile an entirely new kernel for them to
   flash.  No one likes the vxworks way of doing things, and this would be
   re-creating that.  It's just a nightmare to work with, for development,
   maintenance and support.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
