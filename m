From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 03 Dec 2005 12:45:53 +0000
Subject: [lm-sensors] Re: Incorrect v4l patch in 2.6.15-rc4-git1
Message-Id: <20051203124715.52f8d736.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051202192814.282fc10c.khali@linux-fr.org>
	<1133602035.6724.5.camel@localhost>
In-Reply-To: <1133602035.6724.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>

Hi Mauro

> Em Sex, 2005-12-02 ?s 19:28 +0100, Jean Delvare escreveu:
> > Hi Linus,
> > 
> > Please revert this commit:
> > 
> > author	Mauro Carvalho Chehab <mchehab@brturbo.com.br>
> > 	Thu, 1 Dec 2005 08:51:35 +0000 (00:51 -0800)
> > committer	Linus Torvalds <torvalds@g5.osdl.org>
> > 	Thu, 1 Dec 2005 23:48:57 +0000 (15:48 -0800)
> > commit	769e24382dd47434dfda681f360868c4acd8b6e2
> > tree	1be728dd2f1a7f523e3de5f3f39b97a4b9905dbe
> > parent	6f502b8a7858ecfa7d2a0762f7663b8b3d0808fc
> > 
> > [PATCH] V4L: Some funcions now static and I2C hw code for IR
> > 
> > - Some funcions are now declared as static
> > - Added a I2C code for InfraRed.
> 
> 	Please point what is so deadly broken on this trivial patch that fix a
> bug where a prodution driver is using I2C code reserved for
> experimentation.

I never said it was deadly broken, just that it wasn't correct (fact)
and probably shouldn't have been accepted at this point of the release
cycle (opinion).

Using an experimental ID is certainly bad and fixing it is welcome, but
this isn't causing any immediate bug as far as I can see. You don't even
use the ID anywhere at the moment.

My point is that defining a new ID just before 2.6.15 when we know
we'll change it right after 2.6.15 is a bad engineering practice. More
importantly, I am asking what the point is of publishing patches for
review before they get integrated if they'll be integrated regardless
of objections. If we can't deal with that kind of situation, our
development process probably needs to be improved - even if in this
one case the harm done is admittedly neglectable.

I'll go undefine these experimental IDs soon anyway, as the concept is
broken IMHO. If driver authors don't use the ID, they can set it to 0.
If they do use it, they better register it soon so as to avoid
collisions with other drivers which haven't been merged either.

Thanks,
-- 
Jean Delvare
