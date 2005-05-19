From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: [PATCH] More i2c driver changes for 2.5.66
Message-Id: <20030403163757.GA4473@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1049328958830@kroah.com> <3E8BD2D9.8050002@attbi.com> <20030403063359.GA1536@kroah.com> <3E8C31BE.5060000@attbi.com>
In-Reply-To: <3E8C31BE.5060000@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Albert Cranford <ac9410@attbi.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Thu, Apr 03, 2003 at 08:06:06AM -0500, Albert Cranford wrote:
> Your right, nobody outside of sensors uses i2c-proc, but
> why not create a new i2c-sysfs.h in drivers/i2c locally
> and and adjust the couple of existing drivers.

What would i2c-sysfs.h be needed for?  All of the needed sysfs prototype
functions are already in device.h.

> We all know the application library is not going to have
> access to include/linux/include/i2c-xxxx.h anyhow.

It never did :)

> Later we can completely remove linux/include/linux/i2c-proc.h
> which the existing application library relies upon.

No userspace program should rely on kernel header files.
And I didn't take away the functionality that i2c-proc.h provided with
the list of devices supported and such.  Just the unused function
prototypes that dealt with the proc and sysctl interface.

thanks,

greg k-h
