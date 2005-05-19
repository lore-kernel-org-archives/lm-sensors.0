From: drewie@freemail.hu (Andras BALI)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: lm77 on national sc1100
Message-Id: <1089026358.32259.55.camel@null>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2004-07-05 at 11:57, Jean Delvare wrote:

> I reviewed your code, it's overall good but there are a few things that
> should be fixed before submitting it to Greg:

> 1* Address range is 0x48-0x4b.

Agreed & fixed. 

> 2* Detection code could be simplified/accelerated:

> >  for (i = 0; i <= 0x1f; i++)
> >    if ((i2c_smbus_read_byte_data(new_client, i * 8 + 1) != conf) ||

> I think we better do i+=8 instead of multiplying by 8 each time.

Agreed & fixed.

> >  if (((swab16(cur)  >> 12) != 0xf && (swab16(cur)  >> 12) != 0x0) ||

> This is expensive for no benefit. you can check (cur&0x00f0) directly.

Agreed (and ashamed :-) ) & fixed.

> >  cur = i2c_smbus_read_word_data(new_client, 0);
> >  if (i2c_smbus_read_word_data(new_client, 6) != cur ||
> >      i2c_smbus_read_word_data(new_client, 7) != cur)
> >                goto exit_free;

> Doesn't look safe to me. We don't know exactly if 6 and 7 return the
> last read value or the value of the last read register. The latter
> sounds much more probable, and since current reading may change, it's
> not safe. Better rely on limit registers (like you do right after).

I actually tested this, and 6 and 7 return the last read value, not the
value of the last read register.

> > static void lm77_init_client(struct i2c_client *client)
> > {
> > 	/* Initialize the LM77 chip */
> > 	lm77_write_value(client, LM77_REG_CONF, 0);
> > }

> It's a bit agressive. I think there's only one bit which really needs
> to be cleared, correct?

From the datasheet:

D0: Shutdown - when set to 1, the LM77 goes to low power shutdown mode.
Power up default of 0.
D1: Interrupt mode - 0 is Comparator Interrupt mode, 1 is Event
Interrupt mode. Power up default of 0.
D2, D3: T_CRIT_A and INT polarity - 0 is active low, 1 is active high.
Outputs are open-drain. Power up default of 0.
D4: Fault Queue - when set to 1, the Fault Queue is enabled. Power up
default of 0.

Since the power up default is 0x0 for the whole configuration register,
maybe this whole initialization can be skipped. What do you think?

> One more important issue with your driver is the hyst limit. For the
> LM77, it is a relative value which applies to all 3 limits. This
> doesn't quite fit into our standard intefrace, where all limits must be
> absolute. This means that you have to change your driver to provide the
> following interface files:

> temp1_crit_hyst
> temp1_min_hyst
> temp1_max_hyst

> The first one would be RW, while the two others would be read-only (since
> there is a single register in hardware).

I understand that the current interface operates with absolute limits,
but are you sure that the hysteresis should be treated the same way as
temperature limits? The way I see it, hysteresis is not a limit, but
rather a "delay", a relative value per se. Quoting Webster:

  Hysteresis (n): A lagging or retardation of the effect, as if 
   from velocity or internal friction; a temporary resistance to
   change from a condition previously induced, observed in magnetism,
   thermoelectricity, etc., on reversal of polarity.

It's just my $0.02 - I think it makes more sense if it's kept as a
relative value (and the interface is more sensible this way, IMHO). But
I'm not a native English speaker, nor do I know much about physics and
stuff like this, so please feel free to correct me. And I can of course
make the change, if you don't agree.

> Oh, and I almost missed it: it really has to be temp1_min and _max, not 
> _low and _high.

Agreed & fixed.

Thanks,
Andras

