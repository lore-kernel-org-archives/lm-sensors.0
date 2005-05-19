From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Tickets #1322 and #1323
Message-Id: <20030708093213.642bde1a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Martin,

I'm a bit troubled by your tickets. First, I guess that you were using
i2c & lm_sensors CVS, not 2.7.0.

You say that the depmod commands at the end of our Makefile were
preventing you from compiling lm_sensors. I can't understand, since they
are run by "make install", not make. Also, didn't you have the same
problem with installing i2c? The very same commands are run when you run
"make install" for i2c.

A more detailed problem description than "I have problem to compile"
would be greatly appreciated. For example, could you provide a log of
the error as it shows? These commands are specificaly meant not to
interrupt the installation even if they fail (see the leading dash) so I
just don't understand what your problem could be.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
