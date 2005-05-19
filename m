From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: driver for mic184 chip
Message-Id: <20050129105334.742d2e81.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41FAB35E.1050208@aeroflex.com>
In-Reply-To: <41FAB35E.1050208@aeroflex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frank,

> This chip is from Micrel (http://www.micrel.com/_PDF/mic184.pdf) and
> is a local/remote thermal supervisor. The data sheet states "This
> device is a pin-for-pin and and software compatible upgrade for the
> industry standard LM75." While this is true, the LM75 driver failed
> to work as we needed when I tested with it. Since we had an older
> (kernel 2.4.25) driver that did work, I chose to bring it forward
> instead of debugging/modifying the LM75.

This wasn't the correct choice IMHO. We avoid duplicating code when
possible. It would be better to understand why the lm75 driver doesn't
work, and fix that. Since the chips are supposedly compatible, I would
suspect that the problem is only the detection method. It checks three
different things:

1* that unused bits in the configuration register are clear;

2* that the registers cycle over 8-byte boudaries;

3* that addresses 0x04-0x07 aren't real registers, and instead always
   return the last read (real) value.

While this heavily relies on the hardware implementation of the chip
rather than its specifications, it has proven to be very reliable, at
least for the original LM75 chip, which is by far the most used, even
though no other hardware monitoring chip ever had that many clones.
Anyway, we hardly have any other choice since the LM75 chip and clones
do not offer any dedicated identification register, and can be found on
a wide, common address range.

I guess that the MIC184 at least fails the unused bits test in the
configuration register, since it does actually use them. Also, since it
seems that one of the additional bits in the configuration register is
actually a status register, it might change, so the register cycling
trick could fail too if you are in bad luck - providing that the
registers cycle at all, which should be verified first.

You might use i2cdump to check how the MIC184 reacts to unexpected
register reads (above address 0x03), so that we can see if it behaves
like the original LM75 in that respect or not.

The MIC184 datasheet isn't exactly clear about the additional bits of
the configuration register. I think I understand that bit 5 switches to
the external temperature sensor and bit 6 disables the interrupt output,
while bit 7 would be the status bit. Is that it? I cannot find a clear
detailed view of the configuration register.

> I would like to know what is broke about the config register (unless
> I sent you the wrong version) because I have in fact used it. By
> default the config register gets loaded with 0x60 (I don't recall what
> all this configures but it is the default we have used forever) and
> when our application prepares to use it we set it to 0x40.

The set_temp_conf if defined thanks to the set macro. If you expand it,
it will read:

static ssize_t set_temp_conf(struct device *dev, const char *buf, size_t count)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct mic184_data *data = i2c_get_clientdata(client);
	data->temp_conf = TEMP_TO_REG(simple_strtoul(buf, NULL, 10));
	mic184_write_val(client, MIC184_REG_CONF, data->temp_conf);
	return count;
}

The use of the TEMP_TO_REG conversion macro on the configuration
register value is unlikely to lead to anything valid.

I'm surprised about the default value of 0x60 you mention, because the
datasheet says 0x00 is the default. If the value of 0x60 was set by the
BIOS for example, it might be wiser to update the BIOS to write the
value you want (0x40) than to do so afterwards at the OS level.

BTW, what system do you have this MIC184 chip on?

> Additional features include (beyond the LM75): remote temp
> measurement and interrupt status and mask bits for sw polling.
> If no one needs it, that is fine. Just trying to contribute back.

Well, the first question would be, do *you* need it? Until further
notice, you are probably the only user of the MIC184 chip with a linux
system. So if you do not personally need the extra features, there is no
point in implementing them.

Even if you do, the configuration of the chip depends on the way the
chip is wired together on the board (whatever it is) and as such depends
on the BIOS. This is the reason why no hardware monitoring driver in the
linux 2.6 kernel offers an interface to that kind of configuration. We
might offer module parameters (not sysfs interface) to workaround
critical BIOS bugs such as an improper fan polarity configuration, but
that's about it.

In your specific case, it seems that you could use i2cset to reprogram
the chip if updating the BIOS isn't an option. They you should be able
to load the lm75 driver with the "force" parameter and it would work
fine, as far as I can see. So I think you could go without a separate
driver, and even without modifying the lm75 driver.

Don't get me wrong, I really like when people contribute back code they
wrote or modified. It just happens that I don't think you are doing the
right thing here. For one thing having a separate driver for the MIC184
sounds overkill. For another, exposing the configuration register to
userspace doesn't sound sane (e.g. changing the interrupt polarity or
disabling interrupts could lead to hardware damage). Configuration
belongs to the BIOS because it supposedly knows how the chip is wired,
while the driver doesn't.

What we would accept is an update to the lm75 driver that makes it
recognize the MIC184 chip, providing that the detection method is
reliable enough not to cause misdetections. As a side note, your
detection routine for the MIC184 (taken from the datasheet if I'm not
mistaken) wouldn't be accepted because it is destructive (you are
writing to the registers as part of the detection, which would lead to
unpredictable results if the chip happened *not* to be a MIC184). You
must find a way to detect the MIC184 chip without writing to the
registers. Note that we don't really need to differenciate between the
MIC184 and LM75 chips, because they are compatible and the differences
are of no importance to the driver code, so the detection method
provided by Micrel isn't what we really need here. What is really
important is to not misdetect a completely different chip as being a
MIC184/LM75. This is why we tried to sharpen the LM75 detection code as
much as possible.

> I am looking at the ADM1030/1031 driver currently and having some
> issues with it that I need to resolve. It appears that no tested it
> or only had limited configurations for it.

I tested it personally, and so did Alexandre d'Alton (we wrote the
driver together), and it appeared to work rather fine for both of us.
Please let us know the problems you are having and we'll take a look.
The driver is admittedly rather new, so it might not have received as
wide a testing as the other drivers did. These two ADM chips aren't
exactly simple and we might have missed corner cases.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
