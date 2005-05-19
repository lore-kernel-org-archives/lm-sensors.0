From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] i2c driver changes for 2.5.64
Message-Id: <20030314085305.GB3084@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10476033153504@kroah.com> <1047603318248@kroah.com> <20030314082142.B11701@infradead.org>
In-Reply-To: <20030314082142.B11701@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Fri, Mar 14, 2003 at 08:21:42AM +0000, Christoph Hellwig wrote:
> On Thu, Mar 13, 2003 at 04:55:00PM -0800, Greg KH wrote:
> > ChangeSet 1.1106, 2003/03/13 10:50:41-08:00, greg@kroah.com
> > 
> > i2c: get i2c-ali15x3 driver to actually bind to a PCI device.
> 
> OOPS, should take a look at all patches first before complaining :)

Heh :)

Yes, for the first changeset I just took the cvs version of the driver
and added it.

Then I went and made the driver work, and started to clean it up.  These
drivers still need a lot of cleanup (static, printk, indentation in
places, etc.) and I'll be doing it.  This is a work in progress.  I
wanted to make baby steps with these things and not just do one
changeset with a description that said:
	Took cvs version of driver and cleaned up everything

I'm trying to bridge the gap between the sensor developers and the
kernel group.  Hopefully by working this way it will help integrate them
more into the kernel community, and get these drivers whipped into
shape.

thanks for looking these over.

greg k-h
