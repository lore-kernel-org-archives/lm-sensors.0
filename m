From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: sensors-detect enhancement needed for sysfs
Message-Id: <20031118031237.GB17276@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FB839E3.6C7D5CCD@paradyne.com>
In-Reply-To: <3FB839E3.6C7D5CCD@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark D. Studebaker <mds@paradyne.com> [2003-11-16 22:00:51 -0500]:

> I've enhanced i2cdetect, i2cdump, and i2cset using the new common
> function in
> i2cbusses.c to list all the i2c busses, whether in 2.4 or 2.6 kernels.
> In 2.6 it's essentially 'cat /sys/class/i2c-adapter/*/device/name' but
> see i2cbusses for details like finding the sysfs mount point.

Hmm, did you forgot to 'cvs add prog/dump/isaset.c'?  I'm getting
a build error...

make: *** No rule to make target `prog/dump/isaset.rd'.  Stop.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
