From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: failed again; vetctor 300
Message-Id: <20030806003310.2f6da31b.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805222340.3799d819.zdavatz@ywesee.com>
In-Reply-To: <20030805222340.3799d819.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Aug 2003 14:34:15 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> 
> > make of lm-sensors_2.7.0 gives me:
> > 
> > usses/i2c-amd8111.c -o kernel/busses/i2c-amd8111.o
> > kernel/busses/i2c-amd8111.c:25:2: #error Your i2c is too old -
> > i2c-2.7.0 or greater required!
> > (...)
> > Any hints?
> 
> Sure. http://secure.netroedge.com/~lm78/, see new item "# May 31st,
> 2003". Get the updated Makefile and config.c, should work OK then.
Ok, done that. Now I get this:
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21-ben2/build/include  -Wall -O2   -c lib/data.c -o lib/data.ao
In file included from lib/data.c:20:
/usr/include/stdlib.h:445: error: Syntaxfehler before "int32_t"
/usr/include/stdlib.h:447: error: Syntaxfehler before '*' token
/usr/include/stdlib.h:451: error: Syntaxfehler before '*' token
/usr/include/stdlib.h:452: error: Syntaxfehler before '}' token
/usr/include/stdlib.h:455: error: Syntaxfehler before "int32_t"
lib/data.c: In function `sensors_parse_chip_name':
lib/data.c:117: Warnung: deprecated use of label at end of compound statement
lib/data.c:151: Warnung: deprecated use of label at end of compound statement
make: *** [lib/data.ao] Fehler 1

Any hints?

Thanks for Feedback.

Zeno
