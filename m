From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 24 Mar 2006 07:26:00 +0000
Subject: [lm-sensors] [PATCH] Clean up magic numbers in i2c_parport.h
Message-Id: <20060324082600.ca9f9796.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060323205617.38e02afe.khali@linux-fr.org>
	<000e01c64efd$cae7f750$8401000a@fakie>
In-Reply-To: <000e01c64efd$cae7f750$8401000a@fakie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christopher Hoover <ch@murgatroid.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org, Andrew Morton <akpm@osdl.org>

Hi Christopher,

> > Beeuh. These macros don't really help. They actually make the lines
> > longer! I'm not taking this change, sorry.
> 
> If I kill off the macros but continue to use C99 structure initializers,
> which is I believe is the proper kernel coding style today, the lines are
> going to get even longer.  Is that OK?
> 
> Or are you asking for the patch w/o macros and w/o C99 structure
> initializers?
> 
> I can/will do either.  Just let me know what is acceptable a priori.

I don't think C99 initializers are needed here, the structure is pretty
simple and is also defined in the same file, a few lines above all its
instance declarations. So I am indeed asking for a patch w/o macros and
w/o C99 structure initializers, unless someone objects.

Thanks,
-- 
Jean Delvare

