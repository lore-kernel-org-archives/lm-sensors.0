From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Oct 2010 10:02:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Add support for
Message-Id: <20101003120226.6dee377c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101002203250.773e1c3a@endymion.delvare>
In-Reply-To: <20101002203250.773e1c3a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Sat, 2 Oct 2010 17:50:58 -0700, Guenter Roeck wrote:
> Hi Jean,
> 
> On Sat, Oct 02, 2010 at 02:32:50PM -0400, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Fri, 17 Sep 2010 21:01:48 -0700, Guenter Roeck wrote:
> > > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > > ---
> > > This patch depends on the function reordering patch submitted earlier.
> > > 
> > >  drivers/hwmon/lm90.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++---
> > >  1 files changed, 84 insertions(+), 5 deletions(-)
> > 
> > I was about to test this patch on my ADM1032 evaluation board, and
> > suddenly realized that my new motherboard lacks a parallel port. Bummer.
>
> Good that I have a system with max6696 here, so I could test it.
> You might be able to get a usb to parallel port adapter for a few $ (or Euros).
> At least if you find one which works with Linux.

The cheapest I could find costs 13 €, and it's a no-name part and I
have no idea if it's supported by Linux or not. The cheapest part which
I know is supported by Linux is the Trendnet TU-P1284, which costs 17 €,
way more than I am willing to invest just for an old evaluation board.

I think I'll just boot an old machine for the tests, I don't run them
that often after all.

> > > diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> > > index 302d9eb..569f6be 100644
> > > --- a/drivers/hwmon/lm90.c
> > > +++ b/drivers/hwmon/lm90.c
> > > @@ -104,6 +104,13 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
> > >  	max6646, w83l771, max6696 };
> > >  
> > >  /*
> > > + * Maximum supported conversion rate register values per chip.
> > > + * If multiple register values reflect the fastest supported conversion rate,
> > > + * provide the lower value.
> > > + */
> > > +static u8 max_convrates[] = { 9, 10, 9, 9, 8, 8, 10, 7, 6, 8, 6 };
> > 
> > Should be const. Anyway I don't like this approach, as the order here
> > has to be the same as the order of enum chips or everything breaks, but
> > this isn't spelled out anywhere. Remember that you changed that order
> > not so long ago, it might happen again someday... I think it is overall
> > too fragile. This is also inconsistent with the way data->alert_alarms
> > is set in lm90_probe().
> > 
> Good point.
> 
> > I think we want to come up with a unified way to set per-chip
> > attributes, and stick to it. This could either be done with switch/case
> > in lm90_probe(), as we already have, or using a chips-indexed array of
> > property structures.
>
> I had thought about another switch/case in probe, but didn't like it because
> it is getting large.
> 
> I do like the idea of a chips-indexed structure. That could cover alarms, flags,
> and conversion rates.
> 
> One patch or two ? Seems to me that adding such a structure should be
> done in a separate patch.

Ideally, yes.

> > > (...)
> > > +{
> > > +	int i;
> > > +
> > > +	/* find the nearest update rate from the table */
> > > +	for (i = 0; i < ARRAY_SIZE(update_intervals) - 1; i++) {
> > > +		if (interval >= update_intervals[i]
> > > +		    || i >= max_convrates[data->kind])
> > 
> > This algorithm doesn't actually give you the nearest update rate. It
> > gives you the immediately lesser supported value. To get the nearest
> > supported value, you would have to compare with (update_intervals[i] +
> > update_intervals[i + 1]) / 2. Your current algorithm would give 8000 ms
> > is the user asks for 15000 ms, while 16000 ms is arguably a better
> > match.
> > 
> Good point. I'll use rounding instead. Should be
> 	update_intervals[i] - update_intervals[i + 1]) / 2
> though (-, not +).

+, sorry to insist. You want to compare the requested value with the
middle point between each supported value. See set_pwm_freq() in it87.c
for an example.

> 
> This results in the following cutover points.
> 
> 0..22		--> 10(15.875ms)
> 23..46		--> 9 (31.75ms)
> 47..93		--> 8 (62.5ms)
> 94..187		--> 7 (125ms)
> 188..374	--> 6 (250ms)
> 375..749	--> 5 (500ms)
> 750..1499	--> 4 (1s)
> 1500..2999	--> 3 (2s)
> 3000..5999	--> 2 (4s)
> 6000..11999 	--> 1 (8s)
> 12000..		--> 0 (16s)

Yes, looks good.

> > > (...)
> > > -	if (time_after(jiffies, data->last_updated + HZ / 2 + HZ / 10)
> > > -	 || !data->valid) {
> > > +	next_update = data->last_updated
> > > +	  + msecs_to_jiffies(data->update_interval) + HZ / 10;
> > 
> > We probably want to reconsider this HZ / 10. 100 ms on top of 500 ms
> > wasn't too noticeable. 100 ms on top of 31 ms or even 16 ms is way too
> > much.
> > 
> How about the following ?
> 
> 	next_update = data->last_updated +
> 		msecs_to_jiffies(data->update_interval + data->update_interval / 8)
> 
> I used /8 to avoid a divide operation. The old constant was 20% above
> the update interval. This is 12.5% above. Should still be ok, even for HZ0.

This should work fine, even though the rationale for such a formula is
hard to justify. The margin is to make sure the chip has the time to
complete its conversion and isn't interrupted by serial communications.
There is no technical reason I can see to make this safety margin
depend on the cache lifetime.

This isn't overly important though.

> Thanks a lot for the review!

You're welcome.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
