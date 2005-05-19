From: Mario.Holbe@RZ.TU-Ilmenau.DE (Mario 'BitKoenig' Holbe)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: scaling of loadavg in sensord
Message-Id: <20041028160446.GA11428@darkside.22.kls.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <417CB2E3.3090007@aurel32.net>
In-Reply-To: <417CB2E3.3090007@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 28, 2004 at 12:39:30PM +0200, Jean Delvare wrote:
> I agree that the thermal curve will depend on the system, and I guess
> this is the reason why you want the user to be able to choose which
> average load he/she wants to compare the temperature with.

That's exactly the point.

> I believe that people needing more accurate temperature vs. load curves
> are better lowering the sampling rate to one every minute than averaging
> the cpu load over a longer period of time. Comparing an instant
> temperature with an average load doesn't make much sense unless you
> assume that the instant temperature is actually a form of average

Of course, you are right: load1 is the best equivalent to an
"instant" value, we have.
However, sensord is able to cope with different sample rates.
Users configure it to fit their needs. Users needs are quite
different, as we all know :) And if the user decides to have
a samplerate of 5 minutes (because temperatures shrink slower
than they grow perhaps), a load average of 5 minutes would
perhaps give him better results, because temp is still high,
but load1 doesn't show anything anymore. However, load5 would
still show the peak that lead to the temperature growth.

> Yes, I noticed that and this is great if we'd end up applying the patch.
> I still need to be convinced that we want to do that though.

Well, we agree that sensord is not a system monitor at all.
Perhaps we also agree, that it's nice to monitor load together
with sensord anyways, because it just sometimes makes sense.
This patch just rounds this nice-to-have-thing up: it gives
the user the flexibility to choose whatever fits his needs
best.
And - perhaps even more important (especially for you as
developers :)) - its not that big thing at all and it's
capsulated well. Once it works, there are not much "new"
or "change" issues to expect from it.

> where values are missing, right? Does rrd do any averaging in the
> regular case? I think there was a discussion about this some months ago
> but I cannot seem to remember where they did led us.

Well, on the one hand, rrd does averaging when it's needed
for displaying data. For example, if your window is too big
to show single raw "data points", it generates new averaged
"data points" to show.
On the other hand, rrd does also averaging on the raw
"data points", when they appear out of time. For example,
if your RR-database has "data slots" every full minute
and your data arrives 30 seconds later, it averages the
"slot data".
The first is expected and wanted. The latter led us to
a patch (already applied) that made sure, sensord collects
the data as near as possible to the "data slots", i.e.
for one-minute-slots it forces sensord to collect and
store the data at the full minutes and not 28 seconds
later for example.

So, just consider the discussion about rrds averaging as
finished :)


regards,
   Mario
-- 
Whenever you design a better fool-proof software,
the genetic pool will always design a better fool.
