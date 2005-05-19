From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6.12-rc2-mm3] i2c: modify lm87 to use auto fan_div
Message-Id: <h2q161t2d3btdi8sbq3d67t36pp98g90re@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
In-Reply-To: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Sat, 16 Apr 2005 11:26:16 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>Hi Grant,
>
>> A common problem for end users is setting the fan clock divider for 
>> correct operation.  This patch removes fan_div sysfs write accessor 
>> and implements an automatic fan clock divider selection strategy.
>> 
>> Two states are possible: if the user specifies a valid minimum low 
>> speed alarm limit that will set an appropriate fan clock divider, 
>> otherwise the driver will seek to a fan clock divider that gives 
>> best resolution for current fan speed.
>
>While I like the idea of an automatic selection of the fan clock divider
>by the driver, I don't think that your implementation is correct.
>
>If there is a low limit set, you do not take the actual speed
>measurement into account for divider selection. What if the limit has
>been set significantly higher than the actual fan speed? This speed

This is the issue I was chasing in data-loss -- we assume user knows 
what they want and set the divider appropriately, the fan may yet 
to be installed.  IMHO this is correct operation.  If the fan stops 
we report an alarm.  Alarm status is always valid in this model.

>cannot be measured, and the driver won't adapt the divider. Since the
>BIOS typically sets an arbitrary low speed limit (or the chip itself has
>a power-up default), you have the very same problem as with the original
>model where the user needs to change the divider manually before he/she
>can get a reading. In other words, your driver modification fails to
>address the problem.

User either does:

	nothing:	who cares?

	sets a limit:	we accept their command, alarm status is correct 
			even if the driver cannot display fan speed

	set 0 limit:	User is telling us to just display the fan speed,
			thus driver may change divider in either direction, 
			I want this feature as it makes sense for wide 
			operating range thermal fans I use.  Because the 
			machine with that fan has no fan speed controller 
			in software.

>The fan clock divider increase upon unreadable fan speed (lower than the
>current divider allows) must happen regardless of the low limit being
>set or not. If not, then the driver modification isn't worth the effort.

No, I don't think you see the issue.

>I also believe that the measured fan speed should not possibly lead to a
>divider decrease. Decreasing the divider will require a min limit
>register change in the general case, which will result in rounding at
>best, plain loss of limit at worst.

No, explained above

>The model I am using for the upcoming w83627ehf driver is as follow:
>
>1* When the fan speed register reads 255 (overflow), try increasing the
>divider if possible.
Until you go one step too far??
>
>2* When the user sets a low limit, pick the best divider for this speed,
>where best is defined by "register value between 96 and 191". This
>ensures that all speeds over the limit can be read with a reasonable
>accuracy, and speeds down to 75% of the low limit as well.

I do that, same numbers
>
>The advantages are:
>
>1* If the user doesn't configure the chip, he/she will still get valid
>readings (providing that there is a fan connected, of course) after a
>limited number of tries.
No point, if an alarm limit is specified and the fan runs slow, that is 
an alarm. FULL STOP -- as long as the alarm flag is correct it does not 
matter if the fan speed is not displayed.  So under these conditions we 
certainly MUST NOT change user limit point.  No point having an alarm?
>
>2* If the user does configure the chip, he/she will set the low limit,
>and get the best divider (providing that he/she picks a reasonable
>limit, of course).
>
>3* It is guaranteed by design that the fan clock divider can only change
>a limited (and low) number of times after it has been loaded or the fan
>low limit has been changed.
>
>Your implementation fails to provide points 1 and 3.

It does not.  You have it backwards, as I did for some time, se below 
on measurement resolution issue.

