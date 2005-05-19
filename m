From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: PATCH: lm92: port for 2.6 kernel
Message-Id: <20050228232232.2cd3765d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <422318E5.4000201@katalix.com>
In-Reply-To: <422318E5.4000201@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi James,

> > I invite you to take a look at the libsensors code. You'll find out
> > that libsensors is really stupid. It is not currently able to parse
> > the sysfs directories and find out the chip features on its own.
> > Instead, each feature of each chip must be individually listed. This
> > explains the size of both libsensors and the sensors program
> > 
> > Yes, this is a pity, but originally the library was really only
> > handling two chips, not 100+ like it does now. The whole thing needs
> > a full rewrite, but I'm out of time.
> 
> Not everyone who makes use of the Linux support of sensor chips uses
> libsensors... Indeed, many embedded devices do their own hardware
> monitoring using custom applications. The kernel's i2c sensors
> API should not be restricted by one application.

Reading raw values is possible for some sensors but not for all. Some
sensors need scaling (typically voltages), some temperature sensors even
need complete thermistor computation. Libsensors also centralizes labels
and channel discarding ("ignore" lines). I sincerely believe that
libsensors is a good idea. What sucks is the current implementation,
which is in part the result of the original design of the Linux 2.4
procfs interface for sensors. The lm_sensors project really shows its
age, and the fact that it wasn't designed for the extreme variety of
hardware we have now. With libsensors and sensors weighting 165kB and
128kB, repsectively, I definitely can understand why embedded folks
prefer direct accesses.

So, in fact everyone should (IMHO) use libsensors, which should be
chip-independent and lightweight.

Among others, libsensors has the advantage that it (now) supports both
the 2.4 and 2.6 kernel interfaces, and we update it when the interface
changes or chip drivers are ported. This is a valid reason to invite
application developers to rely on it.

The kernel API isn't exactly restricted by libsensors, as you seem to
think. It is in fact restricted by real world users who dislike
compatbility breakage. I would really like to redesign the whole sysfs
interface for sensors again. There are half a dozen major things I would
change. However, this would break compatibility so badly that there
would be no way to adapt libsensors, which would mean rewriting it
entirely, dropping 2.4 support, rewriting the sensors program, and
helping two dozen developers port their own applications to the new
library. I would love being paid for the job, but at the moment I am
working on this on my sole free time, and the amount of work is way
above my capabilities and knowledge.

> My concern about taking shortcuts in the implementation of /sysfs
> for the i2c chip drivers is that these shortcuts tend to live for a
> long time.

The shortcuts have been taken 6 years ago, and we live with this history
now. If you have ideas to make things better without breaking
everything, they are very welcome.

> If libsensors dictates that the sysfs node
> /sys/bus/i2c/drivers/xxx/yyy/name is always the name of the driver xxx
> rather than the actual chip detected, there is no simple way for
> an application to discover the actual chip identities.

name isn't always xxx. xxx is a driver name, name is a "kind" (or type)
name. What libsensors dictates is that we avoid adding clones names,
just because it creates additional dependencies between kernel and
libsensors versions, with little benefit.

In fact, having the same kind for two chips (like lm92 for both the LM92
and the MAX6635) is considered a benefit in some cases. Sometimes
hardware manufaturer use various compatible chips for a given board
model. People buy many boards of a model, or many system based on that
board, and then wonder why lm_sensors works on some and not on others,
while the board is supposedly the same. By masking the fact that some
chips are clones of others, we make life easier for them.

> I think the i2c /sysfs files should be designed such that an
> application can determine which devices exist and what features are
> supported. Right now it seems we can only determine which i2c drivers
> exist and what features the devices detected by those drivers support.

I see no real difference. Where several chips share a type name, all
these chips do have the same feature set, so the user application
wouldn't make a difference anyway. The only information missing is the
name of the physical chip. Frankly it isn't that important for most
users if both chips are real clones.

> > Sure it should. And libsensors should be rewritten to be freed of
> > any chip-dependant stuff. And the sysfs interface for sensors should
> > be made totally free of chip-dependant stuff. And all of these must
> > be done in the reverse order, so this is a long way to go. Feel free
> > to contribute :)
> 
> :) I'm trying. :)
> 
> Is anyone working on such a rewrite?

Not that I know. I do have some precise ideas of what should be done
(and what shouldn't) but unfortunately there are technical points that
prevent me from going on: configuration file parsing and library
interface to name only the major two. But I'd be very happy to discuss
this with you if you want to give it a try.

Thanks,
-- 
Jean Delvare
