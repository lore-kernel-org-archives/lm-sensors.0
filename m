From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: failed again; vetctor 300
Message-Id: <20030806152117.3011d99b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805222340.3799d819.zdavatz@ywesee.com>
In-Reply-To: <20030805222340.3799d819.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Ok, done that. Now I get this:
> gcc -I. -Ikernel/include -I/usr/local/include
> -I/lib/modules/2.4.21-ben2/build/include  -Wall -O2   -c lib/data.c -o
> lib/data.ao In file included from lib/data.c:20:
> /usr/include/stdlib.h:445: error: Syntaxfehler before "int32_t"
> /usr/include/stdlib.h:447: error: Syntaxfehler before '*' token
> /usr/include/stdlib.h:451: error: Syntaxfehler before '*' token
> /usr/include/stdlib.h:452: error: Syntaxfehler before '}' token
> /usr/include/stdlib.h:455: error: Syntaxfehler before "int32_t"
> lib/data.c: In function `sensors_parse_chip_name':
> lib/data.c:117: Warnung: deprecated use of label at end of compound
> statement
> lib/data.c:151: Warnung: deprecated use of label at end of
> compound statement
> make: *** [lib/data.ao] Fehler 1
> 
> Any hints?

Not really. Didn't you encounter this problem with lm_sensors 2.8.0?

The warnings are harmless, you can get the fixed version of the file
here if you want.
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/lib/data.c

Sounds like a broken system header, which won't let you compile the
library nor any user-space program.

What's there in /usr/include/stdlib.h, lines 430 to 460?


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
