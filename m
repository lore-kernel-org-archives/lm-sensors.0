From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: lm77 on national sc1100
Message-Id: <200407050957.i659vCHS018613@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>> Next steps:
>> 1* Update detection in lm75 driver and docs (CVS/2.4).
>> 2* Update detection in lm75 driver and docs (2.6).
>
>I see in the CVS that the detection in the 2.4 module has
>already been updated. Should I port it to the 2.6 module,
>or has someone else already done that?

I already did, sorry for not CC'ing you.

>> 3* Complete your lm77 driver and submit it for integration into Linux 2.6.
>
>Attached is a new version that has improved detection (mostly based on
>the sensors-detect script). It works here (and I see no reason why it
>shouldn't work at anywhere else), but could use some testing, especially
>against lm75 sensors.
>
>Please let me know what else can I help to get this driver into the
>kernel.

I reviewed your code, it's overall good but there are a few things that
should be fixed before submitting it to Greg:

1* Address range is 0x48-0x4b.

2* Detection code could be simplified/accelerated:

>  for (i = 0; i <= 0x1f; i++)
>    if ((i2c_smbus_read_byte_data(new_client, i * 8 + 1) != conf) ||

I think we better do i+=8 instead of multiplying by 8 each time. That's
what I did for the LM75.
http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.7-mm5-i2c-lm75-detect.diff

You can also start at i=8.

>  if (((swab16(cur)  >> 12) != 0xf && (swab16(cur)  >> 12) != 0x0) ||

This is expensive for no benefit. you can check (cur&0x00f0) directly.

>  cur = i2c_smbus_read_word_data(new_client, 0);
>  if (i2c_smbus_read_word_data(new_client, 6) != cur ||
>      i2c_smbus_read_word_data(new_client, 7) != cur)
>                goto exit_free;

Doesn't look safe to me. We don't know exactly if 6 and 7 return the
last read value or the value of the last read register. The latter
sounds much more probable, and since current reading may change, it's
not safe. Better rely on limit registers (like you do right after).

> static void lm77_init_client(struct i2c_client *client)
> {
> 	/* Initialize the LM77 chip */
> 	lm77_write_value(client, LM77_REG_CONF, 0);
> }

It's a bit agressive. I think there's only one bit which really needs
to be cleared, correct?

The lm75 driver would benefit a similar change.

One more important issue with your driver is the hyst limit. For the
LM77, it is a relative value which applies to all 3 limits. This
doesn't quite fit into our standard intefrace, where all limits must be
absolute. This means that you have to change your driver to provide the
following interface files:

temp1_crit_hyst
temp1_min_hyst
temp1_max_hyst

The first one would be RW, while the two others would be read-only (since
there is a single register in hardware). Oh, and I almost missed it: it
really has to betemp1_min and _max, not _low and _high.

Please update your code to code to comply with my remarks.

Thanks,
Jean Delvare
