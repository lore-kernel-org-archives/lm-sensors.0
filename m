From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [RFC] driver core support for i2c bus and drivers
Message-Id: <20030318012718.GB4904@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030310072337.GJ6512@kroah.com> <3E6D0D25.26B5584F@attbi.com> <3E7676F7.40209@paradyne.com>
In-Reply-To: <3E7676F7.40209@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark D. Studebaker " <mds@paradyne.com>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 08:31:35PM -0500, Mark D. Studebaker  wrote:
> 
> our userspace tools use the /proc/bus/i2c file and (of course) the entire
> tree of exported sysctl info under /proc/sys/dev/sensors
> (as implemented in i2c-proc.c).

Right now, the /proc and sysctl code is not changed at all.

However, the end goal will be to remove the /proc and sysctl code
entirely, and just use sysfs, as this is exactly what sysfs is for.  I
know, in order to do this properly the userspace library will need to be
changed, and I'm willing to do this work too.  I do not want to break
userspace compatibility needlessly.

I'll not remove anything until the same functionality can be achieved,
is this ok?  I will, of course, provide patches that for people to
evaluate, when it's working...

> Does your proposal or Cristoph's recent changes affect these?

Christoph's changes preserve the existing code, but make it work without
oopses :)

thanks,

greg k-h
