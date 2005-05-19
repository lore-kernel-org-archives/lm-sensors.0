From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: 2.6.0-test11: i2c-dev.h for userspace
Message-Id: <20031212175656.GA2933@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031212145652.GA30747@convergence.de>
In-Reply-To: <20031212145652.GA30747@convergence.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johannes Stezenbach <js@convergence.de>, sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 03:56:52PM +0100, Johannes Stezenbach wrote:
> 
> I had some trouble compiling a userspace application
> which uses the I2C device interface (the DirectFB
> Matrox driver). Apparently some stuff has been removed
> from i2c-dev.h

Yes it has.  Do not use the kernel headers in your userspace
application.  If you need this interface, use the updated i2c-dev.h that
is in the lmsensors release.  That is the proper file.

thanks,

greg k-h
