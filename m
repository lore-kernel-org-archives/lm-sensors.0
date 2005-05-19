From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: PATCH: lm92: port for 2.6 kernel
Message-Id: <0IIb1n9Y.1109612982.0408570.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <422318E5.4000201@katalix.com>
In-Reply-To: <422318E5.4000201@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi James,

> > Damn. I have done the exact same work one week ago... I have set a link
> > to my patch on our "Supported Devices" page, but maybe I should have
> > advertised more about it. I'm really sorry we duplicated the work.
>
> When do you plan to push the work to the 2.6 kernel?

Right after you have confirmed it works for you. My driver is supposed to
be finished, it really only needs testing.

> Is there a BitKeeper kernel tree for I2C changes?

Yes, Greg KH's bk-i2c tree.

> I thought the I2C devices pulled data from devices as a byte stream.

They do.

> Don't the i2c_smbus_[read|write]_word_data() routines pass the u16
> data in little endian format because that's the endian of the SMbus?

Not exactly. The bytes arrive LSB first, but the i2c bus drivers then
convert the word to the endianess of the system. At least they are
supposed to, those who don't are broken, if any.

> Surely if swab16() is used rather than cpu_to_le16(), different values
> are passed to the xxx_word_data() routines depending on cpu endian?

No, since the conversion is done by the bus drivers. The only reason why
swab16 is used is because the chips do not respect the SMBus specs (with
good reasons, but still...)

> My CPU is a ppc. On big endian CPUs, cpu_to_le16() and swab16() are
> equivalent. It's little endian CPUs that I'm worried about...

swab16 (or equivalent) has been used in lm_sensors since 1999 or so, and
like 95% of the lm_sensors users are on x86, so you really shouldn't
worry about them, they are working just fine ;)

> The I2C bus driver is a mv64x60 (Marvell Discovery). The driver was
> recently written by Mark Greer. I'm cc'ing him on this.

I partly reviewed Mark's code, IIRC. It was rather good so I would not
suspect it. Anyway I think I made it clear that there is no endianess
bug at all.

> Looking at other drivers, they put different chip names into sysfs
> even though the drivers work in exactly the same way for each chip.
> So why not LM92?

Not so many do. lm90, adm1025 maybe... any other? It happens that I wrote
both drivers, and added several "types" for otherwise siilar chips,
against the majority's opinion, back then (I was new to the project). I
have made up my mind though, for a reason given right below.

> I think it's really useful to identify the exact chip name now that it's
> easy to do so with 2.6.

It wasn't difficult with 2.4 either, that I can see. But you can printk
the name of the chip if you want, it doesn't really have to make it
into sysfs.

> In fact I was going to submit another patch to differentiate the
> 6633/6634/6635 devices too.

That's a different matter since the MAX6633 and MAX6634 are not exact
clones of the LM92. Possible addresse ranges differ, and some functions
are missing. Reliable differenciation promises to be complex, BTW. I
wasn't planning to add support for the MAX6633 and MAX6634 yet, not
until someone really needed it. We never had any report for these chips.
Same goes for the LM76 (we only had one report and it was a home made
design under linux 2.4 IIRC).

> Why does the libsensors code care what the chip is called? It knows the
> driver name from the /sys/bus/i2c/drivers/xxx directory entry...

I invite you to take a look at the libsensors code. You'll find out that
libsensors is really stupid. It is not currently able to parse the sysfs
directories and find out the chip features on its own. Instead, each
feature of each chip must be individually listed. This explains the size
of both libsensors and the sensors program

Yes, this is a pity, but originally the library was really only handling
two chips, not 100+ like it does now. The whole thing needs a full
rewrite, but I'm out of time.

> Well lm90 has 4 other compatible devices. The driver puts those chip
> names out into /sysfs... Why make another rule for lm92?

As said above the lm90 isn't the correct example to follow. Actually it
would be the exception, not the rule. And I am not exactly proud of it.

> The /sys/bus/i2c files should be as accurate and meaningful as possible.

Sure it should. And libsensors should be rewritten to be freed of any
chip-dependant stuff. And the sysfs interface for sensors should be made
totally free of chip-dependant stuff. And all of these must be done in
the reverse order, so this is a long way to go. Feel free to contribute
:)

Thanks,
--
Jean Delvare
