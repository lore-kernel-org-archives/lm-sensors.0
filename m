From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: make fails
Message-Id: <20030731102303.75446d0d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722165359.538d577f.khali@linux-fr.org>
In-Reply-To: <20030722165359.538d577f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> On Wed, 30 Jul 2003 18:56:33 +0200
> Jean Delvare <khali@linux-fr.org> wrote:
> 
> > Do you have any sys/io.h file on your system (use find or locate)?
> > Some systems have asm/io.h instead. There is a macro that is
> > supposed to decide which one to chose, but maybe it isn't working
> > for PPC systems.
> 
> zeno@zrr:/var/log$ sudo find / -name io.h
> /usr/include/asm/io.h

OK, so thats the problem. Your io.h is in asm, and we look for it in
sys.

What's your glibc version? (ls -l /lib/libc-*.so will tell you).

Anyway, this problem is completely different from the other one (well, I
think so) so we'll leave it apart for now. Please edit
proc/dump/isadump.c. At the beginning you'll see:

/* To keep glibc2 happy */
#if defined(__GLIBC__) && __GLIBC__ = 2 && __GLIBC_MINOR__ >= 0
#include <sys/io.h>
#else
#include <asm/io.h>
#endif

Simply replace the whole block with:

#include <asm/io.h>

Save, and try to compile again. I hope it will be fine. I'll think of a
real fix later. This is the only program using this file. With a bit of
luck, it was the last compilation problem :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
