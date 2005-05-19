From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: ticket #1291
Message-Id: <20030731143840.16c8cc66.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030731110954.43f2f54e.khali@linux-fr.org>
In-Reply-To: <20030731110954.43f2f54e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 31 Jul 2003 14:27:31 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> 
> > > Typo here, I really meant: "ls -l /usr/include/ioport.h".
> > lrwxrwxrwx    1 root     root            8 2003-06-16 08:23
> > /usr/include/ioport.h -> ioport.h
> 
> This is *bad*. Delete this:
> 
> rm -f /usr/include/ioport.h
> 
> Back to the mailing list then.
Ok. Done that, I am just doing make again now ang I get:
gcc -shared -Wl,-soname,libsensors.so.2 -o lib/libsensors.so.2.0.0 lib/data.lo lib/general.lo lib/error.lo lib/chips.lo lib/proc.lo lib/access.lo lib/init.lo lib/conf-parse.lo lib/conf-lex.lo -lc -lm
rm -f lib/libsensors.so.2
ln -sfn libsensors.so.2.0.0 lib/libsensors.so.2
rm -f lib/libsensors.so
ln -sfn libsensors.so.2.0.0 lib/libsensors.so
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
