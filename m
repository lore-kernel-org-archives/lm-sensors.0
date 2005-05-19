From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6] I2C: New hardware monitoring driver: w83627ehf
Message-Id: <20050417100430.2b674c82.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050416201701.7e4a5e74.khali@linux-fr.org>
In-Reply-To: <20050416201701.7e4a5e74.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> > I now have:
> >
> >	if (!val) {
> >		/* No min limit, alarm disabled */
> >		data->fan_min[nr] = 255;
> >		new_div = data->fan_div[nr]; /* No change */
> >	} else if ((reg = 1350000U / val) >= 128 * 255) {
> >		/* Speed below this value cannot possibly be represented,
> >		   even with the highest divider (128) */
> >		data->fan_min[nr] = 255;
> >		new_div = 7; /* 128 = (1 << 7) */
> >	} else {
> >		/* Automatically pick the best divider, i.e. the one such
> >		   that the min limit will correspond to a register value
> >		   in the 96..192 range */
> >		new_div = 0;
> >		while (reg > 192 && new_div < 7) {
> >			reg >>= 1;
> >			new_div++;
> >		}
> >		data->fan_min[nr] = reg;
> >	}
> >
> > Looks OK now?
> 
> Yes, but is the (!val) test needed?  I'd merge it with next test 
> like so:
> 	if (val < 1350000U / (128 * 254)) {
> 
> as same end result is to store 255 to fan_min.

This is the test I had in the first place, and as I said earlier, it
fails to catch val = 41. 1350000U / (128 * 254) = 41, so 41 < 41 is wrong
and we'll enter the "else" clause, which will do 1350000U / 41 = 32926,
then divide as much as possible (128) down to 32926 / 128 = 257, which
hardly fits in an 8-bit register.

A quick fix would be to use <= instead of < (like you did in your first
lm87 patch, and I shouldn't have objected to that point, sorry). This
works in this case but I am not able to prove if it works in the general
case. At least, by testing (reg = 1350000U / val) >= 128 * 255, I am
sure it filters out exactly the cases the "else" clause wouldn't handle.
I believe it is worth the additional test.

Also note that in my new proposal, the "!val" case does *not* do the
same as the second case, which is why I didn't merge them. In the "!val"
case I do not change the divider, while in the second case I force it to
128. That's slightly different from your lm87 approach where you don't
change the divider in either case. My point was that someone asking for
a very low but non-zero limit would probably do so for a reason, which
would be a very slow fan, so setting the fan min to 128 is probably the
right thing to do. That being said, I do not think that any fan can
reasonably run below 60 RPM anyway, so in the case of the w83627ehf (or
any chip with fan clock divider up to 128), it probably makes very
little difference. In the lm87 case where the max divider is 8, it does.

I do agree that the other part of the automatic fan clock divider
selection code will tend to the correct divider anyway, so you might be
right. What about this then?

	if (!val || (reg = 1350000U / val) >= 128 * 255) {
		/* Speed below this value cannot possibly be represented,
		   even with the highest divider (128) */
		data->fan_min[nr] = 255;
		dev_dbg(dev, "fan%u low limit and alarm disabled\n", nr + 1);
	} else {
		/* Automatically pick the best divider, i.e. the one such
		   that the min limit will correspond to a register value
		   in the 96..192 range */
		new_div = 0;
		while (reg > 192 && new_div < 7) {
			reg >>= 1;
			new_div++;
		}
		data->fan_min[nr] = reg;

		/* Write the new divider if it changed */
		if (new_div != data->fan_div[nr]) {
			/* Preserve fan speed reading */
			if (new_div > data->fan_div[nr])
				data->fan[nr] >>= (data->fan_div[nr] - new_div);
			else
				data->fan[nr] <<= (new_div - data->fan_div[nr]);

			data->fan_div[nr] = new_div;
			w83627ehf_write_fan_div(client, nr);
			dev_dbg(dev, "fan%u clock divider set to %u\n",
				nr + 1, div_from_reg(data->fan_div[nr]));
		}
	}


Note that I dropped the last parameter of w83627ehf_write_fan_div() as
it was redundant and error-prone. I also added some debugging messages,
like you did for lm87.

Thanks,
-- 
Jean Delvare
