From: nemesis@icequake.net (Ryan Underwood)
Date: Fri, 17 Nov 2006 18:18:27 +0000
Subject: [lm-sensors] sensord and missing alarms
Message-Id: <20061117181827.GB10405@dbz.icequake.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061110190557.GA25801@dbz.icequake.net>
In-Reply-To: <20061110190557.GA25801@dbz.icequake.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Fri, Nov 17, 2006 at 01:45:43PM +0100, Jean Delvare wrote:
> 
> Not really, sorry. How can you be that interested in possible alarms
> that happened in the past, but you don't care about what value
> triggered it?

We want to catch the alarm so we can then check if the condition that
triggered it is still true, and if so, take action according to the
magnitude of the condition.

> Most chips (including the LM78 and the W83781D) have only
> one alarm bit for each channel, so you get the same alarm bit set for
> over-voltage and under-voltage, for example. And an alarm triggering
> because temperature is 1 degree C too high is quite different from the
> same alarm flag triggering because temperature reached 110 degrees C
> and your system is on fire.

Yes, but it draws attention to what componene needs attention.

> This is a completely different need, and one which is already covered
> by the drivers. If there is an out-of-range condition, then the alarm
> _is_ asserted. That's the other way around which may not be true for
> most chips.

It's asserted, but is cleared on read with some chips.  Then the
condition remains out of range, but the alarm is cleared.

> channel? The simple truth is that, if you are interested in past states,
> then your user-space application gets to repeatedly poll the sensor
> values, including alarm flags, and store whatever values you want for
> future use.

So in general, the alarms are useless and the application should simply
check the current value against the ranges always?

-- 
Ryan Underwood, <nemesis at icequake.net>