>Some comments on your coding style now, although the patch is quite hard
>to read (not sure there's anything you can do about this though).
>
>> +	u8 reg, old, shf = (nr + 2) << 1;

>Please use explicit variable names. "shf" is a poor name. A comment
>would also be very welcome, as the value you set it to isn't exactly
>obvious.
I have a bad habit of lining up names by size, so I pick 3 letter 
names for temps, I'll go to one letter temps?  CodingStyle. :)
>
>> +	reg = lm87_read_value(client, LM87_REG_VID_FAN_DIV);
>> +	old = (reg >> shf) & 3;
>> +	reg &= ~(3 << shf);
>> +	reg |= fan_div << shf;
>> +	lm87_write_value(client, LM87_REG_VID_FAN_DIV, reg);
>> +	dev_dbg(&client->dev, "autoX fan%u old %u new %u   fan_div changed\n",
>> +			nr + 1, 1 << old, 1 << fan_div);

I don't have a non-debug mode, the user selects that from kernel 
menuconfig??  I make assumption on that...  

>I don't much like your debug message. What about something like "fan%u
>clock divider changed from %u to %u\n"?

Too frigging long on the screen, I use 96 column terminals -- was 
looking at this display updating once every 2 seconds for days... :)
>
>> +	dev_dbg(&client->dev, "auto? fan%u div %u min %3u val %5ld spd %u\n",
>> +			nr + 1, 1 << data->fan_div[nr],
>> +			data->fan_min[nr],val,data->fan[nr]);
>
>Not sure that this debug message really helps. It's somewhat redundant
>with the more specialized ones below.

It tells what the driver sees, can go now if you don't want to 
check operation of the thing.

>> +	if (val <= 1350000 / (8 * 254)) {
>
>Wouldn't it be < instead of <=? By definition, if val = 1350000 / (8 *
>254) then a solution exists (divider = 8, register = 254, obviously).

I get correct operation on ten times overange, divider goes to zero.

>Also, 1350000 would be 1350000U, for consistency with the code below.
okay

>
>> +		data->fan_min[nr] = 255; /* too low, disable alarm */
>> +		dev_dbg(&client->dev, "auto! fan%u div %u min %3u too low\n",
>> +				nr + 1, 1 << data->fan_div[nr],
>> +				data->fan_min[nr]);
>
>Your debug messages are really cryptic. What about simply "fan%u low
>limit disabled"?

Because I shrank the messages and lined them up for data collection.

>
>> +	} else {
>> +		/* calculate optimum fan clock divider to suit fan_min */
>> +		unsigned int new_min = 1350000U / val;
>> +		u8 new_div = 0;
>> +
>> +		while (new_min > 192 && new_div < 3) {
>> +			new_div++;
>> +			new_min++;
>> +			new_min >>= 1;
>> +		}
>
>I understand that new_min++ is for rounding purposes, but it doesn't
>sound good to me, because of cumulated errors.

It does not accumulate errors.  It is the same half bit rounding used 
elsewhere.

>Consider the case where the user asked for a low limit of 2630. new_min
>will be computed as 513, new_div as 0. First iteration of the loop,
>new_div becomes 1, new_min becomes 257. Second iteration of the loop,
>new_div becomes 2, new_min becomes 129. We're happy and leave the loop.
>The effective min limit is now (1350000 + (2 * 129)) / (4 * 129) = 2616
>RPM.

Considering particular case is stupid because of the translation 
through the chip, rarely does the displayed value match the 
setpoint, nature of the beast, your setting numbers to 1/3000 
resolution through a system with 1/254 resolutiuon.

>Without the rounding now. First iteration of the loop, new_div becomes
>1, new_min becomes 256. Second iteration of the loop, new_div becomes 2,
>new_min becomes 128. We're happy and leave the loop. The effective min
>limit is now (1350000 + (2 * 128)) / (4 * 128) = 2637 RPM, which is
>nearer from 2630 than 2616 was.

See above

>So I would drop the rounding effort altogether, as it makes code
>slightly slower and harder to understand with at best no benefit.

It is there because it works.  

>> +		dev_dbg(&client->dev, "auto- fan%u div %u min %3u\n",
>> +				nr + 1, 1 << new_div, new_min);
>
>"fan%u min register set to %u"?
>
>If this results in a divider change, the debug message in the other
>function will tell.
can go, was when I was debugging decision point, which now you 
cannot see because I removed some of the instrumentation 
already


>> +				/* if fan_min off: auto fan clock divider */
>> +				if (data->fan_min[i] = 255) {
>> +					int x = 0;
>
>x is a *really* *poor* variable name. How are we supposed to guess what
>it represents?
the variable is alive for three decisions half a screen of code, 
gimme a break.

>As explained earlier, I think you should do it even if data->fan_min[i]
>!= 255. Beware that it also means that fan low speed limit will need to
>be preserved.

No.  Not correct, we been there done that.

If I pull the instrumentation, that means nobody else can verify correct
operation.  What then?

Cheers,
Grant.


