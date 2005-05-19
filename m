From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] i2c driver changes for 2.5.64
Message-Id: <20030315214623.GB13446@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10476033263399@kroah.com> <10476033262095@kroah.com> <20030315104901.A3923@ucw.cz>
In-Reply-To: <20030315104901.A3923@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Sat, Mar 15, 2003 at 10:49:01AM +0100, Vojtech Pavlik wrote:
> On Thu, Mar 13, 2003 at 04:55:00PM -0800, Greg KH wrote:
> >  static struct pci_driver amd8111_driver = {
> > -	.name		= "amd8111 smbus 2.0",
> > +	.name		= "amd8111 smbus",
> 
> The 2.0 was quite intentional in the .name, because the 8111 has *two*
> SMBus busses, one SMBus 1.1 and one SMBus 2.0. This driver is only for
> the 2.0 SMBus controller.

Ah, I removed the "2.0" portion because it was larger than the 16
character limit for pci driver names (it shows up in sysfs garbled if
it's bigger).

Would "amd8111 smbus 2" be an ok name?

thanks,

greg k-h
