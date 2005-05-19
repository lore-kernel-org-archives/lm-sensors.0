From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: 2.5 integration
Message-Id: <3C5E91FA.3DC65481@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020204055303.GA6150@berlin.ccc.de>
In-Reply-To: <20020204055303.GA6150@berlin.ccc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ingo,

Sorry it's not looking so easy.

You may wish to modify mkpatch.pl or create a new
mkpatch25.pl to make things easier.

One reason to get a patch in soon is to get in before
all the other changes - the build system and whatever else -
that will cause us to catch up.

I think the PPC people are submitting a patch of the
405 stuff. It isn't in mkpatch because you couldn't
patch it until kernel 2.4.something, and mkpatch supports
all 2.2 and 2.4 kernels. There is no facility for
only patching as of a certain kernel.

But the lm-sensors patch should not depend on the i2c patch;
kernel 2.4.13 has i2c-2.6.2 which is all that is necessary.
We're trying hard to maintain compatibility with
kernel 2.4.13 to make things easier for our users
and for patching.

I don't think we've told the I2C list you may be doing a patch,
if you do intend to do an i2c patch we should tell them.

If you need help w/ mkpatch problems let us know.
thanks for your help.
mds


prom@berlin.ccc.de wrote:
> 
> Hi list
> 
> i finally got some time to get a closer look at
> your patch generation script and (after having
> *some* problems with my first try to generate
> patches for 2.5) have found that this isn't as
> easy as i believed it would be. I just started
> making patches manually, but this can't be a
> solution for more than a few patches.
> 
> Although the current build system in 2.5 is
> rather a hack to make life till arrival of
> kbuild/CML2 easier, it would be a good idea
> to rewrite mkpatch.pl to correctly handle
> the new structure.
> 
> Also, i am asking myself how files like
> i2c-ppc405.h should be handled. Did i miss
> anything or are they completely unhandled
> in the current mkpatch.pl configuration?
> 
> Ingo
> 
> PS Please CC me for now. I'll send the second
> subscription request to phil in a few minutes,
> but until he responds...
> 
> --
> Let the people think they govern and they will be governed.
>                 -- William Penn, founder of Pennsylvania
