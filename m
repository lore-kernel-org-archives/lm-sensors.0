From: Matt Roberds <mattroberds@cox.net>
Date: Mon, 22 Jun 2009 07:00:13 +0000
Subject: [lm-sensors] What do I log if I'm not sure about the compute lines?
Message-Id: <Pine.LNX.4.64.0906220138120.9018@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all!

Quick version: If I don't know the right values to plug into the
"compute" line for voltages in sensors.conf, what should I log so that
when I find out the right values, I can go back through the log and
compute the voltages?

Long version:

At work, we build a product that has a rackmount Linux PC plugged into
some other hardware.  I've gotten lm-sensors to run on the PC, and I
get the expected number of voltages, fan speeds, and temperatures.  I
even mostly believe the fan speeds and temperatures, but I'm not sure
about some of the voltages; I'm not sure what scaling resistors the
motherboard manufacturer is using.  I can ask the manufacturer, and
experience tells me that they will probably give me the right answer,
but it takes a few rounds of emails to get there.

One copy of the system has to go in for several days' worth of
environmental testing: hot, cold, humidity, etc.  There is independent
measurement and control of all this stuff, but it would be nice to know
what the PC is seeing internally during all of this.  The wrinkle is
that I can configure the PC however I want, but once the test starts, I
can't change the configuration.  Of course, the test has to start a few
days before I expect to get a good answer from the manufacturer about
how the motherboard is wired.

I am assuming that it is possible to log the raw data, or the (possibly
incorrectly-scaled) "cooked" data, and then go back later and correct
the computation.  I realize I probably won't be able to "replay" the
wrong data through sensors; the correction will have to be done in a
script or spreadsheet or something like that.  (I can have the system
under test copy the logged raw data to another computer during the
test, so I can do computations on the other computer.)

So, the question: What values should I log so that I can do this?
Should I have a null sensors.conf and log the output of sensors?  Or
should I put in sensors.conf compute lines that do nothing to the raw
value (for instance, "compute in1 @*1, @*1") and log the output of
sensors?  Or should I maybe grab something directly out of /proc or
/sys or somewhere?

Thanks for your help!

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
