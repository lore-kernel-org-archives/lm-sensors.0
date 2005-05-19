From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lm_sensors current CVS on 2.6.0-test10
Message-Id: <20031129181805.4e46ca03.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.SOL.4.44.0311261657140.26419-100000@blue1>
In-Reply-To: <Pine.SOL.4.44.0311261657140.26419-100000@blue1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Program received signal SIGSEGV, Segmentation fault.
> 0x009402bc in _int_free () from /lib/tls/libc.so.6
> (gdb) bt
> #0  0x009402bc in _int_free () from /lib/tls/libc.so.6
> #1  0x0093f28b in free () from /lib/tls/libc.so.6
> #2  0x40015618 in free_bus (bus>       {number = -1, adapter = 0x8065330 "\231\006\bmain adapter",
>       algorithm = 0x40019746 "ISA bus algorithm", lineno >       1073795018}) at lib/init.c:98
> #3  0x40015553 in sensors_cleanup () at lib/init.c:78
> #4  0x0804936c in main (argc=1, argv=0xbffff944) at
> #prog/sensors/main.c:237

I could reproduce the bug and fix. It was caused by sysfs algorithm
labels being filled statically, while the same labels are dynamically
allocated with procfs. Calling free on the labels would crash sensors in
the first case, of course.

You can check an up-to-date version from CVS, should work :)

Thanks for the report.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
