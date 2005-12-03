From: mchehab@brturbo.com.br (Mauro Carvalho Chehab)
Date: Sat, 03 Dec 2005 19:57:23 +0000
Subject: [lm-sensors] Re: Incorrect v4l patch in 2.6.15-rc4-git1
Message-Id: <1133636181.6724.43.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051202192814.282fc10c.khali@linux-fr.org>
	 <1133602035.6724.5.camel@localhost>
	 <20051203124715.52f8d736.khali@linux-fr.org>
In-Reply-To: <20051203124715.52f8d736.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>

Hi Jean,
Em S?b, 2005-12-03 ?s 12:47 +0100, Jean Delvare escreveu:
> Hi Mauro
> 
> > Em Sex, 2005-12-02 ?s 19:28 +0100, Jean Delvare escreveu:
> > > Hi Linus,
> > > 
> > > Please revert this commit:
> > > 
> > > author	Mauro Carvalho Chehab <mchehab@brturbo.com.br>
> > > 	Thu, 1 Dec 2005 08:51:35 +0000 (00:51 -0800)
> > > committer	Linus Torvalds <torvalds@g5.osdl.org>
> > > 	Thu, 1 Dec 2005 23:48:57 +0000 (15:48 -0800)
> > > commit	769e24382dd47434dfda681f360868c4acd8b6e2
> > > tree	1be728dd2f1a7f523e3de5f3f39b97a4b9905dbe
> > > parent	6f502b8a7858ecfa7d2a0762f7663b8b3d0808fc
> > > 
> > > [PATCH] V4L: Some funcions now static and I2C hw code for IR
> > > 
> > > - Some funcions are now declared as static
> > > - Added a I2C code for InfraRed.
> > 
> > 	Please point what is so deadly broken on this trivial patch that fix a
> > bug where a prodution driver is using I2C code reserved for
> > experimentation.
> 
> I never said it was deadly broken, just that it wasn't correct (fact)
> and probably shouldn't have been accepted at this point of the release
> cycle (opinion).
> 
> Using an experimental ID is certainly bad and fixing it is welcome, but
> this isn't causing any immediate bug as far as I can see. You don't even
> use the ID anywhere at the moment.
	No, but it offers a potential but of somebody else's using it, making
hard to diagnose. I've noticed a problem some time ago with a driver
using a bad ID, that was not properly handled by i2c probing routines.
> 
> My point is that defining a new ID just before 2.6.15 when we know
> we'll change it right after 2.6.15 is a bad engineering practice. 
	As you and Greg pointed me before more than once, internal kernel
interfaces are subject to change from release to release. If so, what's
the problem of just changing one name? I'll prepare a patch renaming it
to a better name as you suggested me in priv (I2C_DRIVERID_INFRARED),
but anyway, it is just better to have a not-so-good name than using the
experimental one (I2C_DRIVERID_EXP3).
> More
> importantly, I am asking what the point is of publishing patches for
> review before they get integrated if they'll be integrated regardless
> of objections. If we can't deal with that kind of situation, our
> development process probably needs to be improved - even if in this
> one case the harm done is admittedly neglectable.
	As you said, neglectable damage in this case. And, in fact, this is
really a trivial patch. If we had some damage, somebody may point or
send another patch to fix. We are very close to 2.6.15, and we shouldn't
stop bug fixing because of minor details.
> 
> I'll go undefine these experimental IDs soon anyway, as the concept is
> broken IMHO. If driver authors don't use the ID, they can set it to 0.
> If they do use it, they better register it soon so as to avoid
> collisions with other drivers which haven't been merged either.
	Agreed! you have my support on it! during this kernel cycle, both you
and me found at V4L lots of experimental (and its own i2c_id.h file)
that we did removed from kernel. Having experimeental IDs
 

(and non-official codes) only generates mess and may be a source of hard
to diagnose bugs.
> 

> Thanks,
Chee
rs, 
Mauro.

