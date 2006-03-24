From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 24 Mar 2006 19:31:35 +0000
Subject: [lm-sensors] [PATCH] Clean up magic numbers in i2c_parport.h
Message-Id: <20060324203135.bfcaac45.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060323205617.38e02afe.khali@linux-fr.org>
	<000e01c64efd$cae7f750$8401000a@fakie>
	<20060324082600.ca9f9796.khali@linux-fr.org>
	<20060324174901.GA27881@kroah.com>
In-Reply-To: <20060324174901.GA27881@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, Christopher Hoover <ch@murgatroid.com>
Cc: Andrew Morton <akpm@osdl.org>, kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Greg, Christpher,

> > I don't think C99 initializers are needed here, the structure is pretty
> > simple and is also defined in the same file, a few lines above all its
> > instance declarations. So I am indeed asking for a patch w/o macros and
> > w/o C99 structure initializers, unless someone objects.
> 
> You should use structure initializers whereever possible, as it makes
> future changes much easier and safer (reorder the fields and things
> don't break in odd ways.)  So I would encourage this kind of change.

Oh well, if Greg says so...

Christopher, can you please respin a patch with C99 initializers, which
would look a bit better than your original one? I'd suggest a single,
straightforward macro (no needless underscores please):

#define LINEOP(val, port, inverted) \
    { .val = (val), .port = (port), .inverted = (inverted) }

Hopefully this will keep all lines within a reasonable length and won't
hurt the readability too much.

Also, I just noticed in your original patch: please preserve the comma
at the end of the last line of struct declarations. It's not needed,
sure, but it makes later changes easier.

Thanks,
-- 
Jean Delvare

