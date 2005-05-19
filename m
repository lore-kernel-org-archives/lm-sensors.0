From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: make fails
Message-Id: <20030731104247.54e48814.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722165359.538d577f.khali@linux-fr.org>
In-Reply-To: <20030722165359.538d577f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 31 Jul 2003 10:23:03 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> 
> > On Wed, 30 Jul 2003 18:56:33 +0200
> > Jean Delvare <khali@linux-fr.org> wrote:
> OK, so thats the problem. Your io.h is in asm, and we look for it in
> sys.
> 
> What's your glibc version? (ls -l /lib/libc-*.so will tell you).
-rwxr-xr-x    1 root     root      1273304 2003-04-20 19:36 /lib/libc-2.3.1.so

> 
> Anyway, this problem is completely different from the other one (well, I
> think so) so we'll leave it apart for now. Please edit
> proc/dump/isadump.c. At the beginning you'll see:
> 
> /* To keep glibc2 happy */
> #if defined(__GLIBC__) && __GLIBC__ = 2 && __GLIBC_MINOR__ >= 0
> #include <sys/io.h>
> #else
> #include <asm/io.h>
> #endif
> 
> Simply replace the whole block with:
> 
> #include <asm/io.h>
> 
> Save, and try to compile again. I hope it will be fine. I'll think of a
> real fix later. This is the only program using this file. With a bit of
> luck, it was the last compilation problem :)
well it is compiling now...

Will get back to you as soon as I know about success or failure.

Thanks in the meantime.

Zeno
-- 
Mit freundlichen Gruessen / Best regards

Zeno Davatz
Strategie und Akquisition

+41 1 350 85 86

www.ywesee.com > intellectual capital connected > www.generika.cc
