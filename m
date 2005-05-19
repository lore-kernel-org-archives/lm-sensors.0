From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: ATI i2c bus driver
Message-Id: <Pine.LNX.4.53.0401090250340.21119@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040102115144.219b5579.khali@linux-fr.org>
In-Reply-To: <20040102115144.219b5579.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 8 Jan 2004, Jean Delvare wrote:

> > The GPIO pins could be bidirectional, but one way at a time. Meaning,
> > the read value _GPIO_Y_0 is not valid when _GPIO_EN_0 is set.
>
> I did not see anything similar in Gatos' code.

Change getscl/sda to test the _GPIO_EN_x bit. If set (pull low), return
zero, else if unset (hi-Z) read and return _GPIO_Y_x.

I wondered why there was I2C_ALGO_ATI in i2c-id.h : Katos. It claims to
have working i2c kernel code, and does not use i2c-algo-bit. The code is
from -99, so don't expect it to compile out-of-the box either.

http://www.core.binghamton.edu/~insomnia/gatos/katos/src/katos-0.5.tar.gz

> > Did you try without bit_test? You might need some <1 us delay between
> > read and write to see the change, the bus has some capacitance even
> > without monitor cable.
>
> Yes, I tried without bit_test=1. I2cdetect hangs using 100% CPU, which
> makes me think my code is somehow broken, although I don't see where.
> I've copied what I read from the gatos code, using i2c-savage4 as a
> base, everything seems very simple, but it doesn't work. Would you have
> any concrete suggestion of something I could try? Else I think I'll just
> give up.

I guess i2cdetect sleeps in sclhi() twice for each address to scan.
Run with strace, does it return from syscalls or is it simply slow?
Also have i2c-algo-bit debugging enabled, plz.

At some point I got fed up tracing the failure paths and return codes in
i2c-algo-bit. You could have better debugging experience using
the i2c-algo-biths, just uncomment one COMPATIBILITY #define in the
source.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
