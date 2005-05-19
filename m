From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: mkpatch works
Message-Id: <20030622151705.GA6801@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EF5B5CE.6050103@paradyne.com>
In-Reply-To: <3EF5B5CE.6050103@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark D. Studebaker <mds@paradyne.com> [2003-06-22 09:57:34 -0400]:
> I got mkpatch working on both i2c and sensors,
> both configuring as modules and compiling-in.
> Please test.
> 
> A few hints:
> 
> - Follow steps in order: generate and apply i2c patch; then generate and 
> apply sensors patch.

I2C mkpatch works and applies cleanly to 2.4.9.

Then lm_sensors mkpatch says this:

Can't open './kernel/include/sensors.h' at mkpatch/mkpatch.pl line 1432.

Is that file generated on the fly now?

> - As a compile test you can compile-in all drivers. But actually running 
> that kernel takes
> forever to load (bus scanning) and you hit all the driver quantity limits
> (see the top of i2c.h). For easiest testing of compiled-in drivers only 
> compile-in a few at a time.
> 
> - Don't enable bttv or other non-compatible i2c stuff in kernel.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
