From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Asus a7v266ex // lm_sensors // fan solution
Message-Id: <20030805042040.GC11605@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308040114.06823.info@i-service.de>
In-Reply-To: <200308040114.06823.info@i-service.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2003-08-04 14:40:03 +0200]:
> > Another output to show, I'm a bit confused. I did again a "sensors -s"
> > like yesterday, but now, without any changes to sensors.conf I got
> > this:
> > 
> > (root@athlon) ~$ sensors -s
> > (root@athlon) ~$ sensors
> > as99127f-i2c-0-2d
> > Adapter: SMBus Via Pro adapter at e800
> > Algorithm: Non-I2C SMBus adapter
> > [...]
> > - -5V:       -4.03 V  (min =  -5.24 V, max =  -4.74 V)       ALARM
> > CPU FAN:  2311 RPM  (min = 1795 RPM, div = 4)
> > [...]
> > 
> > setting is still 1800, I got 1795, I think its ok so far.
> 
> Yes, it's OK. I can't tell you why it didn't work yesterday (damn Asus
> again). 1795 is OK, don't expect to get exactly 1800, resolution is
> limited so you usually get rounded values (even if it doesn't look so
> "round" from a human point of view).

Sorry, can't blame Asus for this one ;)

The fan_min and fan_div are related.  Unfortunately, many (most?) of
our chip drivers have this problem: when one changes the fan div, the
fan min silently changes due to the relation.  When your sensors.conf
specifies a change to both fan_min and fan_div, a race is possible
that would require you to run `sensors -s` twice to actually get what
you want.

I fixed this when I ported lm78.c to 2.5/2.6 - I took the hint from
someone else's code (might have been Phil P.)  Haven't had time to
propagate that to other drivers though.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
