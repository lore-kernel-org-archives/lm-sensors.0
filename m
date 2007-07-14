From: Vadim Zeitlin <vadim@zeitlins.org>
Date: Sat, 14 Jul 2007 14:23:16 +0000
Subject: Re: [lm-sensors] [PATCH] First cut of a adt7470 driver
Message-Id: <E1I9ia2-0007Sl-Lf@teufli.physik.fu-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706211144.GI3435@tree.beaverton.ibm.com>
In-Reply-To: <20070706211144.GI3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 8 Jul 2007 18:53:12 +0200 Jean Delvare <khali@linux-fr.org> wrote:

JD> On Fri, 6 Jul 2007 14:11:45 -0700, Darrick J. Wong wrote:
JD> > Below is a first draft of a driver for the ADT7470 chip.  I've tested
JD> > the driver against the adt7470 in the IBM IntelliStation Z30 and as far
JD> > as I can tell it's good for controlling the speed of the CPU heatsink
JD> > fans and monitor CPU temperature.  Please let me know what you think of
JD> > the driver.  The patch should apply cleanly against 2.6.22-rc7.
JD> 
JD> I've added an entry in our wiki Devices page to track this one.
JD> 
JD> Note that back in January this year, someone (Vadim Zeitlin, Cc'd)
JD> asked for support for this chip. So maybe Vadim would be interested in
JD> testing your driver.

 Hello,

 Thanks a lot Jean for cc'ing this to me and, of course, thanks a lot to
Darrick for writing the driver (and sorry for never getting around to
writing it myself...)! I was away during this week so I couldn't test it
before but now I got back and so I've just compiled the driver for my
current 2.6.20 kernel. The module loads (accompanied by a brief switch to
maximal fan speed judging by the noise) and creates its directory under
/sys/bus/i2c/drivers/adt7470. I don't really know what do I have to do to
make it work with lm-sensors (do I need the svn version? Debian only has
2.10.1 currently) so for now I just tried to manually check the files in
this directory.


 The first thing I noticed is that accessing any of them takes almost 3
seconds:

# time cat fan1_input
2001
cat fan1_input  0.00s user 0.00s system 0% cpu 2.760 total

I wonder if this is normal? I see a 1 sec sleep in adt7470_update_device()
but the delay happens not only for the temperatures and it's also much
bigger than 1 second.

 Next, the fan speed detection seems to work as expected, i.e. the number
it gives (like 2000 above) seem to be RPM. But reading the temperature
files produces strange results:

# grep . temp?_input
temp1_input:0
temp2_input:228000
temp3_input:59000
temp4_input:54000
temp5_input:226000
temp6_input:228000
temp7_input:58000
temp8_input:54000
temp9_input:49000

Again, I see the factor of 1000 in adt7470.c and, accounting for it, all
numbers except 227000 may be correct -- but what about those latter ones?
To confuse the matters (or at least me) further, temp_min files contain
129000 while temp_max files have 127000 (no typo) so something seems wrong
here... At the very least, the factor of 1000 seems to be unnecessary:

# grep . pwm1*
pwm1:0
pwm1_auto_channels_temp:1023
pwm1_auto_point1_pwm:128
pwm1_auto_point1_temp:90000
pwm1_auto_point2_pwm:255
pwm1_auto_point2_temp:110000
pwm1_enable:2

The values here clearly should be 90 and 110 degrees, shouldn't they?

 Please let me know what else should I test, thanks in advance!
VZ


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
