From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: 2.4.22 kernel patches available
Message-Id: <20030913225310.74c2a284.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030831172730.775fb950.khali@linux-fr.org>
In-Reply-To: <20030831172730.775fb950.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > The I2C architecture as we know it has been defined some years ago,
> > IIRC.  And the i2c subsystem is regularly updated from our CVS
> > repository AFAIK (although it has been some time since it was last
> > done).
> 
> It has been quite a while for a 2.4 sync up, right?

Right. August 2001. Quite a while, as you say.

> > People needing I2C IDs should know they have to ask. People wanting
> > to write I2C drivers should read our docs and follow the guidelines.
> > Or why are we writing docs?
> 
> These docs are not in the kernel tree.  People are free to do what
> they want with the kernel source.  Hence changes happen, deal with it,
> this is normal :)

OK, I guess I got angry a bit fast, and would like to appologize for
that.

The docs *are* in the kernel tree. Exerpt from
linux-2.4.22/Documentation/i2c/writing-clients:

"The id should be a unique ID. The range 0xf000 to 0xffff is reserved
for
local use, and you can use one of those until you start distributing the
driver. Before you do that, contact the i2c authors to get your own
ID(s)."

If you think things should be made clearer, please suggest some changes
and we'll apply them.

> And as there hasn't been an active i2c kernel maintainer for a long
> time, it's normal that others start to make changes to the code.

May I volunteer to be listed as the maintainer? IIRC, Frodo's name is
still listed, while he hasn't been seen around for several months (if
not a few years). If I don't know anything about I2C, it's probably
better to have a maintainer with my level of knowledge than nobody at
all.

> > I wiped them out because they would not *compile* and I don't want
> > people to think that our patch is faulty, while it isn't.
> 
> How did you build these drivers?  They need a mips configuration and
> probably cross compiler.  Did you do that or something else?

I took a look at the code, because I knew I'd have to patch the drivers
so that they follow the new module usage count policy. I saw the IDs,
grep'd the whole source tree and saw they weren't defined anywhere. So I
*know* they wouldn't compile, no need to try.

> > I think that we should preserve the sibyte driver (and algo).
> 
> Agreed.

At least something we agreed on ;)

> > But I want the i2c-max1617 driver out, because we *do* have a driver
> > for that chip for a very long time, which respects the overall
> > architecture, with procfs and libsensors support. So we just don't
> > need another, poor max1617 driver.
> 
> As long as you don't break the in-kernel driver, that's fine with me.

Which basically means you suggest I should keep the i2c-max1617 driver
alive, at least until our own driver is integrated into the official
kernel tree (which, for the 2.4 tree, means: forever, since I don't
think we plan to have lm_sensors drivers integrated there). After some
thinking about it, it's OK for me.

> But remember, the sysctl stuff is _not_ going into the main 2.4 kernel
> tree (at least not through me...)  So I don't really know how a 2.4
> merge will happen.

Well, it will not happen. If it was to happen, that would be after
everyone has moved to Linux 2.6, and would then be pointless IMHO.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
