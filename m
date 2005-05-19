From: ac9410@attbi.com (Albert Cranford)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: remove 2.2 support?
Message-Id: <3E264E28.ECE94904@attbi.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E0E709B.5000900@paradyne.com>
In-Reply-To: <3E0E709B.5000900@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ky?sti M?lkki wrote:
> 
> On Wed, 15 Jan 2003, Mark Studebaker wrote:
> 
> > so, tell me if this is a good plan, or if this is what you said...
> > (sorry if I am still a little confused...)
> >
> > You are going to submit i2c changes (including refcount changes),
> > based on lk2-4, for inclusion in 2.4.21?
> 
> Yes, or actually I hope the one who has been maintaining patches
> so far to 2.4 would comment on this. Albert?
> 
> > And then our i2c 2.8.0 release would be only for kernels 2.4.21+.
> > Our i2c 3.0.0 release (from HEAD) would be only for kernels 2.5.54+.
> > And our 2.7.0 release would be the last for kernels 2.2 - 2.4.20.
> 
> The code from lk2-4 should work and compile with 2.4.9 too.
> The original 2.4.9's i2c drivers (video4linux) will fail to compile, or
> needs patch like the ones for 2.4.20 and 2.4.21-pre3 I posted.
> 
> >From HEAD, I would only support the latest of 2.5. We can use tags like
> lk2-5-90 to note this is i2c as of 2.5.90, I see no point of supporting
> all of 2.5.54+ from HEAD, until 2.6 comes around.
> 
> > If and only if we wanted to make another i2c release that was compatible for
> > kernels 2 4.9 - 2.4.20 (hopefullly not) would we branch again, at the
> > tag POST-2-4-9-KERNELS, and generate a release from that branch.
> 
> Either that to use inc/dec_use refcounting, or create incremental
> patches to modify 2.4 tree i2c drivers for .owner.
> 
> > For sensors we would do something similar, following your
> > instructions below...
> 
> I reworked it a bit:
> 
> > >  - cvs up
> > >  - tag LAST-PRE-2-4-X-KERNEL
> > >  - tag LAST-PRE-2-8-0-I2C
> > >  - drop < 2-4-X support
> > >  - fix module refcounting to use .owner
> > >  - tag POST-2-8-0-I2C
> > >  - consider PCI changes 2.4<->2.5, branch if necessary
> 
> Looking at amd756 ported back from 2.5, the PCI changes are apparently
> in 2.4 too. There may not be need to branch sensors at all, as the
> dependency is to the .owner refcounting that applies to both 2.4
> and 2.5 trees if our i2c lk2-4 is accepted.
> 
> The tag LAST-PRE-2-4-X-KERNEL is to branch if we find severe problems
> we need to fix for 2.2 kernels. Hopefully not.
> 
> I have got sensors .owner changes in my working directory.
> While at it, I have changed drivers to use module_init/exit, have
> removed a lot of #ifdef MODULE everywhere. And just generally break it.
> 
> --
>   Ky?sti M?lkki
>   kmalkki@cc.hut.fi

I could put my $0.02 in, but Linus will not accept patches
from me anymore.  My belief is the changes you are making
would make him happy and give him faith that the drivers
have very good support.  I was screwing this up.

I would hope that any created patch could be reviewed and
tested by sensors people before submitting.

BTW Linus only accepts 2.5 patches.torvalds@transmeta.com
and Marcello accepts 2.4 patches.marcelo@conectiva.com.br
Albert
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@attbi.com
