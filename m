From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <20040714034456.GA2782@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-07-05 20:05:11 +0200]:
> > I vote option #1 for 2.4.
> > Option #2 would force sensors users to upgrade to latest i2c.
> > Option #3 isn't worth the trouble, unless that's what we do for 2.6,
> > then maybe.
> 
> Ah, interesting remark about #2, I had missed that point. That's
> especially important since we would like to bring more compatibility
> back.

Agreed.

> > I vote option #1 for 2.6, unless we get objections, then we do #3.
> > I don't see much in common with the code in i2c-sensor (#2).
> 
> i2c-sensor contains the code common to sensor chips. I see no better
> place for the new function. I agree that having a separate module (#3)
> is theoretically nicer, but all in all what's the point in having two
> drivers which will be loaded together like 90% of the time?

Somewhere between #2 & #3...

We could make i2c-sensor a composite module, composed of e.g.
i2c-sensor-detect.c (i2c-sensor.c renamed) and i2c-sensor-vid.c.
Using drivers/net/e1000 as an example, the makefile would look
something like this:

 obj-$(CONFIG_I2C_SENSOR)       += i2c-sensor.o
 obj-y                          += busses/ chips/ algos/
  
+i2c-sensor-objs := i2c-sensor-detect.o i2c-sensor-vid.o
+
 ifeq ($(CONFIG_I2C_DEBUG_CORE),y)
 EXTRA_CFLAGS += -DDEBUG
 endif

We could still keep a separate include/linux/i2c-vid.h.  Then just
put which_vrm() into i2c-sensor-vid.o.  The vid_from_reg() func
then becomes a candidate to move to i2c-sensor-vid.c as well.

BTW: which_vrm() should be renamed i2c_which_vrm()

> > Also, by returning 0, we require each module to pick its own
> > default: if(! vrm = which_vrm()) vrm = DEFAULT_VRM;
> > this is what we want, right, since different drivers may have
> > different ideas about what is the best default?
> 
> This is how things are now, so doing so preserve compatibility. We had a
> theoretical default VRM but some drivers (asb100) don't follow it, and I
> wouldn't blame MMH for that (the ASB100 is a recent chip not used with
> VRM 8.x CPUs, so it would be silly to default to that).
> 
> However things are different now. The default will be for chips we don't
> know about, at all. This means they are likely to be recent and to use
> more and more recent versions of VRM. We could want to have a default
> and keep it up-to-date with the latest known common VRM version.
> 
> Another thing to consider is that this case is just not supposed to
> happen, so the thing to do would be to make sure people will report to
> us, so that we can update our detection code. One way to do so would be
> *not* to report any value, ie VRM = 0 -> nominal Vcore = 0 whatever the
> VID values (+ message in the logs). This latest method looks cleaner
> than an arbitrary VRM which is likely not to be correct anyway.

Yeah, I like this last idea.  Put a printk in the CONFIG_X86 version of
which_vrm() if the cpu is unknown.  Other arch's will have to manually
config their VRM (if it even makes sense not to just ignore it).

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
