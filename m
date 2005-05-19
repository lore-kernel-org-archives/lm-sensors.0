From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: tests
Message-Id: <20020709224106.781e3035.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020708223223.2cb9b5b5.khali@linux-fr.org>
In-Reply-To: <20020708223223.2cb9b5b5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Let's go for a first report.

There is a warning at the end of compilation of i2c:

kernel/i2c-pcf-epp.c:53: warning: `DATA' redefined
/usr/src/linux/include/linux/parport_pc.h:16: warning: this is the
location of the previous definition

I have no suggestion on how it should be fixed.

There is a warning in the middle of compilation of lm_sensors2:

kernel/chips/smbus-arp.c: In function `smbusarp_contents':
kernel/chips/smbus-arp.c:461: warning: comparison is always 1 due to
limited range of data type

("1" may be replaced by "true" depending of the compiler used)

This one is easily fixed by removing the line 461 ("a >= 0 &&") but
there is maybe something more complex than just that hidden behind this
warning ?

On some systems, the new module lm92 won't compile. I can't say wether
this is caused by the version of gcc (egcs-2.91.66) or the version of
the kernel (2.2.20). The error is:

kernel/chips/lm92.c:409: parse error before `sensors_lm92_exit'
kernel/chips/lm92.c: In function `__cleanup_module_inline':
kernel/chips/lm92.c:424: warning: return from incompatible pointer type

It is caused by the "__exit" keyword on line 409. Removing "__exit"
allowed me to compile the module, but I don't know what the consequences
will be, if any.

The new module ds1307 also suffers this problem, but it won't show
because it is *not* compiled when running make. I think this is not
wanted and that you will want to have a look at what's wrong there.

Ok, that's all for this evening. I'll go on when these ones are fixed.

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
