From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: i2c-philips-par
Message-Id: <1074242713.4007a49945749@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1074182942.4006bb1e3fdf9@imp.gcu.info>
In-Reply-To: <1074182942.4006bb1e3fdf9@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Try replacing the line I told you to add by this one:
> > #define HZ 100
> > (...)
> 
> Okay, this line seams to be work. After adding it to the
> i2c-philips-par.c "make all" also exits by parsing the files
> i2c-velleman.c, i2c-elv.c and i2c-pport.c. I added the line on each
> file and it works - except i2c-pport.c. On this file I will get the
> same error.

This is strange. Could you double-check that the error is strictly
identical?

BTW I have another idea. I think that the "right" fix is to add this
line:
#include <linux/sched.h>
instead of the others I suggested so far. Could you please verify that
it works for you? If it does I'll apply it to our CVS repository.

> So far I commented the line for this file out in the Module.mk and
> make all runs with no errors. I think the pport isn't so important
> for using ml_sensors, is it?!

Correct, you most likely won't need it. Still I wonder why the fix
doesn't work for these.

> Hm, don't know why I will get these errors. My CPU is an AMD Athlon
> XP 2600+. My "uname -a" output is "Linux igge 2.4.21-166-athlon #1
> Thu Dec 18 18:24:05 UTC 2003 i686 athlon i386 GNU/Linux".

So it is an i386 architecture. Do you have anything else particular on
this machine? The other person who has the same problem as you reports
he is using win4lin.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
