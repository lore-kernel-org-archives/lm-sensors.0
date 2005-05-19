From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: error compiling with i2c 2.8.0 patch
Message-Id: <20030718093619.3c51764d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <m3oeztep4f.fsf@athlon.familiaroa>
In-Reply-To: <m3oeztep4f.fsf@athlon.familiaroa>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have tried with the SuSE  kernel v. 2.4.21 and I get similar errors,
> like these (maybe a problem of compatibility between SuSE and standard
> kernel?):

Hm, I think I get it now. SuSE must come with modified kernel sources,
right? My patches are intended to be used with vanilla kernels.

> gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-4/include  -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2
> -march=i586 -DMODULE  -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=scx200_i2c  -c -o scx200_i2c.o scx200_i2c.c
> scx200_i2c.c:107: unknown field `inc_use' specified in initializer
> scx200_i2c.c:107: warning: initialization from incompatible pointer
> type scx200_i2c.c:108: unknown field `dec_use' specified in
> initializer scx200_i2c.c:108: warning: initialization from
> incompatible pointer type

These ones are "normal", I think you forgot to apply some of my patches
(actually, you must have applied the core-only patch instead of the
global one.) Or maybe it got rejected?

> initialization makes integer from pointer without a cast
> i2c-ali1535.c:177: warning: initialization makes integer from pointer
> without a cast i2c-ali1535.c:178: warning: initialization makes
> integer from pointer without a cast i2c-ali1535.c:178: initializer
> element is not computable at load time i2c-ali1535.c:178: (near
> initialization for `smbus_algorithm.name[6]') i2c-ali1535.c:182:
> warning: initialization from incompatible pointer type
> i2c-ali1535.c:183: warning: missing braces around initializer
> i2c-ali1535.c:183: warning: (near initialization for
> `ali1535_adapter.name') i2c-ali1535.c:183: warning: overflow in
> implicit constant conversion i2c-ali1535.c:184: warning:
> initialization makes integer from pointer without a cast
> i2c-ali1535.c:184: initializer element is not computable at load time
> i2c-ali1535.c:184: (near initialization for `ali1535_adapter.name[1]')
> i2c-ali1535.c:185: warning: initialization makes integer from pointer
> (...)

Less usual.

I guess that part of my patch was rejected when you applied it to the
SuSE kernel tree?

Please retry with a vanilla kernel and confirm that it works better.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
