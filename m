From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 04 Nov 2005 06:30:52 +0000
Subject: [lm-sensors] Re: [PATCH] lm93 driver for 2.6
Message-Id: <20051104053037.GB30472@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051028182339.23792.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20051028182339.23792.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

> Rudolf Marek wrote:
> > This patch provides driver for lm93.
(snip)

* Jean Delvare <khali@linux-fr.org> [2005-11-01 16:09:57 +0100]:
> Here's my review of it.
> 
> A general comment first. Some code in this driver does not appear to
> have been taken from Mark Hoffman's driver. Even for the part that has
> been, it would probably be worth checking the CVS log for Mark's
> driver. There have been several fixes to it since the first version,
> and these fixes may apply to the 2.6 version of the driver too. Same
> goes for the documentation (I just committed minor fixes to the lm93
> documentation file, BTW).
> 
> Second, no matter how many hours I spent on this, this really only is a
> *quick* review. This driver is a monster. The chip design is very
> complex, I just can't read all the code in deep details. Seriously, who
> needs this complexity? I wouldn't trust a chip which needs a 70 kB

Well, the guys that paid for it needed it. 

> driver to work properly when it comes to monitoring my hardware and
> controlling its cooling. It's the largest hwmon driver we have, by far.
> 
> I'm serious. I would very much enjoy a smaller driver with only the
> features users actually need. I can't believe anyone really needs to
> finetune the chip to the possible extent.

There is probably a small subset of the existing driver that will satisfy
most users.  We could add a CONFIG option that defaults to turning off
all of the detailed ("non-standard") fan control options.

> Is anyone willing to be the maintainer for this driver if it is
> integrated into Linux 2.6? I will not be maintaining this thing myself,
> that wouldn't be serious.

I will help to maintain it, but I don't actually have a LM93 to test on.

(snip)

> > +LM93 Unique sysfs Files
> > +-----------------------
> > +

(snip many unique files)

> I'm really worried about this. So many non-standard file names! I
> understand that some features are non-standard and deserve non-standard
> names, but some features here are standard as far as I can see.
> temp<n>_auto_base, temp<n>_auto_offset[1-12] and
> temp<n>_auto_offset_hyst could be changed to fit in the standard
> auto-pwm interface. Some other names (fan<n>_smart_tach,
> pwm<n>_auto_spinup_min, pwm<n>_auto_spinup_time) could be discussed to
> become part of the standard interface, as other chips have similar
> functionalities.

As they say... in for a dime, in for a dollar.  The LM93 clearly has many
features that aren't even addressed by the proposed fan control standard.
I thought it was agreed that as long as the non-standard names do not
interfere with the standard ones, it's all good.

> If nobody is willing to work on this, then at least I would like the
> lm93 driver to come with a big fat warning that the interface is not
> standard and subject to change without notice anytime in the future.

I'm not sure what is the point.

(snip: /etc/sensors.conf example)

> This belongs to userspace, I don't want this in the kernel
> documentation. I would suggest to drop that part from the 2.4
> documentation file as well. Why not add this to sensors.conf.eg like
> all other chip drivers do?

Agreed.

(snip)

> > +/* min, max, and nominal register values, per channel (u8) */
> > +static const u8 lm93_vin_reg_min[16] = {
> > +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xae,
> > +};
> > +static const u8 lm93_vin_reg_max[16] = {
> > +	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> > +	0xff, 0xfa, 0xff, 0xff, 0xff, 0xff, 0xff, 0xd1,
> > +};
> > +
> > +/* min, max, and nominal voltage readings, per channel (mV)*/
> > +static const unsigned long lm93_vin_val_min[16] = {
> > +	0, 0, 0, 0, 0, 0, 0, 0,
> > +	0, 0, 0, 0, 0, 0, 0, 3000,
> > +};
> > +static const unsigned long lm93_vin_val_max[16] = {
> > +	1236, 1236, 1236, 1600, 2000, 2000, 1600, 1600,
> > +	4400, 6500, 3333, 2625, 1312, 1312, 1236, 3600,
> > +};
> 
> This all suggests that 

That what... ?

(snip)
> > +static u8 lm93_block_buffer[I2C_SMBUS_BLOCK_MAX];
> > +
> > +/*
> > +	read block data into values, retry if not expected length
> > +	fbn => index to lm93_block_read_cmds table
> > +		(Fixed Block Number - section 14.5.2 of LM93 datasheet)
> > +*/
> > +static void lm93_read_block(struct i2c_client *client, u8 fbn, u8 *values)
> > +{
> > +	int i, result=0;
> > +
> > +	for (i = 1; i <= MAX_RETRIES; i++) {
> > +		result = i2c_smbus_read_block_data(client, 
> > +			lm93_block_read_cmds[fbn].cmd, lm93_block_buffer);
> > +
> > +		if (result = lm93_block_read_cmds[fbn].len) {
> > +			break;
> > +		} else {
> > +			dev_warn(&client->dev, "lm93: block read data failed, "
> > +				 "command 0x%02x.\n", 
> > +				 lm93_block_read_cmds[fbn].cmd);
> > +			mdelay(i + 3);
> > +		}
> > +	}
> > +
> > +	if (result = lm93_block_read_cmds[fbn].len) {
> > +		memcpy(values,lm93_block_buffer,lm93_block_read_cmds[fbn].len);
> > +	} else {
> > +		/* <TODO> what to do in case of error? */
> > +	}
> > +}
> 
> lm93_block_buffer should be local to lm93_read_block.

You're right about that.  I didn't want to put something so big on the stack,
but as it's written now, it's broken if there's more than one LM93 in a system.

(snip)

> Anyone willing to review the code is welcome to do so. It's so large
> that it would be very surprising that no bug are left it.

Of course I can't promise there aren't bugs, but I have to point out...

Do you remember the great testing that David Knierim did?  His employer
was the sponsor for this driver.  I may be biased, but I suspect that the
LM93 driver (in CVS, anyway) has seen more (and more rigorous) testing than
any of the others, despite its size and complexity.

> We also need someone to test this code in deep, on a real LM93 chip,
> before we can put this in Linux 2.6.

I imagine Eric did that?  Otherwise why would he port it?  Would it be
enough if I reviewed it closely?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

