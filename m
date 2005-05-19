From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Makefile problems
Message-Id: <20040115190013.76f38931.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040115164753.98479.qmail@web14522.mail.yahoo.com>
In-Reply-To: <20040115164753.98479.qmail@web14522.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I having a problem with lm_sensors2 Makefile.  I run make all or
> make install It seems to just go into a loop and ends up doing
> nothing.  I have sent a log of what Makefile outputs.   Please let
> me know what I'm doing wrong or missing.

Is it from CVS?

Most probably your time is wrong (or you use CVS which is known to have
a bad time) and this confuses make. Make sure that no file in the source
tree has a date and time that belongs to the future ('find . -type f
-exec touch "{}" \;' may help). I'd expect everything to go fine after
that.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
