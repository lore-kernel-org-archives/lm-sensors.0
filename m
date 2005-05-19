From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: make fails
Message-Id: <20030730174531.5b788a95.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722165359.538d577f.khali@linux-fr.org>
In-Reply-To: <20030722165359.538d577f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Could you try the following (from the root of the lm_sensors
> > package, where you would run "make"). Basically, the command that
> > fails is:
> >   gcc -I. -Ikernel/include -I/usr/local/include
> > -I/lib/modules/2.4.21-ben2/build/include -Wall -O2 -c lib/data.c -o
> > lib/data.ao
> > I would like you to try removing each -I parameter, in turn, or
> > switch their order in any possible combination. If it is an include
> > order problem, one of these should work. That's just a wild guess
> > anyway, it may not work at all. We are not used to PPC systems...
>
> Sorry, please tell me how to remove the -I parameter.

Well, just run the command by yourself (from the root of the lm_sensors
package):

gcc -I. -Ikernel/include -I/usr/local/include
-I/lib/modules/2.4.21-ben2/build/include -Wall -O2 -c lib/data.c -o
lib/data.ao

This is expected to fail. Then try:

gcc -I. -Ikernel/include -I/usr/local/include -Wall -O2 -c lib/data.c -o
lib/data.ao

See, I removed one -I parameter. If it's not OK, you can try removing
another one instead, or two of them. If it's still not OK, you can try
switching the order like that:

gcc -Ikernel/include -I/usr/local/include
-I/lib/modules/2.4.21-ben2/build/include -I. -Wall -O2 -c lib/data.c -o
lib/data.ao

Or any other order. It's kind of repetitive work, I know, but if you can
find one or more combinations that work, we'll have something to start
from.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
