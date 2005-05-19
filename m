From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: CONFIG_xxxx inconsistency
Message-Id: <3BDF50E7.859416A0@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20011028233121.A2816@werewolf.able.es>
In-Reply-To: <20011028233121.A2816@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Now I'm wondering if we changed things in the wrong direction.
Rather than going from "old" to "new" should we have gone
from "new" to "old".

Since the kernel has "old" CONFIG_xxx things,
won't us changing things lead to problems with compiles outside
of the kernel (which check for definitions of CONFIG_xxx)
and also unnecessary patches?

Seems like it would be safer to go back to the "old" and
make sure the few places that used "new" were switched to "old".

what do you all think?




"J . A . Magallon" wrote:
> 
> On 20011028 Mark D. Studebaker wrote:
> >The "new" (like CONFIG_I2C_PCFISA) and "old" (like CONFIG_I2C_ELEKTOR)
> >have coexisted in our code since as far back as our CVS records go,
> >mid-1999.
> >
> >I thought something had changed recently in the kernel tree to mess
> >things
> >up but that's not the case. The kernel has all "old" CONFIG things.
> >
> 
> No, the problem (as I saw it) was not related to any kernel in particular.
> There were zones of code like:
> 
> #ifdef CONFIG_I2C_BITVELLE
>     extern int i2c_bitvelle_init(void);
> #endif
> ...
> #ifdef CONFIG_I2C_VELLEMAN
>     i2c_bitvelle_init();
> #endif
> 
> and the new option did not appear anywhere to be defined/undefined, so
> building i2c in static mode you din't nad any prototypes...do not know
> if there could be any more serious problem.
> 
> >I'll apply your patch to make them all "new".
> >
> 
> Thanks, just cvs_upated.
> 
> More to come...
> 
> TIA
> 
> --
> J.A. Magallon                           #  Let the source be with you...
> mailto:jamagallon@able.es
> Mandrake Linux release 8.2 (Cooker) for i586
> Linux werewolf 2.4.13-ac3-beo #1 SMP Sun Oct 28 09:44:34 CET 2001 i686
