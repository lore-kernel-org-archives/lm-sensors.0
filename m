From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: failed again
Message-Id: <20030806170749.7aeabbd0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806164234.1a694ea3.zdavatz@ywesee.com>
In-Reply-To: <20030806164234.1a694ea3.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Done that. Now I get:
> 
> gcc -M -MG  -DMODVERSIONS -include
> /lib/modules/2.4.21-ben2/build/include/linux/modversions.h
> -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I.
> -Ikernel/include -I/usr/local/include 
> -I/lib/modules/2.4.21-ben2/build/include -nostdinc -I
> /usr/lib/gcc-lib/powerpc-linux/3.3.1/include  -Wall -O2  
> kernel/busses/i2c-ali1535.c | \
>         sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali1535.d
>         kernel/busses/i2c-ali1535.o: Makefile '`dirname
>         kernel/busses/i2c-ali1535.d`/Module.mk' @' >
>         kernel/busses/i2c-ali1535.d
> make: *** Keine Regel vorhanden, um das Target ?sys/io.h?,
>   ben?tigt von ?prog/dump/isadump.rd?, zu erstellen.  Schluss.

Same error you had the other time (seems you don't remember much things
about it, do you? ;)).

The solution was to remove "prog/dump" from SRCDIRS (Makefile, line
165), if I remember correctly.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
