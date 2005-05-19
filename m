From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: bus scan removal
Message-Id: <Pine.LNX.4.53.0312211413180.23656@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031221100543.28eaf2ff.khali@linux-fr.org>
In-Reply-To: <20031221100543.28eaf2ff.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 21 Dec 2003, Jean Delvare wrote:

> > 1. If wanted in kernel code, have a single scanner in i2c-core
> > instead.
>
> But you finally did not implement that, right?

Did not. There was i2cdetect.

> > 2. A simple SMBus Quick command may have effect, the most simple i2c
> > chip is a relay acting on the R/W bit of the address. Some chip at
> > 0x69 (?) locked the bus in the early days (-99), and I think it
> > was solved using write, not read address in the bus scan.
>
> I wasn't there back to these times, but we now use a quick write
> command (which, as you know, doesn't really write anything). A quick
> look at i2c-ibm_iic.c in Linux 2.6.0 shows that they use one-byte read
> instead.

Not all chips acknowledge the read address. With the i2c-ibm_iic, I
don't see the reason for using one-byte read,  if hw could not do
quick write a one-byte read is next best choice.


-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
