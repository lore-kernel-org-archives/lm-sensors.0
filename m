From: greg@kroah.com (Greg KH)
Date: Wed, 30 Aug 2006 15:29:24 +0000
Subject: [lm-sensors] [PATCH 00/14] hwmon updates for 2.6.19
Message-Id: <20060830152924.GB3401@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060828140020.61c81eb0.khali@linux-fr.org>
In-Reply-To: <20060828140020.61c81eb0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 30, 2006 at 01:14:14PM +0200, Jean Delvare wrote:
> > Care to work on all of the __must_check warnings that the hwmon code now
> > spits out in the -mm and my trees?  It's quite ugly :(
> 
> Mark M. Hoffman and others are already working on that:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017463.html
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017204.html
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017462.html

Great.

> Note that we decided to abuse the fact that removing a sysfs file which
> doesn't exist is not considered an error. It makes our code much more
> simple. I hope there is no plan to change this behavior.

Hm, that works?  Ah, nice, I need to remember it, as it would make my
other cleanups easier too.

> I still wonder how the sysfs file creation functions did qualify for
> __must_check while nothing bad actually happens if the files are not
> created. OK, the files are missing, but kernel-wise this doesn't cause
> any broken state as far as I can see.

Why would you not check the return value of a function that provides you
that information?  :)

All of the driver core functions that return errors were marked in this
manner due to a wide range of problems that we have been having for a
while with drivers ignoring problems that the driver core has been
reporting.  We need to handle error conditions better, and this is
finally forcing it to happen.

thanks,

greg k-h

