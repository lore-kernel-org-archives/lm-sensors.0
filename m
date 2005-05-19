From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] restore correct vaio handling in eeprom driver
Message-Id: <20040116012544.GP23253@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111205346.6182c330.khali@linux-fr.org>
In-Reply-To: <20040111205346.6182c330.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 15, 2004 at 06:55:48PM +0100, Jean Delvare wrote:
> > > Here is a patch to the eeprom driver in 2.6.1 that changes the way
> > > Vaio eeproms are handled. In 2.6.1, the eeprom is readable only by
> > > root, which isn't consistent with the 2.4 driver which simple hides
> > > (i.e. fills it with zeroes) the first row (16 bytes) of the eeprom
> > > to regular users.
> > > 
> > > The patch restores a similar behaviour in the 2.6 driver. Greg, feel
> > > free to apply it if you like it.
> > 
> > Hm, why not just prevent the user from reading those bytes at all?
> > Something like what the pci core does for the pci config files (see
> > drivers/pci/pci-sysfs.c::pci_read_config().
> > 
> > I'd take that kind of a patch :)
> 
> I took a look at that piece of code this morning. I don't see how I
> could apply the same here.
> 
> In pci-sysfs.c, the result of capable() defines how much bytes you can
> read (with offset=0). 256 bytes for sysadmin, else 128 or 64 depending
> on some device type. This makes sense, because if for example a
> non-sysadmin user asks for 256, he/she will get the first 128 or 64
> only, and will be warned about that.
> 
> Now for the eeprom driver, the sensible part that should be hidden to
> non-sysadmin users is the *first* row (16 bytes) of data.

Ah, oops, you are correct, sorry about that.  I'll go apply that patch
then...

> I agree that code simplicity matters at least as much as speed, but the
> speedup is as important as *8 for regular eeproms and *4 for Vaio
> eeproms. This is much IMHO, and at least enough to consider it as a
> serious option. Maybe you could take a look at how it is done in our 2.4
> driver and see if you really don't want something of that kind in 2.6?
> The eeprom driver is so simple that a little more complexity should be
> still easily understandable.

Depends on what the patch looks like.  Care to make it up to see if it's
not too ugly?

thanks,

greg k-h
