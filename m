From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 30 Aug 2006 11:14:14 +0000
Subject: [lm-sensors] [PATCH 00/14] hwmon updates for 2.6.19
Message-Id: <20060830131414.89e42608.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060828140020.61c81eb0.khali@linux-fr.org>
In-Reply-To: <20060828140020.61c81eb0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

> > Here comes a 14-piece hwmon update patchset. There is a new driver for
> > the thermal sensors embedded in AMD K8 CPUs, many fixes and
> > improvements to the it87 driver, including support for the IT8716F and
> > IT8718F, and a few other things. All these patches should go to -mm for
> > now, and to 2.6.19 later.
> 
> I've applied them all.

Great, thanks :)

> Care to work on all of the __must_check warnings that the hwmon code now
> spits out in the -mm and my trees?  It's quite ugly :(

Mark M. Hoffman and others are already working on that:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017463.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017204.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017462.html

I think we should have about half the drivers fixed for 2.6.19 at this
rate. My own drivers are a bit delayed because I have some conflicting
patches which I need to push to you first.

Note that we decided to abuse the fact that removing a sysfs file which
doesn't exist is not considered an error. It makes our code much more
simple. I hope there is no plan to change this behavior.

I still wonder how the sysfs file creation functions did qualify for
__must_check while nothing bad actually happens if the files are not
created. OK, the files are missing, but kernel-wise this doesn't cause
any broken state as far as I can see.

I've already taken care of drivers/i2c, BTW. You picked the two core
patches some times ago, and I have a third patch for the chip drivers
which I will send to you soon (or you can pick it from the i2c list if
you want it now.)

-- 
Jean Delvare

