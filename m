From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 19 Nov 2013 17:53:51 +0000
Subject: Re: [lm-sensors] Ticket #2382
Message-Id: <20131119175351.GA16693@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <528A62DC.9030107@baymicrosystems.com>
In-Reply-To: <528A62DC.9030107@baymicrosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 19, 2013 at 06:18:57PM +0100, Jean Delvare wrote:
> Hi Guenter, Mike,
> 
> On Tue, 19 Nov 2013 08:38:40 -0800, Guenter Roeck wrote:
> > On Tue, Nov 19, 2013 at 10:04:08AM -0500, Mike Gilbert wrote:
> > > 
> > > Guenter,
> > > 
> > > We're evaluating the new card in a open chassis. It is on the test
> > > bench with a table fan for cooling. I turned off the fan and got:
> > > 
> > >     ENTER show_temp
> > >     cpu 0 (0)
> > >     status_reg @ 19C
> > >     eax = 885E0000 edx = 0
> > >     temp = 1770 valid = 1
> > >     EXIT show_temp
> > > 
> > > It seems like you've seen this before. What's going on?
> > 
> > No, I was just throwing darts at a wall with my eyes closed.
> 
> Oh, you thought that was a wall? :D
> 
> > Seriously, it was just a wild guess. Idea was that the valid bit may be 0
> > if the temperature is too low to be even remotely close to the maximum.
> 
> That was my theory in ticket #2382, indeed. It was never tested until
> today I think, thanks Mike for doing that.
> 
> > For this chip, just to give you an example, the datasheet says that any
> > reported temperature below 50 degrees C only means that the temperature
> > is below 50 degrees C.
> 
> That's a start... I didn't know it was documented. Is it documented for
> all CPU models? If we can gather the values at least for all affected

Uuh ... I didn't say it was documented. If it is, I don't know about it.
As I said, it was just a wild guess.... even without reading your comment
on the ticket.

> Atom CPU models (as I suppose the value will vary per model) we could
> tweak something in the driver.
> 
> > Jean, any idea what we can do about this ? Report X degrees C (some constant
> > below TjMax) if valid is 0 ?
> 
> Well well, we don't really have a sane way to transmit the information
> ("temperature is below X") down to the monitoring applications. The
> sysfs interface has no provision for it, libsensors wouldn't handle it
> and "sensors" wouldn't either, of course.
> 
> We could hard-code an arbitrarily low temperature as you suggest,
> however I'm not sure if we want to do it for all CPU models or only the
> ones listed in ticket #2382. My concern is that the Intel specification
> doesn't limit "valid = 0" to too low temperature values. They don't
> give any detail, so assuming that "too low" is the only reason seems
> weird. I remember we saw transient errors on coretemp readings in the
> past, but I can't remember if that was on these Atom models (i.e. just
> another incarnation of ticket #2382) or other CPU models. I'm afraid we
> may start reporting temperature values instead of actual errors if the
> fix-up is too broad.
> 
> Either way, the current situation is rather bad, as "N/A" looks more
> like "it's broken" than "it's cold". So I have no objection to crafting
> "something" into the driver to make it look better, if you are
> motivated to give it a try.
> 
> If you are even more motivated and want to extend the sysfs to properly
> report the situation to user-space, feel free to do that as well. I
> volunteer to review any kernel patch related to this, and to write the
> user-space code to deal with it. I'm just not sure it's worth the
> effort for just 3 CPU models.
> 
I'd rather go with an exception table, or rather extend the existing tables.
It is probably somewhat safe to assume that the problem applies to all CPUs
with the same model/mask. Based on that we could declare a "tjmin" and
report that if it is 1) defined and 2) the valid bit is 0. A somewhat "safe"
temperature to report for the D5xx (model 0x1c/mask 10), based on Mike's
numbers, would then be 36 degrees C (100 - 64).

If you are ok with that I'll submit a patch for it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
