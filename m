From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH 2.4] i2c-dev user/kernel bug and mem leak
Message-Id: <20030814223404.3dfa59c7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806100702.78298ffe.khali@linux-fr.org>
In-Reply-To: <20030806100702.78298ffe.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Everyone using lm_sensors uses i2c-dev, because our sensors-detect
> > script relies on it. Our i2cdump tool also relies on it, and this
> > tool is oh so precious to us developpers. Writing new chip drivers
> > and debugging existing chip drivers would be almost impossible
> > without it.
> 
> Yes, developers, and the initial detect script do use it, but that's
> it, right?

Yes, that is. Additionally, some people may be using it for driving
specific i2c chips that do not have a driver yet. But they should have
written a driver instead, and send it to us too, so since they did not,
they are considered bad guys, and we don't care about breaking their
toys ;)

> And because of that, we shouldn't break the 2.4 user/kernel interface,
> right?

The change you are talking about is obviously too much for 2.4.

> I'm not saying to take away that functionality at all, I was just
> suggesting a different type of interface (fs instead of ioctls).  It's
> nice to know that there are so few users (only developers and 1
> userspace program) so that any changes would only have to be made to
> those users.

And it's even nicer to know you'll have our unconditional support if
something like that is decided :)

> It's also quite telling that there is not a 64 bit thunking layer for
> the i2c-dev ioctls, showing that there really isn't a use for it
> outside i386 platforms.  With more and more amd64 motherboards showing
> up, and ppc64 oddities appearing, I imagine that they will soon start
> showing i2c devices that we need to support.  Making a
> platform-neutral interface, which also allows any programming language
> to work with it, would probably be a good thing for the future.
> 
> But, as I don't have any code to back these claims up right now, I'll
> just shut up about it :)

I don't have code either, and this is probably above my anyway, so I'll
do just the same. Come here Greg, let's shut up together and feel less
lonely in our silence ;)

Of course you won't shut up, because nothing related to i2c in 2.6 could
be done without your so precious help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
