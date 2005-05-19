From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6.12-rc2-mm3] i2c: modify lm87 to use auto fan_div
Message-Id: <12v261hdu6gqg68v4t4vmhvg1ekscjfuuj@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
In-Reply-To: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Sat, 16 Apr 2005 11:26:16 +0200, Jean Delvare <khali@linux-fr.org> wrote:

Second look as I modify the driver to suit your comments.

>Some comments on your coding style now, although the patch is quite hard
>to read (not sure there's anything you can do about this though).

I tried with and without 'p' diff option, would changing the number 
of context lines stop diff from 'merging' a replacement function?  No, 
it didn't -- would appreciate a cluebat on getting a better diff?

>"old" is only used for debug, so it should not be defined at all in
>non-debug mode.
I like the idea of saying we changed from 'old' to 'new'

>I don't much like your debug message. What about something like "fan%u
>clock divider changed from %u to %u\n"?
Done!
>
>> +	dev_dbg(&client->dev, "auto? fan%u div %u min %3u val %5ld spd %u\n",
>> +			nr + 1, 1 << data->fan_div[nr],
>> +			data->fan_min[nr],val,data->fan[nr]);
>
>Not sure that this debug message really helps. It's somewhat redundant
>with the more specialized ones below.
It really helps during testing with the ramping up and down the fan 
limit setting, to watch the register values being adjusted, removed. 
>
>> +	if (val <= 1350000 / (8 * 254)) {
>
>Wouldn't it be < instead of <=? By definition, if val = 1350000 / (8 *
>254) then a solution exists (divider = 8, register = 254, obviously).
Okay
>Also, 1350000 would be 1350000U, for consistency with the code below.
Okay
>Your debug messages are really cryptic. What about simply "fan%u low
>limit disabled"?
Done!
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
>
>Consider the case where the user asked for a low limit of 2630. new_min
>will be computed as 513, new_div as 0. First iteration of the loop,
>new_div becomes 1, new_min becomes 257. Second iteration of the loop,
>new_div becomes 2, new_min becomes 129. We're happy and leave the loop.
>The effective min limit is now (1350000 + (2 * 129)) / (4 * 129) = 2616
>RPM.
>
>Without the rounding now. First iteration of the loop, new_div becomes
>1, new_min becomes 256. Second iteration of the loop, new_div becomes 2,
>new_min becomes 128. We're happy and leave the loop. The effective min
>limit is now (1350000 + (2 * 128)) / (4 * 128) = 2637 RPM, which is
>nearer from 2630 than 2616 was.
And the other side of the same decision point: 255? 

>
>So I would drop the rounding effort altogether, as it makes code
>slightly slower and harder to understand with at best no benefit.
I prefer correctness in measurement systems, I think I'm correct here.

>If this results in a divider change, the debug message in the other
>function will tell.
You're right, I now detect change from 'disabled' mode and report
"fanX low speed limit enabled", complementary to the above 'disabled'.
>
>x is a *really* *poor* variable name. How are we supposed to guess what
>it represents?
Alright, deleted it altogether, sidestep the issue :)
>
>As explained earlier, I think you should do it even if data->fan_min[i]
>!= 255. Beware that it also means that fan low speed limit will need to
>be preserved.

Disagree: we already selected best fan clock divider when setting the 
low speed limit, cannot change it after that because we lose the alarm 
point resolution.  Adjusting operating point while a limit is set  
introduced problems in my testing, so I make a simple rule to define 
how the algorithm works.
>
>And as explained earlier, I don't think you should do that (decrease the
>divider). Increasing is needed, but decreasing isn't.

Disagree: when using a wide speed range fan user may prefer most 
accurate fan speed measurement reading.

It is the idea that user explicitly selects either fan low speed 
limit mode, or wants to monitor fan speed.

New patch as soon as compile check.  Still can't get a better looking 
diff, rearranging the code for a clean diff would be worse, no? :)

Cheers,
Grant.
