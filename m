From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: make fails
Message-Id: <20030730155036.094c0c5d.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722165359.538d577f.khali@linux-fr.org>
In-Reply-To: <20030722165359.538d577f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 30 Jul 2003 14:27:27 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> 
> > As far as I can remember (after my holidays ;-) there where no Tabs
> > somewhere around line 178 in the CVS-Code. I had to insert the Tabs
> > for the spaces manually on two lines and then I tink everything
> > worked...
> 
> OK for this one, I closed it.
> 
> I see you have another, older ticket still unresolved:
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket91
> 
> What about this one? Did you find a solution at that time, do you
> remember what it was?
Ok, recompiled. i2c installs great but lm-sensors gives me:

In file included from lib/data.c:20:
/usr/include/stdlib.h:445: error: parse error before "int32_t"
/usr/include/stdlib.h:447: error: parse error before '*' token
/usr/include/stdlib.h:451: error: parse error before '*' token
/usr/include/stdlib.h:452: error: parse error before '}' token
/usr/include/stdlib.h:455: error: parse error before "int32_t"
make: *** [lib/data.ao] Fehler 1

this ticket can be expanded to this error - or shall I open a new one?

Thanks for your Feedback.

Zeno
