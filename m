From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] i2c driver changes for 2.5.64
Message-Id: <20030322115455.0200e7bb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10476033213315@kroah.com>
In-Reply-To: <10476033213315@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > If so, any hope of merging the two to make it at least sane?  :)
> 
> sounds like more trouble than it is worth;
> hard to move files in CVS without losing the history.

Actually, I read the CVS docs some days ago, and there seem to be a
command for that. See there:
http://www.cvshome.org/docs/manual/cvs_7.html#SEC70

OK, doesn't sound easy, but not impossible. What about using method 1
(7.4.1 in the docs) and simply add some header comment in the new file
stating the old name, so that one can get the history if needed?

(...)

> > Why care about backwards compatibility?  Hopefully there will not
> > need to be a cvs tree for the kernel portions of the i2c code if we
> > get all of the code into the main kernel tree.
> > 
> 
> We have a large number of 2.4-based "customers". Our project is
> ranked in the top 100 on freshmeat (no idea if that means anything,
> though :) If our 2.7.0 release last December was the last
> 2.4-compatible release, how bad is that? I don't know. Unless we get a
> patch into 2.4, it will be, because of the i2c_driver struct change
> that's already been made in CVS. I'm guessing we want to release
> 2.4-compatible packages for another year? But maybe that's hopelessly
> ambitious. Maybe 2.7.0 will have to be it. Kyosti was optimistic that
> on the lm_sensors side (as opposed to i2c), we could stay compatible
> with 2.4 and 2.5 in one branch. But he hasn't been heard from in a
> while...

I really think we shouldn't give our preference to compatibility over
code cleanness. We could simply keep 2.7.0 as our pre-heavy-work
release, and do the minimum bugfixes to it when required, no more. Once
"everything" is integrated into the kernel (and you have gone too far
already for this not to happen), nobody will care about the old code
anymore, so I don't think it's clever to spend too many time on it.

Just my opinion, though.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
