From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: lm sensors sysfs file structure
Message-Id: <20030328074031.GA29404@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048806052.10675.4440.camel@cube> <20030327231027.GC1687@kroah.com> <1048836107.4776.2285.camel@workshop.saharact.lan>
In-Reply-To: <1048836107.4776.2285.camel@workshop.saharact.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>, sensors@stimpy.netroedge.com

On Fri, Mar 28, 2003 at 09:21:48AM +0200, Martin Schlemmer wrote:
> 
> Silly w83781d again.  temp1 is a u8, and temp2 and temp3 is u16
> (if they are supported on the specific model.
> 
> Should we do any bounds checking on input via sysfs ?

So that you can't hurt your hardware or crash the os, yes.

I think the write ability is limited to root, so that's a good first
step too.

thanks,

greg k-h
