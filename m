From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Reading a compass CMPS03
Message-Id: <1081173340.4071655ccccd3@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <16497.19215.209434.328945@aber.ac.uk>
In-Reply-To: <16497.19215.209434.328945@aber.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to Fred Labrosse:

> This device is supposed to be at address 0xC0.  I read at [URL]
> that I should specify this as 0xC0 >> 1, which is 0x60 (0xC0 is
> clearly not supported anywhere anyway ;-).

Correct. Bit 0 is for R/W, the address by itself being 7-bit. Some docs
reference chip address as the pair N (write address) and N+1 (read
address) but most people, including us, refer to the single address
N>>1 (chip address).

> I have written a small program that should to that, but it doesn't
> work.
> Here is what I did.  I attached it to my parallel port as in
> i2c-2.8.4/doc/i2c-pport.  I loaded all the modules:
> 
> pcffl root # lsmod
> Module                  Size  Used by    Tainted: P
> i2c-pport               1297   0
> i2c-proc                6836   0  (unused)
> i2c-dev                 4608   0
> i2c-algo-bit            7720   0  [i2c-pport]
> i2c-core               15460   0  [i2c-proc i2c-dev i2c-algo-bit]

That looks good.

> and the parallel port is detected:
> 
> pcffl root # cat /proc/bus/i2c
> i2c-0   i2c             Primitive Parallel port adaptor        
> Bit-shift algorithm

This is correct too.

> My program is attached below:

As long as i2cdetect and i2cdump don't output the expected result, your
program doesn't have a chance to work.

> pcffl root # i2cdetect 0
> (...)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
> 10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
> 20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
> 30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
> 40: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f
> 50: 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f
> 60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f
> 70: 70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f

This is bad. Only 60 should answer, other addresses should show "XX".

> pcffl root # i2cdump 0 0x60

Bad too, of course :(

> Now, the funny thing is that i2cdetect and i2cdump produce exactly
> the same thing whether or not my device is plugged in!

Well, it simply looks like i2c-parport isn't working as intended.

> One additional bit:
> 
> pcffl root # cat /proc/sys/dev/parport/parport0/modes
> PCSPP,TRISTATE

That may be a problem. I think I remember the i2c-pport doc stating that
the i2c-pport.c driver takes benefit of the features of modern parallel
ports (usually known as EPP or ECP, as opposed to SPP). Looks like your
parallel port doesn't support these modes, which may be why i2c-pport
doesn't work. Maybe you need to enable it through the BIOS setup
screen?

Second, i2c-pport.c doesn't use the standard parport interface, i.e. it
doesn't depend on the parport module - and is not even compatible with
it AFAIK. This means that you should *not* load the parport module when
using i2c-pport, because both modules will try to access the same I/O
ports and that may be the problem.

You may consider using i2c-philips-par (or i2c-parport in the 2.6 kernel
tree) instead, but the electronics needed to interface with your chip
are slighly different in this case, so you would have to change that.

> I hope someone can help me with that.  Sorry for the long message.

No problem, I hope you'll find a solution. Let us know!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
