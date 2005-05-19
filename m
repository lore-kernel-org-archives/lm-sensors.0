From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: driver design question
Message-Id: <20030729103909.55d59307.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030728153714.7b09e0b7.khali@linux-fr.org>
In-Reply-To: <20030728153714.7b09e0b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> >Is there any way values can be written to the driver's register
> >without telling us?
> 
> I think any other communication with the chip which isn't through our 
> driver (Bios? or some other code?) might change the values, although
> it is unlikely.

No other code should. If they do, they are bad, not us. As for the BIOS,
is there any BIOS code running after boot time? I would have said no,
but you seem to think the other way.

Of course, one can use i2cset to write some arbitrary value to any
register, and break the driver if it is designed my way, while it
woudln't if designed your way. But someone doing so has to know what
he/she does, isn't it? I2cset is meant for developing/debugging
purposes, not regular use.

> It's also possible that a driver may be misdetected or forced.
> It would be odd if the driver gave misleading 'correct'
> limit readings in these cases.  I don't think it is worth the risk.

As I was proposing, we still can read the limit back once, at the time
we write it at first (and any later time we change it) so if it really
is wrong (such as the register is read only) we'll see it exactly the
same way we would with the current policy. As far as I know, the chips
only seldom, if ever, change their R/W registers on their own, except at
init time (none of our business) and reset (this could happen, I admit,
but shouldn't after module init). So the only two errors I can think of
if the chip isn't what it is supposed to be are writing a limit to a
read only register (which can be handled as described right above) and
hitting some reset register or bit, which is likely to show the same way
(reading the value back probably won't be what was expected) and will
have other side effects the user will probably notice.

All these are problems caused by the driver being used with wrong
hardware, which will not work anyway. It looks like we "optimize" our
drivers for the very very few cases were the things go bad. I don't
pretend we must ignore problems and remove error checking from our code
;) but still I believe we should optimize the working, not the faulty.

One thing I'm strongly thinking of is disabling the limit readings
*unless* the module is loaded with any force parameter (still mainly
thinking of my ADM1025/NE1619 driver). This makes the secure path back
in case a user is forcing the driver, but makes the driver faster for
regular users.

> In a nutshell, I think lower level drivers which talk to hardware 
> shouldn't do any internal caching or optimizing which isn't nessesary.

And I don't quite agree. We are already caching since we limit the
frequency at which new data can be obtained. Also, note that I don't
advocate in favor of caching too much. For example, one could think of
caching VID readings since it's unlikely to change after boot time,
still I think it could in some cases (I guess Speedstep technology and
the like could want to change that value) so we have to "sample" it
continuously. I just want to limit what I consider useless re-readings,
(mainly limits).

> I.e., when values are asked for, it should talk directly with the
> hardware to ask for them and not make any assumptions.

I understand your point of view. I think it's motivated by the fact that
you are a developer (I am too BTW ;)) and you must love the idea of
watching whatever happens to the internal registers of every chipset in
your computer. I love playing with them too, don't doubt it :) But what
about the end-user? He/she wants an efficient driver. He/she event just
wants temperature, etc. readings. The fact that a driver is required for
that, and how the driver does it, is far beyond his/her interest.

Again, I don't mean we can do anything that would make the driver
faster, at any cost. I don't want speed. I want efficiency.

> Now, for user-space apps, it could be more justifiable to cache or 
> assume values.  At least, I'd rather see those sorts of hacks done in 
> user-space than kernel driver space.

OK, maybe I see what you mean now, but I think you're missing something.
At the time being, the user-space applications cannot cache a given set
of values and refresh only the rest, because most of our drivers, if not
all, have a single update function. If *one* value is queried and the
data isn't up-to-date, *all* values are refreshed. This is the reason
why I want to limit what is refreshed.

