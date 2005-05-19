From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: make fails
Message-Id: <20030730185633.3a69ad88.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722165359.538d577f.khali@linux-fr.org>
In-Reply-To: <20030722165359.538d577f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> ok. done that. now I get:
> 
> k' @' > kernel/busses/i2c-ali1535.d
> gcc -M -MG  -DMODVERSIONS -include
> /lib/modules/2.4.21-ben2/build/include/linux/modversions.h
> -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I.
> -Ikernel/include -I/usr/local/include 
> -I/lib/modules/2.4.21-ben2/build/include -nostdinc -I
> /usr/lib/gcc-lib/powerpc-linux/3.3/include  -Wall -O2  
> kernel/busses/i2c-nforce2.c | \
>         sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-nforce2.d
>         kernel/busses/i2c-nforce2.o: Makefile '`dirname
>         kernel/busses/i2c-nforce2.d`/Module.mk' @' >
>         kernel/busses/i2c-nforce2.d
> make: *** Keine Regel vorhanden, um das Target ?sys/io.h?,
>   ben?tigt von ?prog/dump/isadump.rd?, zu erstellen.  Schluss.

Do you have any sys/io.h file on your system (use find or locate)? Some
systems have asm/io.h instead. There is a macro that is supposed to
decide which one to chose, but maybe it isn't working for PPC systems.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
