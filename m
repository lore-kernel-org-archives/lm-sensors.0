From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 02 Sep 2006 06:44:11 +0000
Subject: [lm-sensors] TODO: "dynamic" sysfs callbacks (plus 2D
Message-Id: <20060902084411.28cd01ad.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F88746.6090801@gmail.com>
In-Reply-To: <44F88746.6090801@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> Im hoping (against experience) that by doing these:
> 
> - identify drivers using macro repeated function defns
> - show how to find the lines to look at (the above grep)
> - discuss the technique ( 'dynamic' doesnt explain it, at least for me)

Agreed, a better name would probably have been "parametrized" or
similar, but for some reason we came up with "dynamic" originally.

> .. that I/we can lower the barrier to participation.
> The task is still somewhat harder than the average janitorial patch,
> (which may attract would-be hackers), and of course there are the
> testing / validation issues (must have hardware).

Sure, that'd be nice. Maybe you can really make it a kernel janitors
project? You might be more successful that way than by assuming that
people on the lm-sensors list will pick your plan and implement it. As
you said, experience suggests this won't happen, as much as we'd both
like it to change.

At any rate, this should only happen after we're done with the
unchecked return status changes, and preferably after the individual
alarm files are added, because these two changes have higher priority.

> <aside>  Testing by personal invitation has worked for me, at least once.
> Yuan Mu from Winbond took a compile-tested patch from me, and finished it.
> I aint too proud to beg ;-)  ..  (cues up some Rolling Stones ..)

Yep, sometimes it works, and that was nice.

> > As I mentioned earlier during the vt1211 review, I'm no big fan of this
> > approach. You end up aggregating many features which don't share much
> > code. It's still reasonable in your example above, but I think it has
> > gone to an extreme in one case in the vt1211 driver. Let's not jump
> > from one extreme to the other.
>
> As with everything else, its a judgement call -  Juerg used it for
> show_in, set_in, show_temp, set_temp, show_fan, set_fan, show|set_pwm
> He did not for many others.

Well the list above covers almost all the callbacks, only missing are
the automatic fan speed regulation and misc ones.

> In most places he did so, the combo-callback
> was still ~30 lines, a pretty good indicator of clarity.

True, the only one I think was not so nice was set_pwm, as it reaches
90 lines.

> Also, the 'assignment' of callbacks (by SENSOR_ATTR*) is hugely flexible;
> one could use a combo-callback to handle show-ops, but stick with 
> dedicated callbacks
> for store-ops.  This is perhaps subtle at 1st, but a 2 line comment 
> could address that.

I agree, that makes sense, as the show-ops are usually very simple, and
the store-ops usually more complex.

> > I do agree that having a single callback for displaying fanN_input and
> > fanN_min makes full sense, and this suggests a second level of
> > indexing. But beyond that point I think we have to be reasonable. I
> > don't mind for new drivers, authors should stay relatively free,
> > however I strongly object to converting all our perfectly working
> > drivers to use that approach.
>
> Uhm .. "strongly object" ?
> Is it your intent to discourage patches of this nature ?

Yes.

> (and by inference, other minor improvements ?)

No. The change proposed above is not a "minor improvement" by any mean,
it is a complete rewrite of the callback functions, for no technical
benefit that I can see.

To summarize my idea, I do encourage people to get rid of all the ugly
macros the older hardware monitoring drivers have, assuming they have
the hardware to test their change (or can find someone who does). I do
encourage them to use 1-index "dynamic" callbacks because they are
straightforward and do only require minimum changes. Going beyong that
requires larger changes, design decisions, and is more risky; not
something for newcomers.

> I know you've got bigger fish to fry ( conversion to platform, etc - 
> todo list forthcoming ? ;-)

Indeed. i2c core conversion to the driver model, unchecked return
values, i2c-isa/platform conversion, individual alarm files, all these
are big and have higher priority. People could help with some of these,
by the way.

> and that review of combo-callback conversions is a non-zero cost upon you,
> but surely you want to give objective incentives for folks to get involved.

If people really want to get involved, they will. If they are looking
for easy little changes to start with and learn how the kernel
development works, there are the kernel janitors and kernel mentors
projects for that, and I don't plan to duplicate their effort. I
couldn't afford it anyway.

> For my part, your acceptance of my previous work is a big factor in my
> hanging around here, and Id hope you'd regard those reviews as a 
> successful investment,

Sure I do, and I know that my reviews might sound harsh sometimes and
might discourage the newcomers. I try to explain my reasons everytime
so that it doesn't sound too arbitrary or personal. But well, we want
high quality code in the kernel, and we want code that follows
guidelines, some written, some unfortunately not.

I am also aware that my reviews are often delayed beyond what
contributors would like (see the vt1211 driver for an extreme example),
but my time and energy is limited. The only two ways around it are:
* I get paid for the reviews. Now that I am a Suse employee, it is
  partly true, but my main task there is L3 support, not kernel
  development, so I only have a few hours every month that I can use for
  kernel development. This month I used this time for the vt1211 review.
* Others help me with the reviews.
Ideally both would happen.

> beyond the X kB trimmed from 1 driver.  Even half-baked reviews (such as 
> the ones Ive offered) can result in brush-clearing (something our
> president is good at ;-)

Absolutely. I encourage everyone here to review other's patches. You
don't have to be me to do it, and every contribution in that area can
help lower my workload, which I think can only help the project.

> > I have been thinking of a "standard hwmon attribute" which would
> > combine our current sensor and sensor_2 attributes. I'll think again
> > about it after we are done with the unchecked return values.
> 
> interesting.  I played briefly with enums, but couldnt figure out how to 
> do it as a specialization/derivation of struct sensor_device_attribute.
> maybe anonymous unions have a place here..

enums don't have anything to do here, unions could. But my original
intent was just one simple structure which would fit all needs. The
idea came to me as I realized that the struct sensor_device_attribute_2
is _smaller_ than the struct sensor_device_attribute.

-- 
Jean Delvare

