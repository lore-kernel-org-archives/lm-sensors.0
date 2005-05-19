From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: 2.4.22 kernel patches available
Message-Id: <20030908185015.GA1694@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030831172730.775fb950.khali@linux-fr.org>
In-Reply-To: <20030831172730.775fb950.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Sep 07, 2003 at 06:21:30PM +0200, Jean Delvare wrote:
> > > I feel like we should complain about that, but unfortunately I don't
> > > have time for that right now. Greg, you have more contact with the
> > > kernel people than any of us here, do you have any information we
> > > don't have?
> > 
> > Why complain?  What is it hurting?  The cvs code sure isn't in the
> > kernel tree so what do we have to base our complaint on?  :)
> 
> The I2C architecture as we know it has been defined some years ago,
> IIRC.  And the i2c subsystem is regularly updated from our CVS repository
> AFAIK (although it has been some time since it was last done).

It has been quite a while for a 2.4 sync up, right?

> People needing I2C IDs should know they have to ask. People wanting to
> write I2C drivers should read our docs and follow the guidelines. Or
> why are we writing docs?

These docs are not in the kernel tree.  People are free to do what they
want with the kernel source.  Hence changes happen, deal with it, this
is normal :)

And as there hasn't been an active i2c kernel maintainer for a long
time, it's normal that others start to make changes to the code.

> > So I'm guessing that some people with MIPS platforms actually use this
> > driver.  Good for them.  I would not recommend that your patches "wipe
> > them out" for that reason.
> 
> I wiped them out because they would not *compile* and I don't want
> people to think that our patch is faulty, while it isn't.

How did you build these drivers?  They need a mips configuration and
probably cross compiler.  Did you do that or something else?

> I think that we should preserve the sibyte driver (and algo).

Agreed.

> But I want the i2c-max1617 driver out, because we *do* have a driver
> for that chip for a very long time, which respects the overall
> architecture, with procfs and libsensors support. So we just don't
> need another, poor max1617 driver.

As long as you don't break the in-kernel driver, that's fine with me.

But remember, the sysctl stuff is _not_ going into the main 2.4 kernel
tree (at least not through me...)  So I don't really know how a 2.4
merge will happen.

thanks,

greg k-h
