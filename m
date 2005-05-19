From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: stdarg.h inclusion problem (ticket #1343)
Message-Id: <20030720235220.287d7f55.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1058736432.30749.4.camel@kalaha>
In-Reply-To: <1058736432.30749.4.camel@kalaha>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Le dim 20/07/2003 ? 23:41, Jean Delvare a ?crit :
> > Maybe one more locales problem. What's the output of "LC_ALL=C gcc
> > -print-search-dirs" ?
> Here it is :23:41 cif@kalaha ~% export LC_ALL=C
> 23:41 cif@kalaha ~% gcc -print-search-dirs
> install: /usr/lib/gcc-lib/i386-linux/3.3.1/
> programs:
> =/usr/lib/gcc-lib/i386-linux/3.3.1/:/usr/lib/gcc-lib/i386-linux/3.3.1
> /:/usr/lib/gcc-lib/i386-linux/:/usr/lib/gcc/i386-linux/3.3.1/:/usr/li
> b/gcc/i386-linux/:/usr/lib/gcc-lib/i386-linux/3.3.1/../../../../i386-
> linux/bin/i386-linux/3.3.1/:/usr/lib/gcc-lib/i386-linux/3.3.1/../../.
> ./../i386-linux/bin/ libraries:
> =/usr/lib/gcc-lib/i386-linux/3.3.1/:/usr/lib/gcc/i386-linux/3.3.1/:/u
> sr/lib/gcc-lib/i386-linux/3.3.1/../../../../i386-linux/lib/i386-linux
> /3.3.1/:/usr/lib/gcc-lib/i386-linux/3.3.1/../../../../i386-linux/lib/
> :/usr/lib/gcc-lib/i386-linux/3.3.1/../../../i386-linux/3.3.1/:/usr/li
> b/gcc-lib/i386-linux/3.3.1/../../../:/lib/i386-linux/3.3.1/:/lib/:/us
> r/lib/i386-linux/3.3.1/:/usr/lib/

Seems to work...

OK, I better tell you the story from the beginning. The include path is
constructed in the Makefile at line 226:
kbuild_2_4_nostdinc := -nostdinc $(shell LC_ALL=C $(CC)
-print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')

Obviously, this doesnt work for you, which is strange because the
command is OK when you run it by yourself. We had problems with locales
on this line, that's why we added "LC_ALL=C", and it was supposed to
work. I can't say if the problem you have is locale-related or not.
Could you please investigate a bit for us? For example, try to print the
value or kbuild_2_4_nostdinc, or create another variable with this line:
  kb24bis := $(shell LC_ALL=C $(CC) -print-search-dirs)
and print it too. Maybe we'll see what's wrong.

You could also try unsetting your locales by hand right before running
make.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
