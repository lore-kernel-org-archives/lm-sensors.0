From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: 2.4.22 kernel patches available
Message-Id: <20030924205707.GU11234@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030831172730.775fb950.khali@linux-fr.org>
In-Reply-To: <20030831172730.775fb950.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 13, 2003 at 10:53:10PM +0200, Jean Delvare wrote:
> > > People needing I2C IDs should know they have to ask. People wanting
> > > to write I2C drivers should read our docs and follow the guidelines.
> > > Or why are we writing docs?
> > 
> > These docs are not in the kernel tree.  People are free to do what
> > they want with the kernel source.  Hence changes happen, deal with it,
> > this is normal :)
> 
> OK, I guess I got angry a bit fast, and would like to appologize for
> that.
> 
> The docs *are* in the kernel tree. Exerpt from
> linux-2.4.22/Documentation/i2c/writing-clients:
> 
> "The id should be a unique ID. The range 0xf000 to 0xffff is reserved
> for
> local use, and you can use one of those until you start distributing the
> driver. Before you do that, contact the i2c authors to get your own
> ID(s)."
> 
> If you think things should be made clearer, please suggest some changes
> and we'll apply them.

Ah, missed that, sorry.

Hm, now why do we need ids anyway?  I've looked at the adapter ids, and
removed almost all usages of then in the 2.6 kernel as no one except
some video drivers used them.  I'll hack on the video drivers in some
point in the future to get rid of that id all together.

Do we do anything with client ids?

> > And as there hasn't been an active i2c kernel maintainer for a long
> > time, it's normal that others start to make changes to the code.
> 
> May I volunteer to be listed as the maintainer? IIRC, Frodo's name is
> still listed, while he hasn't been seen around for several months (if
> not a few years). If I don't know anything about I2C, it's probably
> better to have a maintainer with my level of knowledge than nobody at
> all.

Sure, send a patch.

thanks,

greg k-h
