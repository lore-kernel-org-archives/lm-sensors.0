From: fabrice@yako.via.ecp.fr (Fabrice Ollivier)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: stdarg.h inclusion problem (ticket #1343)
Message-Id: <1058817156.2802.2.camel@kalaha>
List-Id: <lm-sensors.vger.kernel.org>
References: <1058736432.30749.4.camel@kalaha>
In-Reply-To: <1058736432.30749.4.camel@kalaha>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Obviously, this doesnt work for you, which is strange because the
> command is OK when you run it by yourself. We had problems with locales
> on this line, that's why we added "LC_ALL=C", and it was supposed to
> work. I can't say if the problem you have is locale-related or not.
> Could you please investigate a bit for us? For example, try to print the
> value or kbuild_2_4_nostdinc, or create another variable with this line:
>   kb24bis := $(shell LC_ALL=C $(CC) -print-search-dirs)
> and print it too. Maybe we'll see what's wrong.
> 
> You could also try unsetting your locales by hand right before running
> make.

1 = kbuild_2_4_nostdinc and 2 = kb24bis

1=-nostdinc

2=install: /usr/lib/gcc-lib/i386-linux/3.3.1/ programs:
=/usr/lib/gcc-lib/i386-linux/3.3.1/:/usr/lib/gcc-lib/i386-linux/3.3.1/:/usr/lib/gcc-lib/i386-linux/:/usr/lib/gcc/i386-linux/3.3.1/:/usr/lib/gcc/i386-linux/:/usr/lib/gcc-lib/i386-linux/3.3.1/../../../../i386-linux/bin/i386-linux/3.3.1/:/usr/lib/gcc-lib/i386-linux/3.3.1/../../../../i386-linux/bin/ libraries: =/usr/lib/gcc-lib/i386-linux/3.3.1/:/usr/lib/gcc/i386-linux/3.3.1/:/usr/lib/gcc-lib/i386-linux/3.3.1/../../../../i386-linux/lib/i386-linux/3.3.1/:/usr/lib/gcc-lib/i386-linux/3.3.1/../../../../i386-linux/lib/:/usr/lib/gcc-lib/i386-linux/3.3.1/../../../i386-linux/3.3.1/:/usr/lib/gcc-lib/i386-linux/3.3.1/../../../:/lib/i386-linux/3.3.1/:/lib/:/usr/lib/i386-linux/3.3.1/:/usr/lib/

But it did'nt work, always the same error, even if I seet my locales by
hand just before.

-- 
Fabrice
