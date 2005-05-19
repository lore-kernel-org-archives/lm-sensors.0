From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: make fails
Message-Id: <20030731104455.393d8ef2.zdavatz@ywesee.com>
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
Now I get:
gcc -I. -Ikernel/include -I/usr/local/include  -Wall -O2   -c prog/sensors/main.c -o prog/sensors/main.ro
gcc -I. -Ikernel/include -I/usr/local/include  -Wall -O2   -c prog/sensors/chips.c -o prog/sensors/chips.ro
gcc -o prog/sensors/sensors prog/sensors/main.ro prog/sensors/chips.ro -Llib -lsensors
gcc -I. -Ikernel/include -I/usr/local/include  -Wall -O2   -c prog/dump/isadump.c -o prog/dump/isadump.ro
prog/dump/isadump.c: In function `main':
prog/dump/isadump.c:174: Warnung: implicit declaration of function `outb'
prog/dump/isadump.c:183: Warnung: implicit declaration of function `inb'
gcc  -o prog/dump/isadump prog/dump/isadump.ro
prog/dump/isadump.ro(.text+0x284): In function `main':
: undefined reference to `outb'
prog/dump/isadump.ro(.text+0x290): In function `main':
: undefined reference to `inb'
prog/dump/isadump.ro(.text+0x308): In function `main':
: undefined reference to `outb'
prog/dump/isadump.ro(.text+0x318): In function `main':
: undefined reference to `outb'
prog/dump/isadump.ro(.text+0x32c): In function `main':
: undefined reference to `outb'
prog/dump/isadump.ro(.text+0x33c): In function `main':
: undefined reference to `outb'
collect2: ld returned 1 exit status
make: *** [prog/dump/isadump] Fehler 1

Thanks for Feedback.
Zeno
