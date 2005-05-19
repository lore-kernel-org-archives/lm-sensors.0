From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c changes Was: sensors in 2.5.54
Message-Id: <20030107143653.GA32318@atrey.karlin.mff.cuni.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0301070020190.17118-200000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0301070020190.17118-200000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

> > The patch for i2c-amd756, i2c-amd8111, adm1021, and lm75,
> > submitted by Pavel Machek, has been included,
> > with modifications, in kernel 2.5.54 by Cristoph Hellwig.
> 
> Attached patch removes unnecessary include of i2c header files
> at few locations. With luck it still compiles. Should..

In such case, post it to Linus ;-) [or maybe trivial patch monkey].

> > Note that we'll have to go through the changes he made,
> > figure them out, backport them into CVS, and apply
> > to the other drivers.
> >
> > This will be somewhat easier after we remove 2.2 support.
> > But there are still several 2.4<->2.5 differences which
> > we will have to keep out of CVS, or at least #ifdef,
> > and the patcher will have to deal with those.
> 
> One could generate a branch in CVS from i2c release V2-6-4 to trace back
> changes in 2.5 tree, and then reapply it on 2.5 to sync revision tags.
> I briefly reviewed some i2c diffs, they mostly handle module refcounting
> and declarations which are not likely to change for 2.4 support.
> 
> Optimally, we could keep up with the pace and have relevant 2.5 patches
> go through i2c CVS first and have files in sync. This seems not be the
> case, so I say it is better to remove revision tags from i2c files in
> Linus's tree altogether.

Well, you know linus's opinion about CVS. Probably the best thing
would be to remove kernel drivers from your CVS and do all
development in the Linus's tree....
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
