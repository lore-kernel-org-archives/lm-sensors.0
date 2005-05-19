From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: make fails
Message-Id: <20030730160739.3daa4af6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722165359.538d577f.khali@linux-fr.org>
In-Reply-To: <20030722165359.538d577f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Ok, recompiled. i2c installs great but lm-sensors gives me:
> 
> In file included from lib/data.c:20:
> /usr/include/stdlib.h:445: error: parse error before "int32_t"
> /usr/include/stdlib.h:447: error: parse error before '*' token
> /usr/include/stdlib.h:451: error: parse error before '*' token
> /usr/include/stdlib.h:452: error: parse error before '}' token
> /usr/include/stdlib.h:455: error: parse error before "int32_t"
> make: *** [lib/data.ao] Fehler 1

Mmmh, doesn't sound like our fault. The error is in a system header.
This should *not* happen. I guess you would be unable to compile most
software, not only lm_sensors. It happens that i2c doesn't use this
header (that's why you succeeded), but lm_sensors use it many times, so
you won't get it to compile unless you can fix this.

> this ticket can be expanded to this error - or shall I open a new one?

Neither. I feel like it's not related to the old problem nor even to
lm_sensors, so no place for a ticket.

But I could be wrong. I would like you to try to compile some other
program that uses stdlib.h. If you succeed, then lm_sensors must be
wrong somewhere. In this case, I'd like you to send us the line that
produces the error (the error itself isn't very useful without the "gcc
-I. -Ikernel/include ..." line  that produced it.)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
