From: fabrice@yako.via.ecp.fr (Fabrice Ollivier)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: stdarg.h inclusion problem (ticket #1343)
Message-Id: <1058737374.31350.0.camel@kalaha>
List-Id: <lm-sensors.vger.kernel.org>
References: <1058736432.30749.4.camel@kalaha>
In-Reply-To: <1058736432.30749.4.camel@kalaha>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Le dim 20/07/2003 ? 23:41, Jean Delvare a ?crit :
> Maybe one more locales problem. What's the output of "LC_ALL=C gcc
> -print-search-dirs" ?
Here it is :23:41 cif@kalaha ~% export LC_ALL=C
23:41 cif@kalaha ~% gcc -print-search-dirs
install: /usr/lib/gcc-lib/i386-linux/3.3.1/
programs:
=/usr/lib/gcc-lib/i386-linux/3.3.1/:/usr/lib/gcc-lib/i386-linux/3.3.1/:/usr/lib/gcc-lib/i386-linux/:/usr/lib/gcc/i386-linux/3.3.1/:/usr/lib/gcc/i386-linux/:/usr/lib/gcc-lib/i386-linux/3.3.1/../../../../i386-linux/bin/i386-linux/3.3.1/:/usr/lib/gcc-lib/i386-linux/3.3.1/../../../../i386-linux/bin/
libraries:
=/usr/lib/gcc-lib/i386-linux/3.3.1/:/usr/lib/gcc/i386-linux/3.3.1/:/usr/lib/gcc-lib/i386-linux/3.3.1/../../../../i386-linux/lib/i386-linux/3.3.1/:/usr/lib/gcc-lib/i386-linux/3.3.1/../../../../i386-linux/lib/:/usr/lib/gcc-lib/i386-linux/3.3.1/../../../i386-linux/3.3.1/:/usr/lib/gcc-lib/i386-linux/3.3.1/../../../:/lib/i386-linux/3.3.1/:/lib/:/usr/lib/i386-linux/3.3.1/:/usr/lib/


-- 
Fabrice
