From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 03 Oct 2010 12:43:36 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Add support for
Message-Id: <20101003124336.GA30184@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101002203250.773e1c3a@endymion.delvare>
In-Reply-To: <20101002203250.773e1c3a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Oct 03, 2010 at 06:02:26AM -0400, Jean Delvare wrote:
[ .. ]
> > > I think we want to come up with a unified way to set per-chip
> > > attributes, and stick to it. This could either be done with switch/case
> > > in lm90_probe(), as we already have, or using a chips-indexed array of
> > > property structures.
> >
> > I had thought about another switch/case in probe, but didn't like it because
> > it is getting large.
> > 
> > I do like the idea of a chips-indexed structure. That could cover alarms, flags,
> > and conversion rates.
> > 
> > One patch or two ? Seems to me that adding such a structure should be
> > done in a separate patch.
> 
> Ideally, yes.
> 
Already working on it.

> > > > (...)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	/* find the nearest update rate from the table */
> > > > +	for (i = 0; i < ARRAY_SIZE(update_intervals) - 1; i++) {
> > > > +		if (interval >= update_intervals[i]
> > > > +		    || i >= max_convrates[data->kind])
> > > 
> > > This algorithm doesn't actually give you the nearest update rate. It
> > > gives you the immediately lesser supported value. To get the nearest
> > > supported value, you would have to compare with (update_intervals[i] +
> > > update_intervals[i + 1]) / 2. Your current algorithm would give 8000 ms
> > > is the user asks for 15000 ms, while 16000 ms is arguably a better
> > > match.
> > > 
> > Good point. I'll use rounding instead. Should be
> > 	update_intervals[i] - update_intervals[i + 1]) / 2
> > though (-, not +).
> 
> +, sorry to insist. You want to compare the requested value with the
> middle point between each supported value. See set_pwm_freq() in it87.c
> for an example.
> 
Umm .. time for some thinking.

The output below was created with a test program which uses '-'.
Ok, I know what is different. I didn't use ().

Let's see.

	ui[0] = 16000, ui[1] = 8000

	(ui[0] + ui[1]) / 2 = 24000/2 = 12000
	ui[0] - ui[1] / 2 = 16000 - 8000/2 = 12000

and with ui[i+1] = ui[1]/2:

	(ui[1] + ui[i]/2) / 2 = ui[1]/2 + ui[i]/4 = ui[i] * 3 / 4
	ui[i] - (ui[1]/2)/2 = ui[i] - ui[1]/4 = ui[i] * 3 / 4

So we are both right ;). I'll use your version - it looks a bit cleaner to me.
I'll also get rid of the table - it _is_ really unnecessary.

> 
> > > > (...)
> > > > -	if (time_after(jiffies, data->last_updated + HZ / 2 + HZ / 10)
> > > > -	 || !data->valid) {
> > > > +	next_update = data->last_updated
> > > > +	  + msecs_to_jiffies(data->update_interval) + HZ / 10;
> > > 
> > > We probably want to reconsider this HZ / 10. 100 ms on top of 500 ms
> > > wasn't too noticeable. 100 ms on top of 31 ms or even 16 ms is way too
> > > much.
> > > 
> > How about the following ?
> > 
> > 	next_update = data->last_updated +
> > 		msecs_to_jiffies(data->update_interval + data->update_interval / 8)
> > 
> > I used /8 to avoid a divide operation. The old constant was 20% above
> > the update interval. This is 12.5% above. Should still be ok, even for HZ0.
> 
> This should work fine, even though the rationale for such a formula is
> hard to justify. The margin is to make sure the chip has the time to
> complete its conversion and isn't interrupted by serial communications.
> There is no technical reason I can see to make this safety margin
> depend on the cache lifetime.
> 
Good point. Guess I have too much tendency to not changing behavior once in a while.
A better option would be to use 
	next_update = data->last_updated
			+ msecs_to_jiffies(data->update_interval) + 1;

Should still be good enough, because it still guarantees that the chip can complete
at least one conversion.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
