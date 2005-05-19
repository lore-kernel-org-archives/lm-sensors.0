From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: negative voltages
Message-Id: <1075796532.401f5a3459773@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075721644.401e35ac8e6fc@imp.gcu.info>
In-Reply-To: <1075721644.401e35ac8e6fc@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Mark Studebaker <mds4@verizon.net>:

> As you have said, the /sys or /proc values are raw values.
> So min < max. 
> If you don't do it that way, the alarms won't work.

Agreed.

> So if (and only if) you have an inverting compute line in
> userspace, then you MUST flip the limits for userspace.
> Somewhere it has to be done, I think you'll agree.
> That's what was done in lib/chips.c for 2.4.

This is where I don't fully agree. I understand pretty well how things
have been done and I agree that it works. I also admit that it keeps
min < max for the user whatever the chip, which can be considered
nice.

But this also introduce more chip-dependant code in the library.
Remember that the sysfs interface was meant to be self explanatory.
This should allow one to write a library with no chip-dependant code in
it. All chip-dependant information would belong to sensors.conf.

You will object that this won't allow us to keep the "min < max"
assertion true for all chips. I have a trick in mind to workaround the
problem (if it is a problem, which I'm still not sure of, BTW). The
library can test each formula and detect if it is inverting, providing
the function is monotonic around the current value (simply test the
sign of f(x+d)-f(x-d) where x is the current value and d a relatively
small positive delta). Another possibility is to add a new syntax to
the configuration as MMH proposed, but I would prefer to avoid it if
possible.

Anyway, I'd still like to know if there are real problems having min >
max for negative voltages of some chips (i.e. keep the min and max
semantics in line with the chip internals even if there are inverting
formulas). I don't really see the problem with sensors, as long as
sensors.conf matches with that choice. But maybe it would cause
third-party apps trouble?

We better think twice before breaking something that works, even if the
change simplifies the (new) library.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
