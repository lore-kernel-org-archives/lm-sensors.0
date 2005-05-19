From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: DESTDIR/depmod problem
Message-Id: <20030708093938.4cb5580f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F0A299C.2060406@paradyne.com>
In-Reply-To: <3F0A299C.2060406@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Khali please look at tickets #1322 and #1323 which claim a problem in
> the CVS makefile with the new depmod lines. Don't understand why...

I don't understand either. I suspect that the guy was frightened by the
depmod errors and did not see that they are *ignored*. Let's ask for
details. I'm considering adding a kind of disclaimer at this point of
the "make install" ("The following command may generate errors, we know,
don't be afraid."). Maybe this could also be the place for a reminder
not to use external i2c drivers for a while?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
