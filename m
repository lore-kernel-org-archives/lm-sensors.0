From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:54 +0000
Subject: it87 driver converted to sysfs
Message-Id: <20030424172758.GA27365@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030424150113.GJ1069@iucha.net> <20030424160431.GC18690@kroah.com> <20030424165132.GK1069@iucha.net>
In-Reply-To: <20030424165132.GK1069@iucha.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, chrisg@0-in.com, sensors@stimpy.netroedge.com

On Thu, Apr 24, 2003 at 11:51:32AM -0500, Florin Iucha wrote:
> On Thu, Apr 24, 2003 at 09:04:31AM -0700, Greg KH wrote:
> > A few comments:
> [snip]
> > Other than those very minor things the patch looks good.  Mind fixing
> > them and sending it to me again?
> 
> Thank you, fixed patch inlined.

Thanks, I've applied this and will send it on in a bit.

Oops, I've fixed the call to check_region, which should not have been
made.  Sorry I missed that last time.

greg k-h
