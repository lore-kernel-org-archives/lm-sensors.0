From: prom@berlin.ccc.de (prom@berlin.ccc.de)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: 2.5 integration
Message-Id: <20020204055303.GA6150@berlin.ccc.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi list

i finally got some time to get a closer look at
your patch generation script and (after having
*some* problems with my first try to generate
patches for 2.5) have found that this isn't as
easy as i believed it would be. I just started
making patches manually, but this can't be a
solution for more than a few patches.

Although the current build system in 2.5 is
rather a hack to make life till arrival of
kbuild/CML2 easier, it would be a good idea
to rewrite mkpatch.pl to correctly handle
the new structure.

Also, i am asking myself how files like
i2c-ppc405.h should be handled. Did i miss
anything or are they completely unhandled
in the current mkpatch.pl configuration?

Ingo

PS Please CC me for now. I'll send the second
subscription request to phil in a few minutes,
but until he responds...

-- 
Let the people think they govern and they will be governed.
                -- William Penn, founder of Pennsylvania
