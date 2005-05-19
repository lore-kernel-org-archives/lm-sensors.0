From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: make fails
Message-Id: <20030730182503.2d579d89.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722165359.538d577f.khali@linux-fr.org>
In-Reply-To: <20030722165359.538d577f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 30 Jul 2003 18:16:44 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> 
> > > gcc -I. -Ikernel/include -I/usr/local/include -Wall -O2 -c
> > > lib/data.c -o lib/data.ao
> > 
> > this one worked fine.
> > 
> > What is next?
> 
> Attached is a Makefile I'd like you to try. Simply replace the original
> lm_sensors' Makefile with this one, then run "make clean && make". It
> works for me (which means it doesn't break the x86 compilation) and I
> expect it so solve your problem, at least partly.

ok. done that. now I get:

k' @' > kernel/busses/i2c-ali1535.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.4.21-ben2/build/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include  -I/lib/modules/2.4.21-ben2/build/include -nostdinc -I /usr/lib/gcc-lib/powerpc-linux/3.3/include  -Wall -O2   kernel/busses/i2c-nforce2.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-nforce2.d kernel/busses/i2c-nforce2.o: Makefile '`dirname kernel/busses/i2c-nforce2.d`/Module.mk' @' > kernel/busses/i2c-nforce2.d
make: *** Keine Regel vorhanden, um das Target ?sys/io.h?,
  ben?tigt von ?prog/dump/isadump.rd?, zu erstellen.  Schluss.

Thanks for your feedback.

Zeno
