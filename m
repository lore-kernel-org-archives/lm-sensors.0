From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: i2c cvs repository status
Message-Id: <20031220120151.27b9db49.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

I can see that you have just been committing important changes to the
i2c CVS repository. What's the big idea?

This repository is meant to be Linux-2.4 compatible. I'm having a hard
time these days trying to commit older changes into Linux-2.4 itself,
before it is too late for such changes to ba accepted. You have to
realize that once the Linux-2.4 kernel will have been placed into frozen
mode (and this is supposed to happen as 2.4.24 is released), no more
changes but bug fixes (and possibly code cleanups) will be accepted. I
already doubt I'll be in time to commit all the changes before the
deadline. What if you now start adding more new stuff in there?

Let me be clear. Whatever is added to the i2c CVS repository by now
(including your recent "emulation patch") is *not* going to go into 2.4.
So what's the point in commiting it? New stuff should go into the 2.6
kernel. With the release of the 2.6 kernel, 2.4 is no more the place for
development. And the i2c CVS repository as it exists today (well, as it
existed yesterday) has no other purpose but to be integrated into Linux
2.4. What is not accepted into 2.4 will more likely be lost forever
unless it is ported to Linux 2.6.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
