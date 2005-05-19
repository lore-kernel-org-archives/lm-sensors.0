From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: Cross-compile
Message-Id: <20050310040450.GH4472@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0502241106300.6330@boxer.fnal.gov>
In-Reply-To: <Pine.LNX.4.58.0502241106300.6330@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steven:

* Steven Timm <timm@fnal.gov> [2005-02-24 11:08:52 -0600]:
> 
> Since version 2.8.8 of i2c and lm_sensors, I am discovering 
> that the kernel modules are different sizes when compiled under
> i686 and under athlon architectures.  And what is compiled on 

I took a look through lm_sensors2 CVS... I don't see anything that
should cause new behavior in this regard since 2.8.7.

> i686 doesn't work on athlon, and vice versa.  Is this supposed
> to be happening?  Is there any way to compile a generic i386
> version that works on both?

When you compile the kernel modules from the i2c or lm_sensors2 packages,
you will need to have the kernel source available and configured for the
target system.  IOW, the i2c and lm_sensors2 modules build differently
(686 vs. athlon) because the kernel source on the systems is configured
differently.

(At least, that's what I speculate is happening in your case.)

I don't think there's any way to reliably build the modules to work
in both, unless your base kernel is also configured for that (e.g.
the RedHat -i386 builds), but that's probably not what you really want.

I hope that helps; Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
