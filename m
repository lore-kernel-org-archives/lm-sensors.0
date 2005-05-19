From: akpm@osdl.org (Andrew Morton)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: kernel maintainer's HOWTO for quilt and -mm
Message-Id: <20050428163121.1343aa6c.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050428223414.GA22785@kroah.com>
	<20050428223622.GC22785@kroah.com>
In-Reply-To: <20050428223622.GC22785@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net, sensors@stimpy.netroedge.com

Greg KH <greg@kroah.com> wrote:
>
> On Thu, Apr 28, 2005 at 03:34:14PM -0700, Greg KH wrote:
> > Examples of the output of this script can be seen at:
> > 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
> 
> Andrew, I'm now putting my broken out patches in this directory so you
> can apply them to the -mm tree.  You can take them in the 4 big chunks
> (they all apply one after each other), or you can take the individual
> patches if you want too (they also apply, one after each other.)  It's
> up to you what is easier for you to handle.
> 
> Does this work out for you?

Yes, it does.  I'm now sucking

	gregkh-01-driver
	gregkh-02-i2c
	gregkh-03-pci
	gregkh-04-USB
	cpufreq
	agp
	alsa

as individual patches and

	linus.patch
	git-ia64.patch
	git-net.patch
	git-scsi-misc.patch
	git-scsi-rc-fixes.patch

from git repos.

It's a bit of a hassle that your patches aren't based on latest -linus.
