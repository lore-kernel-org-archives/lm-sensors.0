From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: ASUS A7V333, ASB100(bach) must not be an as99127f
Message-Id: <20021218232009.A2630@earth.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1040258701.6614.45.camel@linux.local>
In-Reply-To: <1040258701.6614.45.camel@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Ed Harrison <ed.tman@verizon.net> [2002-12-18 19:45:01 -0500]:
> I have an ASUS A7V333 which definitely has the ASB100 chip (on $2d:
> $581, $4f), not to be confused with as99127f or the w83781d,
> although some functionalities are the same.  Your NEW AND REQUESTED CHIP
> DRIVERS - STATUS states that the asb100(bach) is recognized as an
> as99127f.  The as99127f and the asb100(bach) have different ID's and
> behave differently because using w83781d force_as99127f is not working 

Yes, we recognize the ASB100 (with different ID) but treat it like
a as99127f.  This is working since 2.6.5; what version are you using?

<cut>

> fan2 rpm = CMOS rpm, which I do not get with xmbmon, nor have ever
> gotten from sensors.

Did you try FAQ 4.1.1?
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/fan-divisors

> If I modprobe the i2c and lm_sensors modules, mbmon and xmbmon start
> giving me crazy numbers (for example CPU 5.1 F, up from 90.5 a few
> moments before), as does sensors.
> 
> The only way to restore sensible numbers again is to reboot.  How Come?

Looks like mbmon touches the hardware directly... that's equivalent to
loading two drivers for the same hardware at once.  No suprise if they
get in eachother's way.  You could try to "rmmod" our modules including
i2c before you run mbmon... but even then I can't vouch for whatever state
in which that program leaves the hardware.  Any error in lm sensors that
you notice after running mbmon is out of our hands.

> I was going to try to hack w83781d.c into something useable, but alas I
> am too dumb.  I offer what I know about this chip in hopes one of you
> can do it, maybe as a force_asb100=0,0x2d option to w83781d.

<cut, as99127f vs asb100>
> Temp sensor 4: $17 on ASB100 [AMD diode only it seems]

Yes, another a7v333 user mentioned this previously.  I thought he might
eventually submit a patch?  In the meantime, let's try to get everything
else working for you.  To start with, make sure you have at least the
2.6.5 i2c & sensors packages.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
