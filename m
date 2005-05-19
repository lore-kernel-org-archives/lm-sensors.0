From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: I2C on 2.6
Message-Id: <20040212011803.GB15983@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
In-Reply-To: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 10, 2004 at 07:20:25AM -0800, Jon Smirl wrote:
> --- Greg KH <greg@kroah.com> wrote:
> > > What do you think about moving the 'host' class directories out of /class
> > and
> > > into the bus directory? For example move /sys/class/usb_host to
> > > /sys/bus/usb/host, /sys/class/i2c_adapter to /sys/bus/i2c/adapter (or host).
> > 
> > That would take some driver core changes to do this.  Also 2.7 work.
> > 
> > > Moving the 'host' items out of /sys/class will make /sys/class have more of
> > a
> > > direct correspondence with /udev.
> > 
> > But there's no reason it has to have a directo correspondence with what
> > udev sees.  udev is smart enough to only care about the devices that
> > have a "dev" file.  And none of the above do, for now.  But some types
> > of host controllers might in the future, who knows :)
> 
> /sys/class is starting to feel a little confusing to me. And there are a lot
> more devices that don't have sysfs enabled yet that are going to end up in
> /sys/class too.  Currently /sys/classs holds two classes of entries: hosts and
> devs. Are you sure you don't want to get the hosts out of there before software
> get written using them and it's too late to move them?

And how do you propose doing this?  It will take some driver core
mangling to do this.

And what's really wrong with it?

> Is anything already using /class/sys/'host' entries? Or is the driver work just
> what is needed to move the location of the directory?

Driver core work and driver bus work would be needed.

It's much simpler the way things currently are.  Leave this as a 2.7
thing to do if you really don't like it :)

thanks,

greg k-h
