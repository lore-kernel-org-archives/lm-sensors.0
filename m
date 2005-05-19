From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Ticket 1552
Message-Id: <1075799908.401f67641e643@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040201215112.2227131d.khali@linux-fr.org>
In-Reply-To: <20040201215112.2227131d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Mark Studebaker <mds4@verizon.net>:

> Back in late 2002/Jan. '03 we had a lot of discussion about read
> errors.

I think I remember reading it.

> Certainly the situation then and now, where most drivers just return
> a -1, isn't great.

Sure, that's not fine at all. That -1 is then converted to bogus
temperatures, voltages, whatever. Could have unsuspected consequences.

> One sentiment was that drivers definitely shouldn't silently return
> the old value, that definitely wasn't "server-class".
> People felt strongly about this.

I agree too. If nothing else, the error should at least be logged. But
it would of course be better to let the user-space know about the
problem.

> So what I did back then was update the adm1021 driver as a
> demonstration.
> This was just after it got ported to 2.6, so my changes are only
> in our package, not 2.6.
> This driver now sets the appropriate alarms bit on a read failure,
> and returns the old value. Take a look.

Interesting. I didn't know you did that, must have occured before I
started working actively on the project. The idea isn't bad, but I
don't  like much using a value for something else than its original
meaning. Two drawbacks I can think of: user-space cannot differenciate
between real alarms and read errors, and the alarms value doesn't match
the register(s) anymore.

> I think at the time I also proposed a new /proc entry, similar to
> alarms and with the same bitmask, called 'fail'. This would
> provide an indication separate from the alarm indication.

I like that idea even more, although it has some caveats to be
discussed. For example, what about registers that do not have an alarm
bit?

> I'm sure there are other ways... perhaps sysfs opens some new
> possibilities.
> Any way to make the sysfs read fail, for example?

Not with the current structure of the drivers AFAICT. Since any
procfs/sysfs read attempt updates all registers (except for a very few
drivers), you cannot easily know which register failed, unless you keep
track of it. This would require either one "valid" boolean for each
register, or even one additional "last_updated" value for each register
(in which case we get rid of the global update concept). This means a
greater complexity of the driver (same idea as what I did for the
eeprom driver, but with a one-byte granularity) but possibly increased
responsiveness and lessened collision probabilities.

I am not sure such changes are required to solve the read errors. If we
leave the w83l785ts apart, read errors are most likely caused by dying
or badly designed hardware. Logging the error and returning the
previous value or retrying to read may be considered sufficent and
doesn't require much change in the code, as you can see with my recent
patch to the w83l785ts driver.

That said, the w83l785ts is a slightly different case, since the errors
are obviously caused by a design issue (well, in a way, we can call it
badly designed hardware as well). Read errors happen to (almost?) all
A7N8X owners, and more frequently than what one would call rarely (15%
of the time as James' stats showed). This is why I implemented my
insisting-read method in this driver.

Write errors, on the other hand, can already be easily reported by
sysfs, as Reinhard Nissl demonstrated while porting the fscher driver.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
