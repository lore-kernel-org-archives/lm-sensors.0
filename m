From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 27 May 2005 16:57:32 +0000
Subject: [lm-sensors] Query: what chance to get scaled voltages into
Message-Id: <IRmSuesY.1117205327.0127340.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <b6qc91dgk33k2ucv21du0aqsqbk3egj389@4ax.com>
In-Reply-To: <b6qc91dgk33k2ucv21du0aqsqbk3egj389@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Couple months back I was terribly confused over vid being scaled
> within drivers, other voltages scaled in user-space, then discover
> that internally scaled values were in fact not being scaled as per
> sysfs documentation in driver but in user-space.

VID is not scaled, it is decoded.

Also, not all internally scaled values are scaled in user-space. All the
chips those inputs are all internally scaled have kernel-space scaling.
The problem is with the chips for which only a few inputs are internally
scaled (usually because these inputs are also power sources for the
chip).

Thinking about it, I am not even sure this is a problem we want to fix.
Mixing scaled and unscaled values within the same driver is likely to
make this driver more complex. Did you try?

> Seem too late to fix that,

I think so, yes.

> (...) and lmsensors not only ppl to get it wrong,

It took me 4 tries to understand what this sentence means.

> Windows SpeedFan reports 5.5V for 5VSB 'cos they not grok
> datasheet tell different dividers for each 5V.

Totally unrelated. Did you try to contact Alfredo about this issue? Maybe
he would fix it.

> What I'm thinking of is inX_scale, read returns scaled value, write
> sets scale factor, driver will know how to do negative offset given
> negative scale factor.

This wouldn't comply with the sysfs rules. From
Documentation/fs/sysfs.txt:

  "When writing sysfs files, userspace processes should first read the
  entire file, modify the values it wishes to change, then write the
  entire buffer back.

  Attribute method implementations should operate on an identical
  buffer when reading and writing values."

As I understand this, having different values for read and write
oprerations is not welcome.

Not really sure about what you mean with "negative offset given negative
scale factor", but I'd guess user-space knows just as much as the
driver does.

> By making it a parallel option, we don't break existing user-space.

True, but...

> This idea worth trying or forget it?

... you are trying to solve a minor problem with a rather invasive
solution. OK, some scaling is done externally where it should -
according to rules we defined ourselves, and which I don't think are
written anywhere - be done internally. This isn't causing any problem
by itself. We could as well change the rule and say that a given driver
should either scale all voltages internally, or all externally, whatever
is best according to its own specificities. Miracle, all drivers now
comply with the rule (which qualifies as a de facto standard, BTW).

> Reason I ask is winbond series have three different internal scaling
> for 5V and 5VSB, which is driver knowledge,

It is as much driver knowledge as user-space knowledge. The knowledge
comes from the datasheets and is just where we decide to put it. The
fact that different chips use different scaling factors can be handled
very easily in /etc/sensors.conf. There is no immediate need to rework
any driver for this.

> (...) and drivers could default
> to manuf. recommended dividers, also driver knowledge.

Basically you are trying to get the drivers to do all the scaling work
for all inputs, at the price of one or two additional interface files
for each input. I don't see the benefit. The historical reason why
scaling was done internally by certain drivers is because the cost to do
so was rather low and the benefit seemed to be worth it. If I should
write a driver for such a device today, I'm not even sure I would do
internal scaling. Reporting voltages at the ADC input is no less
meaningful than reporting voltages at the chip pins, and this approach
would make the drivers more similar, while also complying better with
the rule which state that kernel drivers should not convert data.

> (...) Other chips
> also depend on user-space scaling what 'should' have been done in
> driver per documentation.

This sentence doesn't make immediate sense to me. Whatever, you should
really provide concrete examples (or even a complete list) when stating
that something is broken.

> BTW: there are only 630 discrete resistor ratios from 1.2:1 to 10:1
> using E24 resistor series.  But that's a user-space thingy to generate
> 'compute' lines for sensors.conf.  I can do that instead.

Given that (24*23)/2 is 276, 630 isn't possible. Typo? Anyway, E24 being
given at +/- 5%, I don't think this is going to help. MDS suggested
that using E96 series would make much more sense (but then there are so
many discrete ratio that we won't get anywhere either.)

> Since something needs doing in documentation / drivers / sensors.conf.eg
> I'd like some idea of most acceptable path to follow, I've scratched my
> particular itch with voltage calibration, dunno if anyone else cares :)

We care, but there is no real technical problem. The major problem is a
lack of cooperation from the motherboard manufacturers (and even before
that their failure to follow the recommended wirings and resistor values
when these exist). This is a relationship and management problem, not
one which you can solve with patches. We are trying to get the
manufacturers to cooperate, but this is a very slowly process. Any help
is welcome.

Additional note:
It would be really helpful if you could keep your posts focused on a
particular point. This one had no less than 4 different topics. Also, I
invite you to review your posts before actually sending them. Broken
sentences really don't help. I do review my own words before I post,
most of the time. You may think it wastes your time, but keep in mind
that there is only one poster and many readers, and this is how you
increase the chances that your posts will get the feedback you hope for.

Thanks,
--
Jean Delvare
