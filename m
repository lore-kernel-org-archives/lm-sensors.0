From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 06 Mar 2006 10:21:17 +0000
Subject: [lm-sensors] Proposal to individual alarm/beep sysfs files
Message-Id: <QZ6kh67w.1141640476.9172650.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060305231105.97f9085a.khali@linux-fr.org>
In-Reply-To: <20060305231105.97f9085a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Philip,

Thanks for joining the discussion, it's much appreciated.

On 2006-03-06, Philip Pokorny wrote:
> > So my new suggestion is to have per-limit alarm files for chips which
> > implement things that way. This makes every alarm file a boolean. The
> > only drawback I can think of is that we'll end up with many more sysfs
> > files defined in each driver. However, the size increase seems to be
> > acceptable, thanks to the dynamic sysfs callbacks and the array of
> > attributes which we can use now.
> >
> > Fault conditions and beep masks can be handled exactly the same way.
>
> What about using strings in the alarm files instead of booleans?  Then
> you could report the *name* of the limit or condition causing the alarm
> (or alarms) or an empty string if there is no alarm?

A given input channel may have several alarms active at the same time,
for example the high and critical limits may be active at the same time
if the temperature is above both limits. It's even possible to have the
low and high limit alarms active at the same time if the chip is
misproperly configured ;)

How would you handle this situation? Returning more than one string per
file is sort of against the sysfs philosophy. Unless we decide to see it
as a single string... I guess it's a matter of point of view.

> When you look at the code in libsensors, it seems that alarms are almost
> always converted into text strings.  Why not move that code into the
> driver itself and then user-space tools would just print the contents of
> the ALARM file rather than having to parse the alarm file name to
> determine what limit or condition is causing the alarm or fault.

Please try to forget all you know about libsensors here. If just for
libsensors, we would not be discussing this new interface, for the old
one would be enough. Likewise, don't think too much about the
"sensors" program. It's really only one hardware monitoring tool
among a dozen.

So, thinking about a new library, relying on a chip-independant sysfs
interface, I don't think your proposal will help most of the programs
using it. Graphical tools may want to express alarm conditions with a
different color, or with some blinking led-like picture. If the sysfs
interface file says "HIGH" instead of "1", it doesn't help them at
all, does it?

Also, even for text-based programs, authors may want to internationalize
them, so they'll need to parse the file contents anyway, rather than
displaying it directly. Good coders will want to parse the file contents
anyway, because it wouldn't be safe to let a string go through without
some minimum checks.

So all in all I don't see much added value to having drivers export
alarm conditions as strings, sorry. I'm still carefully listening to
counter arguments though, and interested in seeing actual code for
alternative proposals.

Thanks,
--
Jean Delvare

