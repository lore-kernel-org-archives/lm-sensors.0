From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 29 Jul 2007 19:18:42 +0000
Subject: Re: [lm-sensors] [PATCH] adt7470: Update sensors periodically via
Message-Id: <20070729191842.GK3796@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070726010421.GM19586@tree.beaverton.ibm.com>
In-Reply-To: <20070726010421.GM19586@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans, Darrick:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-07-26 18:58:18 +0200]:
> Darrick J. Wong wrote:
> > On Thu, Jul 26, 2007 at 08:08:09AM -0700, Juerg Haefliger wrote:
> >> Hi Darrick,
> >>
> >> I guess I'm not seeing the big picture :-) The problem you're trying to
> >> solve is that the reading of the registers takes a long time and needs to
> >> be able to sleep?
> > 
> > Yes, and also that sleeping in the sysfs read function is not desirable.
> > Personally, I was fine with that, but Mr. de Goede was concerned about it,
> > so I decided to try to fix it.  I admit, the dual-delayed-workqueue method
> > is a bit strange, but it solves the reading problem at a slight cost of
> > waking up the CPU even if nobody's watching the sensors.
> > 
> 
> I just read in another thread, that other hwmon drivers suffer from similar
> problems, so I guess userspace will just have to be able to deal with this,
> and the best fix is not to fix it. Sorry to waist everybody's time on this.

Yes, and in this case the cure is worse than the disease.  As I mentioned in
another thread recently, most I2C bus drivers are very slow and polled, using
%100 cpu while doing transfers.

To put that kind of load on a system periodically just to keep the app from
blocking would be IMHO a terrible tradeoff.

The root cause of the speed problem is in the I2C bus drivers, not the hwmon
drivers.

> You could still try to shave some time off by not reading all the limits etc 
> each update.

Notwithstanding what I wrote above, this is still a good idea.  But don't go
too far with it... we do still want to read/update the limits occasionally.
Sometimes that's the only way a user can find out that the BIOS or ACPI or
whatever is modifying chip values behind our backs.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