(Next paragraph is me thinking while writing, not necessary very clear,
feel free to plain skip or ask for better explanations)
We could think of splitting all values into groups for separate
refreshes, but it ain't that obvious. The groups would be "vertical"
(understand: current values form one group, limits form one group...)
from the driver's point of view, while they would be "horizontal"
(understand: in0, in0_min and in0_max form one group...) from user-space
(because for example reading /proc/dev/sys/.../in0 needs these three
values). Or we can have individual refreshed (that is, each group only
has one value in it), but considering you need one timestamp per group,
it will be really painful. What's more, I think most applications will
read all values at a time, which justifies there is a single update
function in our drivers. This is how I came to the idea of not reading
the limits as being the better optimization one could think of.

> For this paricular issue (if we are trying to optimize speed or
> limit transaction numbers over the I2C bus), it doesn't buy
> anything so it is a moot point.

I guess the I2C bus isn't overloaded by our drivers, for sure ;) On the
other hand, speed (I prefer the term of quickness or reactivity) could
be discussed. For example, running "sensors" on my desktop system takes
about 500ms (three busses, one chip on each) when an update is needed.
OK, 500ms isn't that long, but think of it. It doesn't do that many
things in 500ms. It could be faster, isn't it? If it ain't much of an
issue for the sensors program, I think it is for apps that monitor the
values continuously (such as gkrellm). My proposal could lower the time
to say 200ms, which is far better IMHO.

> >Thus my question, and I ask it again, maybe more clearly than the
> >first time. How could the chip's register be changed without using
> >our driver?
>
> Well, I guess it is a matter of ideals.  I've thought of kernel
> hardware drivers as being an inbetween for the user-space apps and the
> actual hardware with absolutely as little tainting of the data as
> possible.

We already do many transformations, even between the registers and the
internal vars.

> Even if the values in the hardware's registers are unlikely
> to change or change infrequently, we still should pass values straight
> through and not make any assumptions on the data in code.

My point isn't about values that are unlikely to change (see my opinion
about VID above) but about values that *should* not change. It's
slightly different (in the spirit if not in the facts).

> As long as overhead and processor loading isn't an issue, I'd suggest
> we not cache or code in any value/limit assumptions into the code. 
> I2C transactions are slow, but they cause little (if any) CPU loading
> or resource hogging.  Even as far as percentage usage of the I2C bus,
> it is small.  I can't see any possible significant performance gains
> by caching things like limits.  Also, there are at least some
> potential drawbacks (at least marginally more than simply 'no
> drawbacks'), so I see some additional risk with no gain.

Hardly anything I can say against this, you're of course right. It's
more about having a "beautiful" driver than anything else.

> BTW- The worst offender of reading values over and over with little 
> chance of change is the eeprom driver.  For each device, if I
> remember correctly, each byte read takes two I2C transactions for
> 256 bytes! So, if you have 4 dimms (with an eeprom on each), you
> are doing over 2 thousand transactions.  Still, though, this
> take little time and almost no CPU overhead, so it doesn't seem
> to hurt anything.

You're definitely right. I guess this is the reason why the update
frequency is limited to 1 each 5 minutes as opposed to 1 each 1 or 2
seconds for the rest of our drivers. Refreshing the two eeproms on my
laptops takes 5 full seconds (and I was complaining about the 500ms on
the other system...) The worst part of the story is that over 50% of the
data we retrieve isn't even used. Anyway it's a bit different, the
EEPROM driver isn't a sensor-like driver. It isn't meant to be refreshed
frequently. All data in the EEPROM are the same (update-frequency-wise),
so that a user-space app can cache the whole thing and never use the
driver again, while it's different with usual chipsets. While it's
useful for our tests, few people want to use that driver (I even wonder
if we should tell the users to modprobe that module at the end of
sensors-detect).

> Anyways, that's my $0.02. :')

I add my 0.02 Eur (not much more ;)). Long way still before we can
afford a drink ;) Thanks a lot for the clarifications, I really
appreciate when we can exchange our views like that.

(My state of mind after this step: I think I'll use "my" policy in the
ADM1025 as a test. It's not widely used AFAIK so we don't risk much. If
we have feedback of any kind, we'll could either revert the driver to
the usual policy, of extend the experiment to other drivers. Or I can
just be quiet and leave the ADM1025 driver as the other ones, if you or
anyone doesn't want me to experiment. What is certain after our
discussion is that I won't change all drivers to my policy right now ;))

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
