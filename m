From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: make fails
Message-Id: <20030730163301.6889bfcd.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722165359.538d577f.khali@linux-fr.org>
In-Reply-To: <20030722165359.538d577f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 30 Jul 2003 16:07:39 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Mmmh, doesn't sound like our fault. The error is in a system header.
> This should *not* happen. I guess you would be unable to compile most
> software, not only lm_sensors. It happens that i2c doesn't use this
> header (that's why you succeeded), but lm_sensors use it many times, so
> you won't get it to compile unless you can fix this.
> 
> > this ticket can be expanded to this error - or shall I open a new one?
> 
> Neither. I feel like it's not related to the old problem nor even to
> lm_sensors, so no place for a ticket.
> 
> But I could be wrong. I would like you to try to compile some other
> program that uses stdlib.h. 
What program would that be? I do know of any on the top of my mind.

If you succeed, then lm_sensors must be
> wrong somewhere. In this case, I'd like you to send us the line that
> produces the error (the error itself isn't very useful without the "gcc
> -I. -Ikernel/include ..." line  that produced it.)
Well, as I just said I recompiled my kernel before and I got no error compiling it.

The last lines are:

kernel/chips/via686a.c -o kernel/chips/via686a.o
gcc  -DMODVERSIONS -include /lib/modules/2.4.21-ben2/build/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21-ben2/build/include  -nostdinc -I /usr/lib/gcc-lib/powerpc-linux/3.3/include  -Wall -O2   -c kernel/chips/vt1211.c -o kernel/chips/vt1211.o
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21-ben2/build/include  -Wall -O2   -c lib/data.c -o lib/data.ao
In file included from lib/data.c:20:
/usr/include/stdlib.h:445: error: parse error before "int32_t"
/usr/include/stdlib.h:447: error: parse error before '*' token
/usr/include/stdlib.h:451: error: parse error before '*' token
/usr/include/stdlib.h:452: error: parse error before '}' token
/usr/include/stdlib.h:455: error: parse error before "int32_t"
make: *** [lib/data.ao] Fehler 1

Let me know if you need anything more.

Thanks for your time and help.
Zeno
