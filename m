From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c changes Was: sensors in 2.5.54
Message-Id: <20030108211840.GA559@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0301070020190.17118-200000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0301070020190.17118-200000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

> >Optimally, we could keep up with the pace and have relevant 2.5 patches
> >go through i2c CVS first and have files in sync. This seems not be the
> >case, so I say it is better to remove revision tags from i2c files in
> >Linus's tree altogether.
> 
> For i2c, we've kept up for years - in fact we have the opposite problem now,
> we have lots of stuff in the i2c tree that we haven't gotten in to either 
> 2.4 or 2.5.
> (2.4 is at our release 2.6.1, about 15 months old, and 2.5 is at 2.6.4, 
> about
> 15 months old).

Hmm, you probably need to patch-bomb Linus a little ;-).

> Cristoph's changes are largest I can recall that didn't come from us.
> That's what happens when we aren't getting changes in - other
> folks make the changes and we get where we are now.

Well, I hope it is not too bad. One solution to
cvs-and-linus-out-of-sync is of course to drop 2.5 from your CVS and
do all development through Linus... He's not *that* bad at accepting
patches from maintainers.

If you want to keep 2.5 in your CVS, easiest probably is to scan
patch-2.5.XX from linus for any i2c/sensors changes, and if they are
applicable, just apply them to CVS...
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
