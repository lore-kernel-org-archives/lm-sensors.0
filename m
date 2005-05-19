From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: make fails
Message-Id: <20030730164729.3fca1b53.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722165359.538d577f.khali@linux-fr.org>
In-Reply-To: <20030722165359.538d577f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > But I could be wrong. I would like you to try to compile some other
> > program that uses stdlib.h. 
>
> What program would that be? I do know of any on the top of my mind.

Try the attached file. Compile with "gcc -Wall -W test-zeno.c -o
test-zeno". Tell us if it fails or not.

> Well, as I just said I recompiled my kernel before and I got no error
> compiling it.

That's different. The kernel, as i2c and the modules of lm_sensors, are
kernel-space code. They use completely different headers. That's why i2c
and the first half of lm_sensors could compile, while the second part of
lm_sensors couldn't.

> The last lines are:
> 
> gcc -I. -Ikernel/include -I/usr/local/include
> -I/lib/modules/2.4.21-ben2/build/include  -Wall -O2
> -c lib/data.c -o lib/data.ao
> In file included from lib/data.c:20:
> /usr/include/stdlib.h:445: error: parse error before "int32_t"
> /usr/include/stdlib.h:447: error: parse error before '*' token
> /usr/include/stdlib.h:451: error: parse error before '*' token
> /usr/include/stdlib.h:452: error: parse error before '}' token
> /usr/include/stdlib.h:455: error: parse error before "int32_t"
> make: *** [lib/data.ao] Fehler 1
> 
> Let me know if you need anything more.

Could you try the following (from the root of the lm_sensors package,
where you would run "make"). Basically, the command that fails is:
  gcc -I. -Ikernel/include -I/usr/local/include
-I/lib/modules/2.4.21-ben2/build/include -Wall -O2 -c lib/data.c -o
lib/data.ao
I would like you to try removing each -I parameter, in turn, or switch
their order in any possible combination. If it is an include order
problem, one of these should work. That's just a wild guess anyway, it
may not work at all. We are not used to PPC systems...

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
#include <stdlib.h>

int main(void)
{
	return 0;
}
