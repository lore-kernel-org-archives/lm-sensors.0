From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: 2.4.22 kernel patches available
Message-Id: <1064475756.3f729c6cd90ca@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030831172730.775fb950.khali@linux-fr.org>
In-Reply-To: <20030831172730.775fb950.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > The docs *are* in the kernel tree. Exerpt from
> > linux-2.4.22/Documentation/i2c/writing-clients:
> > 
> > "The id should be a unique ID. The range 0xf000 to 0xffff is
> > reserved for local use, and you can use one of those until you
> > start distributing the driver. Before you do that, contact the
> > i2c authors to get your own ID(s)."
> > 
> > If you think things should be made clearer, please suggest some
> > changes and we'll apply them.
> 
> Ah, missed that, sorry.
> 
> Hm, now why do we need ids anyway?  I've looked at the adapter ids,
> and removed almost all usages of then in the 2.6 kernel as no one
> except some video drivers used them.  I'll hack on the video drivers
> in some point in the future to get rid of that id all together.
> 
> Do we do anything with client ids?

No idea. I never dived deep enough in the i2c core. I remember someone
already wondered if they were used (maybe it was you already?), and
seeing how many kernel or third-party drivers use bad IDs, I wouldn't be
surprised if they were not used at all. Or maybe for debugging purposes?

> > May I volunteer to be listed as the maintainer? IIRC, Frodo's name
> > is still listed, while he hasn't been seen around for several
> > months (if not a few years). If I don't know anything about I2C,
> > it's probably better to have a maintainer with my level of
> > knowledge than nobody at all.
> 
> Sure, send a patch.

Mmm, you mean a patch to MAINTAINERS?

Whatever, I should first contact Simon Vogl and Frodo Looijaard to ask
them what they do think about it.

Will do that now, (CC'd to the list, of course).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
