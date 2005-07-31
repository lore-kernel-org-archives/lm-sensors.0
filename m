From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 31 Jul 2005 23:03:36 +0000
Subject: [lm-sensors] Re: [PATCH 2.6] (10/11) hwmon vs i2c, second round
Message-Id: <20050731230259.05625a4e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050731205933.2e2a957f.khali@linux-fr.org>
	<20050731220224.23136906.khali@linux-fr.org>
	<20050731205650.GA3963@mipter.zuzino.mipt.ru>
In-Reply-To: <20050731205650.GA3963@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Greg KH <greg@kroah.com>

Hi Alexey,

> > I see very little reason why vid_from_reg and vid_to_reg are
> > inlined. The former is not exactly short,
> 
> 1)
> 				   and their arguments aren't known at
> compile time,
> 
> [Compiler can optimise them away _completely_ if both arguments are
> known at compile time or significantly of only one is known.]

Good point, I'll try to remember that. It doesn't apply here though
except for lm78 I think, and maybe lm93 when it gets ported. That's not
the majority of users though, so I still believe uninlining is the
correct decision.

> > and they are never called in speed critical areas. Uninlining them
> > should cause little performance loss if any, and saves a signficant
> > space and compilation time as well.
> 
> 2) VID_FROM_REG is asking for removal from lm85.

True, I wrote a patch doing this already:
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-July/013148.html

Just wait for Greg to pick it and it'll show in -mm.

> 3) vid_to_reg is used only by atxp1.

That's right. Do you suggest that it should be kept inlined then?
Similar drivers may be written in the future, causing vid_to_reg to gain
users and possibly grow larger (to support more VRM/VRD standards), then
we'll certainly want to uninline it anyway - but I agree that this ain't
the case at the moment.

I'll change that patch to only uninline vid_from_reg and not vid_to_reg
if a majority prefers me to do so.

Thanks for your comments :)
-- 
Jean Delvare
