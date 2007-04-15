From: jk <lm_sensors@kosowsky.org>
Date: Sun, 15 Apr 2007 07:48:42 +0000
Subject: Re: [lm-sensors]
Message-Id: <loom.20070415T093136-520@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare <khali <at> linux-fr.org> writes:
> On 08 Apr 2007 16:17:31 -0400, lmsensors <at> kosowsky.org wrote:
> > On 06 Apr 2007 13:21:59 -0400, jk wrote:
> > I think though that part of the problem is that many of the user-space
> > programs and documentation in the lm_sensors tarball (at least in
> > version 2.10.1) are not updated for recent 2.6 kernels.
> 
> True. Their number is hopefully shrinking, but there may be a couple
> scripts still not ported.
> 
> > For example, the program sens_update_rrd looks in either
> > /proc/sys/dev/sensors (which is obsolete) or in /sys/bus/i2c/devices
> > (which gives the problems I have).
> 
> /proc/sys/dev/sensors isn't really obsolete, it is the right place to
> look at for 2.4 kernels.
> 
> sens_update_rrd is not maintained as far as I know so I am not
> surprised if you have some problems with it.
> 
> > Instead it should just go to /sys/class/hwmon and be done with it!
> 
> No, doing so would break compatility with older kernels. The right
> thing to do is to look in /sys/class/hwmon first and fallback to old
> places if that didn't work. This is what libsensors does.
> 
> > Also, just as a random example, the documentation for sensors.conf
> > when discussing about the BUS STATEMENT (which I found by your reference
> > below) only talks about /proc/bus/i2c which is obsolete for 2.6
> > kernels. Similarly, it references the program
> > prog/config/grab_busses.sh which only works in 2.4 kernels.
> > 
> > So, I guess the better question is whether anybody plans on updating
> > the documentation and auxiliary programs in the lm_sensors tarball to
> > reflect 2.6 kernels in general and "later" 2.6 kernels in particular.
> 
> What about you? Maybe you could stop complaining and actually help the
> project?

I believe I have been "asking questions" rather than "complaining". Usually,
packages have existing maintainers and it would be a bit presumptuous of me as a
newbie to lm_sensors to start rewriting base code without making sure first that
I really understand the issue and the reason for the existing situation (which
you and others have now just explained to me) and second that no one else is
currently maintaining the code (which indeed it seems that no one else is doing).

And in fact, I have now adjusted the code to first check for existence of hwmon
(and I also wrote another cleaner version that only looks at hwmon but I
understand why you may not want that so as to preserve backwards compatibility.)

Anyway, here is the diff for the version that preserves backwards compatibility. 

--- sens_update_rrd             2007-04-08 01:18:16.000000000 -0400
+++ sens_update_rrd.new         2007-04-15 03:42:15.000000000 -0400
@@ -30,6 +30,7 @@
 then
        echo "usage: $0 database.rrd sensor"
        echo "       sensor example: w83781d-isa-0290 (2.4) or 0-0290 (2.6)"
+       echo "           or hwmon0 (later 2.6)"
        exit 1
 fi
 #
@@ -38,19 +39,23 @@

 SENSDIR=/proc/sys/dev/sensors
 SDIR=/sys/bus/i2c/devices
-if [ ! -d $SENSDIR ]
+HWMONDIR=/sys/class/hwmon
+SENSDEV=$2
+if [ -d $HWMONDIR ]
 then
-       if [ ! -d $SDIR ]
+       SYSFS=1
+       SENSDIR=$HWMONDIR
+       SENSDEV=$SENSDEV/device
+elif [ -d $SDIR ]
        then
-               echo $0: 'No sensors found! (modprobe sensor modules?)'
-               exit 1
-       else
                SYSFS=1
                SENSDIR=$SDIR
-       fi
+elif [ ! -d $SENSDIR]
+then
+       echo $0: 'No sensors found! (modprobe sensor modules?)'
+       exit 1
 fi

-SENSDEV=$2
 SENS=$SENSDIR/$SENSDEV
 if [ ! -r $SENS ]
 then


> 
> I don't use sens_update_rrd myself, nor prog/config/grab_busses.sh, nor
> bus statements. You do. Why would you expect me or anyone else to fix
> them?

Did I ever say I expected you to? But it is not an unreasonable expectation for
there to be a maintainer of code or barring that some indication that the code
is no longer supported. Also, I would think that even if the rrd stuff is seldom
used that the documentation for a basic config file like sensors.conf should be
up to date and should not just reference obsolete kernel 2.4 methods which by
now are four years out of date.

In any case, I am happy to help where I can, but I don't appreciate being
accused of complaining or of having unreasonable expectations that I never
myself expressed or implied.







_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
