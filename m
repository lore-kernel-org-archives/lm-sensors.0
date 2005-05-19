From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH 2.4] i2c-dev user/kernel bug and mem leak
Message-Id: <20030814200032.GB3071@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806100702.78298ffe.khali@linux-fr.org>
In-Reply-To: <20030806100702.78298ffe.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 14, 2003 at 09:48:10PM +0200, Jean Delvare wrote:
> 
> > 4. no one really uses i2c-dev at all...
> 
> Greg, how dare you! What's more, CC'd to the sensors mailing-list! I
> admit it shows your courage though ;)

Heh :)

> Everyone using lm_sensors uses i2c-dev, because our sensors-detect
> script relies on it. Our i2cdump tool also relies on it, and this tool
> is oh so precious to us developpers. Writing new chip drivers and
> debugging existing chip drivers would be almost impossible without it.

Yes, developers, and the initial detect script do use it, but that's it,
right?

And because of that, we shouldn't break the 2.4 user/kernel interface,
right?

> Whatever is decided, please keep that in mind.

I'm not saying to take away that functionality at all, I was just
suggesting a different type of interface (fs instead of ioctls).  It's
nice to know that there are so few users (only developers and 1
userspace program) so that any changes would only have to be made to
those users.

It's also quite telling that there is not a 64 bit thunking layer for
the i2c-dev ioctls, showing that there really isn't a use for it outside
i386 platforms.  With more and more amd64 motherboards showing up, and
ppc64 oddities appearing, I imagine that they will soon start showing
i2c devices that we need to support.  Making a platform-neutral
interface, which also allows any programming language to work with it,
would probably be a good thing for the future.

But, as I don't have any code to back these claims up right now, I'll
just shut up about it :)

thanks,

greg k-h
