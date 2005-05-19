From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c changes Was: sensors in 2.5.54
Message-Id: <20030108211525.GC32645@atrey.karlin.mff.cuni.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0301070020190.17118-200000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0301070020190.17118-200000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

> >One could generate a branch in CVS from i2c release V2-6-4 to trace back
> >changes in 2.5 tree, and then reapply it on 2.5 to sync revision tags.
> >I briefly reviewed some i2c diffs, they mostly handle module refcounting
> >and declarations which are not likely to change for 2.4 support.
> >
> 
> I have Pavel's mail from December 4 to linux-kernel with his submission,
> which is taken from the contents of our 2.7.0 release of Dec. 8.
> Right Pavel? (if you made changes before you submitted the patch

I made multiple submissions and slightly cleaned up files in between
(comments came after submissions of what needs to be fixed). I
certainly did not do any functional changes.

> let's start by having you check those changes in!)

I don't think I have cvs write access...

							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
