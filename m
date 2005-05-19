From: jonsmirl@yahoo.com (Jon Smirl)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: I2C on 2.6
Message-Id: <20040210023920.62991.qmail@web14909.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
In-Reply-To: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the explanation, PCI, I2C, SCSI and USB all make sense now. I hadn't
realized that USB hubs were also USB devices. This is all new so some things
aren't obvious to me.

So looking at it from a symmetry point of view then shouldn't all entries in
/sys/bus have a parallel entry in /sys/class like 'bus'_host?

I have these buses:
i2c                   i2c-adapter
ide
ieee1394
pci                   pci_bus
platform
scsi                  scsi_host
usb                  usb_host

What do you think about moving the 'host' class directories out of /class and
into the bus directory? For example move /sys/class/usb_host to
/sys/bus/usb/host, /sys/class/i2c_adapter to /sys/bus/i2c/adapter (or host).

Moving the 'host' items out of /sys/class will make /sys/class have more of a
direct correspondence with /udev.

--- Greg KH <greg@kroah.com> wrote:
> On Mon, Feb 09, 2004 at 05:09:27PM -0800, Jon Smirl wrote:
> > I see now that the usb hosts are in /sys/class/usb_host. But to be
> symetrical
> > with USB and PCI we should have i2c-1, i2c-2, etc in /sys/bus/i2c/devices.
> 
> Again no.  See my other response to you for why.
> 
> Remember, a i2c adapter is not a i2c device.
> 
> But a USB controller does contain a USB device (at least one, usually
> more than one these days) within itself.
> 
> thanks,
> 
> greg k-h

==Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html
