From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6] I2C: New hardware monitoring driver: w83627ehf
Message-Id: <jv74615pf9kfkvv1br3k5523ce34ft37hp@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050416201701.7e4a5e74.khali@linux-fr.org>
In-Reply-To: <20050416201701.7e4a5e74.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Sun, 17 Apr 2005 10:04:30 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>Hi Grant,
>> Yes, but is the (!val) test needed?  I'd merge it with next test 
>> like so:
>> 	if (val < 1350000U / (128 * 254)) {
>> 
>> as same end result is to store 255 to fan_min.
>
>This is the test I had in the first place, and as I said earlier, it
>fails to catch val = 41. 1350000U / (128 * 254) = 41, so 41 < 41 is wrong
>and we'll enter the "else" clause, which will do 1350000U / 41 = 32926,
>then divide as much as possible (128) down to 32926 / 128 = 257, which
>hardly fits in an 8-bit register.
>
>A quick fix would be to use <= instead of < (like you did in your first
>lm87 patch, and I shouldn't have objected to that point, sorry). This
>works in this case but I am not able to prove if it works in the general
>case. At least, by testing (reg = 1350000U / val) >= 128 * 255, I am
>sure it filters out exactly the cases the "else" clause wouldn't handle.
>I believe it is worth the additional test.

Right now I have:

        if (val <50000U / (8 * 254)) {

                if (data->fan_min[nr] < 255) { /* report mode change */
                        data->fan_min[nr] = 255;
                        dev_dbg(&client->dev, "fan%d low speed limit "
                                        "disabled\n", nr + 1);
                }
                new_div = 3;

        } else { /* calculate optimum fan clock divider to suit new fan_min */
                unsigned int new_min = 1350000U / val;
                new_div = 0;

                while (new_min > chop_point && new_div < 3) {
                        new_div++;
                        new_min++;
                        new_min >>= 1;
                }

                if (data->fan_min[nr] = 255) { /* report mode change */
                        dev_dbg(&client->dev, "fan%d low speed limit enabled\n",
                                        nr + 1);
                }
                data->fan_min[nr] = new_min;
        }

        if (new_div != data->fan_div[nr]) {
                data->fan_div[nr] = new_div;
                adm9240_write_fan_div(client, nr, new_div);
        }

'chop_point' is set via a write only accessor, lowering the 'chop_point'
from 192 looks promising -- but I post another email I been writing on 
testing.  soon.

No errors or unexpected surprises, I'm still evaluating the rounding :)
Just went back in before I read this email.  

(val <50000U / (8 * 254)) test is need in conjunction with half-bit 
rounding.  The reasom I did this was without it this looked like an 
off-by-one where the read-back didn't match the set, it is slow work 
at two seconds per trial :)

I can replace <= with < as long as I remove half-bit rounder as well, 
they go as a pair, just checking the drift between set and read fan 
limit due to lowered resolution.  

Chop points of 64, 96 or 128 looking promising, 32 still works, but 
that is register val going to 4 with div=8, very low resolution. 
>
>Also note that in my new proposal, the "!val" case does *not* do the
>same as the second case, which is why I didn't merge them. In the "!val"
>case I do not change the divider, while in the second case I force it to
>128. That's slightly different from your lm87 approach where you don't
>change the divider in either case. My point was that someone asking for
>a very low but non-zero limit would probably do so for a reason, which
>would be a very slow fan, so setting the fan min to 128 is probably the
>right thing to do. That being said, I do not think that any fan can
>reasonably run below 60 RPM anyway, so in the case of the w83627ehf (or

My design was based on bidirectional non-limit adjustment, but I put 
max divider back in on too low as it matches expectations, if I'm 
surprised then what of end-user?  

60rpm: What about the next generation case with the 40cm fans on the 
side? :)

>any chip with fan clock divider up to 128), it probably makes very
>little difference. In the lm87 case where the max divider is 8, it does.

All my testing today (after bugfix to you and Philip) is with the 
auto divider changer disabled.  One thing at a time.  

This is more a discovery of what is possible, I watch what happens 
to register values.

>
>I do agree that the other part of the automatic fan clock divider
>selection code will tend to the correct divider anyway, so you might be
>right. What about this then?
>
>	if (!val || (reg = 1350000U / val) >= 128 * 255) {
>		/* Speed below this value cannot possibly be represented,
>		   even with the highest divider (128) */
>		data->fan_min[nr] = 255;
>		dev_dbg(dev, "fan%u low limit and alarm disabled\n", nr + 1);
>	} else {
>		/* Automatically pick the best divider, i.e. the one such
>		   that the min limit will correspond to a register value
>		   in the 96..192 range */
>		new_div = 0;
>		while (reg > 192 && new_div < 7) {
>			reg >>= 1;
>			new_div++;
>		}
>		data->fan_min[nr] = reg;
>
>		/* Write the new divider if it changed */
>		if (new_div != data->fan_div[nr]) {
>			/* Preserve fan speed reading */

Changing the divider does not change the indicated fan speed ??
Providing you wait for the change to go to the chip and back...

>			if (new_div > data->fan_div[nr])
>				data->fan[nr] >>= (data->fan_div[nr] - new_div);
>			else
>				data->fan[nr] <<= (new_div - data->fan_div[nr]);
>
>			data->fan_div[nr] = new_div;
>			w83627ehf_write_fan_div(client, nr);
>			dev_dbg(dev, "fan%u clock divider set to %u\n",
>				nr + 1, div_from_reg(data->fan_div[nr]));
>		}
>	}
>
>
>Note that I dropped the last parameter of w83627ehf_write_fan_div() as
>it was redundant and error-prone. I also added some debugging messages,
>like you did for lm87.

I made a boo-boo in that, took out one too many parenthesis when I 
lifted the code from another driver.  So further suggestions from 
me will come from what I test here: adm9240 or w83627hf.

Cheers,
Grant.
