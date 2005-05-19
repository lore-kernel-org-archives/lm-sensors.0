From: joden@lee.k12.nc.us (James Olin Oden)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: Fancontrol (perl) patch
Message-Id: <Pine.LNX.4.58.0406192253290.14196@malachi.lee.k12.nc.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <637C4FE1-BEA4-11D8-8C9C-000A95AF6760@hawaii.rr.com>
In-Reply-To: <637C4FE1-BEA4-11D8-8C9C-000A95AF6760@hawaii.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 19 Jun 2004, Jean Delvare wrote:

> Hi Dean,
> 
> > Add END {} block to restore fans on many kinds of errors/interrupts.
> > Remove arugment from restorefans
> 
> Two questions:
> 
> 1* What cases are you trying to catch? You already seem to be catching
> all possible signals.
> 
> 2* I suspect that the restorefans() function will be called twice more
> often than not. Since the END block is executed on exit, and
> restorefans() exits, won't it call itself each time?
>
That could be easily avoided by having a global state variable that can 
be checked in END(), such that it does not call restorefans() if it has 
already been called.

Cheers...james 
> Thanks.
> 
> 
