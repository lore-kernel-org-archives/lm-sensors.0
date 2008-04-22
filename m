From: Trent Piepho <tpiepho@freescale.com>
Date: Tue, 22 Apr 2008 00:30:01 +0000
Subject: Re: [lm-sensors] [PATCH] LM63: Add controls for configuring device
Message-Id: <Pine.LNX.4.64.0804211631400.7949@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080412173221.7b2a2f41@hyperion.delvare>
In-Reply-To: <20080412173221.7b2a2f41@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 19 Apr 2008, Jean Delvare wrote:
> On Fri, 18 Apr 2008 15:45:43 -0700 (PDT), Trent Piepho wrote:
>> On Sun, 13 Apr 2008, Jean Delvare wrote:
>> Because the code that knows what needs to be set runs from userspace, after
>> the system has booted and the lm63 driver is loaded.  At that point you can't
>> set it with the firmware (if there was firmware) or platform code.  If the
>> setup needed in in a file, how can platform code read the contents of this
>> file?
>
> Maybe you're thinking the wrong way around? You start from the fact
> that you made the configuration data available to user-space only, and
> from that you conclude that we must find a way to program the LM63
> from user-space. You said that you were designing the system yourself,
> so presumably you have a lot of control over it. Can't you make it such
> that the configuration data is easily available from kernel-space, so
> that the hardware setup can happen where it belongs, in the kernel?

Well, no.  Making data available to the kernel on early bootup is *a lot*
harder than userspace.  What would you do, write a new bootloader that
had a flash filesystem driver that can mount a logging flash filesytem
(which is not fast to mount, since it has to be scanned) just to read a
config file and pass it to the kernel via some more firmware that would
need to be written to create a flattened device tree?  And even after
writing and debugging all this, you're still stuck with doubling your
bootup time by double-scanning the flash filesystem.

IMHO, doing system configuration later vs early is a better idea.  And
I'm not the only one who thinks so, from the initramfs docs:

 	The move to early userspace is necessary because finding and
 	mounting the real root device is complex.  Root partitions can
 	span multiple devices (raid or separate journal).  They can be
 	out on the network (requiring dhcp, setting a specific MAC
 	address, logging into a server, etc).  They can live on removable
 	media, with dynamically allocated major/minor numbers and
 	persistent naming issues requiring a full udev implementation to
 	sort out.  They can be compressed, encrypted, copy-on-write,
 	loopback mounted, strangely partitioned, and so on.

 	This kind of complexity (which inevitably includes policy) is
 	rightly handled in userspace.  Both klibc and busybox/uClibc are
 	working on simple initramfs packages to drop into a kernel build.

The direction the kernel is going, IMHO rightly, is to do as much system
configuration as possible from userspace.  The only system configuration
that needs to be compiled into the kernel is the minimum needed to get
userspace up, and things like initramfs are there to get to userspace as
soon as possible.

> have desktop users (or, more generally speaking, wide use) in mind. The
> result is that it took us several years to design a new interface that
> is desktop-application-friendly and update the whole code accordingly.
> I'm just trying to avoid making the same mistake again.

By creating a desktop-application-friendly interface to begin with, or by
not having an interface at all?

>> But it seems that you're of the option that nothing that is primarily aimed at
>> hardware developers or embedded systems is acceptable.  I do not see how one
>> can possibly develop embedded systems under those conditions.
>
> You are free to use local patches that help you during development.

It would have helped me even more if the code was already there because
the last person who needed it sent it upstream.

>>> Of course the underlying I2C adapter and its driver have to support
>>> this. I2C block read isn't too widely supported, the other two are.
>>
>> Hmm, sounds like a lot of trouble.  I'm pretty sure that the i2c block read
>> will work for me, but what if the adapter doesn't support it?  It looks like
>> the smbus layer doesn't emulate it for you with read_byte_data(s) if the
>> adapter doesn't have it, so you've got do that yourself.
>
> Indeed, the smbus layer doesn't emulate it for you, and I am glad it
> doesn't! There are no semantics attached to the I2C transactions, so
> arbitrarily replacing a big one by several shorter ones would be plain
> wrong. In your case it may happen that an I2C block read of length N is
> equivalent to N SMBus byte reads, but for other devices both might
> produce different results.

I was thinking of i2c_smbus_read_i2c_block_data(), not arbitrary i2c
transactions.  You have your basic smbus register read, were the master
sends the register address then does a repeated start and reads a byte. 
That's one of the specific i2c transactions that smbus documents, and all
some controllers and/or drivers support.

Now, a great many i2c/smbus devices have an auto incrementing index
register, so if you read another byte you get the next register, and so
on.

So, one could have a function called "read contiguous block of smbus
registers", which is something a lot of drivers do, even if they just
code it as a bunch of random reads.  This function would use the most
efficient transaction(s) supported by the controller, which could get all
the registers one multi-byte read, or do individual smbus byte reads for
each register, or two bytes at a time, depending on the controller's
abilities.

>> It does have some disadvantages:
>> * The decision of how to configure the device must be done in the kernel, in
>>    the platform code that runs in the early bootup phase.  What if the proper
>>    setting is stored in a file, based on what fan the user connected?  Or
>
> The settings which depend on what fan is connected (e.g. pwm1_freq)
> have sysfs files. That's something we already agreed upon. The
> remaining settings, which I say should go in the platform code and you
> say shouldn't, are things which only depend on hardware settings, which
> the user can't change. For this reason I don't see the problem of
> setting these things up in the kernel.

No so.  For instance, pwm control and fan speed monitoring are mutually
exclusive.  If the device is an a server room, fan noise may be
irrelevant and monitoring fan operation with SNMP or something of that
nature might be desirable.  On the other hand, if the device is on a
user's desk, quieting a noisy fan could by of the utmost importance and
an the user is unlikely to have or care to use some network device health
monitoring system.

So you see, fan1_enable depends not just on the fan connected, but where
the device is located.  How can one compile the device's location and the
user's sensitivity to noise into the kernel?

> I just don't get that. You only need to add platform data if there is
> new hardware. I can't believe that someone would be skilled enough to
> design and build new hardware, but wouldn't be able to add 3 lines of
> kernel code and flash the new kernel.

You'd be surprised at the changes a prototype undergoes during
development and the different jobs of the people who want it to do
something with it.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
