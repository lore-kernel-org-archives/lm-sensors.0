From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: Fix for 64-bit platforms to i2c-2.8.7
Message-Id: <20040924083359.M25375@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4153C035.4020804@penguincomputing.com>
In-Reply-To: <4153C035.4020804@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 23 Sep 2004 23:35:33 -0700, Philip Pokorny wrote
> I've had problems compiling 2.8.7 on Opteron (x86-64) systems due to
> some assembly code in i2c-algo-biths.c
> (...)
> Seems that we've duplicated some code from the mainline kernel 
> (udelay) in the biths implementation.  But as with most forks, the mainline
> kernel implementation works on 64-bit but ours doesn't.
> (...)
> In fact, I'm not really sure I see the point of this duplicated code 
> at all.  It would seem like we should just call the kernels udelay 
> in all cases.  In fact that's the fallback case in the code if it 
> doesn't think it can use the multiply instruction.

We sure don't want duplicate code. I also don't see the point of assembly code
in the i2c drivers. You fixed this specific problem for x86-64, but what about
all other non-i386 architectures? I doubt that the speed improvement is worth
the pain.

Could you possibly propose a patch which gets rid of the assembler code
altogether, and uses the kernel's udelay instead?

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
