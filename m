From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: driver design question
Message-Id: <20030728225830.2bf97139.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030728153714.7b09e0b7.khali@linux-fr.org>
In-Reply-To: <20030728153714.7b09e0b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> >Reading some code today, I noticed that most of our drivers, if not
> >all, read the current values and the limit values when updated. Why
> >that? I would have read the current values only. We set the limits
> >ourself(either at init time or through procfs/sysfs) so they are
> >unlikely to have changed. Looks like an overhead we could easily get
> >rid of. Is there something obvious I am missing?
> 
> I think we should try to read and report what we know.  If we don't
> read the limits, we probably shouldn't report them either (i.e. make
> them write-only).  Reducing overhead by introducing assumptions in the
> code (like that limits won't change), is a bad idea, imho.

I think I understand your point. You want us to play it safe and you
must be right. However, what could make the limits change? The chip
(refering to ADM1025 here, since it's the one I'm working on right now)
doesn't change them on his own unless it is power-cycled (a case we
don't handle anyway, and I believe we are right to do so). The only way
the limits can be changed is through our driver, and in this case we can
store it on-the-fly instead of reading it back on every update.

One may object that this doesn't allow us to check wether a round-trip
from userspace to the registers and back again is OK (we assume that the
right value was written to the register). However, we are never sure the
register value is right, even if we read the values back. The two
conversions formula can be bad but compensate each other, and it's
transparent from user's point of view. Anyway, a compromise is to read
the limits back once (at the time we write them) so we don't loose this
is-the-conversion-OK information.

Another compromise is to read the limits but not on every update. This
would however require to have two "last update" values recorded into the
driver. Not very clean IMHO.

Is there any way values can be written to the driver's register without
telling us?

> At least, I think this is more important at the driver level than 
> the user-space apps.

Not sure I get you there, is there a similar problematic with user-space
apps?

> Are we having problems with performance and overhead issues?

No (at least none I am aware of). But I don't like the idea of our
driver doing something that could be avoided with no drawback. Please
realize that for each update, which can occur typically as often as once
every 1.5 second, 1/3 of the work is for the current values, which is
legitimate, and 2/3 of the work is for limits, which 100% of the time
AFAIK did not change. Multiplying the amount of work by three is more
than just overhead, isn't it?

Thus my question, and I ask it again, maybe more clearly than the first
time. How could the chip's register be changed without using our driver?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
