From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: two questions about w83792d.c for linux-2.4
Message-Id: <0JKtpivv.1108980406.7209860.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190A90@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190A90@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> I think the reason most of my multipliers are less than 1 is that:
> The /proc/in0-in6 measured value keep such as (CR[20]*4 + CR[3E]&0x03)
> Which are different from the traditional one, because they are about 4
> times of CR[20]. While the /proc/in7-in8 only keep such as CR[B0]/
> CR[B1], so their multipliers are greater than 1.
> I explained it in my mail sent on 2005-02-18, please refer it.
>
> So my in0-in6 multipliers in sensors.conf is the quarter of the
> traditional one. If you multiply my multipliers of in0-in6 with the
> value 4, you will find that most of them will be greater than 1,
> except in0 and in1(0.8)
>
> The multipliers in sensors.conf is corresponding with the data sheet,
> You may check it. :-)

Hm, in fact I think the reason is more complex than that. I have read the
datasheet again. I do not deny that the final computations as shown in
"sensors" are correct, I think they are. But I think you do some
computations in sensors.conf that should be done in the driver
(ironically the exact opposite of the original problem).

What you do for now is export the raw register value (or combined
registers value for in0-6), with magnitude 2, so the value is divided by
100. That's what /proc files have: register values, possibly combined,
divided by 100. This is an arbitrary unit, it's not standard (standard
is Volts). You had to compensate in sensors.conf (* 0.2 for in0-1
because they have a resolution of 2mV, * 0.4 for other inputs because
they have a resolution of 4mV).

The values in /proc should really be Volts. If a /proc file reads 1.12 it
really must mean 1.12V at that pin of the chip, and not that the
register was holding value 112. User-space doesn't care about
implementation details nor register values, it wants standard values
expressed in Volts.

So what the driver should do is export the following value, e.g.:
(CR[20]*4 + CR[3E]&0x03) * 2, with magnitude 3

* 2 is because of the 2mV resolution, magnitude 3 (divide by 1000) for
milliVolts.

For in2-8, this would be * 4 instead of * 2, because LSB is 4mV.

That way you will really export values in Volts through /proc, which is
the standard. You will find that, after doing that, most compute lines
in sensors.conf are unnecessary. In fact you should only need such lines
for inputs which involve resistors (negative voltages, and positive
voltages greater than 2.04 or 4.08 V).

> OK, please refer to the following function, Is it what you need?

That's it. I could find why it doesn't work (I think). I also found
another bug:

>		if(nr <= 6){
>			vol_count = (vol_count << 2);
>			switch (nr)
>			{
>			case 0:  /* vin0 */
>				low_bits = (data->low_bits[0]) & 0x03;
>				break;
>			case 1:  /* vin1 */
>				low_bits = (data->low_bits[0]) & 0x0c;
>				break;
>			case 2:  /* vin2 */
>				low_bits = (data->low_bits[0]) & 0x30;
>				break;
>			case 3:  /* vin3 */
>				low_bits = (data->low_bits[0]) & 0xc0;
>				break;
>			case 4:  /* vin4 */
>				low_bits = (data->low_bits[1]) & 0x03;
>				break;
>			case 5:  /* vin5 */
>				low_bits = (data->low_bits[1]) & 0x0c;
>				break;
>			case 6:  /* vin6 */
>				low_bits = (data->low_bits[1]) & 0x30;
>				break;
>			default:
>				break;
>			}
>			vol_count = vol_count | low_bits;
>		}

You have a bug here. in0 and in4 will be OK, but in1, in2, in3, in5 and
in6 will not be. For example, in1 should be:

case 1:  /* vin1 */
	low_bits = (data->low_bits[0] & 0x0c) >> 2;
	break;

If you don't properly shift the 2 bits you extract, they won't be
placed at the right location when you add them ("|") to the main value
later.

>	} else if (operation = SENSORS_PROC_REAL_WRITE) {
>		if( *nrels_mag < 3 ){
>			return;
>		}

And the reason why you cannot write voltage limits is here, I think. It
should be "< 2", not "< 3" (or even "!= 2", since you obviously
expect exactly 2 parameters).

Thanks,
--
Jean Delvare
