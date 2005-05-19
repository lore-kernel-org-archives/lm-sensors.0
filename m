From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: Installation problems.
Message-Id: <20021224004216.A11276@earth.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200212241526.16960.shandih@bigpond.com>
In-Reply-To: <200212241526.16960.shandih@bigpond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Stan:

* Stanley Hutchinson <shandih@bigpond.com> [2002-12-24 15:26:16 +1000]:
> home/stan/Documents/lm-sensors_2.7.0/make  required install of 'bison' and 
> 'flex' and then pulled up with:-
> 	lib/libsensors.so: undefined reference to  sensors_yylex
> 	lib/libsensors.so: undefined reference to  sensors-yyin
> 	lib/libsensors.so: undefined reference to sensors-lex_error
> 	lib/libsensors.so: undefined reference to sensors-yylineno
> Collect2: ld returned 1 exit status
> Make: *** [prog/sensors/sensors ] Error 1

Flex and Bison are the GNU projects' "lex" and "yacc", respectively.  They
are standard tools used to build e.g. compilers.  These programs are avail-
able from your distribution CDs.  Install them and try again.

> Following from your FAQ,
> 	prog/detect/i2cdetect   and   prog/detect/sensors-detect  both return
> 		'No such file or directory"

You haven't built them yet because of missing tools.  See above.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
