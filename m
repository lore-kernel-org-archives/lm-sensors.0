From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: ticket #1291
Message-Id: <20030731110954.43f2f54e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Now I get:
> gcc -I. -Ikernel/include -I/usr/local/include  -Wall -O2   -c
> prog/sensors/main.c -o prog/sensors/main.ro gcc -I. -Ikernel/include
> -I/usr/local/include  -Wall -O2   -c prog/sensors/chips.c -o
> prog/sensors/chips.ro gcc -o prog/sensors/sensors prog/sensors/main.ro
> prog/sensors/chips.ro -Llib -lsensors gcc -I. -Ikernel/include
> -I/usr/local/include  -Wall -O2   -c prog/dump/isadump.c -o
> prog/dump/isadump.ro prog/dump/isadump.c: In function `main':
> prog/dump/isadump.c:174: Warnung: implicit declaration of function
> `outb' prog/dump/isadump.c:183: Warnung: implicit declaration of
> function `inb' gcc  -o prog/dump/isadump prog/dump/isadump.ro
> prog/dump/isadump.ro(.text+0x284): In function `main':
> : undefined reference to `outb'
> prog/dump/isadump.ro(.text+0x290): In function `main':
> : undefined reference to `inb'
> prog/dump/isadump.ro(.text+0x308): In function `main':
> : undefined reference to `outb'
> prog/dump/isadump.ro(.text+0x318): In function `main':
> : undefined reference to `outb'
> prog/dump/isadump.ro(.text+0x32c): In function `main':
> : undefined reference to `outb'
> prog/dump/isadump.ro(.text+0x33c): In function `main':
> : undefined reference to `outb'
> collect2: ld returned 1 exit status
> make: *** [prog/dump/isadump] Fehler 1

So we are back to the original problem (ticket #1291).

Maybe you need an additional header and library to get inb and outb on
PPC. Could you please run the following commands and report outputs?

grep '^inb ' -r /usr/include/*
grep '^outb ' -r /usr/include/*

Gives /usr/include/sys/io.h for me, I would have expected
/usr/include/asm/io.h for you, but maybe it's elsewhere.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
