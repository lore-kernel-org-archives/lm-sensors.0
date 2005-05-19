From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: add eeprom i2c driver
Message-Id: <20030326213723.GC26886@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030325172024.GC15823@kroah.com>
In-Reply-To: <20030325172024.GC15823@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 25, 2003 at 06:17:00PM -0500, Mark Studebaker wrote:
> Jean described the history of the driver well.
> 
> I would call it more of a "demonstration" driver than something
> that is exceptionally useful.
> (the CVS continues that tradition, I added I2C Block read capability to the
> driver, more as a demonstration and block read test than anything else).
> 
> It's also useful to us as a diagnostic tool with users -
> (if eeprom works then the i2c bus works. if eeprom is the only
> thing found on the i2c bus then the sensors must be on the ISA bus).

Well, that's a good reason for it to stick around, right?

> As such, I'm not really sentimental about the existing interface in /proc
> or what it could be in sysfs, or whether it goes into the kernel at all. 
> If the debate makes it more trouble than
> it's worth to get into the kernel, it can stay out of the kernel
> as far as I'm concerned.
> 
> For Greg, it's probably best to start with lm75, not eeprom, to review
> the changes W.R.T. sysfs.

Good point, I've sent my patch for lm75 to the list.

It looks like the binary files for sysfs support isn't as easy when you
are in the driver model, so it will take a bit longer to add that
support (need to add some driver core wrapper support first).  But that
is the way the eeprom driver should move to.

thanks,

greg k-h
