From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: ticket 1614
Message-Id: <1080052081.40604971c6758@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> You are right - that was an old instance of 'sensors' running. Still,
> I consider it a bug that 'make install' will not inform me that there
> already is a 'sensors' script in my system and just silently fail to
> replace it.

This is "sensors-detect", not "sensors". "make install" most probably
did not fail to replace it. It installed it under /usr/local/sbin, and
you must have an older version in *another* directory that is placed
before /usr/local/sbin in your $PATH. This is certainly not something
we want to check when installing, since it would be the case for
almost
anything we install, including manual pages. And it also affects just
any other package, not just ours. We do such a check for our library
however, because there have been much trouble reported on version
conflicts here, and even without installing it in different place, you
can easily fail to use the version you just installed.

It is under the user's responsability to know what his/her $PATH
contains and which binaries are installed in each of its constituents.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
