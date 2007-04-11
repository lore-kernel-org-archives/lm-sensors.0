From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Apr 2007 11:35:35 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <20070411133535.0dcb0750@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans,

On Mon, 09 Apr 2007 14:26:06 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > I guess that the motherboard ID can be retrieved in user-space using
> > dmidecode, can't it? So it might not even be needed to export it.
> 
> Nope, the motherboard ID used by the chip is a 16 bit unsigned int, not some 
> kinda string like dmidecode gives.

I didn't mean the 16-bit number itself, just one way to uniquely
identify the motherboard model.

> > This is absolutely not different from all other hardware monitoring
> > drivers. And all other drivers handle it in user-space, because that's
> > the right design. I see no valid reason why it would be different for
> > your abituguru3 driver. All you need is one configuration file per
> > motherboard.
> 
> Actually it is _very_ different. The uguru is not a chip, its more a piece of 
> software (looking from the driver POV) then a chip, thus sensors which aren't 
> there really aren't there, they are not just unconnected pins, they _really_ 
> aren't there.

You don't have to convince me that Abit "chips" are crap, I know that
already ;)

More seriously, I'm sorry but I just can't see the difference. Other
hardware monitoring chips can have pins used for different functions.
Their drivers have to create the sysfs files which match the hardware
reality, and they do it in a motherboard-independent way. Your
abituguru3 driver must do the same. If you can't get the wiring
information from the hardware (or embedded software), this a major
design flaw from Abit, or the price to pay for writing a driver for an
undocumented device.

Remember how I told you months ago that I did not want us to support
undocumented chips because I knew it would be painful? Here you are.

> And afaik some drivers have magic and or module options to not generate 
> generate certain sysfs entries in certain cases, this is no different.

What kind of "magic" are you thinking of? Many drivers are reading
their configuration registers to find out wiring information, but
there's nothing magic about that.

The only module options we have that change which sysfs entries are
created are:
* uch_config in the vt1211 driver, which I didn't like, and I don't
think anyone is actually using it.
* extra_sensor_type in the gl520sm driver, which I didn't like either,
and I don't think anyone is actually using it.
In both cases, the parameter is there just in case the BIOS failed to
properly initialize the device, and should otherwise never be needed.

Oh, and of course the abituguru driver has lots of module parameters to
control a whole lot of things. But you know about that one already ;)

Anyway, the main point here is that none of our drivers include
motherboard-specific information. Except hdaps, granted, and it is a
pain to maintain, which is why I don't want other drivers to do the
same.

> Also this is they way how Abit handles this. The windows software comes with an 
> ini-files, each named with the hex value of the ID, and that is used to 
> determine how to talk to the uguru (which addresses to use) and what to ask.

So they have a user-space tool which reprograms the driver depending on
the ID. This is quite different from what you proposed, isn't it?

> Last but not least, this way (with libsensors-support and/or dyn chip support), 
> the experience is truely plug and play, isn't that what we want in the end?

What we want is not to have to update the kernel drivers each time a
new motherboard is released. Of course, the less effort is needed from
the end user, the better, but this doesn't mean everything is in the
driver. This might as well mean a better infrastructure in user-space,
which is exactly what some of your students have been, and are, working
on.

> The same argument could be made for PCI ID tables in the kernel for hardware 
> not essential to booting (or through ramdisk, even for boot essential hardware) 
> why have the PCI-id's in the kernel? Why not have them in userspace and always 
> use the new_id sysfs files?

This is an interesting point. I see two main differences though.
Firstly, as you wrote, the PCI ID tables are needed at boot time for a
number of drivers. Once the infrastructure is in place, the overhead to
extend its usage to all PCI devices is thin, so it would be stupid not
to do it. Secondly, PCI ID tables are listing devices, not motherboards.

That being said, new PCI IDs can already be quite painful. If you look
at the patches that we've been taking for the popular SMBus master
drivers (i2c-i801, i2c-viapro, i2c-nforce2, i2c-piix4) over the past
few years, you'll see that most of them are simply adding new PCI IDs.
If the new_id sysfs file was more broadly used, it wouldn't take a new
kernel to support these new devices. OTOH, the real problem here is that
manufacturers should stop giving new PCI IDs to 100% compatible
devices, it's useless :(

> Again the same argument could be made for blacklists / whitelists for many 
> things in the kernel. There always is a trade-off, between putting this info in 
> the kernel or in userspace. You yourself agreed, that given the limited amount 
> of motherboards featuring the uguru, it might even be an idea to add an export 
> a dmi-info-table with the supported motherboards to the driver, how is this 
> different?

I seem to remember that I agreed that the abituguru driver could check
that the motherboard maker was Abit using the DMI data. I don't
remember what my opinion was on a complete DMI table as the hdaps
driver has. Either way, my point was to make sure that the driver
wouldn't cause trouble is loaded on a system without an uGuru chip.
There's a major difference between identifying the motherboard and
embedding motherboard-specific configuration information inside the
driver. With the approach you are advocating, I fear that pretty much
every problem we might encounter (bug in the feature defintions, new
motherboard model, new revision of a supported motherboard model,
etc...) will take a driver update to solve. This is what I would like
to avoid.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
