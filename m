From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: failed again
Message-Id: <20030806164234.1a694ea3.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Aug 2003 16:18:12 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Please get the new Makefile here:
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/Makefile
> 
> Should fix the problem.
Done that. Now I get:

gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.4.21-ben2/build/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include  -I/lib/modules/2.4.21-ben2/build/include -nostdinc -I /usr/lib/gcc-lib/powerpc-linux/3.3.1/include  -Wall -O2   kernel/busses/i2c-ali1535.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali1535.d kernel/busses/i2c-ali1535.o: Makefile '`dirname kernel/busses/i2c-ali1535.d`/Module.mk' @' > kernel/busses/i2c-ali1535.d
make: *** Keine Regel vorhanden, um das Target ?sys/io.h?,
  ben?tigt von ?prog/dump/isadump.rd?, zu erstellen.  Schluss.

Thanks for Feedback.

Zeno
