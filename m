From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: i2c/kernel i2c-algo-bit.c
Message-Id: <Pine.LNX.4.53.0311211238550.27319@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031101170944.386fd941.khali@linux-fr.org>
In-Reply-To: <20031101170944.386fd941.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 1 Nov 2003, Jean Delvare wrote:

> > Modified Files:
> > 	i2c-algo-bit.c
> > Log Message:
> > (Khali) Fix sclhi() for adapters that do not have getscl().
> >         Enable bit_test for adapters that do not have getscl().
> >         Mostly rewrite test_bus(), cleaner and probably faster.
>
> I'd like reviewers and testers on this, since I plan to submit a similar
> for Linux 2.6. There are two distinct changes:
>
> 1* Fixed sclhi() for adapters that do not have getscl(). It looks like
> there was a udelay call missing in this case.

1*

Your fix for adapters not capable of reading SCL looks correct.
I introduced this bug as I moved udelay() call _after_ SCL is read back
as HIGH. Purpose of udelay() there is to guarantee SCL HIGH time.
I think we agree upon this change?

But, the bus has some capacitance and first call(s) to getscl() after
setscl(1) are likely to return LOW. This may slow down transmission and
generate undesirable amount of scheduling as cond_resched() is called.

Results of my bug fix: Earlier it could, rarely, output very short SCL
high pulses. Now it will, likely, output very long SCL high pulses.

To see i2c-algo-biths solution, search for "rdcount".

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>  +358 50 462 8786
