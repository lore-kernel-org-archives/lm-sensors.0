From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6.12-rc2-mm3] i2c: modify lm87 to use auto fan_div
Message-Id: <20050417155954.6c42c43c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
In-Reply-To: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> Okay, what I have so far is fan_min set to zero, disable fan alarm, 
> no touch divider.

Yes, looks like the best thing to do.

> fan_min set too low, set to lowest value (div = 8, fan_min = 254), 
> this indicates to the user the lowest limit value for adm9240: 664.
> Since their fan is (mine was) running alarm not asserted, alarm will 
> be asserted if fan speed goes below min operating point --> correct 
> operation.

Interesting. I was doing almost that in w83627ehf before (setting
fan_min to 255 instead of 254, but still setting div to the max value).
What you propose here indeed makes sense. I would then suggest that we
do add a warning message as you proposed earlier (fan%u low limit %u
below minimum, setting to %u instead).

> fan_min set too high?  50000 -> fan_min, displayed back as something 
> like 42000 and alarm asserted :)  Takes a few measurement cycles to 
> recover fan speed display...  that's what you wanted?

Yes, that's what I wanted. "fan_min set too high" isn't a special case
IMHO. It is handled just fine by the regular code. As said earlier, if
the user asks for something stupid, he/she gets what he/she deserves. We
can't help.

> Not quite right yet...  
> 
> The rules seem to be don't auto-adjust fan clock divider unless 
> fan_min > 192, speed = 255 and div < max_div...

True, except that these are really two separate rules. "fan_min > 192"
is the rule when setting fan low limit, "speed = 255 and div < max_div"
is the rule when speed reading overflows.

Thanks,
-- 
Jean Delvare
