From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: I2C on 2.6
Message-Id: <20040210081548.GH20139@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
In-Reply-To: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 09, 2004 at 06:39:20PM -0800, Jon Smirl wrote:
> Thanks for the explanation, PCI, I2C, SCSI and USB all make sense now. I hadn't
> realized that USB hubs were also USB devices. This is all new so some things
> aren't obvious to me.
> 
> So looking at it from a symmetry point of view then shouldn't all entries in
> /sys/bus have a parallel entry in /sys/class like 'bus'_host?

That might be a good idea, for 2.7

> I have these buses:
> i2c                   i2c-adapter
> ide
> ieee1394
> pci                   pci_bus
> platform
> scsi                  scsi_host
> usb                  usb_host
> 
> What do you think about moving the 'host' class directories out of /class and
> into the bus directory? For example move /sys/class/usb_host to
> /sys/bus/usb/host, /sys/class/i2c_adapter to /sys/bus/i2c/adapter (or host).

That would take some driver core changes to do this.  Also 2.7 work.

> Moving the 'host' items out of /sys/class will make /sys/class have more of a
> direct correspondence with /udev.

But there's no reason it has to have a directo correspondence with what
udev sees.  udev is smart enough to only care about the devices that
have a "dev" file.  And none of the above do, for now.  But some types
of host controllers might in the future, who knows :)

thanks,

greg k-h
