From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: lm_sensors && bt869
Message-Id: <20031231221515.0b328eac.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031228153744.49065c91.khali@linux-fr.org>
In-Reply-To: <20031228153744.49065c91.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Well...I don't actually know what the difference between kernel
> modules in 2.4 and 2.6 is.

Just to make it clear, the difference we are talking about is somewhat
i2c-chip-drivers specific (although one of the most important changes is
that they now use sysfs instead of procfs, which is a typical 2.4 to 2.6
change).

> Does the module need to be fully rewritten or do I only have to change
> parts?

Well, somewhere in the middle. There is much more to do than just a few
trivial changes. Still I don't consider it unfeasable, even for a
newbie, if you can follow a guide and keep track of four files at once
(see below).

> Could you point me to those docs?

See Documentation/i2c/porting clients in linux-2.6.1-rc1. I suggest that
you follow that guide, with four additional files opened: the old bt869
driver, the new bt869 (that you'll be writing), and the old and new
version of an arbitrary driver that has already been ported (I'd suggest
lm75 or lm83). This is what I did and it works well.

Good luck. Feel free to ask questions as they come.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
