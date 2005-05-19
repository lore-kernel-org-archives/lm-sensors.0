From: js@convergence.de (Johannes Stezenbach)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: 2.6.0-test11: i2c-dev.h for userspace
Message-Id: <20031212185357.GB32169@convergence.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031212145652.GA30747@convergence.de> <20031212175656.GA2933@kroah.com>
In-Reply-To: <20031212175656.GA2933@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 09:56:57AM -0800, Greg KH wrote:
> On Fri, Dec 12, 2003 at 03:56:52PM +0100, Johannes Stezenbach wrote:
> > 
> > I had some trouble compiling a userspace application
> > which uses the I2C device interface (the DirectFB
> > Matrox driver). Apparently some stuff has been removed
> > from i2c-dev.h
> 
> Yes it has.  Do not use the kernel headers in your userspace
> application.  If you need this interface, use the updated i2c-dev.h that
> is in the lmsensors release.  That is the proper file.

I think you create a mess here. Other drivers have usable
API include files in /usr/include/linux, why are i2c.h and i2c-dev.h
special?

While I can understand why the ioctl wrappers have been removed
from the kernel include file i2c-dev.h I fail to see the logic
in having a different i2c-dev.h for userspace, or generally breaking
the kernel includes for userspace.

It seems to me that there is no package that I could install to make
the correct i2c-dev.h available for userspace programs, and the only
way to fix the DirectFB Matrox driver so it compiles with 2.4 and
2.6 kernel headers is to copy the correct i2c-dev.h into the
DirectFB source tree.

I think that sucks.


Johannes
