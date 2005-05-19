From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: stdarg.h inclusion problem (ticket #1343)
Message-Id: <20030722091709.7ae566f0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1058736432.30749.4.camel@kalaha>
In-Reply-To: <1058736432.30749.4.camel@kalaha>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Do you have sed installed on your system? Which  version is it?
> cif@kalaha ~% sed -V
> GNU sed version 4.0.7

Should be OK.

> > What does the following command return is run from a shell?
> > LC_ALL=C gcc -print-search-dirs | sed -ne 's/install: \(.*\)/-I
> > \1include/gp'
> cif@kalaha ~% LC_ALL=C gcc -print-search-dirs | sed -ne 's/install:
> \(.*\)/-I\1include/gp'
> -I/usr/lib/gcc-lib/i386-linux/3.3.1/include

I'm puzzled. The command works from your shell, but doesn't seem to work
from inside the Makefile.

Can you force make to use bash as its shell (uncomment the SHELL= line
at the beginning of the Makefile)? Does it work?

Or maybe its is caused by a too recent gcc version (no idea why though),
could you try an older one? You seem to have many versions of gcc on
your system.

I admit I'm puzzled.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
