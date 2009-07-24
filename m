From: Matt Roberds <mattroberds@cox.net>
Date: Fri, 24 Jul 2009 04:04:17 +0000
Subject: Re: [lm-sensors] What do I log if I'm not sure about the compute
Message-Id: <Pine.LNX.4.64.0907232256540.32050@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0906220138120.9018@birdbird.example.com>
In-Reply-To: <Pine.LNX.4.64.0906220138120.9018@birdbird.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 21 Jul 2009, Jean Delvare wrote:
> Given the specific timing of your project, I suspect it's too late,
> but maybe for next time...

It's actually working out well.  We haven't run a system through the
thermal chamber yet, so this info will come in handy.  I also haven't
asked the motherboard manufacturer yet; I'm 80% sure that the first
few rounds will consist of "Just use the handy Windows monitoring
utility" and I don't feel like explaining it at the moment.  :)

> Out of curiosity, which monitoring chip is it? Not all chips require
> compute statements.

sensors-detect says "Winbond W83627EHF/EHG Super IO Sensors" at 0x290,
driver w83627ehf .  (Note that this is lm-sensors 2.x; I have to use
the packaged version that is already on the machine.)  I haven't
opened up the case to see what chip is actually there, but this
driver provides plausible results so far.

> Grabbing the raw values from /sys/class/hwmon has the advantage that
> it is much easier to feed into a spreadsheet or scripts for
> post-processing. The output of "sensors" is more tedious to parse.

I already worked up a really simple script to grep out what I wanted
from the "sensors" output and hack it into a one-line-per-reading
CSV format, but it may not have been very robust in the face of things
like alarm warnings.  I have enough disk that I _could_ just log the
straight "sensors" output to timestamped files, or to one big file
with timestamps in it, and then process the whole thing later.

Thanks!

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
