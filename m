From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Jul 2009 18:17:16 +0000
Subject: Re: [lm-sensors] What do I log if I'm not sure about the compute
Message-Id: <20090721201716.7dad4d93@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0906220138120.9018@birdbird.example.com>
In-Reply-To: <Pine.LNX.4.64.0906220138120.9018@birdbird.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matt,

Sorry for the late answer. Given the specific timing of your project, I
suspect it's too late, but maybe for next time...

On Mon, 22 Jun 2009 02:00:13 -0500 (CDT), Matt Roberds wrote:
> Hello all!
> 
> Quick version: If I don't know the right values to plug into the
> "compute" line for voltages in sensors.conf, what should I log so that
> when I find out the right values, I can go back through the log and
> compute the voltages?

Out of curiosity, which monitoring chip is it? Not all chips require
compute statements.

> Long version:
> 
> At work, we build a product that has a rackmount Linux PC plugged into
> some other hardware.  I've gotten lm-sensors to run on the PC, and I
> get the expected number of voltages, fan speeds, and temperatures.  I
> even mostly believe the fan speeds and temperatures, but I'm not sure
> about some of the voltages; I'm not sure what scaling resistors the
> motherboard manufacturer is using.  I can ask the manufacturer, and
> experience tells me that they will probably give me the right answer,
> but it takes a few rounds of emails to get there.
> 
> One copy of the system has to go in for several days' worth of
> environmental testing: hot, cold, humidity, etc.  There is independent
> measurement and control of all this stuff, but it would be nice to know
> what the PC is seeing internally during all of this.  The wrinkle is
> that I can configure the PC however I want, but once the test starts, I
> can't change the configuration.  Of course, the test has to start a few
> days before I expect to get a good answer from the manufacturer about
> how the motherboard is wired.
> 
> I am assuming that it is possible to log the raw data, or the (possibly
> incorrectly-scaled) "cooked" data, and then go back later and correct
> the computation.  I realize I probably won't be able to "replay" the
> wrong data through sensors; the correction will have to be done in a
> script or spreadsheet or something like that.

This is right, we currently don't have any way to point libsensors to
fake data files. This might be interesting to implement in the future,
either for cases like yours, or for a test suite.

>  (I can have the system
> under test copy the logged raw data to another computer during the
> test, so I can do computations on the other computer.)

If you don't know the scaling factors, I suggest logging the raw data.
It's always easier to go from raw data to cooked data than the other
way around. If OTOH you are almost certain your compute statements are
good, logging the cooked values make sense.

Note that sensord, the daemon that comes with lm-sensors, may well be
suited for the task. It can log all values in a RRD database, and then
display the values as nice charts.

> So, the question: What values should I log so that I can do this?
> Should I have a null sensors.conf and log the output of sensors?  Or
> should I put in sensors.conf compute lines that do nothing to the raw
> value (for instance, "compute in1 @*1, @*1") and log the output of
> sensors?

This is equivalent: "compute in1 @*1, @*1" is a no-op, as you found out
yourself. The easiest IMHO is:

sensors -c /dev/null

>  Or should I maybe grab something directly out of /proc or
> /sys or somewhere?

Grabbing the raw values from /sys/class/hwmon has the advantage that it
is much easier to feed into a spreadsheet or scripts for
post-processing. The output of "sensors" is more tedious to parse. But
you'll need a custom script to do the former. All in all it really
depends on what you intend to do with the collected data.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
